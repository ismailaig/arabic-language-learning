import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ContentPage extends StatefulWidget {

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                      icon: Icon(
                          Icons.close, color: Colors.grey, size: 40),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      tooltip: MaterialLocalizations
                          .of(context)
                          .openAppDrawerTooltip
                  );
                }
            ),
            backgroundColor: Colors.white,
            elevation: 1.7,
            title: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: LinearPercentIndicator(
                    width: 220,
                    lineHeight: 19,
                    percent: 20/100,
                    animation: true,
                    animationDuration: 1000,
                    barRadius: Radius.circular(100),
                    trailing: new Text("20%", style: TextStyle(fontSize: 20, color: Colors.green),),
                    progressColor: Colors.green,
                  ),
                ),
              ),
        ),
        body: Center(
          child: Text('Content page', style: Theme.of(context).textTheme.headline4,),
        )
    );
  }

}




