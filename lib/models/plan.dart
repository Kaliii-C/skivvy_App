import 'dart:convert';

UserPlans userPlansFromJson(String str) => UserPlans.fromJson(json.decode(str));

String userPlansToJson(UserPlans data) => json.encode(data.toJson());

class UserPlans {
  UserPlans({
    this.plans,
  });

  List<Plan> plans;

  factory UserPlans.fromJson(Map<String, dynamic> json) => UserPlans(
        plans: List<Plan>.from(json["plans"].map((x) => Plan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "plans": List<dynamic>.from(plans.map((x) => x.toJson())),
      };
}

class Plan {
  Plan({
    this.id,
    this.title,
    this.note,
    this.dueDate,
    this.owner,
  });

  String id;
  String title;
  String note;
  DateTime dueDate;
  String owner;

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        id: json["_id"],
        title: json["title"],
        note: json["note"],
        dueDate: DateTime.parse(json["dueDate"]),
        owner: json["owner"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "note": note,
        "dueDate": dueDate.toIso8601String(),
        "owner": owner,
      };
}
