
import 'package:fflex/common/colo_extension.dart';
import 'package:fflex/view/home/activity_traker_view.dart';
import 'package:fflex/view/meal_planner/meal_planner_view.dart';
import 'package:fflex/view/workout_tracker/workout_tracker_view.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:fflex/view/home/home_view.dart';
import 'package:fflex/view/profile/profile_view.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({Key? key}) : super(key: key);

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int selectedIndex = 0;
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [const HomeView(), const MealPlannerView(), const WorkoutTrackerView(), const ProfileView()];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
            child: GNav(
              selectedIndex: selectedIndex,
              onTabChange: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              color: const Color.fromARGB(255, 164, 164, 164),
              activeColor: TColor.primaryColor1,
              tabBackgroundColor: TColor.primaryColor1.withOpacity(0.1),
              gap: 8,
              padding: const EdgeInsets.all(10),
              tabs: const [
                GButton(
                  icon: Icons.home_rounded,
                  text: 'Домой',
                ),
                GButton(
                  icon: Icons.restaurant_rounded,
                  text: 'Рецепты',
                ),
                GButton(icon: Icons.fitness_center_rounded),
                GButton(
                  icon: Icons.person_rounded,
                  text: 'Профиль',
                ),
              ],
            ),
          ),
        ),
        body: IndexedStack(
          index: selectedIndex,
          children: pages,
        ),
      ),
    );
  }
}