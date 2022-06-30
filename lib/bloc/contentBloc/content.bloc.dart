import 'package:bloc/bloc.dart';
import '../../repository/contents.repository.dart';
import '../enums/EnumEvent.dart';
import 'content.event.dart';
import 'content.state.dart';

class ContentBloc extends Bloc<ContentEvent,ContentState>
{
  final ContentRepository _contentRepository;

  ContentBloc(this._contentRepository) : super(ContentState(error: '')) {
    on<ContentLoading>((event, emit) async {
      emit(ContentState(eventState: EventState.LOADING,error: ''));
      try {
        final contents = await _contentRepository.getContents(event.idLessons);
        emit(ContentState(contents: contents,eventState: EventState.LOADED,error: ''));
      } catch (e) {
        emit(ContentState(eventState: EventState.ERROR,error: e.toString()));
      }
    });
  }

}