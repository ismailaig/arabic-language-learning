import 'package:bloc/bloc.dart';
import 'package:language/repositories/user_repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
part 'reg_state.dart';

abstract class RegisterEvent {}
class SignUpButtonPressed extends RegisterEvent{
  String password;
  String email;
  SignUpButtonPressed({required this.email, required this.password});
}

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  UserRepository userRepository;
  RegisterBloc({required this.userRepository}) : super(RegisterInitial()){

    on((SignUpButtonPressed event, emit) async{
      emit(RegisterLoading());
      try {
        var user = await userRepository.signUp(event.email, event.password);
        emit(RegisterSucced(user: user));
      } catch (e) {
        emit(RegisterFailed(message: e.toString()));
      }
    });

  }

}
