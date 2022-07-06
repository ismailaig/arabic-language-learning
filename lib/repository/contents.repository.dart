import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/contents.model.dart';

class ContentRepository{


  Future<Contents> getContents(int idLesson) async{
    String url = "https://arabic-language.herokuapp.com/api/contents/?populate=*&pagination[page]=1&pagination[pageSize]=30&filters[lesson][id][\$eq]=$idLesson";
    try {
      http.Response response = await http.get(Uri.parse(url));
      if(response.statusCode==200){
        Map<String, dynamic> contentsMap = json.decode(response.body);
        Contents contents = Contents.fromJson(contentsMap);
        return contents;
      }else{
        return throw("Error => ${response.statusCode}");
      }
    } catch (e) {
      return throw("Error => "+e.toString());
    }
  }
}