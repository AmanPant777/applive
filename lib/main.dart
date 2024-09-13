import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "Raleway",
          useMaterial3: true,
          primaryColor: const Color(0xFFE3712E),
          primaryColorDark: const Color(0xFF212121),
          primaryColorLight: const Color(0xFFE5E3E0),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Color(0xFFE3712E),
              ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFE3712E),
            shadowColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: false,
            scrolledUnderElevation: 10.0,
            toolbarHeight: 72.0,
            titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.normal),
            actionsIconTheme: IconThemeData(color: Colors.white, size: 16.0),
          ),
          textTheme: const TextTheme(
              headlineLarge:
                  TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
              headlineMedium:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              headlineSmall:
                  TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              bodyMedium: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(66, 71, 71, 71)))),
      home: const MyHomePage(title: 'Flutter Theme Done'),
    );
  }
}

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

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(color: Theme.of(context).primaryColor),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
