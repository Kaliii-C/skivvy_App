import 'dart:convert';

Users userFromJson(String str) => Users.fromJson(json.decode(str));

String userToJson(Users data) => json.encode(data.toJson());

class Users {
  Users({
    this.users,
  });

  List<UserElement> users;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        users: List<UserElement>.from(
            json["users"].map((x) => UserElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}

class UserElement {
  UserElement({
    this.planned,
    this.lists,
    this.groups,
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.isVerified,
    this.dateJoined,
  });

  List<String> planned;
  List<String> lists;
  List<String> groups;
  String id;
  String firstName;
  String lastName;
  String email;
  bool isVerified;
  DateTime dateJoined;

  factory UserElement.fromJson(Map<String, dynamic> json) => UserElement(
        planned: List<String>.from(json["planned"].map((x) => x)),
        lists: List<String>.from(json["lists"].map((x) => x)),
        groups: List<String>.from(json["groups"].map((x) => x)),
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        isVerified: json["isVerified"],
        dateJoined: DateTime.parse(json["dateJoined"]),
      );

  Map<String, dynamic> toJson() => {
        "planned": List<dynamic>.from(planned.map((x) => x)),
        "lists": List<dynamic>.from(lists.map((x) => x)),
        "groups": List<dynamic>.from(groups.map((x) => x)),
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "isVerified": isVerified,
        "dateJoined": dateJoined.toIso8601String(),
      };
}
