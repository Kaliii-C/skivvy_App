import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class Auth with ChangeNotifier {
  String _token;
  String _userId;

  bool get isAuth {
    return token != null;
  }

  String get userId {
    return _userId;
  }

  String get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  Future<void> login(String email, String password) async {
    final url = Uri.parse('https://skivvyapi.herokuapp.com/auth/login');
    try {
      final response = await http.post(
        url,
        body: ({
          "email": email,
          "password": password,
        }),
      );
      final resData = json.decode(response.body);
      if (resData['error'] != null) {
        throw HttpException(resData['error']['message']);
      }
      _token = resData['token'];
      _userId = resData['id'];

      print(_userId);
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', _token);
      prefs.setString('userId', _userId);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(
      String firstName, String lastName, String email, String password) async {
    final url = Uri.parse('https://skivvyapi.herokuapp.com/auth/register');
    final res = await http.post(url,
        body: ({
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "password": password,
        }));
    print(json.decode(res.body));
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
