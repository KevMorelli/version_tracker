import 'package:flutter/material.dart';
import 'package:version_tracker/version_tracker.dart';

late final VersionTracker versionTracker;

void main() async {
  // Without this, SharePreferences doesn't work because is called before the runApp
  // See: https://stackoverflow.com/a/57775690/2584335
  WidgetsFlutterBinding.ensureInitialized();

  versionTracker = VersionTracker();

  await versionTracker.track();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Version Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Version Tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  // ignore: library_private_types_in_public_api
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
