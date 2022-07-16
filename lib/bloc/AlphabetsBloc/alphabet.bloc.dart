import 'package:bloc/bloc.dart';
import 'package:aget_arabic/bloc/enums/EnumEvent.dart';
import 'package:aget_arabic/repository/alphabets.repository.dart';
import 'alphabet.event.dart';
import 'alphabet.state.dart';

class AlphabetBloc extends Bloc<AlphabetEvent, AlphabetState> {
  final AlphabetRepository alphabetRepository;

  AlphabetBloc(this.alphabetRepository) : super(AlphabetState(error: '')) {
    on<AlphabetLoading>((event, emit) async {
      emit(AlphabetState(eventState: EventState.LOADING, error: ''));
      try {
        final alphabet = await alphabetRepository.getAlphabets();
        emit(AlphabetState(
            alphabet: alphabet, eventState: EventState.LOADED, error: ''));
      } catch (e) {
        emit(AlphabetState(eventState: EventState.ERROR, error: e.toString()));
      }
    });
  }
}
