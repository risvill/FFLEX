import 'dart:convert';

import 'package:http/http.dart' as http;
class Workout {
String baseUrl = "http://10.0.2.2:8000/api/workout/list/";
Future<List> getAllWorkout() async {
  try {
    var response = await http.get(Uri.parse(baseUrl));
    if(response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
      
    } else {
        return Future.error("Server Error");
    }
  } catch (e) {
    return Future.error(e);
  }
}
}