import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/models/parentsModel.dart';
import 'package:to_do_list/pages/createParent.dart';

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
      throw Exception("Failed to load data orang tua");
    }
  }

  Future<bool> CreateParent(Map parent) async {
    await _getToken();
    final res = await http.post(
      Uri.parse('$apiURL/add-parent'),
      headers: _setHeaders(),
      body: jsonEncode(parent), // Convert to JSON
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      final convertDataToJson = jsonDecode(res.body);
      return true;
    } else {
      return false;
    }
  }
}
