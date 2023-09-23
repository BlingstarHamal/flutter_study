// import 'dart:convert';
//import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference rootRef = FirebaseDatabase.instance.ref();
  List<dynamic> boardList = [];

  @override
  void initState() {
    super.initState();
    rootRef.get().then((snapshot) {
      if (snapshot.exists) {
        setState(() {
          boardList = snapshot.value as List? ?? [];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('게시물 목록'),
      ),
      body: Column(
        children: boardList.map((item) => Text(item['title'])).toList(),
      ),
    );
  }
}
