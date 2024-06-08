import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fflex/models/notifications.dart';
import 'package:flutter/widgets.dart';
import '../../common/colo_extension.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final List<String> images = [
    "assets/img/c_1.png",
    "assets/img/m_4.png",
    "assets/img/c_3.png",
    "assets/img/otd1.jpg",
    "assets/img/propusk.jpg",
    "assets/img/what_3.png",
    "assets/img/rd_1.png",
  ];
  late Random random;
  List<int> chosenIndexes = [];
  Notifications notificationsService = Notifications();

  @override
  void initState() {
    super.initState();
    random = Random();
  }

  @override
  Widget build(BuildContext context) {
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
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              "assets/img/black_btn.png",
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          "Уведомления",
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
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                "assets/img/more_btn.png",
                width: 12,
                height: 12,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: TColor.white,
      body: FutureBuilder<List>(
        future: notificationsService.getAllNotifications(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          // print(snapshot);
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) {
                  int getRandomIndex(int maxLength) {
                    int index;
                    do {
                      index = random.nextInt(maxLength);
                    } while (chosenIndexes.contains(index)); // Проверяем, что индекс еще не выбран
                    chosenIndexes.add(index); // Добавляем индекс в список выбранных
                    return index;
                  }
                  int randomIndex = getRandomIndex(images.length);
                  var notifications = snapshot.data![i];
                  return Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
              
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Image.asset(
                                      images[randomIndex],
                                      width: 40, // Ширина изображения
                                      height: 40, // Высота изображения
                                      fit: BoxFit.fitWidth,
                                    ),
                                  
                                ),
                                  const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      notifications["title"],
                                      style: TextStyle(
                                          color: TColor.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      notifications["subtitle"],
                                      style: TextStyle(
                                        color: TColor.gray,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                                ],
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          "assets/img/sub_menu.png",
                          width: 15,
                          height: 15,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, i) => const Divider(),
              ),
            );
          } else {
            return const Center(
              child: Text('No Data'),
            );
          }
        },
      ),
    );
  }
}
