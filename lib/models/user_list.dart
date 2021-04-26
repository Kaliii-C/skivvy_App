//     final userLists = userListsFromJson(jsonString);

import 'dart:convert';

UserLists userListsFromJson(String str) => UserLists.fromJson(json.decode(str));

String userListsToJson(UserLists data) => json.encode(data.toJson());

class UserLists {
  UserLists({
    this.lists,
  });

  Lists lists;

  factory UserLists.fromJson(Map<String, dynamic> json) => UserLists(
        lists: Lists.fromJson(json["lists"]),
      );

  Map<String, dynamic> toJson() => {
        "lists": lists.toJson(),
      };
}

class Lists {
  Lists({
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
  List<ListElement> lists;
  List<String> groups;
  String id;
  String firstName;
  String lastName;
  String email;
  bool isVerified;
  DateTime dateJoined;

  factory Lists.fromJson(Map<String, dynamic> json) => Lists(
        planned: List<String>.from(json["planned"].map((x) => x)),
        lists: List<ListElement>.from(
            json["lists"].map((x) => ListElement.fromJson(x))),
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
        "lists": List<dynamic>.from(lists.map((x) => x.toJson())),
        "groups": List<dynamic>.from(groups.map((x) => x)),
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "isVerified": isVerified,
        "dateJoined": dateJoined.toIso8601String(),
      };
}

class ListElement {
  ListElement({
    this.items,
    this.id,
    this.title,
    this.v,
  });

  List<Item> items;
  String id;
  String title;
  int v;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        id: json["_id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "_id": id,
        "title": title,
      };
}

class Item {
  Item({
    this.id,
    this.title,
    this.note,
    this.status,
    this.ownerList,
  });

  String id;
  String title;
  String note;
  String status;
  String ownerList;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["_id"],
        title: json["title"],
        note: json["note"],
        status: json["status"],
        ownerList: json["ownerList"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "note": note,
        "status": status,
        "ownerList": ownerList,
      };
}
