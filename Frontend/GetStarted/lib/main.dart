import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Get started',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Get Started Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  String _screenName = 'getStarted';
  
  void _showTermsOfUse(){
    setState(() {
      _screenName = 'termsOfUse';
    });
  }

  void _onGetStartedPressed() {
    setState(() {
      _screenName = 'nextPage';
    });
  }

  void _onGetStartedPage() {
    setState(() {
      _screenName = 'getStarted';
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_screenName == 'getStarted'){
      return getStartedPage();
    }
    if (_screenName == 'termsOfUse'){
      return getTermsOfUsePage();  
    }
    if (_screenName == 'nextPage'){
      return getNextPage();
    }
    return getErrorPage();
  }

  Widget getErrorPage(){
    return ElevatedButton(
      onPressed: _onGetStartedPage, 
      child: const Text("Page is missing"));
  }

  Widget getTermsOfUsePage(){
    return getErrorPage();
  }

  Widget getNextPage(){
    return getErrorPage();
  }


  Widget getStartedPage(){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
           const Image(height: 670, image: AssetImage('getStarted.jpg') ),
           ElevatedButton (
              style: ElevatedButton.styleFrom(
                backgroundColor:const Color(0xff459A9E),
                foregroundColor:Colors.white,
                minimumSize: const Size(250, 60)
              ),
              onPressed: _onGetStartedPressed,
              child: const Text('Get started'),
            ),
            const Text('By tapping Get Started, you agree to our'),
            GestureDetector(
              onTap: _showTermsOfUse,
              child: const Text('Terms of Use and Privacy Police.', 
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blue))),
            const Text('Please review them.'),
          ],
        ),
      ),
    );
  }
}
