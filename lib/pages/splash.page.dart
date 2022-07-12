import 'package:devrnz/pages/welcome.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    autoNavigation();
    super.initState();
  }
  void autoNavigation() async {
    await Future.delayed(const Duration(seconds: 4));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const WelcomePage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
          child: SpinKitThreeInOut(
            itemBuilder: (context, index){
              final colors = [Colors.cyan, Colors.black26];
              final color = colors[index % colors.length];
              return DecoratedBox(
                  decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle
                  )
              );
            },
            //color: Theme.of(context).primaryColor,
            size: 60.0,
          ),
        ),
    );
  }
}
