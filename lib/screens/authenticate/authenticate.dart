import 'package:flutter/material.dart';
import 'package:tech_two_stop/screens/home/home.dart';
import '../../services/auth.dart';

class Authenticate extends StatefulWidget {
  Authenticate({Key key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  TextStyle style(Color color, double size, bool isBold) {
    return TextStyle(
      fontFamily: 'Poppins',
      color: color,
      fontSize: size,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    );
  }

  bool isSkip = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 200.0),
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    child: Image.asset('images/tech2stop_header_logo.jpeg', fit: BoxFit.fitWidth),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      'Your OneStop Destination For Everything Tech',
                      style: style(Colors.white70, 16.0, false),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 40.0, right: 40.0, bottom: 60.0),
              alignment: Alignment.bottomCenter,
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 10.0),
                      color: Colors.white,
                      onPressed: () => AuthService().signInWithGoogle(),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('images/google_logo.png',
                              width: 28.0, fit: BoxFit.fitWidth),
                          SizedBox(width: 10.0),
                          Text('Sign in with Google',
                              style: style(Colors.black87, 18.0, false)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 10.0),
                      color: Colors.white,
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(isSkip: true), //TODO
                          )),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0)),
                      child:
                          Text('Skip', style: style(Colors.black, 18.0, false)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
