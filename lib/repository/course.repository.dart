import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/lessons.model.dart';

class CourseRepository {
  Future<Lessons> getLessons() async {
    String url =
        "https://arabic-language.herokuapp.com/api/lessons/?populate=*&sort=id";
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> lessonsMap = json.decode(response.body);
        Lessons lessons = Lessons.fromJson(lessonsMap);
        return lessons;
      } else {
        return throw ("Error => ${response.statusCode}");
      }
    } catch (e) {
      return throw ("Error => $e");
    }
  }
}
