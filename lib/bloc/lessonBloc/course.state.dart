import 'package:devrnz/bloc/enums/EnumEvent.dart';
import '../../models/lessons.model.dart';


class CourseState
{
  final Lessons? lessons;
  final EventState? eventState;
  int? currentPage = 0;
  String error = '';
  CourseState({ this.eventState,  this.lessons,  this.currentPage,required this.error});

}