import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConnexionErrorPage extends StatefulWidget {
  const ConnexionErrorPage({Key? key}) : super(key: key);

  @override
  State<ConnexionErrorPage> createState() => _ConnexionErrorPageState();
}

class _ConnexionErrorPageState extends State<ConnexionErrorPage> {
  @override
  void initState() {
    showToastError();
    super.initState();
  }

  void showToastError() async {
    await Future.delayed(const Duration(milliseconds: 100));
    showToast();
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            color: Colors.white,
        ),
      ),
    );
  }

  void showToast() =>
      Fluttertoast.showToast(
          msg: "No internet connexion",
          fontSize: 15,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white
      );

}
