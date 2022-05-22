import 'package:bloc/bloc.dart';
import 'package:language/repositories/user_repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
part 'login_state.dart';

abstract class LoginEvent {}
class SignInButtonPressed extends LoginEvent{
  String password;
  String email;
  SignInButtonPressed({required this.email, required this.password});
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepository;
  LoginBloc({required this.userRepository}) : super(LoginInitial()) {

    on((SignInButtonPressed event, emit) async{
      emit(LoginLoading());
      try {
        var user = await userRepository.signIn(event.email, event.password);
        emit(LoginSucced(user: user));
      } catch (e) {
        emit(LoginFailed(message: e.toString()));
      }
    });

  }

}
