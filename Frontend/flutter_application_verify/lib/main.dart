import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

const String parseApplicationId = '2dcba45ac674d5f59493194fc934b9e0';
const String parseClientKey = 'secret4930342fbf3021349152845f23174a04';
const String parseServerUrl = 'http://localhost:1337/parse';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Parse().initialize(parseApplicationId, parseServerUrl,
    clientKey: parseClientKey, autoSendSessionId: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Your app UI code here
    return MaterialApp(
      home: Scaffold(
        // ...
      ),
    );
  }
}

// Використання Mailjet API для відправлення електронної пошти
Future<void> sendEmailUsingMailjet({
  required String recipientEmail,
  required String senderEmail,
  required String subject,
  required String textContent,
}) async {
  const String mailjetApiKey = '1d68cbf6e6b094e8ebaef97b1e03cfb2'; // POБAЧТЕ: шукайте спосіб безпечно зберігати це значення
  const String mailjetSecretKey = 'secret4930342fbf3021349152845f23174a04'; // POБAЧТЕ: шукайте спосіб безпечно зберігати це значення
  const credentials = '$mailjetApiKey:$mailjetSecretKey';
  final encodedCredentials = base64Encode(utf8.encode(credentials));
  final basicAuthHeader = 'Basic $encodedCredentials';

  final response = await http.post(
    Uri.parse('https://api.mailjet.com/v3.1/send'),
    headers: {
      'Authorization': basicAuthHeader,
      'Content-Type': 'application/json',
    },
    body: json.encode({
      'Messages': [
        {
          'From': {
            'Email': senderEmail,
            'Name': 'Your Name',
          },
          'To': [
            {'Email': recipientEmail}
          ],
          'Subject': subject,
          'TextPart': textContent,
        },
      ],
    }),
  );

  if (response.statusCode == 200) {
    print('Email sent successfully!');
  } else {
    print('Failed to send email: ${response.body}');
  }
}

// Використання Parse SDK для відновлення паролю
Future<void> resetPasswordUsingParse(String email) async {
  var user = ParseUser(null, null, email);
  var response = await user.requestPasswordReset();
  if (response.success) {
    print('Password reset email sent successfully to $email');
  } else {
    print('Failed to send password reset email: ${response.error}');
  }
}