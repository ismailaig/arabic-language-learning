import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:language/repositories/user_repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserRepository userRepository;
  AuthBloc({required this.userRepository}) : super(AuthInitial()){
    on<AppLoaded>((event, emit) async*{
      try {
        var isSignedIn = await userRepository.isSignedIn();
        if (isSignedIn) {
          var user = await userRepository.getCurrentUser();
          yield AuthenticateState(user: user);
        } else {
          yield UnAuthenticateState();
        }
      } catch (e) {
        yield UnAuthenticateState();
      }
    });
  }

}
