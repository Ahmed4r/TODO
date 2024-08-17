import 'package:flutter/material.dart';
import 'package:todolist/appcolor.dart';

class Tasksheet extends StatelessWidget {
  var fomrkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.6,
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Text("Add New Task",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Form(
            key: fomrkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "Enter Task Title") ,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    decoration:
                        InputDecoration(hintText: "Enter Task Description"),
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
                  child: Text('13/8/2024',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Appcolors.blueColor)),
                    onPressed: () {},
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
      decoration: BoxDecoration(color: Appcolors.whiteColor),
    );
  }
}
