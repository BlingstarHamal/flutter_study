import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // firebase realtime database 연결
  // DatabaseReference 가져오기
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference rootRef = FirebaseDatabase.instance.ref("/boards");
  List<dynamic> boardList = [];
  String newTitle = "";
  String newContent = "";

  // get()을 사용하여 한 번 읽기
  Future<void> refreshBoard() async {
    final DataSnapshot snapshot = await rootRef.get();
    if (snapshot.exists) {
      setState(() {
        boardList = (snapshot.value as Map? ?? {}).values.toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    refreshBoard();
  }

  String formatDateTime(DateTime dateTime) {
    return "${dateTime.year}년 ${dateTime.month}월 ${dateTime.day}일 ${dateTime.hour}시 ${dateTime.minute}분";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "플러터 자유게시판",
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => SimpleDialog(
              title: const Text(
                "게시물 추가",
              ),
              contentPadding: const EdgeInsets.all(
                15.0,
              ),
              children: [
                const Text(
                  "제목",
                ),
                TextField(
                  onChanged: (String value) {
                    newTitle = value;
                  },
                  textInputAction: TextInputAction.next,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                ),
                const Text(
                  "내용",
                ),
                TextField(
                  onChanged: (String value) {
                    newContent = value;
                  },
                  textInputAction: TextInputAction.done,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    DatabaseReference newRef = rootRef.push();
                    await newRef.set({
                      "id": newRef.key,
                      "title": newTitle,
                      "content": newContent,
                      "created": DateTime.now().toString(),
                    });
                    setState(() {
                      newTitle = "";
                      newContent = "";
                    });
                    refreshBoard();
                  },
                  icon: const Icon(
                    Icons.save,
                  ),
                  label: const Text(
                    "저장",
                  ),
                ),
              ],
            ),
          );
        },
        tooltip: "게시물 작성",
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: boardList.length,
        itemBuilder: (_, index) => ListTile(
          title: Text(boardList[index]["title"] ?? ""),
          subtitle: Text(
              "${boardList[index]["content"] ?? ""}\n\n${formatDateTime(DateTime.parse(boardList[index]["created"] ?? DateTime.now().toIso8601String()))}"),

          // 길게 누르면 삭제
          onLongPress: () {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: const Text("이 게시물을 삭제하시겠습니까?"),
                      actions: [
                        ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                            final String id = boardList[index]["id"] ?? "";
                            if (id.isEmpty) return;
                            await rootRef.child("/$id").remove();
                            // 삭제는 되는데 리프레쉬 보드가 안되는 듯?
                            refreshBoard();
                          },
                          child: const Text("삭제"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("취소"),
                        ),
                      ],
                    ));
          },
        ),
      ),
    );
  }
}
