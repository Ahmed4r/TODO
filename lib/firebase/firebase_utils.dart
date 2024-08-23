import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/model/task.dart';
import 'package:todolist/screens/tasks.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.fromFirestore(snapshot.data()!),
            toFirestore: (task, options) => task.toFirestore());
  }

  static Future<void> addTaskToFireStore(Task taskobj) {
    var taskCollection = getTasksCollection();
    var taskDocRef = taskCollection.doc();
    taskobj.id = taskDocRef.id; //auto id
    return taskDocRef.set(taskobj);
  }

  static Future<void> deleteTaskFromFireStore(Task task) {
    return getTasksCollection().doc(task.id).delete();
  }

  static Future<void> updateTaskToFireStore(Task taskobj) {
    // return getTasksCollection().doc(taskobj.id).update(taskobj.toFirestore());
    var taskCollection = getTasksCollection();
    var taskDocRef = taskCollection.doc(taskobj.id);
    taskobj.id = taskDocRef.id; //au
    return taskDocRef.update(taskobj.toFirestore());
  }
}
