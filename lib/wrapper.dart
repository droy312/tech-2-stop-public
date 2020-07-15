import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_two_stop/models/user.dart';
import 'screens/authenticate/authenticate.dart';

import 'screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return HomePage();
    }
  }
}
