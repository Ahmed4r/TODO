import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/model/task.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) {
              final data = snapshot.data();
              if (data == null) throw Exception('Task data is null');
              return Task.fromFirestore(data);
            },
            toFirestore: (task, options) => task.toFirestore());
  }

  static Future<void> addTaskToFireStore(Task taskobj) async {
    try {
      var taskCollection = getTasksCollection();
      var taskDocRef = taskCollection.doc();
      taskobj.id = taskDocRef.id; // auto id
      await taskDocRef.set(taskobj);
    } catch (e) {
      print('Failed to add task: $e');
      throw e;
    }
  }

  static Future<void> deleteTaskFromFireStore(Task task) async {
    try {
      await getTasksCollection().doc(task.id).delete();
    } catch (e) {
      print('Failed to delete task: $e');
      throw e;
    }
  }

  static Future<void> updateTaskToFireStore(Task taskobj) async {
    try {
      var taskCollection = getTasksCollection();
      var taskDocRef = taskCollection.doc(taskobj.id);
      await taskDocRef.update(taskobj.toFirestore());
    } catch (e) {
      print('Failed to update task: $e');
      throw e;
    }
  }
}
