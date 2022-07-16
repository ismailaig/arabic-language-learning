import 'package:aget_arabic/bloc/lessonBloc/course.bloc.dart';
import 'package:aget_arabic/repository/alphabets.repository.dart';
import 'package:aget_arabic/repository/contents.repository.dart';
import 'package:aget_arabic/repository/course.repository.dart';
import 'package:aget_arabic/repository/numbers.repository.dart';
import 'package:aget_arabic/repository/users.repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/AlphabetsBloc/alphabet.bloc.dart';
import 'bloc/NumbersBloc/number.bloc.dart';
import 'bloc/contentBloc/content.bloc.dart';
import 'pages/root.view.page.dart';
import 'bloc/authBloc/auth_bloc.dart';
import 'bloc/loginBloc/login_bloc.dart';
import 'bloc/logoutBloc/logout_bloc.dart';
import 'bloc/regBloc/reg_bloc.dart';
import 'bloc/theme.bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider(
          create: (context) => ContentBloc(ContentRepository()),
        ),
        BlocProvider(
          create: (context) => CourseBloc(CourseRepository()),
        ),
        BlocProvider(
          create: (context) => AlphabetBloc(AlphabetRepository()),
        ),
        BlocProvider(
          create: (context) => NumberBloc(NumberRepository()),
        ),
        BlocProvider(
          create: (context) => AuthBloc(UserRepository()),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(),
        ),
      ],
      child: const RootView(),
    );
  }
}
