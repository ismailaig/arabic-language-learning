import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:devrnz/models/users.model.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/users.model.dart';
part 'auth_state.dart';

abstract class AuthEvent {}

class AppLoaded extends AuthEvent{
  ListUsers listUsers;
  AppLoaded({required this.listUsers});
}

class UploadPicture extends AuthEvent
{
  XFile image;
  UploadPicture(this.image);
}

class LogOut extends AuthEvent{
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AppLoaded>((event, emit) {
        emit(AuthenticateState(listUsers: event.listUsers));
    });

    on<LogOut>((event, emit) {
        emit(UnAuthenticateState());
    });

    on<UploadPicture>((event, emit) =>{

    });
  }
}
