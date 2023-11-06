import 'dart:convert';

import 'package:todo_with_clean_architecture/domain/entities/todo_entitiy.dart';

TodoModel todoModelFromJson(String str) => TodoModel.fromJson(json.decode(str));

String todoModelToJson(TodoModel data) => json.encode(data.toJson());

class TodoModel extends TodoEntity {
  TodoModel({
    int? userId,
    int? id,
    String? title,
    bool? completed,
  }) : super(
          userId: userId,
          id: id,
          title: title,
          completed: completed,
        );

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
      };
}
