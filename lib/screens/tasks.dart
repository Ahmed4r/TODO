import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolist/appcolor.dart';

class Tasks extends StatelessWidget {
  const Tasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.all(15),
      height: MediaQuery.of(context).size.height * 0.12,
      decoration: BoxDecoration(
          color: Appcolors.whiteColor, borderRadius: BorderRadius.circular(15)),
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
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                backgroundColor: WidgetStatePropertyAll(Colors.blue)),
          ),
        ],
      ),
    );
  }
}
