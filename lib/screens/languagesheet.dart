import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todolist/appcolor.dart';
import 'package:todolist/providers/app_config_provider.dart';

class Languagesheet extends StatefulWidget {
  static const String routename = 'language_screen';
  const Languagesheet({super.key});

  @override
  State<Languagesheet> createState() => _LanguagesheetState();
}

class _LanguagesheetState extends State<Languagesheet> {
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
                    onTap: ()  {
                      provider.changeLanguage('en');
                    },
                    child: provider.applanguage == 'en'
                        ? getSelectedItemWidget(
                            AppLocalizations.of(context)!.english)
                        : getUnselectedItemWidget(
                            AppLocalizations.of(context)!.english, isdark))),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                  onTap: () {
                    provider.changeLanguage('ar');
                  },
                  child: provider.applanguage == 'ar'
                      ? getSelectedItemWidget(
                          AppLocalizations.of(context)!.arabic)
                      : getUnselectedItemWidget(
                          AppLocalizations.of(context)!.arabic, isdark)),
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
