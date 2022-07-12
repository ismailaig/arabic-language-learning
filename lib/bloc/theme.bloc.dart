import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class ThemeEvent {}
class SwitchThemeEvent extends ThemeEvent{}

class LoadedThemeEvent extends ThemeEvent{
  int index;
  LoadedThemeEvent({required this.index});
}

class ThemeState {
  final ThemeData theme;
  ThemeState(this.theme);
}
class InitialTheme extends ThemeState{
  InitialTheme() : super(ThemeData(primarySwatch:Colors.deepOrange));
}

class ThemeBloc extends Bloc<ThemeEvent,ThemeState>{
  int index=0;
  final storage = const FlutterSecureStorage();

  List<ThemeData> themes = [
    ThemeData(primarySwatch:Colors.deepOrange),
    ThemeData(primarySwatch:Colors.blue),
    ThemeData(primarySwatch:Colors.deepPurple),
    ThemeData(primarySwatch:Colors.teal)
  ];
  ThemeBloc() : super(InitialTheme()){

    on((SwitchThemeEvent event, emit) {
      ++index;
      if(index>=themes.length) {
        index = 0;
      }
      emit(ThemeState(themes[index]));
      storage.write(key: "index", value: index.toString());
    });

    on((LoadedThemeEvent event, emit) {
      index = event.index;
      emit(ThemeState(themes[index]));
    });

  }
}
