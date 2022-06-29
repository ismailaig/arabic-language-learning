import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:devrnz/models/users.model.dart';
import '../../models/users.model.dart';
part 'auth_state.dart';

abstract class AuthEvent {}

class AppLoaded extends AuthEvent{
  ListUsers listUsers;
  int uid;
  AppLoaded({required this.listUsers, required this.uid});
}

class LogOut extends AuthEvent{
  int uid;
  LogOut({required this.uid});
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AppLoaded>((event, emit) {
      if (event.uid!=0) {
        emit(AuthenticateState(listUsers: event.listUsers));
      } else {
        emit(UnAuthenticateState());
      }
    });

    on<LogOut>((event, emit) {
      if (event.uid==0) {
        emit(UnAuthenticateState());
      }
    });
  }
}
