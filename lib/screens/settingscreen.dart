import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todolist/appcolor.dart';
import 'package:todolist/providers/app_config_provider.dart';
import 'package:todolist/screens/languagesheet.dart';
import 'package:todolist/screens/modesheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Settingscreen extends StatefulWidget {
  const Settingscreen({super.key});

  @override
  State<Settingscreen> createState() => _SettingscreenState();
}

class _SettingscreenState extends State<Settingscreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.of(context)!.language,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: provider.isdarkmode() ? Colors.white : Colors.black),
              selectionColor: Colors.black,
            ),
          ),
          SizedBox(
            height: 50,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: provider.isdarkmode()
                      ? const Color.fromARGB(255, 34, 40, 52)
                      : Appcolors.whiteColor,
                  border: Border.all(color: Appcolors.blueColor)),
              child: InkWell(
                onTap: () {
                  showlanguagesheet();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        provider.applanguage == 'en'
                            ? AppLocalizations.of(context)!.english
                            : AppLocalizations.of(context)!.arabic,
                        style: GoogleFonts.inter(
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                            color: Appcolors.blueColor)),
                    Icon(
                      Icons.arrow_drop_down,
                      color: provider.isdarkmode()
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : Appcolors.blackColorCategory,
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.of(context)!.mode,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: provider.isdarkmode() ? Colors.white : Colors.black),
            ),
          ),
          SizedBox(
            height: 50,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: provider.isdarkmode()
                      ? const Color.fromARGB(255, 34, 40, 52)
                      : Appcolors.whiteColor,
                  border: Border.all(color: Appcolors.blueColor)),
              child: InkWell(
                onTap: () {
                  showmodesheet();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        provider.appTheme == ThemeMode.light
                            ? AppLocalizations.of(context)!.light
                            : AppLocalizations.of(context)!.dark,
                        style: GoogleFonts.inter(
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                            color: Appcolors.blueColor)),
                    Icon(
                      Icons.arrow_drop_down,
                      color: provider.isdarkmode()
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : const Color.fromARGB(255, 0, 0, 0),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void showlanguagesheet() {
    showModalBottomSheet(
        context: context, builder: (context) => Languagesheet());
  }

  void showmodesheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Modesheet(),
    );
  }
}
