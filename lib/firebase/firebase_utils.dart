import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/model/task.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.FromFireStore(snapshot.data()!),
            toFirestore: (task, options) => task.ToFirestore());
  }

  static Future<void> addTaskToFireStore(Task taskobj) {
    var taskCollection = getTasksCollection();
    var taskDocRef = taskCollection.doc();
    taskobj.id = taskDocRef.id; //auto id
    return taskDocRef.set(taskobj);
  }
}
