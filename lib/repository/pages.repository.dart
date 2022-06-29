import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pages.model.dart';

class PagesRepository{
  /*Future<Pages> getPages(String lesson) async{
    String url = "https://arabic-language.herokuapp.com/api/pages";
    try {
      http.Response response = await http.get(Uri.parse(url));
      if(response.statusCode==200){
        Map<String, dynamic> pagesMap = json.decode(response.body);
        Pages pages = Pages.fromJson(pagesMap);
        return pages;
      }else{
        return throw("Error => ${response.statusCode}");
      }
    } catch (e) {
      return throw("Error => "+e.toString());
    }
  }*/
}