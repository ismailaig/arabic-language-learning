import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language/bloc/theme.bloc.dart';
import 'package:language/main.dart';
import 'package:language/pages/welcome.page.dart';
import '../bloc/authBloc/auth_bloc.dart';
import 'profile.page.dart';
import 'setting.page.dart';
import 'home.page.dart';

class RootView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc,ThemeState>(
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.theme,
            home: MainScreen(),
            routes: {
              "/home":(context)=> HomePage(),
              "/welcome":(context)=> WelcomePage(),
              "/profile":(context)=> ProfilePage(),
              "/setting":(context)=> SettingPage(),
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
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if(state is AuthInitial){
          return WelcomePage();
        }else if (state is UnAuthenticateState) {
          return WelcomePage();
        } else if (state is AuthenticateState) {
          return HomePage();
        }
        return Container();
      },
    );
  }
}
