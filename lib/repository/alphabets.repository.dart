import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/alphabets.model.dart';

class AlphabetRepository{


  Future<Alphabets> getAlphabets() async{
    String url = "https://arabic-language.herokuapp.com/api/alphabets/?populate=*&sort=id&pagination[page]=1&pagination[pageSize]=32";
    try {
      http.Response response = await http.get(Uri.parse(url));
      if(response.statusCode==200){
        Map<String, dynamic> alphabetsMap = json.decode(response.body);
        Alphabets alphabets = Alphabets.fromJson(alphabetsMap);
        return alphabets;
      }else{
        return throw("Error => ${response.statusCode}");
      }
    } catch (e) {
      return throw("Error => "+e.toString());
    }
  }
}