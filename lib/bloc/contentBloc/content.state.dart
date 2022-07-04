import '../../models/contents.model.dart';
import '../enums/EnumEvent.dart';


class ContentState
{
  Contents? contents;
  late EventState? eventState;
  int currentContent ;
  String error ='';
  ContentState({this.eventState, this.contents, required this.currentContent, required this.error});
}