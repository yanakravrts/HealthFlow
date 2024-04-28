import 'package:flutter/material.dart';
import 'homepage.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BloodPage(),
    );
  }
}

class BloodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Positioned(
      top:0,
      left:0,
      child: Container(

        width: 500,
        height: 800,
        color: const Color.fromRGBO(245, 245, 245, 1),
        child: Stack(
          children: [


            Positioned(
              top: 140,
              left: -7,
              width: 430,
              height: 80,
              child: Transform.scale(
                scale: 1.2,
                child: Image.asset('assets/rectangle_blood.png', width: 100, height: 100),
              ),
            ),
            Positioned(
              top: 175,
              left: 30,
              child: Text(
                'Type',
                style: TextStyle(
                  fontFamily: 'Roboto Flex',
                  fontSize: 27,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(128, 128, 128, 1),
                  height: 23 / 20,
                  letterSpacing: 0,
                ),
              ),
            ),
            Positioned(
              top: 175,
              left: 220,
              child: Text(
                'Requests',
                style: TextStyle(
                  fontFamily: 'Roboto Flex',
                  fontSize: 27,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(128, 128, 128, 1),
                  height: 23 / 20,
                  letterSpacing: 0,
                ),
              ),
            ),


            Positioned(
              top: 245,
              left: 149,
              child: Transform.scale(
                scale: 0.7,
                child: Image.asset('assets/hospital.png', width: 100, height: 100),
              ),
            ),
            Positioned(
              top: 285,
              left: 45,
              child: Text(
                '2+',
                style: TextStyle(
                  fontFamily: 'Roboto Flex',
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(0, 0, 0, 0.73),
                  height: 23 / 20,
                  letterSpacing: 0,
                ),
              ),
            ),
            Positioned(
                top: 275,
                left: 335,
                child:TextButton(
                  onPressed: () {
                    // Navigator.push(
                      // context,
                      // MaterialPageRoute(builder: (context) => HomePage()),
                    // );
                    print('Back button clicked');

                  }, // Image tapped
                  child: Image.asset(
                    'assets/2.png',
                    fit: BoxFit.cover, // Fixes border issues
                    width:17,
                    height: 17,
                  ),
                )
            ),
            Positioned(
              top: 365,
              left:149,
              child: Transform.scale(
                scale: 0.7,
                child: Image.asset('assets/hospital.png', width: 100, height: 100),
              ),
            ),


            Positioned(
              top: 405,
              left: 45,
              child: Text(
                '1-',
                style: TextStyle(
                  fontFamily: 'Roboto Flex',
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(0, 0, 0, 0.73),
                  height: 23 / 20,
                  letterSpacing: 0,
                ),
              ),
            ),
            Positioned(
                top: 395,
                left: 335,
                child:TextButton(
                  onPressed: () {
                    // Navigator.push(
                    // context,
                    // MaterialPageRoute(builder: (context) => HomePage()),
                    // );
                    print('Back button clicked');

                  }, // Image tapped
                  child: Image.asset(
                    'assets/2.png',
                    fit: BoxFit.cover, // Fixes border issues
                    width:17,
                    height: 17,
                  ),
                )

            ),
            Positioned(
              top: 55,
              left: -20,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  print('Back button clicked');
                },
                child: Image.asset(
                  'assets/back.png',
                  fit: BoxFit.cover,
                  width: 320,
                  height: 110,
                ),
              ),
            ),
            Container(
              width: 412,
              height: 1,
              margin: EdgeInsets.only(top: 228),
              color: Color.fromRGBO(34, 151, 161, 1),
            ),
            Container(
              width: 412,
              height: 1,
              margin: EdgeInsets.only(top: 348),
              color: Color.fromRGBO(34, 151, 161, 1),
            ),
            Container(
              width: 412,
              height: 1,
              margin: EdgeInsets.only(top: 468),
              color: Color.fromRGBO(34, 151, 161, 1),
            ),
            Container(
              width: 412,
              height: 1,
              margin: EdgeInsets.only(top: 588),
              color: Color.fromRGBO(34, 151, 161, 1),
            ),
            Container(
              width: 412,
              height: 1,
              margin: EdgeInsets.only(top: 708),
              color: Color.fromRGBO(34, 151, 161, 1),
            ),
            Container(
              width: 412,
              height: 1,
              margin: EdgeInsets.only(top: 828),
              color: Color.fromRGBO(34, 151, 161, 1),
            ),
            Container(
              width: 1,
              height: 690,  // Висота (змініть на бажану висоту)
              margin: EdgeInsets.only(left: 120, top: 228,), // Змініть відступи за необхідністю
              decoration: BoxDecoration(
                color: Color.fromRGBO(34, 151, 161, 1),
              ),
            ),

          ],
        ),
      ),
    );
  }
}