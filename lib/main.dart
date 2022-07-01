import 'package:devrnz/bloc/lessonBloc/course.bloc.dart';
import 'package:devrnz/repository/contents.repository.dart';
import 'package:devrnz/repository/course.repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/contentBloc/content.bloc.dart';
import 'pages/root.view.page.dart';
import 'bloc/authBloc/auth_bloc.dart';
import 'bloc/loginBloc/login_bloc.dart';
import 'bloc/logoutBloc/logout_bloc.dart';
import 'bloc/regBloc/reg_bloc.dart';
import 'bloc/theme.bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

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
            create: (context) => AuthBloc(),
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
        child: RootView(),
      );
  }
}






