import 'dart:convert';

import 'package:belajar/models/user_list_model.dart';
import 'package:belajar/utils/api_config.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<UserListModel> getListUser() async {
    try {
      var res = await http.get(apiUrl + 'users?page=2');
      return UserListModel.fromJson(json.decode(res.body));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
