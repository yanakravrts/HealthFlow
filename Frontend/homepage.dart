import 'package:flutter/material.dart';

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
      backgroundColor: Color.fromRGBO(245, 245, 245,1),
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
                    'Restoring sight to the blind with cutt=ing-edge brain implants',
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
        ],
      ),
    );
  }
}
