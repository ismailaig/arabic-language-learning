import 'package:equatable/equatable.dart';

abstract class LogoutEvent extends Equatable {}

class LogoutButtonPressed extends LogoutEvent {
  @override
  List<Object> get props => [];
}
