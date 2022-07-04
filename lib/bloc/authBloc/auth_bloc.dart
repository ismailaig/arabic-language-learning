import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:devrnz/repository/users.repository.dart';
import 'package:equatable/equatable.dart';
import 'package:devrnz/models/users.model.dart';
import '../../models/users.model.dart';
import '../enums/EnumEvent.dart';
part 'auth_state.dart';

abstract class AuthEvent {}

class AppLoaded extends AuthEvent{
  ListUsers listUsers;
  AppLoaded({required this.listUsers});
}

class UpdatePicture extends AuthEvent
{
  File image;
  ListUsers listUsers;
  UpdatePicture(this.image, this.listUsers);
}

class LogOut extends AuthEvent{
}

class AuthBloc extends Bloc<AuthEvent, AuthenticateState> {
  final UserRepository userRepository;
  AuthBloc(this.userRepository) : super(AuthenticateState(eventState:EventState.ERROR,error: '')) {

    on<AppLoaded>((event, emit) {
        emit(AuthenticateState(listUsers: event.listUsers,eventState: EventState.LOADED,error: '',));
    });

    on<LogOut>((event, emit) {
        emit(AuthenticateState(eventState: EventState.ERROR,error: ''));
    });

    on<UpdatePicture>((event, emit) async {;
        try {
          if(event.listUsers.data[0].attributes.photo.data!=null){
            bool delete = await userRepository.deletePhoto(event.listUsers);
            if(delete){
              print("deleted");
            }
          }
          bool update = await userRepository.updatePhoto(event.image, event.listUsers);
          if(update){
            print("Updated");
            ListUsers listUsers = await userRepository.signIn(event.listUsers.data[0].attributes.email, event.listUsers.data[0].attributes.password);
            emit(AuthenticateState(listUsers: listUsers,eventState: EventState.LOADED,error: '',));
          }
        } catch (e) {
          print("Update problem "+e.toString());
        }
    });

  }
}
