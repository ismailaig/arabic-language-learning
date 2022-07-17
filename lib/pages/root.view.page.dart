import 'package:aget_arabic/bloc/lessonBloc/course.bloc.dart';
import 'package:aget_arabic/pages/connection.error.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aget_arabic/bloc/theme.bloc.dart';
import 'package:aget_arabic/pages/qr.scan.page.dart';
import 'package:aget_arabic/pages/welcome.page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../bloc/authBloc/auth_bloc.dart';
import '../bloc/lessonBloc/course.event.dart';
import '../bloc/loginBloc/login_bloc.dart';
import 'face.detector.page.dart';
import 'graphics.page.dart';
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
  bool logged = false;

  @override
  void initState() {
    super.initState();
    initUserLogin();
  }

  void initUserLogin() async {
    String? email = await storage.read(key: "email");
    String? password = await storage.read(key: "password");
    String? themeIndex = await storage.read(key: "index");
    if (email != null && password != null) {
      context
          .read<LoginBloc>()
          .add(SignInButtonPressed(email: email, password: password));
    } else {
      setState(() {
        logged = true;
      });
    }
    if (themeIndex != null) {
      context
          .read<ThemeBloc>()
          .add(LoadedThemeEvent(index: int.parse(themeIndex)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(listener: (context, state) {
      if (state is LoginSucced) {
        context.read<AuthBloc>().add(AppLoaded(listUsers: state.listUsers));
        context.read<CourseBloc>().add(CourseLoading());
      }
    }, child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      return MaterialApp(
          color: Colors.white,
          debugShowCheckedModeBanner: false,
          theme: state.theme,
          home: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
            if (state is LoginLoading) {
              return Scaffold(
                backgroundColor: Colors.white,
                body: Container(
                  color: Colors.white,
                  child: Center(
                      child: SpinKitThreeInOut(
                    itemBuilder: (context, index) {
                      final colors = [Colors.cyan, Colors.black26];
                      final color = colors[index % colors.length];
                      return DecoratedBox(
                          decoration: BoxDecoration(
                              color: color, shape: BoxShape.circle));
                    },
                    //color: Theme.of(context).primaryColor,
                    size: 60.0,
                  )),
                ),
              );
            } else if (state is LoginSucced) {
              return const HomePage();
            } else if (state is LoginFailed) {
              return const ConnexionErrorPage();
            } else if (state is LoginInitial) {
              if (logged == true) {
                return const WelcomePage();
              } else {
                return Scaffold(
                    backgroundColor: Colors.white,
                    body: Container(color: Colors.white));
              }
            }
            return Scaffold(
                backgroundColor: Colors.white,
                body: Container(color: Colors.white));
          }),
          routes: {
            "/home": (context) => const HomePage(),
            "/welcome": (context) => const WelcomePage(),
            "/profile": (context) => const ProfilePage(),
            "/ocr": (context) => const OcrPage(),
            "/face": (context) => const FaceDetectorPage(),
            "/scanQR": (context) => const QRViewScannerPage(),
            "/graphics": (context) => const GraphicsPage()
          },
      );
    }));
  }
}
