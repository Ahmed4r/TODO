
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

    // Log the number of filtered tasks

    // Notify listeners after filtering
    //sorting
    taskList.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    
    notifyListeners();
  }

  void changeSelectedDate(DateTime newDate) {
    if (selectDate != newDate) {
      selectDate = newDate;
      getAllTaskFromFireStore();
    }
  }
}
