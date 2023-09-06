import 'package:flame/game.dart';
import 'package:flutter/material.dart';

//如何自定义桌面窗口
//http://bbs.itying.com/topic/643548234aa6b50d24f8542b
import 'package:window_manager/window_manager.dart';

import './black_house_game.dart';
import './widgets/widgets.dart';

void main() async {
  //保证Widgets初始化
  /*
  在 Flutter 中,WidgetsFlutterBinding类的主要作用有:
1. 初始化Flutter框架
WidgetsFlutterBinding的ensureInitialized()方法会负责初始化整个Flutter框架,确保各个子系统都准备就绪。这一步非常重要,需要在运行runApp()之前完成。
2. 提供对根Widget的访问
WidgetsBinding可以通过instance访问当前活跃的根Widget,这为获取context提供了可能。
3. 管理窗口大小和 Locale
WidgetsBinding可以获取窗口信息,还可以监听窗口大小改变等事件。可以设置Locale来更改系统语言环境。
4. 提供 Scheduler 绑定
WidgetsBinding内部含有一个SchedulerBinding实例,它管理着UI绘制、布局等任务的调度。
5. 提供平台消息通道
WidgetsBinding包含一个默认的平台通道,可以用来与原生代码通信。
6. 提供应用生命周期监听
可以通过WidgetsBinding监听应用生命周期事件,如暂停、恢复、内存压力等。
7. pump函数重新绘制UI
WidgetsBinding的drawFrame()方法可以手动重新绘制UI界面。
所以在Flutter应用启动前,需要先调用WidgetsFlutterBinding的ensureInitialized()进行初始化,而它正是承担了这些重要工作,是Flutter框架正常运行的基础。
  */
  WidgetsFlutterBinding.ensureInitialized();

  // 必须加上这一行。windowManager 库的初始化
  await windowManager.ensureInitialized();

  // 设置主窗口属性
  WindowOptions windowOptions = const WindowOptions(
    size: Size(600, 800),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const GameApp());
}

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Betrayal at House on the Hill',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey[800]!),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Betrayal at House on the Hill'),
    );
  }
}

// 游戏主窗口对象
final game = BlackHouseGame();

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//增加对 主窗口事件的监听拓展 (WindowListener)
class _MyHomePageState extends State<MyHomePage> with WindowListener {
  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
                constraints: const BoxConstraints(
                  maxWidth: double.infinity,
                  maxHeight: double.infinity,
                ),
                child: GameWidget(
                    game: game,
                    // 主窗口上 增加多层级 布局, 用于显示游戏中的UI
                    // 例如: 1、选择菜单,
                    // 2、暂停画面,
                    // 3、游戏结束层
                    // 等等
                    overlayBuilderMap: {
                      'gamePauseOverLay':
                          (BuildContext context, BlackHouseGame game) {
                        return const Text('gamePauseOverlay');
                      },
                      'mainMenuOverlay':
                          (BuildContext context, BlackHouseGame game) {
                        return const Text('mainMenuOverlay');
                      },
                      'gameOverOverlay':
                          (BuildContext context, BlackHouseGame game) {
                        return GameOverOverlay(game);
                      },
                    }));
          },
        ),
      ),
    );
  }

  /*
  * 以下是各种 主窗口事件的监听回调执行方法
  */
  @override
  void onWindowEvent(String eventName) {
    //print('[WindowManager] onWindowEvent: $eventName');
  }

  @override
  void onWindowClose() {
    // do something
  }

  @override
  void onWindowFocus() {
    // do something
  }

  @override
  void onWindowBlur() {
    // do something
  }

  @override
  void onWindowMaximize() {
    // do something
  }

  @override
  void onWindowUnmaximize() {
    // do something
  }

  @override
  void onWindowMinimize() {
    // do something
  }

  @override
  void onWindowRestore() {
    // do something
  }

  @override
  void onWindowResize() {
    // do something
  }

  @override
  void onWindowMove() {
    // do something
  }

  @override
  void onWindowEnterFullScreen() {
    // do something
  }

  @override
  void onWindowLeaveFullScreen() {
    // do something
  }
}
