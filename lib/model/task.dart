import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  static const String collectionName = 'tasks';
  String id;
  String title;
  String description;
  DateTime dateTime;
  bool isDone;
  Task(
      {this.id = '',
      required this.title,
      required this.description,
      required this.dateTime,
      this.isDone = false});

  // obj => json

  Map<String, dynamic> ToFirestore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'isDone': isDone
    };
  }

  Task.FromFireStore(Map<String, dynamic> data)
      : this(
            id: data['id'] as String,
            title: data['title'],
            dateTime: data['dateTime'] != null
                ? DateTime.fromMillisecondsSinceEpoch(data['dateTime'])
                : DateTime.now(),
            description: data['description'],
            isDone: data['isDone']);
}
