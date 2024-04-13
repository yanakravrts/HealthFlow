import 'package:flutter/material.dart';

class EmptyStatisticPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        fit: StackFit.expand,
        children: [
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
            top: 130,
            left: 5,
            child: Row(
              children: [
                SizedBox(width: 33),
                Text(
                  'Create statistics for',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.0,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 150,
            left: MediaQuery.of(context).size.width / 2 - 178.5,
            child: Column(
              children: [
                Container(
                  width: 357,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 0.05, color: Colors.black),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Choose analysis from your archive',
                            style: TextStyle(fontSize: 16),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Arrow button clicked'),
                            ));
                          },
                          child: Image.asset(
                            'assets/arrow.png',
                            width: 15,
                            height: 15,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100),
                Text(
                  'Empty data archive',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300, color: Color(0xFF8F8E8E)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: EmptyStatisticPage(),
  ));
}
