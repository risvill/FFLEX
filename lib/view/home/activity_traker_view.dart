import 'package:fflex/common_widget/today_target_cell_steps.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../common/colo_extension.dart';
import '../../common_widget/latest_activity_row.dart';
import '../../common_widget/today_target_cell.dart';

class ActivityTrackerView extends StatefulWidget {
  const ActivityTrackerView({super.key});

  @override
  State<ActivityTrackerView> createState() => _ActivityTrackerViewState();
}

class _ActivityTrackerViewState extends State<ActivityTrackerView> {
  int touchedIndex = -1;
  String selectedValue = "Месяц";
  bool isWeekSelected = false;


  List monthlyData = [
    {"month": "Янв", "value": 8.5},
    {"month": "Фев", "value": 7.0},
    {"month": "Мрт", "value": 2.5},
    {"month": "Апр", "value": 5.0},
    {"month": "Май", "value": 8.5},
    {"month": "Июнь", "value": 7.0},
    {"month": "Июль", "value": 1.5},
    // Добавьте остальные дни месяца
  ];  

  List latestArr = [
    {
      "image": "assets/img/pic_4.png",
      "title": "Пить 300 мл воды",
      "time": "Около 1 минуты назад"
    },
    {
      "image": "assets/img/pic_5.png",
      "title": "Ешь перекус (Fitbar)",
      "time": "Около 3 часов назад"
    },
  ];

