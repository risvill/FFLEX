import 'package:fflex/common_widget/meal_recommed_cell.dart';
import 'package:fflex/view/meal_planner/category_list_view.dart';
import 'package:fflex/view/meal_planner/food_info_detail_view.dart';
import 'package:flutter/material.dart';

import '../../common/colo_extension.dart';
import '../../common_widget/meal_category_cell.dart';
import '../../common_widget/popular_meal_row.dart';
import '../../common_widget/today_meal_row.dart';

class MealFoodDetailsView extends StatefulWidget {
  final Map eObj;
  const MealFoodDetailsView({super.key, required this.eObj});

  @override
  State<MealFoodDetailsView> createState() => _MealFoodDetailsViewState();
}

class _MealFoodDetailsViewState extends State<MealFoodDetailsView> {
  TextEditingController txtSearch = TextEditingController();

  List categoryArr = [
    {
      "name": "Салаты",
      "image": "assets/img/c_1.png",
    },
    {
      "name": "Выпечка",
      "image": "assets/img/c_2.png",
    },
    {
      "name": "Десерты",
      "image": "assets/img/c_3.png",
    },
    {
      "name": "Фруктовые",
      "image": "assets/img/c_4.png",
    },
    {
      "name": "Говяжие",
      "image": "assets/img/c_1.png",
    },
    {
      "name": "Куриные",
      "image": "assets/img/c_2.png",
    },
    {
      "name": "Овощные",
      "image": "assets/img/c_3.png",
    },
    {
      "name": "Закуски",
      "image": "assets/img/c_4.png",
    },
  ];

  List popularArr = [
  {
    "name": "Черничный панкейк",
    "image": "assets/img/f_1.png",
    "size": "Средний",
    "time": "1 час",
    "kcal": "230 ккал"
  },
  {
    "name": "Суши Тиряяма",
    "image": "assets/img/f_2.png",
    "size": "Средний",
    "time": "30 минут",
    "kcal": "120 ккал"
  },
  {
    "name": "Паста Карбонара",
    "image": "assets/img/m_4.png",
    "size": "Средний",
    "time": "40 минут",
    "kcal": "400 ккал"
  },
  {
    "name": "Куриные крылышки BBQ",
    "image": "assets/img/m_3.png",
    "size": "Средний",
    "time": "1 час 10 минут",
    "kcal": "450 ккал"
  },
  {
    "name": "Бургер с говядиной",
    "image": "assets/img/m_2.png",
    "size": "Средний",
    "time": "30 минут",
    "kcal": "600 ккал"
  },
  {
    "name": "Морковный пирог",
    "image": "assets/img/m_1.png",
    "size": "Средний",
    "time": "1 час 30 минут",
    "kcal": "350 ккал"
  },
  {
    "name": "Куриный суп",
    "image": "assets/img/sugar.png",
    "size": "Легко",
    "time": "45 минут",
    "kcal": "200 ккал"
  },
  {
    "name": "Шоколадный торт",
    "image": "assets/img/rd_1.png",
    "size": "Трудно",
    "time": "2 часа",
    "kcal": "500 ккал"
  },
  {
    "name": "Салат с тунцом",
    "image": "assets/img/salad.png",
    "size": "Легко",
    "time": "15 минут",
    "kcal": "180 ккал"
  },
];


  List recommendArr = [
    {
      "name": "Сладкие блины",
      "image": "assets/img/rd_1.png",
      "size": "Легко",
      "time": "20 минут",
      "kcal": "180 ккал"
    },
    {
      "name": "Обжаренная курица",
      "image": "assets/img/m_4.png",
      "size": "Легко",
      "time": "1 час",
      "kcal": "230 ккал"
    },
  ];

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
          widget.eObj["name"].toString(),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  color: TColor.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        offset: Offset(0, 1))
                  ]),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: txtSearch,
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        prefixIcon: Image.asset(
                          "assets/img/search.png",
                          width: 25,
                          height: 25,
                        ),
                        hintText: "Найти салаты..."),
                  )),
                ],
              ),
            ),
            SizedBox(
              height: media.width * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Категории",
                    style: TextStyle(
                        color: TColor.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 120,
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryArr.length,
                  itemBuilder: (context, index) {
                    var cObj = categoryArr[index] as Map? ?? {};
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryListView(eObj: cObj, mObj: cObj,) ) );
                      },
                      child: MealCategoryCell(
                        cObj: cObj,
                        index: index,
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: media.width * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Рекомендации\nдля ПП",
                style: TextStyle(
                    color: TColor.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: media.width * 0.6,
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: recommendArr.length,
                  itemBuilder: (context, index) {
                    var fObj = recommendArr[index] as Map? ?? {};
                    return InkWell(
                    onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => FoodInfoDetailsView(mObj: fObj, dObj: fObj) ) );
                    },
                    child: MealRecommendCell(
                      fObj: fObj,
                      index: index,
                    ),
                  );
                  }),
            ),
            SizedBox(
              height: media.width * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Популярное",
                style: TextStyle(
                    color: TColor.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
            ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: popularArr.length,
                itemBuilder: (context, index) {
                  var fObj = popularArr[index] as Map? ?? {};
                  return InkWell(
                    onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => FoodInfoDetailsView(mObj: fObj, dObj: fObj) ) );
                      },
                    child: PopularMealRow(
                      mObj: fObj,
                    ),
                  );
                }),
            SizedBox(
              height: media.width * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}