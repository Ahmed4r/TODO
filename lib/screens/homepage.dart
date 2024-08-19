import 'package:flutter/material.dart';

import 'package:todolist/appcolor.dart';
import 'package:todolist/screens/Task_listscreen.dart';
import 'package:todolist/screens/settingscreen.dart';
import 'package:todolist/screens/taskSheet.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Homepage extends StatefulWidget {
  static const String routeName = "Homepage";

  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.25,
        title: Text(
          AppLocalizations.of(context)!.app_title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 13,
        child: BottomNavigationBar(
            showUnselectedLabels: false,
            elevation: 0,
            backgroundColor: Colors.transparent,
            selectedItemColor: Appcolors.blueColor,
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            currentIndex: selectedIndex,
            items: const [
              BottomNavigationBarItem(
                  label: 'TaskList',
                  icon: ImageIcon(
                    AssetImage('assets/iconList.png'),
                    size: 22,
                  )),
              BottomNavigationBarItem(
                  label: 'Settings',
                  icon: ImageIcon(
                    AssetImage('assets/Iconsettings.png'),
                    size: 22,
                  ))
            ]),
      ),
      body: tabs[selectedIndex]

      // selectedIndex == 0 ? Listscreen() : Settingscreen(),
      ,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTaskSheet();
        },
        child: Icon(Icons.add, color: Colors.white),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 4, color: Appcolors.whiteColor),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  List<Widget> tabs = [Listscreen(), Settingscreen()];

  void addTaskSheet() {
    showModalBottomSheet(context: context, builder: (context) => Tasksheet());
  }
}