  String waterIntake = '8';
  String steps = '2400';
  String dropdownValue = 'мл';

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: TColor.lightGray,
                borderRadius: BorderRadius.circular(10)),
            child: Image.asset(
              "assets/img/black_btn.png",
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          "Трекер активности",
          style: TextStyle(
              color: TColor.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: TColor.lightGray,
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                "assets/img/more_btn.png",
                width: 15,
                height: 15,
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
      ),
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      TColor.primaryColor2.withOpacity(0.3),
                      TColor.primaryColor1.withOpacity(0.3)
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  //Начинается виджет с целью на день
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Сегодняшняя цель",
                          style: TextStyle(
                            color: TColor.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: TColor.primaryG,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: MaterialButton(
                              onPressed: () async {
                                final result = await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Цель дня:'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          decoration: const InputDecoration(
                                              labelText: 'Steps'),
                                          onChanged: (value) {
                                            setState(() {
                                              steps = value;
                                            });
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        TextField(
                                          decoration: const InputDecoration(
                                              labelText: 'Water Intake'),
                                          onChanged: (value) {
                                            setState(() {
                                              waterIntake = value;
                                            });
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            DropdownButton<String>(
                                              value: dropdownValue,
                                              icon: const Icon(
                                                  Icons.arrow_drop_down),
                                              iconSize: 24,
                                              elevation: 16,
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 52, 51, 54)),
                                              underline: Container(
                                                height: 2,
                                                color: const Color.fromARGB(
                                                    255, 163, 163, 163),
                                              ),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  dropdownValue = newValue!;
                                                });
                                              },
                                              items: <String>[
                                                'мл',
                                                'л'
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop({
                                            'waterIntake': waterIntake,
                                            'unit': dropdownValue,
                                            'steps': steps
                                          });
                                        },
                                        child: const Text('Подтвердить'),
                                      ),
                                    ],
                                  ),
                                );

                                if (result != null) {
                                  setState(() {
                                    waterIntake = result['waterIntake'];
                                    dropdownValue = result['unit'];
                                    steps = result['steps'];
                                  });
                                }
                              },
                              padding: EdgeInsets.zero,
                              height: 30,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              textColor: TColor.primaryColor1,
                              minWidth: double.maxFinite,
                              elevation: 0,
                              color: Colors.transparent,
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TodayTargetCell(
                            icon: "assets/img/water.png",
                            data: {
                              'waterIntake': waterIntake,
                              'dropdownValue': dropdownValue
                            },
                            title: "приемов воды",
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TodayTargetCellSteps(
                            icon: "assets/img/foot.png",
                            value: steps,
                            title: "шагов",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //Тут заканчивается сегодняшняя цель
              SizedBox(
                height: media.width * 0.1,
              ),
              //Начинается прогресс активности
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Прогресс активности",
                    style: TextStyle(
                        color: TColor.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  Container(
                      height: 30,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          color: TColor.white,
                          border: Border.all(color: TColor.primaryColor1),
                          borderRadius: BorderRadius.circular(15)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: selectedValue,
                          items: ["Неделя", "Месяц"]
                              .map((name) => DropdownMenuItem(
                                    value: name,
                                    child: Text(
                                      name,
                                      style: TextStyle(
                                        color: TColor.primaryColor1,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value.toString();
                              isWeekSelected = value == "Неделя"; // Установка флага
                            });
                            // Обновление состояния после изменения значения
                            setState(() {
                              touchedIndex = -1; // Сброс индекса при изменении выбранного значения
                            });
                          },
                          
                          icon: Icon(Icons.expand_more,
                              color: TColor.primaryColor1),
                          hint: Text(
                            "Неделя",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: TColor.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      )),
                ],
              ),

              SizedBox(
                height: media.width * 0.05,
              ),

              // Здесь начинается график
              Container(
                height: media.width * 0.5,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                decoration: BoxDecoration(
                    color: TColor.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 3)
                    ]),
                child: BarChart(BarChartData(
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      tooltipHorizontalAlignment: FLHorizontalAlignment.right,
                      tooltipMargin: 10,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        String weekDay;
                        switch (group.x) {
                          case 0:
                            weekDay = 'Понедельник';
                            break;
                          case 1:
                            weekDay = 'Вторник';
                            break;
                          case 2:
                            weekDay = 'Среда';
                            break;
                          case 3:
                            weekDay = 'Четверг';
                            break;
                          case 4:
                            weekDay = 'Пятница';
                            break;
                          case 5:
                            weekDay = 'Суббота';
                            break;
                          case 6:
                            weekDay = 'Воскресенье';
                            break;
                          default:
                            throw Error();
                        }
                        return BarTooltipItem(
                          '$weekDay\n',
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: (rod.toY - 1).toString(),
                              style: TextStyle(
                                color: TColor.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    touchCallback: (FlTouchEvent event, barTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            barTouchResponse == null ||
                            barTouchResponse.spot == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex =
                            barTouchResponse.spot!.touchedBarGroupIndex;
                      });
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: getTitles,
                        reservedSize: 38,
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: showingGroups(),
                  gridData: const FlGridData(show: false),
                )),
              ),

              SizedBox(
                height: media.width * 0.05,
              ),
              // Здесь заканчивается прогресс активности, то есть график
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Последняя тренировка",
                    style: TextStyle(
                        color: TColor.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Подробнее",
                      style: TextStyle(
                          color: TColor.gray,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
              ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: latestArr.length,
                  itemBuilder: (context, index) {
                    var wObj = latestArr[index] as Map? ?? {};
                    return LatestActivityRow(wObj: wObj);
                  }),
              SizedBox(
                height: media.width * 0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    var style = TextStyle(
      color: TColor.gray,
      fontWeight: FontWeight.w500,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('1', style: style);
        break;
      case 1:
        text = Text('2', style: style);
        break;
      case 2:
        text = Text('3', style: style);
        break;
      case 3:
        text = Text('4', style: style);
        break;
      case 4:
        text = Text('5', style: style);
        break;
      case 5:
        text = Text('6', style: style);
        break;
      case 6:
        text = Text('7', style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  List<BarChartGroupData> showingGroups() {
    if (isWeekSelected) {
      // Используйте данные для недели
      return showingWeekGroups();
    } else {
      // Используйте данные для месяца
      return showingMonthGroups();
    }
  }
  List<BarChartGroupData> showingWeekGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(4, 5, TColor.secondaryG,
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 10.5, TColor.secondaryG,
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 5, TColor.secondaryG,
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, 7.5, TColor.secondaryG,
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, 15, TColor.secondaryG,
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, 5.5, TColor.secondaryG,
                isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, 8.5, TColor.secondaryG,
                isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

       List<BarChartGroupData> showingMonthGroups() {
        // Пример использования данных для месяца
        return List.generate(monthlyData.length, (i) {
          var monthData = monthlyData[i];
          var monthName = monthData['month']; // Получаем название месяца
          var value = monthData['value'];
          return makeGroupData(
            i,
            value,
            TColor.primaryG,
            isTouched: i == touchedIndex,
            label: monthName, // Передаем название месяца как метку
          );
        });
      }

  BarChartGroupData makeGroupData(
    int x,
    double y,
    List<Color> barColor, {
    bool isTouched = false,
    double width = 22,
    String? label,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          gradient: LinearGradient(
              colors: barColor,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
          width: width,
          borderSide: isTouched
              ? const BorderSide(color: Colors.green)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: TColor.lightGray,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }
}
