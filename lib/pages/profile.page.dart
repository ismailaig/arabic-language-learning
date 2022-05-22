import 'package:flutter/material.dart';
import '../widgets/drawer.widget.dart';

class ProfilePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: Text('Profile'),),
      body: Center(
        child: Text('Profile Page',
          style: Theme.of(context).textTheme.headline3,),
      ),
    );
  }
}

