import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todolist/appcolor.dart';
import 'package:todolist/firebase/firebase_utils.dart';
import 'package:todolist/model/task.dart';
import 'package:todolist/providers/app_config_provider.dart';
import 'package:todolist/providers/list_provider.dart';

class Edittask extends StatefulWidget {
  static final formkey = GlobalKey<FormState>();
  const Edittask({super.key});

  @override
  State<Edittask> createState() => _EdittaskState();
}

class _EdittaskState extends State<Edittask> {
  String title = '';
  String description = '';
  var selctedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var listprovider = Provider.of<ListProvider>(context);
    return Container(
      color: provider.isdarkmode()
          ? Appcolors.blackColorCategory
          : Appcolors.whiteColor,
      width: MediaQuery.of(context).size.width * 1,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("Edit Task",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: provider.isdarkmode()
                      ? Appcolors.whiteColor
                      : Appcolors.blackColorCategory,
                )),
            Form(
              key: Edittask.formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 18,
                        color: provider.isdarkmode()
                            ? Appcolors.whiteColor
                            : Appcolors.blackColorCategory,
                      ),
                      decoration: InputDecoration(
                          hintText: "This is Title",
                          hintStyle: TextStyle(
                              color: provider.isdarkmode()
                                  ? Appcolors.whiteColor
                                  : Appcolors.blackColorCategory)),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "please enter task title";
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
                      style: TextStyle(
                        fontSize: 18,
                        color: provider.isdarkmode()
                            ? Appcolors.whiteColor
                            : Appcolors.blackColorCategory,
                      ),
                      decoration: InputDecoration(
                          hintText: "Task details",
                          hintStyle: TextStyle(
                              color: provider.isdarkmode()
                                  ? Appcolors.whiteColor
                                  : Appcolors.blackColorCategory)),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "please enter task description";
                        }
                        return null;
                      },
                      onChanged: (text) {
                        description = text;
                      },
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Select Time',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: provider.isdarkmode()
                            ? Appcolors.whiteColor
                            : Appcolors.blackColorCategory,
                      ),
                    ),
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
                        style: TextStyle(
                            fontSize: 18,
                            color: provider.isdarkmode()
                                ? Color(0xffDBDBDB)
                                : Color(0xffA9A9A99C)),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Appcolors.blueColor)),
                        onPressed: () {
                          editTaskFunc();
                        },
                        child: Text(
                          "Save Changes",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void showcalnder() async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: selctedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (chosenDate != null) {
      setState(() {
        selctedDate = chosenDate;
      });
    }
  }

  void editTaskFunc() {
    if (Edittask.formkey.currentState?.validate() == true) {
      Edittask.formkey.currentState?.save();
    }
  }
}
