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
  FirebaseDatabase database =
      FirebaseDatabase.instance; // 이거 사실 아랫줄 때문에 없어도 된다함
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
      // body: SafeArea(
      //   child: Stack(
      //     children: [
      //       ListView(
      //         List.generate(length, (index) => null)
      //       )
      //     ],
      //   ),
      // ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 10.0,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            children: boardList
                .map((item) => Row(
                      children: [
                        Text(
                          item['title'],
                          style: const TextStyle(height: 2.0),
                        ),
                        // const Divider(
                        //   thickness: 5,
                        //   height: 5,
                        //   color: Colors.grey,
                        // )
                      ],
                    ))
                .toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
