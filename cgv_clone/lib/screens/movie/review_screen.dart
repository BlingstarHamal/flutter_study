import 'package:cgv_clone/models/moives.dart';
import 'package:flutter/material.dart';
import 'package:cgv_clone/database_service.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key, required this.item});
  final Movie item;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  TextEditingController reviewIdController = new TextEditingController();
  TextEditingController reviewTextController = new TextEditingController();
  List<String> choices = ['Good!', 'Bad.'];
  int choice_index = 0;

  @override
  Widget build(BuildContext context) {
    Movie thisMovie = widget.item;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '관람평 등록',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.black12,
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "영화 어땠나요?",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                // 평가 버튼
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List<Widget>.generate(
                    choices.length,
                    (index) {
                      return ChoiceChip(
                        padding: EdgeInsets.all(10.0),
                        label: Text(
                          choices[index],
                          style: TextStyle(
                              color: (choice_index == index)
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 20),
                        ),
                        labelPadding: EdgeInsets.symmetric(horizontal: 50),
                        selected: choice_index == index,
                        onSelected: (value) {
                          setState(() {
                            choice_index = index;
                          });
                        },
                        backgroundColor: Colors.white,
                        selectedColor: Colors.red,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
          ),
          // 리뷰 작성
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "나의 감상평",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: reviewIdController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '작성자',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  minLines: 1,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  controller: reviewTextController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '내용',
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    // 재출 버튼 누를 때 유효값 테스트
                    onPressed: () {
                      if (reviewIdController.text.isEmpty ||
                          reviewTextController.text.isEmpty) {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            content: Text('리뷰를 입력하세요.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        addReview(thisMovie.title, reviewIdController.text,
                            reviewTextController.text, choices[choice_index]);
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      '제출',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
