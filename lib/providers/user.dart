import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:skivvy_app/models/users.dart';

class User with ChangeNotifier {
  String _firstName;
  String _lastName;
  String _email;
  List<UserElement> _users = [];

  String get firstName {
    return _firstName;
  }

  String get lastName {
    return _lastName;
  }

  String get email {
    return _email;
  }

  Map<String, User> _userSearch = {};

  Map<String, User> get userSearch {
    return {..._userSearch};
  }

  Future<void> findUser(String name) async {
    final url = Uri.parse('https://skivvyapi.herokuapp.com/user/find-by-name');
    try {
      final response = await http.post(
        url,
        body: ({
          "name": name,
        }),
      );
      final resData = json.decode(response.body);
      if (resData['error'] != null) {
        throw HttpException(resData['error']['message']);
      }

      print(resData);
    } catch (error) {
      throw error;
    }
  }

  Future<List<UserElement>> fetchUsers() async {
    final url = Uri.parse('https://skivvyapi.herokuapp.com/group/all-users');
    try {
      final response = await http.get(
        url,
      );
      //final extractedData = json.decode(response.body);
      final users = userFromJson(response.body);
      _users = users.users;

      print("users: $users");
      print("_users: $_users");
      return _users;
    } catch (error) {
      throw error;
    }
  }
}
