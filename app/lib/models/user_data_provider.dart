import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class UserDataProvider extends ChangeNotifier {
  int _userID = 1;
  int get userID => _userID;

  List<dynamic> users = [];

  UserDataProvider() {
    refreshUserData();
  }

  Future<void> refreshUserData() async {
    const port = String.fromEnvironment("PORT", defaultValue: "3000");
    final response =
        await http.get(Uri.parse('http://3.97.30.243:$port/users'));

    users = jsonDecode(response.body) as List;
    notifyListeners();
  }
}
