import 'package:AgeArabic/bloc/enums/EnumEvent.dart';
import '../../models/numbers.model.dart';

class NumberState
{
  final Numbers? number;
  final EventState? eventState;
  int? currentPage = 0;
  String error = '';
  NumberState({ this.eventState,  this.number,  this.currentPage,required this.error});

}
