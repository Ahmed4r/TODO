import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  static const String collectionName ='tasks';
  String id;
  String title;
  String description;
  DateTime dateTime;
  bool isDone;

  Task({
    this.id = '',
    required this.title,
    required this.description,
    required this.dateTime,
    this.isDone = false,
  });

  // Convert object to Firestore-compatible map
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': Timestamp.fromDate(dateTime), // Convert DateTime to Timestamp
      'isDone': isDone,
    };
  }

  // Create object from Firestore map
  Task.fromFirestore(Map<String, dynamic> data)
      : id = data['id'] ?? '',
        title = data['title'] ?? '',
        description = data['description'] ?? '',
        dateTime = data['dateTime'] is Timestamp
            ? (data['dateTime'] as Timestamp).toDate()
            : DateTime.now(), // Convert Timestamp to DateTime
        isDone = data['isDone'] ?? false;
}
