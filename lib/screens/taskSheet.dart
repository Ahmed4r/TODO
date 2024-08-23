import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/appcolor.dart';
import 'package:todolist/firebase/firebase_utils.dart';
import 'package:todolist/model/task.dart';
import 'package:todolist/providers/list_provider.dart';

class Tasksheet extends StatefulWidget {
  static final formkey = GlobalKey<FormState>();

  @override
  State<Tasksheet> createState() => _TasksheetState();
}

class _TasksheetState extends State<Tasksheet> {
  String title = '';
  String description = '';
  var selctedDate = DateTime.now();
  late ListProvider listprovider;

  @override
  Widget build(BuildContext context) {
    listprovider = Provider.of<ListProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.6,
      padding: EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text("Add New Task",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Form(
              key: Tasksheet.formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "Enter Task Title",
                      ),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "please enter task title ";
                        }
                        return null;
                      },
                      onChanged: (text) {
                        title = text;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration:
                          InputDecoration(hintText: "Enter Task Description"),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "please enter task description";
                        }
                        return null;
                      },
                      onChanged: (text) {
                        description = text;
                      },
                      maxLines: 4,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Select Date',
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {
                        showcalnder();
                      },
                      child: Text(
                          '${selctedDate.day}/${selctedDate.month}/${selctedDate.year}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall),
                    ),
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Appcolors.blueColor)),
                      onPressed: () {
                        addtask();
                      },
                      child: Text(
                        "add",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
      decoration: BoxDecoration(color: Appcolors.whiteColor),
    );
  }

  void addtask() {
    if (Tasksheet.formkey.currentState?.validate() == true) {
      Task task =
          Task(title: title, description: description, dateTime: selctedDate);
      FirebaseUtils.addTaskToFireStore(task).timeout(
        Duration(seconds: 1),
        onTimeout: () {
          print('task added succesffully');
          
          listprovider.getAllTaskFromFireStore();
          Navigator.pop(context);
        }, 
      );

      // offline;
    }
  }

  void showcalnder() async {
    var chosenDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    // if (chosenDate != null) {
    //   selctedDate = chosenDate;
    // }
    selctedDate = chosenDate ?? DateTime.now();
    setState(() {});
  }
}
