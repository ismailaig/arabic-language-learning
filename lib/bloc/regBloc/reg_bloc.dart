import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:devrnz/repository/users.repository.dart';
part 'reg_state.dart';

abstract class RegisterEvent {}
class SignUpButtonPressed extends RegisterEvent{
  String fullname;
  String password;
  String email;
  SignUpButtonPressed({required this.fullname, required this.email, required this.password});
}

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  UserRepository userRepository = UserRepository();
  RegisterBloc() : super(RegisterInitial()){
    on((SignUpButtonPressed event, emit) async{
      emit(RegisterLoading());
      try{
        var isRegistered = await userRepository.signUp(event.fullname, event.email, event.password);
          if(isRegistered==true){
            emit(RegisterSucced());
          }else{
            emit(RegisterFailed());
          }
      } catch (e) {
        emit(RegisterFailed());
      }
    });

  }

}
