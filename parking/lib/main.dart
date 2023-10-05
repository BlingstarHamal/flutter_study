import 'package:flutter/material.dart';
import 'services/fetchpark.dart';
import 'dart:async';
import 'models/park.dart';
import 'repositories/dbhelper.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Park>> parks;

  @override
  void initState() {
    // TODO: implement initSate

    super.initState();
    parks = fetchPark();
    parks.then((value) => value.forEach((element) {
          print(element.parking_name);
          print(element.parking_code);
          print(element.lat);
          print(element.lng);
          var tmpPark = Park(
              parking_name: element.parking_name,
              parking_code: element.parking_code,
              lat: element.lat,
              lng: element.lng);
          DBHelper().insertPark(tmpPark);
        }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '오픈API 활용하기',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('공영 주차장 조회'),
        ),
        body: Center(
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text('주차장명'),
          //     Text('주차코드'),
          //     Text('위도위치'),
          //     Text('경도위치'),
          //   ],
          // ),
          child: FutureBuilder<List<Park>>(
            future: parks,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(snapshot.data.isNotEmpty
                        ? snapshot.data![0].parking_name
                        : '없음'),
                    Text(snapshot.data.isNotEmpty
                        ? snapshot.data![0].parking_code
                        : '없음'),
                    Text(snapshot.data.isNotEmpty
                        ? snapshot.data![0].lat.toString()
                        : '없음'),
                    Text(snapshot.data.isNotEmpty
                        ? snapshot.data![0].lng.toString()
                        : '없음'),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FloatingActionButton(
              child: const Icon(Icons.local_parking),
              onPressed: () {
                DBHelper dbHelper = DBHelper();
                dbHelper.parks().then((value) => value.forEach((element) {
                      print(
                          'parking_code:${element.parking_code}, parking_name:${element.parking_name}');
                    }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
