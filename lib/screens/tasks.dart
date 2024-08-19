import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todolist/appcolor.dart';
import 'package:todolist/screens/editTask.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Slidable(
        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          extentRatio: 0.50,
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),

          // A pane can dismiss the Slidable.

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                //delete from data base
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                showeditscreen();
              },
              backgroundColor: Colors.greenAccent,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit ',
            ),
          ],
        ),
        child: Container(
          // margin: EdgeInsets.all(12),
          padding: EdgeInsets.all(15),
          height: MediaQuery.of(context).size.height * 0.14,
          decoration: BoxDecoration(
              color: Appcolors.whiteColor,
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              VerticalDivider(
                thickness: 3,
                color: Colors.blue,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        "Play basket ball",
                        style: TextStyle(
                            color: Appcolors.blueColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.watch_later_outlined,
                              size: 18,
                            ),
                            Text(
                              '10:30 AM',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ]),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 30,
                ),
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.blue)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showeditscreen() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Edittask(),
    );
  }
}
