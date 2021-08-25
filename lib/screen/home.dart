import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/screen/display.dart';
import 'package:flutter_cloud_firestore/screen/form.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: TabBarView(
            children: [
              FormScreen(),
              DisplayScreen(),
            ],
          ),
          backgroundColor: Colors.blue,
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(text: 'บันทึกคะแนน'),
              Tab(text: 'รายชื่อนักเรียน'),
            ],
          )),
    );
  }
}
