import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/models/parentsModel.dart';

class ParentService {
  final String apiURL = "http://127.0.0.1:8000/api/daftar";
  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token');
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

  // Future<List<Map<String, dynamic>>> getParentData() async {
  //   await _getToken();
  //   final res = await http.get(Uri.parse(apiURL), headers: _setHeaders());
  //   // print(res.body);
  //   if (res.statusCode == 200 || res.statusCode == 201) {
  //     final convertDataToJson = jsonDecode(res.body);
  //     List<dynamic> dataList =
  //         convertDataToJson['data']['data']; // Mengakses "data" dalam "data"
  //     List<Map<String, dynamic>> parentData = [];

  //     for (var data in dataList) {
  //       parentData.add(data);
  //     }

  //     return parentData;
  //   } else {
  //     throw "Failed to Load Parent List";
  //   }
  // }

  Future<List<ParentModel>> getParentData() async {
    await _getToken();
    final res = await http.get(
      Uri.parse(apiURL),
      headers: _setHeaders(),
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      final convertDataToJson = jsonDecode(res.body);
      List<dynamic> list = convertDataToJson['data'];
      return list.map((data) => ParentModel.fromJson(data)).toList();
    } else {
      throw Exception("Failed to load program Donasi list");
    }
  }
}
