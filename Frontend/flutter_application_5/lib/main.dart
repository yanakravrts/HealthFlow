import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top: 100),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
              'assets/terms.png',
             width: 100,
             height: 100,
              ),
                const SizedBox(height: 50),
                const Text(
                  'Terms of Use and Privacy Policy',
                  style: TextStyle(
                    color: Color.fromRGBO(74, 156, 160, 1), // змінено на #4A9CA0
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9, // 90% ширини екрану
                  height: MediaQuery.of(context).size.height * 0.6, // 60% висоти екрану
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(top: 100, bottom: 20), // піднято вище і відступ знизу 20
                  child: const SingleChildScrollView(
                    child: Text(
                      'Health Data Collection: The App may collect and analyze health-related information as results of your analyses. By using the App, you explicitly consent to the collection, processing, and storage of this health data. We are committed to maintaining the confidentiality and security of this information. Your health data will be handled in accordance with our Privacy Policy and applicable laws. 2.Location Information: The App may collect and utilize your location information to provide location-based services, such as identifying nearby health laboratories or providing context-specific health information. By using the App, you explicitly consent to the collection and use of your location data for these purposes. Your location information will be handled in accordance with our Privacy Policy and applicable laws. 3.Confidentiality: We understand the sensitivity of health-related data and location information. We employ industry-standard security measures to safeguard this data from unauthorized access, disclosure, alteration, or destruction. 4.Usage of Data: The health data and location information collected may be used for research, analysis, and improving the Apps functionalities. Aggregated and anonymized data may also be used for statistical and analytical purposes to enhance user experience and improve our services. 5.Sharing of Information: We do not sell, lease, or share your health data or location information with third parties for their marketing purposes without your explicit consent. However, we may share this data as required by law or as necessary to provide our services, such as with healthcare providers or as outlined in our Privacy Policy By using the App, you acknowledge and agree to the collection, use, and sharing of health-related data and location information as outlined in these Terms and our Privacy Policy.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: const Color.fromRGBO(34, 151, 161, 1), backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                          side: const BorderSide(
                            color:  Color.fromRGBO(34, 151, 161, 1),
                            width: 1,
                          ),
                        ),
                        minimumSize: const Size(150, 60),
                      ),
                      child: const Text('Decline'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: const Color.fromRGBO(34, 151, 161, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        minimumSize: const Size(150, 60),
                      ),
                      child: const Text('Accept'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
