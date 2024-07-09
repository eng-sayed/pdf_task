import 'package:flutter/material.dart';

class TaskHomeScreen extends StatelessWidget {
  const TaskHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(child: Text("TaskHomeScreen")),
      ),
    );
  }
}