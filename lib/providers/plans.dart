import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skivvy_app/models/plan.dart';

class Plans with ChangeNotifier {
  List<Plan> _events = [];
  final String authToken;
  final String userId;
  List<Plan> userEvents;
  //Plan _newEvent =;
  Plans(this.authToken, this.userId, this._events);

  List<Plan> get events {
    return [..._events];
  }

  Future<List<Plan>> fetchPlans() async {
    final url =
        Uri.parse('https://skivvyapi.herokuapp.com/plan/get-user-plans');
    try {
      final response = await http.post(url, body: ({"userId": userId}));
      final planData = response.body;
      final userPlans = userPlansFromJson(planData);
      print("userPlans: $userPlans");
      _events = userPlans.plans;
      print("_events:$_events");
      notifyListeners();
      return _events;
    } catch (error) {
      throw error;
    }
  }

  Future<void> addEvent(String title, String note, DateTime dueDate) async {
    final url = Uri.parse('https://skivvyapi.herokuapp.com/plan/add');
    try {
      final response = await http.post(
        url,
        body: ({
          "title": title,
          "note": note,
          "dueDate": dueDate,
          "userId": userId,
        }),
      );
      final newPlan = Plan(
        title: json.decode(response.body)['title'],
        note: json.decode(response.body)['note'],
        dueDate: json.decode(response.body)['dueDate'],
        id: json.decode(response.body)['name'],
      );
      print(newPlan);
      return newPlan;
      // _items.insert(0, newProduct); // at the start of the list
      //notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
