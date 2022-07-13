import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/numbers.model.dart';

class NumberRepository{


  Future<Numbers> getNumbers() async{
    String url = "https://arabic-language.herokuapp.com/api/numbers/?populate=*&sort=id";
    try {
      http.Response response = await http.get(Uri.parse(url));
      if(response.statusCode==200){
        Map<String, dynamic> numbersMap = json.decode(response.body);
        Numbers numbers = Numbers.fromJson(numbersMap);
        return numbers;
      }else{
        return throw("Error => ${response.statusCode}");
      }
    } catch (e) {
      return throw("Error => $e");
    }
  }
}