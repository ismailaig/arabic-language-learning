import '../../models/contents.model.dart';
import '../enums/EnumEvent.dart';

class ContentState
{
  Contents? contents;
  late EventState? eventState;
  int? currentPage = 0;
  String error ='';
  ContentState({this.eventState, this.contents, this.currentPage, required this.error});

}