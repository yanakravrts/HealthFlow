import 'package:flutter/material.dart';
import 'terms.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Вимкнення червоного напису "Debug"
      home: GetstartedPage(),
    );
  }
}

class GetstartedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 500,
        height: 800,
        color: const Color.fromRGBO(255, 255, 255, 1),
        child: Stack(
          children: [
            Center(
              child: Transform.scale(
                scale: 1.111,
                child: Image.asset('assets/getStarted.png', width: 470, height: 800),
              ),
            ),
            Positioned(
              bottom: -100, // Збільшений вертикальний відступ
              left: 20,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  // Обробник подій для тексту "Click here to create one"
                  print('Navigate to account creation');
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: Colors.black.withOpacity(0.5), // Прозорий чорний колір
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: " By tapping GET STARTED, you agree to our Terms of Use and Privacy Police. Please review them ",
                      style: TextStyle(
                        fontFamily: 'RobotoFlex',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                      children: [
                        TextSpan(
                          text: " Terms of Use and Privacy Police. ",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontFamily: 'RobotoFlex',
                            color: Color.fromRGBO(62, 100, 198, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: LoginButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TermsPage()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(87, 163, 167, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        textStyle: TextStyle(
          color: const Color.fromRGBO(255, 254, 0, 1),
          fontFamily: 'RobotoFlex',
          fontSize: 26,
          fontWeight: FontWeight.normal,
        ),
        side: BorderSide.none,
      ),
      child: Container(
        width: 220,
        alignment: Alignment.center,
        height: 50,
        child: Text(
          'ПОЧНІМО',
          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
        ),
      ),
    );
  }
}
