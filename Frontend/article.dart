import 'package:flutter/material.dart';

import 'homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ArticlePage(),
    );
  }
}

class ArticlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 200, 255, 1),
      body: Stack(
        children: [
          Positioned(
            top: -110,
            left: 6,
            height: 385,
            width: 385,
            child: Transform.scale(
              alignment: FractionalOffset.topCenter,
              scale: 1.35,
              child: Image.asset('assets/topic1.jpg'),
            ),
          ),
          //test 

          Positioned(
            top: 258,
            left: 10,
            child: Transform.scale(
              alignment: FractionalOffset.topCenter,
              scaleX: 1.07,
              scaleY: 1.2,
              child: Container(
                width: 393,
                height: 572,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 268,
            left: 37,
            width: 350,
            height: 350,
            child: Transform.scale(
              alignment: FractionalOffset.topCenter,
              scale: 1,
              child: Transform.translate(
                offset: Offset(0, 8),
                child: Text(
                  'Shining light on an aggressive brain cancer',
                  style: TextStyle(
                    fontFamily: 'Roboto Flex',
                    fontSize: 25,
                    letterSpacing: 0,
                    shadows: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 3,
                        offset: Offset(0, 0),
                      ),
                    ],
                    fontWeight: FontWeight.normal,
                    color: const Color.fromRGBO(0, 0, 0, 0.77),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Positioned(
            top: 340,
            left: 30,
            width: 350,
            height: 500,
            child: Transform.scale(
              alignment: FractionalOffset.topCenter,
              scale: 1,
              child: Transform.translate(
                offset: Offset(0, 8),
                child: Text(
                  'Brain surgeons need steady hands as well as cool heads. Now they’re getting a helping hand from researchers in Europe to fight a fatal type of brain cancer called glioblastoma. A Danish biotechnology company named FluoGuide led a research project that received EU funding to pinpoint glioblastoma better so surgeons can more easily remove it. FluoGuide developed a fluorescent chemical dye that’s injected into patients before surgery.\n\nResearch in this article was funded by the EU via the Marie Skłodowska-Curie Actions (MSCA).',
                  style: TextStyle(
                    fontFamily: 'Roboto Flex',
                    fontSize: 18,
                    letterSpacing: 0,
                    color: const Color.fromRGBO(0, 0, 0, 0.77),
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
          Positioned(
            top: 770,
            left: 0,
            right: 0,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundButton("Back", () {Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );}
                ),
                RoundButton("Go on reading", () {
                  // Додайте код для продовження читання
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RoundButton extends StatelessWidget {
  const RoundButton(this.text, this._onPressed, {Key? key})
      : super(key: key);

  final String text;
  final VoidCallback _onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 150,
      child: ElevatedButton(
        onPressed: _onPressed,

        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(78, 171, 179, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(70),
          ),
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          textStyle: const TextStyle(
            fontFamily: 'Roboto Flex',
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          side: BorderSide.none,
        ),
        child: Text(
          text,
          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),

        ),
      ),

    );

  }

}

