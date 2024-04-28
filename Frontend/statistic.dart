import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsPage extends StatelessWidget {
  final List<String> dates = ['02/09/23', '04/10/23', '10/11/23', '12/12/23'];
  final List<double> results = [0.2, 3, 1.3, 0.5];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Stack(
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
            left: MediaQuery.of(context).size.width / 2 - 170.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Створюйте статистику для: ',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 357,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 0.05, color: Colors.black),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Виберіть аналіз з вашого архіву',
                            style: TextStyle(fontSize: 16),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
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
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 350,
                    height: 50,
                    color: Colors.white,
                    child: Center(
                      child: const Text(
                        'Гемоглобін',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 324,
                    width: 350,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceAround,
                              maxY: results.reduce((curr, next) => curr > next ? curr : next) * 1.5,
                              barTouchData: BarTouchData(enabled: false),
                              titlesData: FlTitlesData(
                                show: true,
                                leftTitles: SideTitles(
                                  showTitles: true,
                                  getTitles: (value) {
                                    return value.toStringAsFixed(1);
                                  },
                                  margin: 10,
                                ),
                                bottomTitles: SideTitles(
                                  showTitles: true,
                                  getTitles: (value) {
                                    return dates[value.toInt()];
                                  },
                                  margin: 10,
                                ),
                              ),
                              borderData: FlBorderData(
                                show: true,
                                border: const Border(
                                  bottom: BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                  left: BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                ),
                              ),
                              barGroups: List.generate(
                                dates.length,
                                    (index) => BarChartGroupData(
                                  x: index,
                                  barRods: [
                                    BarChartRodData(
                                      y: results[index],
                                      width: 40,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4),
                                        topRight: Radius.circular(4),
                                      ),
                                      colors: [Color(0xFF2297A1)],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: StatisticsPage(),
  ));
}
