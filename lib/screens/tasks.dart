import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todolist/appcolor.dart';
import 'package:todolist/firebase/firebase_utils.dart';
import 'package:todolist/model/task.dart';
import 'package:todolist/providers/app_config_provider.dart';
import 'package:todolist/providers/list_provider.dart';
import 'package:todolist/screens/editTask.dart';

class Tasks extends StatefulWidget {
  Task task;
  Tasks({required this.task});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    var listprovider = Provider.of<ListProvider>(context);
    var appprovider = Provider.of<AppConfigProvider>(context);

    return Container(
      key: ValueKey(widget.task.id),
      margin: EdgeInsets.all(8),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.50,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                try {
                  FirebaseUtils.deleteTaskFromFireStore(widget.task);
                  listprovider.getAllTaskFromFireStore();

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Task Deleted successfully!'),
                    duration: Duration(seconds: 2),
                  ));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to Delete Task: $e')),
                  );
                }
              },
              // Delete task logic

              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                showeditscreen(context);
              },
              backgroundColor: Colors.greenAccent,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(15),
          height: MediaQuery.of(context).size.height * 0.17, // Reduced height
          decoration: BoxDecoration(
            color: appprovider.isdarkmode()
                ? const Color.fromARGB(255, 46, 45, 45)
                : Appcolors.whiteColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              VerticalDivider(
                thickness: 3,
                color: widget.task.isDone ? Appcolors.greenColor : Colors.blue,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize:
                        MainAxisSize.min, // Adjusts to available space
                    children: [
                      Text(
                        widget.task.title,
                        style: TextStyle(
                          color: widget.task.isDone
                              ? Appcolors.greenColor
                              : Appcolors.blueColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.task.description,
                              style: TextStyle(
                                color: widget.task.isDone
                                    ? Appcolors.greenColor
                                    : Appcolors.blueColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              overflow:
                                  TextOverflow.ellipsis, // Handle text overflow
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    setState(() {
                      widget.task.isDone =
                          !widget.task.isDone; // Toggle completion state in UI
                    });
                    await FirebaseUtils.updateTaskToFireStore(widget.task);
                    listprovider
                        .getAllTaskFromFireStore(); // Refresh tasks list after update
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to update task: $e')),
                    );
                  }
                },
                child: widget.task.isDone
                    ? Text(
                        'Done!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      )
                    : Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 30,
                      ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(widget.task.isDone
                      ? Appcolors.greenColor
                      : Appcolors.blueColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showeditscreen(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Edittask(
        task: widget.task,
      ),
    );
  }
}
