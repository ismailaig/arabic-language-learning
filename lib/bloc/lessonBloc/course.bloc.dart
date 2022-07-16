import 'package:bloc/bloc.dart';
import 'package:aget_arabic/bloc/enums/EnumEvent.dart';
import 'package:aget_arabic/bloc/lessonBloc/course.event.dart';
import '../../repository/course.repository.dart';
import 'course.state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final CourseRepository _courseRepository;

  CourseBloc(this._courseRepository) : super(CourseState(error: '')) {
    on<CourseLoading>((event, emit) async {
      emit(CourseState(eventState: EventState.LOADING, error: ''));
      try {
        final lesson = await _courseRepository.getLessons();
        emit(CourseState(
            lessons: lesson, eventState: EventState.LOADED, error: ''));
      } catch (e) {
        emit(CourseState(eventState: EventState.ERROR, error: e.toString()));
      }
    });
  }
}
