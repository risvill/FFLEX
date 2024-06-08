import 'package:http/http.dart' as http;
import 'dart:convert';

Future<dynamic> postSignIn(
  String username, 
  String password, 
  String token
) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:8000/api/signin/'),
    body: json.encode({
      'username': username,
      'password': password,
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
