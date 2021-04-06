import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget { // 상속의 재료(추상매서드)
  @override
  Widget build(BuildContext context) { //추상클래스는 내용이 x
    return MaterialApp(
      title: 'flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello world'),
        ),
        body: Text('hello world', style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hello world'),
      ),
      body: Text(
        'Hello world',
        style: TextStyle(fontSize: 40),
      ),
    );
  }
}
