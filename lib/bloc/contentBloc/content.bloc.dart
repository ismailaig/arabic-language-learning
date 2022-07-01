import 'package:bloc/bloc.dart';
import '../../repository/contents.repository.dart';
import '../enums/EnumEvent.dart';
import 'content.event.dart';
import 'content.state.dart';

class ContentBloc extends Bloc<ContentEvent,ContentState> {
  final ContentRepository _contentRepository;

  ContentBloc(this._contentRepository) : super(ContentState(error: '', currentContent: 0)) {
    on<ContentLoading>((event, emit) async {
      emit(ContentState(eventState: EventState.LOADING,error: '', currentContent: 0));
      try {
        final contents = await _contentRepository.getContents(event.idLessons);
        /// print(contents.data);
        emit(ContentState(contents: contents,eventState: EventState.LOADED,error: '',currentContent: 0));
      } catch (e) {
        emit(ContentState(eventState: EventState.ERROR,error: e.toString(),currentContent: 0));
      }
    });

    on<ContentPagination>((event, emit) {
      if((state.currentContent+1) < state.contents!.data.length){
        state.currentContent = state.currentContent+1;
        emit(ContentState(currentContent: state.currentContent, error: "",eventState: state.eventState,contents: state.contents));
      }
    });
  }

}