import 'package:devrnz/bloc/enums/EnumEvent.dart';
import 'package:devrnz/bloc/lessonBloc/course.bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:devrnz/bloc/theme.bloc.dart';
import 'package:devrnz/models/users.model.dart';
import 'package:devrnz/pages/qr.code.page.dart';
import 'package:devrnz/pages/qr.scan.page.dart';
import 'package:devrnz/pages/welcome.page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../bloc/authBloc/auth_bloc.dart';
import '../bloc/lessonBloc/course.event.dart';
import '../bloc/loginBloc/login_bloc.dart';
import 'face.detector.page.dart';
import 'graphics.page.dart';
import 'maps.page.dart';
import 'ocr.page.dart';
import 'profile.page.dart';
import 'home.page.dart';

class RootView extends StatefulWidget {


  const RootView({Key? key}) : super(key: key);

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  late ListUsers listUsers;
  final storage = const FlutterSecureStorage();
  late LoginBloc loginBloc;
  late AuthBloc authBloc;

  _onReadUserInfo() async{
    String? email = await storage.read(key: "email");
    String? password = await storage.read(key: "password");
    if(email!=null && password!=null){
      loginBloc.add(SignInButtonPressed(email: email,password: password));
    }
  }

  @override
  Widget build(BuildContext context) {
    authBloc = BlocProvider.of<AuthBloc>(context);
    loginBloc = BlocProvider.of<LoginBloc>(context);
    _onReadUserInfo();
    return BlocBuilder<ThemeBloc,ThemeState>(
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.theme,
            home: BlocBuilder<LoginBloc,LoginState>(
              builder: (context,state){
                  if(state is LoginSucced){
                    authBloc.add(AppLoaded(listUsers: state.listUsers));
                    return MainScreen();
                  }else if(state is LoginLoading){
                    return Container();
                  }else if(state is LoginFailed){
                    return MainScreen();
                  }
                  return Container();
              }
              ),
            routes: {
              "/home":(context) => const HomePage(),
              "/welcome":(context) => const WelcomePage(),
              "/profile":(context) => ProfilePage(),
              "/maps":(context) => const MapPage(),
              "/ocr":(context) => const OcrPage(),
              "/face":(context) => const FaceDetectorPage(),
              "/QR":(context) => const QRCodePage(),
              "/scanQR": (context) => const QRViewScannerPage(),
              "/graphics": (context) => const GraphicsPage()
            },
          );
        }
    );
  }
}


class MainScreen extends StatelessWidget {
  late CourseBloc courseBloc;

  MainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    courseBloc = BlocProvider.of<CourseBloc>(context);
    return BlocBuilder<AuthBloc, AuthenticateState>(
      builder: (context, state) {
        if(state.eventState==EventState.ERROR){
          return const WelcomePage();
        } else if (state.eventState==EventState.LOADED) {
          courseBloc.add(CourseLoading());
          return const HomePage();
        }else if(state.eventState==EventState.INITIAL){
          return const CircularProgressIndicator();
        }
        return Container();
      },
    );
  }
}
