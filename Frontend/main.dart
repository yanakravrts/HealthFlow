import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          height: 844,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(69, 154, 158, 0.9),
          ),
          child: Stack(
            children: [
              const Positioned(
                top: 90,
                left: 83,
                width: 267,
                height: 267,
                child: CircleContainer('assets/circledark.png'),
              ),
              const Positioned(
                top: 89,
                left: 70,
                width: 267,
                height: 267,
                child: CircleContainer('assets/circlelight.png'),
              ),
              Positioned(
                top: 129,
                left: -7,
                height: 189,
                width: 417,
                child: Image.asset('assets/logo.jpg'),
              ),
              const Positioned(
                top: 392,
                width: 413,
                height: 460,
                child: RoundedRectangle(),
              ),
              const Positioned(
                top: 500,
                left: 15,
                height: 60,
                width: 358,
                child: EmailContainer(),
              ),
              const Positioned(
                top: 605,
                left: 61,
                height: 60,
                width: 303,
                child: LoginButton(),
              ),
              Positioned(
                top: 410,
                left: 85,
                width: 261,
                height: 68,
                child: LoginLabel(),
              ),
              // Google and Facebook buttons
              const Positioned(
                top: 724,
                left: 28,
                height: 60,
                width: 163,
                child: GoogleButton(),
              ),
              const Positioned(
                top: 724,
                left: 215,
                height: 60,
                width: 163,
                child: FacebookButton(),
              ),
              // Waves above other elements
              Positioned(
                top: 1089.19,
                left: 555.43,
                height: 304.61,
                width: 684.54,
                child: Transform.rotate(
                  angle: math.pi * 158.62 / 180,
                  child: Wave('assets/wave.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginLabel extends StatelessWidget {
  const LoginLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 261,
      height: 68,
      child: Center(
        child: Text(
          'Login',
          style: TextStyle(
            fontSize: 35,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}



class CircleContainer extends StatelessWidget {
  final String imageUrl;

  const CircleContainer(this.imageUrl, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 267,
      height: 267,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 255),
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class RoundedRectangle extends StatelessWidget {
  const RoundedRectangle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 470,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}
class Wave extends StatelessWidget {
  final String imageUrl;

  const Wave(this.imageUrl, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 684.54,
      height: 304.61,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(69, 154, 158, 0.69),
      ),
      child: Image.asset(imageUrl, width: 684.54, height: 304.61),
    );
  }
}

class EmailContainer extends StatelessWidget {
  const EmailContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 333,
      height: 70,
      margin: const EdgeInsets.only(left: 29),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(4, 4),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
        borderRadius: BorderRadius.circular(30),
      ),
      child: const TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          hintText: 'Enter your email',
          border: InputBorder.none,
        ),
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(87, 163, 167, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        textStyle: const TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
        side: BorderSide.none,
      ),
      child: const Text('Log In'),
    );
  }
}

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        textStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        side: BorderSide.none,
      ),
      icon: Image.asset('assets/google.png', width: 30, height: 30),
      label: const Text('Google'),
    );
  }
}

class FacebookButton extends StatelessWidget {
  const FacebookButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        textStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        side: BorderSide.none,
      ),
      icon: Image.asset('assets/facebook.png', width: 30, height: 30),
      label: const Text('Facebook'),
    );
  }
}
