import 'package:flutter/material.dart';
import 'password.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: EmailVerificationPage(),
      ),
    );
  }
}

class EmailVerificationPage extends StatefulWidget {
  @override
  _EmailVerificationPageState createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  List<TextEditingController> controllers =
  List.generate(4, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          children: [
            Positioned(
              top: 170,
              left: (MediaQuery.of(context).size.width - 300) / 2,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(165),
                  color: Color.fromRGBO(217, 217, 217, 0.32),
                ),
                child: Image.asset(
                  'assets/email.png',
                  width: 200,
                ),
              ),
            ),
            Positioned(
              top: 90,
              left: (MediaQuery.of(context).size.width - 335) / 2,
              child: Text(
                '         Підтвердіть свою \n        електронну  пошту',
                style: TextStyle(
                  fontSize: 26,
                  fontFamily: 'Roboto',
                  color: Colors.black,
                ),
              ),
            ),
            Positioned(
              top: 550,
              left: (MediaQuery.of(context).size.width - 290) / 2,
              child: Container(
                width: 300.0,
                height: 80.0,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.04),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(4, (index) {
                    return Container(
                      width: 40.0,
                      height: 40.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextField(
                        controller: controllers[index],
                        maxLength: 1,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            if (index < 3) {
                              FocusScope.of(context).nextFocus();
                            }
                          }
                        },
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          counterText: '',
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Positioned(
              top: 500,
              left: (MediaQuery.of(context).size.width - 290) / 2,
              child: Text(
                '       Будь ласка, введіть 4-значний код, \n    надісланий на вашу електронну пошту',
                style: TextStyle(color: Colors.black, fontFamily: 'Roboto'),
              ),
            ),
            Positioned(
              top: 700,
              left: (MediaQuery.of(context).size.width - 280) / 2,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PasswordPage()),
                  );
                },
                child: Text(
                  'Підтвердити',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(69, 154, 158, 1),
                  padding: EdgeInsets.symmetric(horizontal: 87.0, vertical: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 640,
              left: (MediaQuery.of(context).size.width - 250) / 2,
              child: TextButton(
                onPressed: () => print('Resend code'),
                child: Text(
                  'Повторно надіслати код',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.teal,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: 780,
              left: (MediaQuery.of(context).size.width - 255) / 2,
              child: TextButton(
                onPressed: () => print('Change email'),
                child: const Text(
                  'Змінити електронну пошту',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.teal,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
