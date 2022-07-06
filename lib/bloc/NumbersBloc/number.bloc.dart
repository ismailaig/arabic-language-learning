import 'package:bloc/bloc.dart';
import 'package:devrnz/bloc/enums/EnumEvent.dart';
import 'package:devrnz/repository/numbers.repository.dart';
import 'number.event.dart';
import 'number.state.dart';

class NumberBloc extends Bloc<NumberEvent,NumberState>
{

  final NumberRepository numberRepository;


  NumberBloc(this.numberRepository) : super(NumberState(error: '')) {
    on<NumberLoading>((event, emit) async {
      emit(NumberState(eventState: EventState.LOADING,error: ''));
      try {
        final number = await numberRepository.getNumbers();
        emit(NumberState(number: number,eventState: EventState.LOADED,error: ''));
      } catch (e) {
        emit(NumberState(eventState: EventState.ERROR,error: e.toString()));
      }
    });
  }

}