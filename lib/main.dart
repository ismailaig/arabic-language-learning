import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language/bloc/theme.bloc.dart';
import 'package:language/pages/root.view.page.dart';
import 'package:language/repositories/user_repositories.dart';
import 'bloc/authBloc/auth_bloc.dart';
import 'bloc/loginBloc/login_bloc.dart';
import 'bloc/logoutBloc/logout_bloc.dart';
import 'bloc/regBloc/reg_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBUfK_n950oVbqu4ZROmYHwW5WLMcFhwWQ",
      projectId: "flutterfirebase-d4b99",
      messagingSenderId: "533148226617",
      appId: "1:533148226617:web:308dbad6aec630ce0d69e8"
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  UserRepository userRepository = UserRepository(firebaseAuth: FirebaseAuth.instance);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context)=> ThemeBloc(),
          ),
          BlocProvider(
            create: (context)=> AuthBloc(userRepository: userRepository),
          ),
          BlocProvider(
            create: (context) => RegisterBloc(userRepository: userRepository),
          ),
          BlocProvider(
            create: (context) => LoginBloc(userRepository: userRepository),
          ),
          BlocProvider(
            create: (context) => LogoutBloc(userRepository: userRepository),
          ),
        ],
        child: RootView(),
      );
  }
}






