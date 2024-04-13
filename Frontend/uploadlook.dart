import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'Existfile.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UploadLookPage(),
    );
  }
}

class UploadLookPage extends StatefulWidget {
  @override
  _UploadLookPageState createState() => _UploadLookPageState();
}

class _UploadLookPageState extends State<UploadLookPage> {
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
            top: 130,
            left: -80,
            width: 570,
            height: 380,
            child: Transform.scale(
              scale: 0.67,
              child: Image.asset('assets/whiter.png', width: 100, height: 100),
            ),
          ),
          Positioned(
            top: 130,
            left: 15,
            child: Text(
              'Назва:',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 21,
                fontWeight: FontWeight.w400,
                color: const Color.fromRGBO(128, 128, 128, 1),
                height: 23 / 20,
                letterSpacing: 0,
              ),
            ),
          ),
          Positioned(
            top: 157,
            left: 15,
            child: Text(
              'Дата: ',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 21,
                fontWeight: FontWeight.w400,
                color: const Color.fromRGBO(128, 128, 128, 1),
                height: 23 / 20,
                letterSpacing: 0,
              ),
            ),
          ),
          Positioned(
            top: 184,
            left: 15,
            child: Text(
              'Тип аналізу: ',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 21,
                fontWeight: FontWeight.w400,
                color: const Color.fromRGBO(128, 128, 128, 1),
                height: 23 / 20,
                letterSpacing: 0,
              ),
            ),
          ),
          Positioned(
            top: 260,
            left: 160,
            right: 0,
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundButton(
                  "Відкрити",
                      () {
                    // Navigate to edit file page
                  },
                  width: 160,
                ),
                RoundButton(
                  "Видалити",
                      () {
                    // Add code for file deletion
                  },
                  width: 160,
                  backgroundColor: Color.fromRGBO(223, 168, 204, 1), // Оновлення кольору тут
                ),

              ],
            ),
          ),

          Positioned(
            top: 115,
            left: -200,
            width: 550,
            height: 400,
            child: Transform.scale(
              scale: 0.46,
              child: Image.asset('assets/bluefile.png', width: 100, height: 100),
            ),
          ),
          Positioned(
            top: 365,
            left: 60,
            child: Text(
              'назва.pdf',
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
            top: 40,
            left: -20,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NofilePage()),
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
            top: 275,
            left: -57,
            width: 526,
            height: 400,
            child: Transform.scale(
              scale: 0.78,
              child: Image.asset('assets/bluer.png', width: 100, height: 100),
            ),
          ),

          Positioned(
            top: 460,
            left: 20,
            child: Text(
              'Імʼя',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 21,
                fontWeight: FontWeight.w400,
                color: const Color.fromRGBO(255, 255, 255, 1),
                height: 23 / 20,
                letterSpacing: 0,
              ),
            ),
          ),
          Positioned(
            top: 460,
            left: 155,
            child: Text(
              'Макс/Мін',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 21,
                fontWeight: FontWeight.w400,
                color: const Color.fromRGBO(255, 255, 255, 1),
                height: 23 / 20,
                letterSpacing: 0,
              ),
            ),
          ),
          Positioned(
            top: 460,
            left: 290,
            child: Text(
              'Ваш резуль- \n тат',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: const Color.fromRGBO(255, 255, 255, 1),
                height: 23 / 20,
                letterSpacing: 0,
              ),
            ),
          ),
          Container(
            width: 412,
            height: 1,
            margin: EdgeInsets.only(top: 510),
            color: Color.fromRGBO(34, 151, 161, 1),
          ),
          Container(
            width: 412,
            height: 1,
            margin: EdgeInsets.only(top: 550),
            color: Color.fromRGBO(34, 151, 161, 1),
          ),
          Container(
            width: 412,
            height: 1,
            margin: EdgeInsets.only(top: 590),
            color: Color.fromRGBO(34, 151, 161, 1),
          ),
          Container(
            width: 412,
            height: 1,
            margin: EdgeInsets.only(top: 630),
            color: Color.fromRGBO(34, 151, 161, 1),
          ),
          Container(
            width: 412,
            height: 1,
            margin: EdgeInsets.only(top: 670),
            color: Color.fromRGBO(34, 151, 161, 1),
          ),
          Container(
            width: 412,
            height: 1,
            margin: EdgeInsets.only(top: 710),
            color: Color.fromRGBO(34, 151, 161, 1),
          ),
          Container(
            width: 412,
            height: 1,
            margin: EdgeInsets.only(top: 750),
            color: Color.fromRGBO(34, 151, 161, 1),
          ),Container(
            width: 412,
            height: 1,
            margin: EdgeInsets.only(top: 790),
            color: Color.fromRGBO(34, 151, 161, 1),
          ),
          Container(
            width: 412,
            height: 1,
            margin: EdgeInsets.only(top: 830),
            color: Color.fromRGBO(34, 151, 161, 1),
          ),Container(
            width: 412,
            height: 1,
            margin: EdgeInsets.only(top: 870),
            color: Color.fromRGBO(34, 151, 161, 1),
          ),



          Container(
            width: 1,
            height: 690,  // Висота (змініть на бажану висоту)
            margin: EdgeInsets.only(left: 130, top: 510,), // Змініть відступи за необхідністю
            decoration: BoxDecoration(
              color: Color.fromRGBO(34, 151, 161, 1),
            ),
          ),
          Container(
            width: 1,
            height: 690,  // Висота (змініть на бажану висоту)
            margin: EdgeInsets.only(left: 275, top: 510,), // Змініть відступи за необхідністю
            decoration: BoxDecoration(
              color: Color.fromRGBO(34, 151, 161, 1),
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
        this.width = 50,
        this.backgroundColor = const Color.fromRGBO(85, 162, 166, 1),
        this.textColor = Colors.white,
      });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontFamily: 'Roboto Flex',
            fontSize: 20,
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

