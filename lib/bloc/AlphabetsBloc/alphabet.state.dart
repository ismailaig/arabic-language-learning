import 'package:devrnz/bloc/enums/EnumEvent.dart';
import '../../models/alphabets.model.dart';

class AlphabetState
{
  final Alphabets? alphabet;
  final EventState? eventState;
  int? currentPage = 0;
  String error = '';
  AlphabetState({ this.eventState,  this.alphabet,  this.currentPage,required this.error});

}
