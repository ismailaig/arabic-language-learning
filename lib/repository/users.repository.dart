import 'dart:convert';
import 'package:devrnz/models/users.model.dart';
import 'package:http/http.dart' as http;

class UserRepository{

  Future<ListUsers> signIn(String email, String password) async{
    String url = "https://arabic-language.herokuapp.com/api/appusers?populate=*&filters[email][\$eq]=${email}&filters[password][\$eq]=${password}";
    try {
      http.Response response = await http.get(Uri.parse(url));
      if(response.statusCode==200){
        Map<String, dynamic> listUsersMap = json.decode(response.body);
        ListUsers listUsers = ListUsers.fromJson(listUsersMap);
        return listUsers;
      }else{
        return throw("Error => ${response.statusCode}");
      }
    } catch (e) {
      return throw("Error => "+e.toString());
    }
  }

  Future<bool> signUp(String fullname, String email, String password) async{
    String url = "https://arabic-language.herokuapp.com/api/appusers/";
    Map<String,String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json'
    };
    Map<String,String> body = {
        "fullname":fullname,
        "email":email,
        "password":password,
    };
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: headers,
          body:jsonEncode({"data":body})
      );
      if(response.statusCode==200){
        return true;
      }else{
        return false;
      }
    } catch (e) {
      return false;
    }
  }




}