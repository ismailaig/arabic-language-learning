import 'package:devrnz/bloc/enums/EnumEvent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:devrnz/bloc/theme.bloc.dart';
import 'package:devrnz/models/users.model.dart';
import 'package:devrnz/pages/qr.code.page.dart';
import 'package:devrnz/pages/qr.scan.page.dart';
import 'package:devrnz/pages/welcome.page.dart';
import '../bloc/authBloc/auth_bloc.dart';
import 'face.detector.page.dart';
import 'graphics.page.dart';
import 'ocr.page.dart';
import 'profile.page.dart';
import 'home.page.dart';

class RootView extends StatelessWidget {

  late ListUsers listUsers;

  RootView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc,ThemeState>(
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.theme,
            home: const MainScreen(),
            routes: {
              "/home":(context) => HomePage(),
              "/welcome":(context) => WelcomePage(),
              "/profile":(context) => ProfilePage(),
              "/ocr":(context) => OcrPage(),
              "/face":(context) => FaceDetectorPage(),
              "/QR":(context) => QRCodePage(),
              "/scanQR": (context) => QRViewScannerPage(),
              "/graphics": (context) => GraphicsPage()
            },
          );
        }
    );
  }
}


class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthenticateState>(
      builder: (context, state) {
        if(state.eventState==EventState.ERROR){
          return const WelcomePage();
        } else if (state.eventState==EventState.LOADED) {
          return HomePage();
        }
        return Container();
      },
    );
  }
}
