import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:provider/provider.dart';
import 'package:todolist/providers/list_provider.dart';
import 'package:todolist/screens/tasks.dart';

class Listscreen extends StatefulWidget {
  Listscreen({super.key});

  @override
  State<Listscreen> createState() => _ListscreenState();
}

class _ListscreenState extends State<Listscreen> {
  @override
  Widget build(BuildContext context) {
    var listprovider = Provider.of<ListProvider>(context);

    return Container(
      child: Column(
        children: [
          EasyDateTimeLine(
            initialDate: DateTime.now(),
            onDateChange: (selectedDate) {
              listprovider.changeSelectedDate(selectedDate);
            },
            activeColor: const Color(0xff85A389),
            dayProps: const EasyDayProps(
              todayHighlightStyle: TodayHighlightStyle.withBackground,
              todayHighlightColor: Color(0xffE1ECC8),
            ),
          ),
          Expanded(
            child: listprovider.taskList.isEmpty
                ? Center(child: Text('No Tasks Added'))
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return Tasks(task: listprovider.taskList[index]);
                    },
                    itemCount: listprovider.taskList.length,
                  ),
          ),
        ],
      ),
    );
  }
}
