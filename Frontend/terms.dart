import 'package:flutter/material.dart';
import 'package:flutter_application_1/displays/getstart.dart';
import 'log_in.dart'; // Додано імпорт LoginPage
import 'getstart.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TermsPage(),
    );
  }
}

class TermsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'Умови використання та Політика конфіденційності',
                style: TextStyle(
                  color: Color.fromRGBO(74, 156, 160, 1),
                ),
              ),
              const SizedBox(height: 6),
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.55,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(top: 0, bottom: 20),
                child: const SingleChildScrollView(
                  child: Text(
                    'Збір даних про здоров\'я: Додаток може збирати та аналізувати інформацію, пов\'язану із здоров\'ям, у вигляді результатів вашого аналізу. Користуючись Додатком, ви явно надаєте згоду на збір, обробку та зберігання цих даних про здоров\'я. Ми зобов\'язані зберігати конфіденційність та безпеку цієї інформації. Ваші дані про здоров\'я будуть оброблені відповідно до нашої Політики конфіденційності та чинного законодавства. 2. Інформація про місцезнаходження: Додаток може збирати та використовувати вашу інформацію про місцезнаходження для надання послуг, пов\'язаних із місцезнаходженням, таких як ідентифікація близьких до вас лабораторій здоров\'я або надання контекстної інформації про здоров\'я. Користуючись Додатком, ви явно надаєте згоду на збір та використання ваших даних про місцезнаходження для цих цілей. Інформація про ваше місцезнаходження буде оброблена відповідно до нашої Політики конфіденційності та чинного законодавства. 3. Конфіденційність: Ми розуміємо чутливість даних, пов\'язаних із здоров\'ям та місцезнаходженням. Ми застосовуємо стандартні заходи безпеки промисловості для захисту цих даних від несанкціонованого доступу, розголошення, зміни або знищення. 4. Використання даних: Зібрані дані про здоров\'я та інформація про місцезнаходження можуть бути використані для наукових досліджень, аналізу та покращення функціональності Додатків. Загальна та анонімізована інформація також може використовуватися для статистичних та аналітичних цілей з метою поліпшення досвіду користувача та покращення наших послуг. 5. Поширення інформації: Ми не продаемо, не здаемо в оренду і не поширюємо ваші дані про здоров\'я або інформацію про місцезнаходження третім сторонам для їхніх маркетингових цілей без вашої явної згоди. Однак ми можемо поширювати ці дані за вимогою закону або як це необхідно для надання наших послуг, наприклад, з медичними установами або відповідно до нашої Політики конфіденційності. Користуючись Додатком, ви підтверджуєте та погоджуєтесь зі збором, використанням та поширенням даних, пов\'язаних зі здоров\'ям та місцезнаходженням, як описано в цих Умовах та нашій Політиці конфіденційності.',                    style: TextStyle(
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
                    onPressed: () { Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GetstartedPage()),
                    );},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color.fromRGBO(34, 151, 161, 1),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                        side: const BorderSide(
                          color:  Color.fromRGBO(34, 151, 161, 1),
                          width: 1,
                        ),
                      ),
                      minimumSize: const Size(150, 60),
                    ),
                    child: const Text('Відхилити'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Переход на сторінку LoginPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );

                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromRGBO(34, 151, 161, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      minimumSize: const Size(150, 60),
                    ),
                    child: const Text('Прийняти'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
