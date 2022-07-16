part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSucced extends LoginState {
  final ListUsers listUsers;

  const LoginSucced({required this.listUsers});
}

class LoginFailed extends LoginState {}
