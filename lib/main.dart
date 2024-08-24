import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todolist/providers/app_config_provider.dart';
import 'package:todolist/providers/list_provider.dart';
import 'package:todolist/screens/homepage.dart';
import 'package:todolist/screens/login.dart';
import 'package:todolist/screens/register_screen.dart';
import 'package:todolist/themeData.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDymZM3RlO__BAhKYOPbRgTYUZ-gyHojDo",
          appId: "com.example.todolist",
          messagingSenderId: "8348827972",
          projectId: "todo-65018"));
  await FirebaseFirestore.instance.disableNetwork();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AppConfigProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ListProvider(),
      )
    ],
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
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        Homepage.routeName: (context) => Homepage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
