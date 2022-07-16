import 'dart:io';
import 'package:flutter/material.dart';

class ConnexionErrorPage extends StatefulWidget {
  const ConnexionErrorPage({Key? key}) : super(key: key);

  @override
  State<ConnexionErrorPage> createState() => _ConnexionErrorPageState();
}

class _ConnexionErrorPageState extends State<ConnexionErrorPage> {
  @override
  void initState() {
    showDialogError();
    super.initState();
  }

  void showDialogError() async {
    await Future.delayed(const Duration(milliseconds: 400));
    showMyDialog();
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

  Future<void> showMyDialog() => showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        title: const Center(child: Text('Error connexion. Try to connect', style: TextStyle(fontSize: 15),)),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.white, side: BorderSide(width: 1, color: Theme.of(context).primaryColor,)),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Ok",style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 15)),
          ),
        ],
      );
    },
  );

}
