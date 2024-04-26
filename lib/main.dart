import 'package:fflex/common/colo_extension.dart';
import 'package:fflex/view/home/activity_traker_view.dart';
import 'package:fflex/view/home/home_view.dart';
import 'package:fflex/view/login/welcome_view.dart';
import 'package:fflex/view/login/what_your_goal_view.dart';
import 'package:fflex/view/on_boarding/on_boarding_view.dart';
import 'package:fflex/view/on_boarding/started_view.dart';
import 'package:fflex/view/profile/profile_view.dart';
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
         GlobalMaterialLocalizations.delegate
       ],
       supportedLocales: const [
         Locale('en'),
         Locale('ru')
       ],
      navigatorKey: kNavigatorKey,
      title: 'Fitness 3 in 1',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: TColor.primaryColor1,
          useMaterial3: true,
          fontFamily: "Montserrat"),
      home:
      const WelcomeView()
    );
  }
}


