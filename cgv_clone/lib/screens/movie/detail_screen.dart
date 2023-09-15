import 'package:cgv_clone/database_service.dart';
import 'package:cgv_clone/models/moives.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cgv_clone/screens/movie/review_screen.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.thisMovie});

  final Movie thisMovie;

  @override
  Widget build(BuildContext context) {
    Size appSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          thisMovie.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
      ),
      body: ListView(
        children: [
          // 영화 상세 정보
          Stack(
            children: [
              // 배경 이미지
              Image.asset(
                thisMovie.imageUrl,
                width: appSize.width,
                height: 300,
                fit: BoxFit.cover,
              ),
              // 배경이미지 그라데이션 - 이미지 자체에 편집한게 아니라
              // 이미지 위에 그림자를 올림
              Container(
                height: 300,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.grey.withOpacity(0.4),
                      Colors.black,
                    ],
                  ),
                ),
              ),
              // 영화 포스터, 영화 제목 및 내용
              Positioned(
                left: 10,
                bottom: 14.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      thisMovie.imageUrl,
                      width: appSize.width * 0.25,
                      fit: BoxFit.contain,
                    ),
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            thisMovie.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            thisMovie.subTitle,
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            thisMovie.runTime,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),

          // 관람평 작성 화면 이동

          Padding(
            padding: const EdgeInsets.all(4.0),
            child: OutlinedButton(
              child: Text(
                "실관람평 등록하기",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.black87),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReviewScreen(item: thisMovie)),
                );
              },
            ),
          ),
          // 리뷰 목록 만들기
          StreamBuilder<QuerySnapshot>(
            stream: getReviews(thisMovie.title),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return const Text('Loading...');

              return Column(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  // return Text('${document['name']} : ${document['comment']}');
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          document['evaluation'],
                          style: TextStyle(color: Colors.brown),
                        ),
                        Row(
                          children: [
                            Text(
                              document['name'],
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Spacer(),
                            Text(
                              (document['registration_date'])
                                  .toDate()
                                  .toString(),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Text(document['comment']),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
