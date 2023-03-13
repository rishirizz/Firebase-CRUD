import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crud/pages/users_page.dart';
import 'package:flutter/material.dart';

import 'forms/add_user_form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UsersPage(),
      onGenerateRoute: (settings) {
        var routes = <String, WidgetBuilder>{
          AddUserForm.routeName: (BuildContext context) => const AddUserForm(),
        };
        WidgetBuilder builder = routes[settings.name]!;
        return MaterialPageRoute(
          builder: (ctx) => builder(ctx),
        );
      },
    );
  }
}
