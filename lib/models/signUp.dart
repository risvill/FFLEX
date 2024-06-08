import 'package:http/http.dart' as http;
import 'dart:convert';

Future<dynamic> postSignUp(
  String username, 
  String first_name, 
  String last_name, 
  DateTime birthdate,
  String password, 
  String weight, 
  String height, 
  String gender, 
  String token
) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:8000/api/signup/'),
    body: json.encode({
      'username': username,
      'first_name': first_name,
      'last_name': last_name,
      'password': password,
      'birthdate': birthdate.toIso8601String(), // Преобразуем дату в строку
      'weight': weight,
      'height': height,
      'gender': gender,
    }),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    return jsonDecode(utf8.decode(response.bodyBytes));
  } else {
    throw Exception('Failed to send data');
  }
}
