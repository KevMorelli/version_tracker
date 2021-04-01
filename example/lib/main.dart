import 'package:flutter/material.dart';
import 'package:version_tracker/version_tracker.dart';

VersionTracker versionTracker;

void main() async {
  // Without this, SharePreferences doesn't work because is called before the runApp
  // See: https://stackoverflow.com/a/57775690/2584335
  WidgetsFlutterBinding.ensureInitialized();

  versionTracker = VersionTracker();

  await versionTracker.track();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Version Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Version Tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
              versionTracker.toString(),
            ),
          ],
        ),
      ),
    );
  }
}
