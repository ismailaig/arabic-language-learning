import 'package:flutter/material.dart';
import '../widgets/drawer.widget.dart';

class SettingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: Text('Setting'),),
      body: Center(
        child: Text('Setting page',
          style: Theme.of(context).textTheme.headline3,),
      ),
    );
  }
}

