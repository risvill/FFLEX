import 'package:fflex/common/colo_extension.dart';
import 'package:fflex/view/home/activity_traker_view.dart';
import 'package:fflex/view/home/home_view.dart';
import 'package:fflex/view/home/notification_view.dart';
import 'package:fflex/view/login/login_view.dart';
import 'package:fflex/view/login/welcome_view.dart';
import 'package:fflex/view/main_tab/main_tab_view.dart';
import 'package:fflex/view/meal_planner/food_info_detail_view.dart';
import 'package:fflex/view/meal_planner/meal_food_detail_view.dart';
import 'package:fflex/view/meal_planner/meal_planner_view.dart';
import 'package:fflex/view/profile/personal_data_view.dart';
import 'package:fflex/view/workout_tracker/workout_detail_view.dart';
import 'package:fflex/view/workout_tracker/workout_tracker_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> kNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ru')
      ],
      navigatorKey: kNavigatorKey,
      title: 'Fitness 3 in 1',
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeView(),
        // '/notification': (context) => const NotificationView(),
        // // '/personal': (context) => const PersonalDataView(),
        // '/workout': (context) => const WorkoutTrackerView(),
        // '/activity': (context) => const ActivityTrackerView(),
        // // '/food-info-detail': (context) => const FoodInfoDetailsView(dObj: {}, mObj: {},),
        // '/meal-planner':(context) => const MealPlannerView(),
        // '/meal-food-detail':(context) => const MealFoodDetailsView(eObj: {},),

      },
      onGenerateRoute: (settings) {
        if (settings.name == '/workout/detail') {
          final args = settings.arguments as Map;
          return MaterialPageRoute(
            builder: (context) {
              return WorkoutDetailView(dObj: args);
            },
          );
        }
        return null;
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: TColor.primaryColor1,
        useMaterial3: true,
        fontFamily: "Montserrat",
      ),
    );
  }
}
