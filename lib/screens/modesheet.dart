import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todolist/appcolor.dart';
import 'package:todolist/providers/app_config_provider.dart';

class Modesheet extends StatefulWidget {
  const Modesheet({super.key});

  @override
  State<Modesheet> createState() => _ModesheetState();
}

class _ModesheetState extends State<Modesheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var isdark = provider.isdarkmode();

    return Container(
      color: provider.isdarkmode() ? Color(0xff2E2E2E) : Colors.white,
      
      padding: EdgeInsets.all(15),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 1,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  provider.changeTheme(ThemeMode.light);
                },
                child: provider.appTheme == ThemeMode.light
                    ? getSelectedItemWidget(AppLocalizations.of(context)!.light)
                    : getUnselectedItemWidget(
                        AppLocalizations.of(context)!.light, isdark = true),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  provider.changeTheme(ThemeMode.dark);
                },
                child: provider.isdarkmode()
                    ? getSelectedItemWidget(AppLocalizations.of(context)!.dark)
                    : getUnselectedItemWidget(
                        AppLocalizations.of(context)!.dark, isdark),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getSelectedItemWidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Appcolors.blueColor),
        ),
        Icon(
          Icons.check,
          size: 30,
          color: Appcolors.blueColor,
        )
      ],
    );
  }

  Widget getUnselectedItemWidget(String text, isdark) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(color: isdark == true ? Colors.white : Colors.black),
    );
  }
}
