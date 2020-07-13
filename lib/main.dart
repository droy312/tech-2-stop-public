import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_two_stop/services/auth.dart';
import 'wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Tech 2 Stop',
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
