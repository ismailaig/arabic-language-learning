part of 'auth_bloc.dart';

class AuthenticateState {
  ListUsers? listUsers;
  late EventState? eventState;
  String error = '';

  AuthenticateState({this.eventState, this.listUsers, required this.error});
}
