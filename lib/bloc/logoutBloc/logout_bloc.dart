import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:language/repositories/user_repositories.dart';
import 'logout_event.dart';
import 'logout_state.dart';


class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  UserRepository userRepository;
  LogoutBloc({required this.userRepository}) : super(LogoutInitial()){
    on<LogoutButtonPressed>((event, emit) async*{
      userRepository.signOut();
      yield LogoutSucced();
    });
  }

}
