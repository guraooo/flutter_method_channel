import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const MethodChannel _channel =
      MethodChannel('com.example.flutterMethodchannel/test');

  String _deviceName = "Unknown";
  int? _result;

  void _fetchDeviceName() async {
    final deviceName = await _channel.invokeMethod('fetchDeviceName');

    setState(() {
      _deviceName = deviceName;
    });
  }

  void _fetchCalculatedNumber() async {
    final result = await _channel.invokeMethod('calculate', 123);

    setState(() {
      _result = result;
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
            const Text(
              'This device is',
            ),
            Text(
              _deviceName,
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 30),
            const Text(
              'The result calculated in android side is ',
            ),
            Text(
              _result == null ? "Unknown" : "$_result",
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: _fetchDeviceName,
            child: const Icon(Icons.phone_android),
          ),
          FloatingActionButton(
            onPressed: _fetchCalculatedNumber,
            child: const Icon(Icons.onetwothree),
          ),
        ],
      ),
    );
  }
}
