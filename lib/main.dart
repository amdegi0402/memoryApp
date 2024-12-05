import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'sqlite.dart';
import 'function/dateFunc.dart';
import 'function/dateFunc_2.dart';
import 'value.dart';
import 'drawerMenu.dart';

void main() async {
  // Flutterの初期化を確実に行う
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'メモリートレーニング',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pink,
          brightness: Brightness.light,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  
  List<String> titles = [];
  List<String> keywords = [];
  List<String> ids = [];

  bool _isLoading = true;
  String? _error;

  /// データベースの初期化とデータの読み込み
  Future<void> _initReadStudyDays() async {
    try {
      await createDatabase();
      await updateDb(date(0));
      
      final titlesResult = await readStudyDays(0, date(0));
      final keywordsResult = await readStudyDays(1, date(0));
      final idsResult = await readStudyDays(5, date(0));

      if (mounted) {
        setState(() {
          titles = titlesResult;
          keywords = keywordsResult;
          ids = idsResult;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  /// 復習日の更新処理
  Future<void> _initChangeStudyDay() async {
    try {
      await updateNextNum(calcToday(), date(0));
    } catch (e) {
      print('復習日更新エラー: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await _initChangeStudyDay();
    await _initReadStudyDays();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${date(0)} 反復学習リスト'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      drawer: Drawer(
        child: drawerMenu(context),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          _buildMainContent(),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(child: Text('エラーが発生しました: $_error'));
    }

    if (titles.isEmpty) {
      return const Center(
        child: Text(
          '本日のタスクはありません',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      itemCount: titles.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: Icon(
              Icons.grade,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              titles[index],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(keywords[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ValueList(
                    catch_title: titles[index],
                    catch_key: keywords[index],
                    catch_id: ids[index],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
