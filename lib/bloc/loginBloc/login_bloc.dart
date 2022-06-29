import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:devrnz/repository/users.repository.dart';
import '../../models/users.model.dart';
part 'login_state.dart';

abstract class LoginEvent {}
class SignInButtonPressed extends LoginEvent{
  String password;
  String email;
  SignInButtonPressed({required this.email, required this.password});
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepository = UserRepository();
  LoginBloc() : super(LoginInitial()) {
    on((SignInButtonPressed event, emit) async{
      emit(LoginLoading());
      try{
        ListUsers listUsers = await userRepository.signIn(event.email, event.password);
          emit(LoginSucced(listUsers: listUsers));
      } catch (e) {
        print(e);
        emit(LoginFailed());
      }
    });

  }

}
