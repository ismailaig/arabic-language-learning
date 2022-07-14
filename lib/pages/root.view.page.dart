import 'package:AgeArabic/bloc/lessonBloc/course.bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:AgeArabic/bloc/theme.bloc.dart';
import 'package:AgeArabic/pages/qr.code.page.dart';
import 'package:AgeArabic/pages/qr.scan.page.dart';
import 'package:AgeArabic/pages/welcome.page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  final storage = const FlutterSecureStorage();
  int logged = 0;

  @override
  void initState(){
    super.initState();
    initUserLogin();
  }

  void initUserLogin() async {
    String? email = await storage.read(key: "email");
    String? password = await storage.read(key: "password");
    String? themeIndex = await storage.read(key: "index");
    if(email!=null && password!=null){
      context.read<LoginBloc>().add(SignInButtonPressed(email: email, password: password));
    }else{
      setState((){
        logged = 2;
      });
    }
    if(themeIndex!=null){
      context.read<ThemeBloc>().add(LoadedThemeEvent(index: int.parse(themeIndex)));
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc,LoginState>(
        builder: (context,state){
          if(state is LoginSucced){
            context.read<AuthBloc>().add(AppLoaded(listUsers: state.listUsers));
            context.read<CourseBloc>().add(CourseLoading());
            return BlocBuilder<ThemeBloc,ThemeState>(
                builder: (context,state){
                  return MaterialApp(
                    color: Colors.white,
                    debugShowCheckedModeBanner: false,
                    theme: state.theme,
                    home: const HomePage(),
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
          }else if(state is LoginLoading){
            return BlocBuilder<ThemeBloc,ThemeState>(
                builder: (context,state){
                  return MaterialApp(
                    color: Colors.white,
                    debugShowCheckedModeBanner: false,
                    theme: state.theme,
                    home: Scaffold(
                      backgroundColor: Colors.white,
                      body: Container(
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
                            )
                        ),
                      ),
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
          }else if(state is LoginFailed){
            return BlocBuilder<ThemeBloc,ThemeState>(
                builder: (context,state){
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: state.theme,
                    home: const WelcomePage(),
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
          }else if(state is LoginInitial){
            if(logged==2){
              return BlocBuilder<ThemeBloc,ThemeState>(
                  builder: (context,state){
                    return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      theme: state.theme,
                      home: const WelcomePage(),
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
          return Container(color: Colors.white,);
        }
    );
  }
}














