import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todolist/providers/app_config_provider.dart';
import 'package:todolist/screens/homepage.dart';
import 'package:todolist/themeData.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // debugPaintSizeEnabled = true;
  runApp(ChangeNotifierProvider(
    create: (context) => AppConfigProvider(),
    child: TodoList(),
  ));
}

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.applanguage),
      themeMode: provider.appTheme,
      theme: MyThemeData.ligthTheme,
      darkTheme: MyThemeData.darkTheme,
      initialRoute: Homepage.routeName,
      routes: {
        Homepage.routeName: (context) => Homepage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
