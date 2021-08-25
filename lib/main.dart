import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/screen/display.dart';
import 'package:flutter_cloud_firestore/screen/form.dart';
import 'package:flutter_cloud_firestore/screen/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/form': (context) => const FormScreen(),
        '/display': (context) => const DisplayScreen(),
      },
    );
  }
}
