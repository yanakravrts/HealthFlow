import 'package:flutter/material.dart';
import 'article.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
      body: Stack(
        children: [
          Positioned(
            top: 97,
            left: 20,
            child: InkWell(
              onTap: () {
                print('Menu Clicked');
              },
              child: Image.asset(
                'assets/menu.jpg',
                width: 45,
                height: 40,
              ),
            ),
          ),
          Positioned(
            top: 88,
            left: 217,
            child: InkWell(
              onTap: () {
                print('My Tips Clicked');
              },
              child: Container(
                width: 217,
                height: 55,
                decoration: BoxDecoration(),
                child: Center(
                  child: Text(
                    'My Tips',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto Flex',
                      fontSize: 32,
                      height: 1.4,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 167,
            left: 34,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ArticlePage()),
                );
                print('Topic 1 Clicked');
              },
              child: Container(
                width: 350,
                height: 190,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: AssetImage('assets/topic1.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Align(
                    alignment: FractionalOffset.bottomLeft,
                    child: Text(
                      'Shining light on an aggressive brain cancer',
                      style: TextStyle(
                        fontFamily: 'Roboto Flex',
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        color: Color.fromRGBO(245, 245, 245, 1),
                        height: 1.4,
                        letterSpacing: 0,
                        shadows: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 5,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 401,
            left: 35,
            child: InkWell(
              onTap: () {
                print('Topic 2 Clicked');
              },
              child: Container(
                width: 353,
                height: 190,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: AssetImage('assets/topic2.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Align(
                    alignment: FractionalOffset.bottomLeft,
                    child: Text(
                      'Restoring sight to the blind with cutting-edge brain implants',
                      style: TextStyle(
                        fontFamily: 'Roboto Flex',
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        color: Color.fromRGBO(245, 245, 245, 1),
                        height: 1.4,
                        letterSpacing: 0,
                        shadows: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 5,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 746,
            left: -187,
            child: InkWell(
              onTap: () {
                print('Rictangle Clicked');
              },
              child: Transform.scale(
                scale: 0.53,
                child: Image.asset('assets/rictangle_home.jpg'),
              ),
            ),
          ),
          Positioned(
            top: 646,
            left: -58,
            child: InkWell(
              onTap: () {
                print('Elipse Home Clicked');
              },
              child: Transform.scale(
                scale: 0.5,
                child: Image.asset('assets/elipsehome.jpg'),
              ),
            ),
          ),
          Positioned(
            top: 736,
            left: 36,
            child: InkWell(
              onTap: () {
                print('Elips Home Clicked');
              },
              child: Transform.scale(
                scale: 0.5,
                child: Image.asset('assets/elips_home.jpg'),
              ),
            ),
          ),
          Positioned(
            top: 775,
            left: 73,
            child: InkWell(
              onTap: () {
                print('Home Clicked');
              },
              child: Transform.scale(
                scale: 0.5,
                child: Image.asset('assets/home.jpg'),
              ),
            ),
          ),
          Positioned(
            top: 585,
            left: -12,
            child: InkWell(
              onTap: () {
                print('Calendar Clicked');
              },
              child: Transform.scale(
                scale: 0.1,
                child: Image.asset('assets/calendar.jpg'),
              ),
            ),
          ),
          Positioned(
            top: 780,
            left: 310,
            child: InkWell(
              onTap: () {
                print('Probirka Clicked');
              },
              child: Transform.scale(
                scale: 0.5,
                child: Image.asset('assets/probirka.jpg'),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: CustomMyRectangle(
              // width: 200,
              // height: 100,
              // color: Colors.blue,
            ),
          ),
          Positioned(
            top: 60,
            left: -5,
            child: Transform.scale(
              scale: 0.7,
              child: Elipse(
                width: 150,
                height: 130,
                color: Colors.blue,
              ),
            ),
          ),
          Positioned(
            top: -33,
            left: -55,
            child: Transform.scale(
              scale: 0.61,
              child: Image.asset(
                'assets/4.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 135,
            child: Text(
              'Name',
              style: TextStyle(
                fontFamily: 'Roboto Flex',
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                height: 23 / 20,
                letterSpacing: 0,
              ),
            ),
          ),
          Positioned(
            top: 130,
            left: 135,
            child: Text(
              'View profile',
              style: TextStyle(
                fontFamily: 'Roboto Flex',
                fontSize: 21,
                fontWeight: FontWeight.w400,
                color: const Color.fromRGBO(128, 128, 128, 1),
                height: 23 / 20,
                letterSpacing: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomMyRectangle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Positioned(
      top:0,
      left:0,
      child: Container(

        width: 350,
        height: 900,
        color: const Color.fromRGBO(245, 245, 245, 1),
        child: Stack(
          children: [
            Positioned(
              top: 60,
              left: -5,
              child: Transform.scale(
                scale: 0.7,
                child: Elipse(
                  width: 150,
                  height: 130,
                  color: Colors.blue,
                ),
              ),
            ),
            Positioned(
              top: -33,
              left: -55,
              child: Transform.scale(
                scale: 0.61,
                child: Image.asset(
                  'assets/4.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Positioned(
              top: 180,
              left: 70,
              child: Transform.scale(
                scale: 2.58,
                child: Image.asset('assets/blood.png', width: 100, height: 100),
              ),
            ),
            Positioned(
              top: 265,
              left:67,
              child: Transform.scale(
                scale: 2.43,
                child: Image.asset('assets/q.png', width: 100, height: 100),
              ),
            ),
            Positioned(
              top: 345,
              left: 67,
              child: Transform.scale(
                scale: 2.43,
                child: Image.asset('assets/people.png', width: 100, height: 100),
              ),
            ),
            Positioned(
              top: 220,
              left: 100,
              child: Text(
                'Blood Bank',
                style: TextStyle(
                  fontFamily: 'Roboto Flex',
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(128, 128, 128, 1),
                  height: 23 / 20,
                  letterSpacing: 0,
                ),
              ),
            ),
            Positioned(
              top: 305,
              left: 100,
              child: Text(
                'Help',
                style: TextStyle(
                  fontFamily: 'Roboto Flex',
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(128, 128, 128, 1),
                  height: 23 / 20,
                  letterSpacing: 0,
                ),
              ),
            ),
            Positioned(
              top: 385,
              left: 100,
              child: Text(
                'About us',
                style: TextStyle(
                  fontFamily: 'Roboto Flex',
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(128, 128, 128, 1),
                  height: 23 / 20,
                  letterSpacing: 0,
                ),
              ),
            ),
            Container(
              width: 356,
              height: 1,
              margin: EdgeInsets.only(top: 180),
              color: Color.fromRGBO(143, 142, 142, 1),
            ),
          ],
        ),
      ),
    );
  }
}
class Elipse extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  Elipse({
    required this.width,
    required this.height,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 130,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color.fromRGBO(85, 162, 166, 1),
      ),
    );
  }
}
