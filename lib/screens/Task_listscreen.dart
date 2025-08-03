import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:provider/provider.dart';
import 'package:todolist/providers/app_config_provider.dart';
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
    var provider = Provider.of<AppConfigProvider>(context);
    var isdark = provider.isdarkmode();

    return Container(
      child: Column(
        children: [
          EasyDateTimeLine(
            
            headerProps: EasyHeaderProps(
              selectedDateStyle: TextStyle(
                  color: provider.isdarkmode() ? Colors.white : Colors.black),
              monthStyle: TextStyle(
                  color: provider.isdarkmode() ? Colors.white : Colors.black),
            ),
            locale: provider.applanguage,
            initialDate: DateTime.now(),
            onDateChange: (selectedDate) {
              listprovider.changeSelectedDate(selectedDate);
            },
           
            activeColor: const Color(0xff85A389),
            dayProps: EasyDayProps(
              inactiveDayNumStyle: TextStyle(
                  color: isdark == true ? Colors.white : Colors.black,
                  fontSize: 21,
                  fontWeight: FontWeight.bold),
              todayHighlightStyle: TodayHighlightStyle.withBackground,
              inactiveMothStrStyle: TextStyle(
                  color: isdark == true ? Colors.white : Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
              inactiveDayStrStyle: TextStyle(
                  color: isdark == true ? Colors.white : Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
              inactiveDayStyle: DayStyle(dayNumStyle: TextStyle(
                  color: isdark == true ? Colors.white : Colors.black,
                  fontSize: 21,
                  fontWeight: FontWeight.bold)),
              todayHighlightColor: Color.fromARGB(255, 87, 92, 75),
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
