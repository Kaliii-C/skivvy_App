import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:skivvy_app/models/user_list.dart';

class ListData with ChangeNotifier {
  final String userId;

  ListData(this.userId);

  Lists lisData;

  Lists get lists {
    return lisData;
  }

  Future<Lists> fetchList() async {
    final url = Uri.parse('https://skivvyapi.herokuapp.com/list/user-list');
    try {
      final response = await http.post(
        url,
        body: ({
          "userId": userId,
        }),
      );
      //final resData = json.decode(response.body);
      final userLists = userListsFromJson(response.body);
      print(userLists);
      lisData = userLists.lists;
      print(lisData);
      return lisData;

      //notifyListeners();
      //lisData = userLists;
    } catch (error) {
      throw error;
    }
  }
}
