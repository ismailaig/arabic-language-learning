import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:devrnz/models/users.model.dart';
import 'package:http/http.dart' as http;

class UserRepository{

  Future<ListUsers> signIn(String email, String password) async{
    String url = "https://arabic-language.herokuapp.com/api/appusers?populate=*&filters[email][\$eq]=$email&filters[password][\$eq]=$password";
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
      return throw("Error => $e");
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
        "king": "${0}"
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

  Future<bool> deletePhoto(ListUsers listUsers) async{
    String url = "https://arabic-language.herokuapp.com/api/upload/files/${listUsers.data[0].attributes.photo.data!.id}";
    try {
      http.Response response = await http.delete(Uri.parse(url));
      if(response.statusCode==200){
        return true;
      }else{
        return throw("Delete photo probleme => ${response.statusCode}");
      }
    } catch (e) {
      return throw("Delete photo probleme => $e");
    }
  }

  Future<bool> updatePhoto(File image, ListUsers listUsers) async{
    String url = "https://arabic-language.herokuapp.com/api/upload/";
    http.MultipartRequest request = http.MultipartRequest("POST", Uri.parse(url));
    try {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath('files', image.path,filename: basename(image.path),contentType: MediaType('image', 'jpeg'));
      request.files.add(multipartFile);
      request.fields['ref'] = "api::appuser.appuser";
      request.fields['refId'] = "${listUsers.data[0].id}";
      request.fields['field'] = "photo";
      var response = await request.send();
      if(response.statusCode==200){
        return true;
      }else{
        return throw("Error uplaod => ${response.statusCode}");
      }
    } catch (e) {
      return throw("Error upload => $e");
    }
  }

  Future<bool> updateUserInfos(int id, String fullname, String password) async{
    String url = "https://arabic-language.herokuapp.com/api/appusers/$id";
    Map<String,String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json'
    };
    Map<String,String> body = {
      "fullname":fullname,
      "password":password,
    };
    try {
      http.Response response = await http.put(Uri.parse(url),
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