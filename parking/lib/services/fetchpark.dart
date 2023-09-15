import 'package:http/http.dart' as http;
import 'package:parking/models/park.dart';
import 'package:parking/key/key.dart';
import 'dart:convert';

Future<List<Park>> fetchPark() async{
  Late List<Park> parkingList;
  String url=''
}