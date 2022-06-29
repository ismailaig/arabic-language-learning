part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthenticateState extends AuthState {
  final ListUsers listUsers;
  const AuthenticateState({required this.listUsers});
}

//
class UnAuthenticateState extends AuthState {}
