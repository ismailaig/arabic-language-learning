import '../../models/contents.model.dart';
import '../enums/EnumEvent.dart';


class ContentState
{
  Contents? contents;
  late EventState? eventState;
  int currentContent;
  int? idLesson;
  String error ='';
  ContentState({this.eventState, this.contents, required this.currentContent, this.idLesson, required this.error});
}