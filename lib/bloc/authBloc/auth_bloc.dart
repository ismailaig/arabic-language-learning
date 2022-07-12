import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:devrnz/repository/users.repository.dart';
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

class DeletePicture extends AuthEvent
{
  ListUsers listUsers;
  DeletePicture(this.listUsers);
}

class UpdateInfos extends AuthEvent
{
  int id;
  String fullname;
  String email;
  ListUsers listUsers;
  String password;
  UpdateInfos({required this.id, required this.fullname, required this.email, required this.listUsers, required this.password});
}

class LogOut extends AuthEvent{
}

class AuthBloc extends Bloc<AuthEvent, AuthenticateState> {
  final UserRepository userRepository;
  AuthBloc(this.userRepository) : super(AuthenticateState(eventState:EventState.INITIAL,error: '')) {

    on<AppLoaded>((event, emit) {
        emit(AuthenticateState(listUsers: event.listUsers,eventState: EventState.LOADED,error: '',));
    });

    on<LogOut>((event, emit) {
        emit(AuthenticateState(eventState: EventState.ERROR,error: ''));
    });

    on<UpdatePicture>((event, emit) async {
        try {
          if(event.listUsers.data[0].attributes.photo.data!=null){
            await userRepository.deletePhoto(event.listUsers);
          }
          bool update = await userRepository.updatePhoto(event.image, event.listUsers);
          if(update){
            ListUsers listUsers = await userRepository.signIn(event.listUsers.data[0].attributes.email, event.listUsers.data[0].attributes.password);
            emit(AuthenticateState(listUsers: listUsers,eventState: EventState.LOADED,error: '',));
          }
        } catch (e) {
          emit(AuthenticateState(listUsers: event.listUsers,eventState: EventState.LOADED,error: 'Not updated',));
          throw("Update problem $e");
        }
    });

    on<UpdateInfos>((event, emit) async {
      emit(AuthenticateState(listUsers: event.listUsers, eventState: EventState.LOADING, error: ''));
      try {
        bool update = await userRepository.updateUserInfos(event.id, event.fullname, event.password);
        if(update){
          ListUsers listUsers = await userRepository.signIn(event.email, event.password);
          emit(AuthenticateState(listUsers: listUsers,eventState: EventState.LOADED,error: 'Updated',));
        }
      } catch (e) {
        emit(AuthenticateState(listUsers: event.listUsers,eventState: EventState.LOADED,error: 'Not updated',));
        throw("Update problem $e");
      }
    });

    on<DeletePicture>((event, emit) async {
      try {
        bool delete = await userRepository.deletePhoto(event.listUsers);
        if(delete){
          ListUsers listUsers = await userRepository.signIn(event.listUsers.data[0].attributes.email, event.listUsers.data[0].attributes.password);
          emit(AuthenticateState(listUsers: listUsers,eventState: EventState.LOADED,error: '',));
        }
      } catch (e) {
        emit(AuthenticateState(listUsers: event.listUsers,eventState: EventState.LOADED,error: 'Not updated',));
        throw("Update problem $e");
      }
    });

  }
}
