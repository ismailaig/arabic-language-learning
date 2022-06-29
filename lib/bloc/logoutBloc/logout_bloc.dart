import 'package:bloc/bloc.dart';
import 'package:devrnz/repository/users.repository.dart';
import 'logout_event.dart';
import 'logout_state.dart';


class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(LogoutInitial()){
    on<LogoutButtonPressed>((event, emit) {
      emit(LogoutSucced());
    });
  }

}
