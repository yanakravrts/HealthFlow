import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(85, 162, 166, 1),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 354,
                height: 195,
                child: Text(
                  'Create password',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0,
                    color: Color.fromRGBO(245, 245, 245, 1),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 202),
              Container(
                width: 320,
                height: 69,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password',
                  ),
                ),
              ),
              SizedBox(height: 46),
              ElevatedButton(
                onPressed: () {},
                child: Container(
                  width: 295,
                  height: 60,
                  alignment: Alignment.center,
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(34, 151, 161, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
