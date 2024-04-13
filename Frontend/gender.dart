import 'package:flutter/material.dart';
import 'Name.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GenderSelection(),
      ),
    );
  }
}

class GenderSelection extends StatefulWidget {
  @override
  _GenderSelectionState createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  late String selectedGender;

  @override
  void initState() {
    super.initState();
    selectedGender = "";
  }

  void selectGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
  }

  void goToNext(BuildContext context) {
    if (selectedGender.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NamePage()),
      );
    } else {
      // Handle the case where no gender is selected
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(85, 162, 166, 1),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 50),
            const Text(
              "Яка ваша стать?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 37,
                fontWeight: FontWeight.w400,
                fontFamily: 'Inter',
                height: 1.05,
              ),
            ),
            const SizedBox(height: 100),
            Stack(
              alignment: Alignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    selectGender('male');
                    goToNext(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(245, 245, 245, 0.89),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 110, vertical: 25), // Однакові значення padding
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter',
                      color: Color.fromRGBO(0, 0, 0, 0.77),
                    ),
                  ),
                  child: const Text("Чоловіча",
                    style: TextStyle(
                      color: const Color.fromRGBO(0, 0, 0, 0.77),
                      fontSize: 22,
                    ),),
                ),
                Positioned(
                  right: 240,
                  child: Image.asset(
                    'assets/m.png',
                    width: 43,
                    height: 43,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    selectGender('female');
                    goToNext(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(245, 245, 245, 0.89),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 110, vertical: 25), // Однакові значення padding
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(0, 0, 0, 0.77),
                    ),
                  ),
                  child: const Text("Жіноча",
                    style: TextStyle(
                      color: const Color.fromRGBO(0, 0, 0, 0.77),
                      fontSize: 22,
                    ),),

                ),
                Positioned(
                  right: 240,
                  child: Image.asset(
                    'assets/f.png',
                    width: 43,
                    height: 43,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
