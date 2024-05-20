import 'package:flutter/material.dart';
import 'article.dart';
import 'Profile.dart';
import 'blood_bank.dart';
import 'Existfile.dart';
import 'noevent.dart';

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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  bool _menuVisibility = false;


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
                setState(() {
                  _menuVisibility = !_menuVisibility;
                });

                //Navigator.push(context, MaterialPageRoute(builder: (context) => CustomMyRectangle(width: width, height: height)));
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
            left: 205,
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
                    'Поради',
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => ArticlePage()));
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
                      'Проливаємо світло на агресивний рак мозку',
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
                      'Відновлення зору незрячим за допомогою новітніх мозкових імплантатів',
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
            top: 585,
            left: -12,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarPage()),
                );
                print('Calendar Clicked');
              },
              child: Transform.scale(
                scale: 0.1,
                child: Image.asset('assets/calendar.jpg'),
              ),
            ),
          ),
          Positioned(
            top: 775,
            left: 73,
            child: InkWell(
              onTap: null,
              child: Transform.scale(
                scale: 0.5,
                child: Image.asset('assets/home.jpg'),
              ),
            ),
          ),
          Positioned(
            top: 780,
            left: 310,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NofilePage()),
                );
                print('Probirka Clicked');
              },
              child: Transform.scale(
                scale: 0.5,
                child: Image.asset('assets/probirka.jpg'),
              ),
            ),
          ),
        if(_menuVisibility) CustomMyRectangle()
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
              top: 100,
              left: 135,
              child: Text(
                'Імʼя',
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
              top: 40,
              left: -20,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
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
            Positioned(
              top: 130,
              left: 135,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
                child: Text(
                  'Подивитись профіль',
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
              top: 236,
              left: 100,
              child: Text(
                'Банк крові',
                style: TextStyle(
                  fontFamily: 'Roboto Flex',
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
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
                'Допомога',
                style: TextStyle(
                  fontFamily: 'Roboto Flex',
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
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
                'Про нас',
                style: TextStyle(
                  fontFamily: 'Roboto Flex',
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
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
            Positioned(
              top: 178,
              left: -44,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BloodPage()),
                  );
                  print('Blood button clicked');
                },
                child: Transform.scale(
                  scale: 0.9,
                  child: Image.asset(
                    'assets/blood.png',
                    fit: BoxFit.cover, // Fixes border issues
                    width: 320,
                    height: 110,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
