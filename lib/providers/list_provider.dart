import 'package:flutter/material.dart';
import 'package:todolist/firebase/firebase_utils.dart';
import 'package:todolist/model/task.dart';

class ListProvider extends ChangeNotifier {
  List<Task> taskList = [];
  var selectDate = DateTime.now();

  void getAllTaskFromFireStore() async {
    var querySnap = await FirebaseUtils.getTasksCollection().get();
    taskList = querySnap.docs.map((doc) => doc.data()).toList();

    print(
        'Fetched ${taskList.length} tasks'); // Log the number of fetched tasks

    // Filtering tasks based on the selected date
    taskList = taskList.where(
      (task) {
        return selectDate.day == task.dateTime.day &&
            selectDate.month == task.dateTime.month &&
            selectDate.year == task.dateTime.year;
      },
    ).toList();

    print(
        'Filtered ${taskList.length} tasks for date $selectDate'); // Log the number of filtered tasks

    notifyListeners(); // Notify listeners after filtering
  }

  void changeSelectedDate(DateTime newDate) {
    if (selectDate != newDate) {
      selectDate = newDate;
      getAllTaskFromFireStore();
    }
  }
}
