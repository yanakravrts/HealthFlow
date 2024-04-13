import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/displays/uploadlook.dart';
import 'package:path_provider/path_provider.dart';
import 'homepage.dart';
import 'Date.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UploadPage(),
    );
  }
}

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  bool _menuVisibility = false;

  Future<void> _selectFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        PlatformFile file = result.files.first;

        String? filePath = file.path;

        if (filePath != null) {
          final directory = await getApplicationDocumentsDirectory();
          String newPath = '${directory.path}/${file.name}';
          File newFile = File(newPath);
          await newFile.writeAsBytes(await file.bytes!);

          print('File saved at: $newPath');
        }
      } else {
        // Handle file selection cancelled by the user
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
      body: Stack(
        children: [
          Positioned(
            top: 108,
            left: 15,
            child: Text(
              'Імʼя',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: const Color.fromRGBO(128, 128, 128, 1),
                height: 23 / 20,
                letterSpacing: 0,
              ),
            ),
          ),
          Positioned(
            top: 144,
            left: 15,
            child: Text(
              'Дата: ',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: const Color.fromRGBO(128, 128, 128, 1),
                height: 23 / 20,
                letterSpacing: 0,
              ),
            ),
          ),
          Positioned(
            top: 576,
            left: 0,
            right: 0,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
          ),
          Positioned(
            top: 110,
            left: -68,
            width: 550,
            height: 400,
            child: Transform.scale(
              scale: 1,
              child: Image.asset('assets/file.png', width: 100, height: 100),
            ),
          ),
          Positioned(
            top: 138,
            left: -48,
            width: 522,
            height: 379,
            child: Transform.scale(
              scale: 0.62,
              child: Image.asset('assets/pdf.png', width: 100, height: 100),
            ),
          ),
          Positioned(
            top: 198,
            left: 24,
            width: 366,
            height: 420,
            child: CustomPaint(
              painter: RectanglePainter(),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -187,
            child: InkWell(
              onTap: () {
                print('Rectangle Clicked');
              },
              child: Transform.scale(
                scaleX: 0.7,
                scaleY: 0.72,
                child: Image.asset('assets/wave.jpg'),
              ),
            ),
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
          Positioned(
            top: 530,
            left: 116,
            height: 63,
            width: 200,
            child: RoundButton(
              " Завантажити \n         файл",
              _selectFile,
              width: 320,
              backgroundColor: const Color.fromRGBO(85, 162, 166, 1),
            ),
          ),
          Positioned(
            top: 417,
            left: 93,
            child: Text(
              'Перетягніть файл сюди',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: const Color.fromRGBO(0, 0, 0, 0.5),
                height: 23 / 20,
                letterSpacing: 0,
              ),
            ),
          ),
          Positioned(
            top: 460,
            left: 142,
            child: Text(
              '-----АБО----- ',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: const Color.fromRGBO(0, 0, 0, 0.5),
                height: 23 / 20,
                letterSpacing: 0,
              ),
            ),
          ),
          Positioned(
            top: 750,
            left: 127,
            height: 60,
            width: 180,
            child: RoundButton(
              "Зберегти",
                  () {
                    {Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DatePage()),
                    );}
              },
              width: 320,
              backgroundColor: const Color.fromRGBO(85, 162, 166, 1),
            ),
          ),
        ],
      ),
    );
  }
}

class RoundButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final Color backgroundColor;
  final Color textColor;

  RoundButton(
      this.text, this.onPressed, {
        this.width = 200,
        this.backgroundColor = const Color.fromRGBO(85, 162, 166, 1),
        this.textColor = Colors.white,
      });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontFamily: 'Roboto Flex',
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
        ),
      ),
    );
  }
}

class RectanglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color.fromRGBO(34, 151, 161, 1).withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final Rect rect = Rect.fromLTRB(0, 0, size.width, size.height);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
