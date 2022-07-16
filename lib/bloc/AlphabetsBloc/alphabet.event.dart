abstract class AlphabetEvent {}

class AlphabetLoading extends AlphabetEvent {}

class AlphabetLoaded extends AlphabetEvent {
  AlphabetLoaded();
}

class AlphabetError extends AlphabetEvent {
  String erroMessage;

  AlphabetError(this.erroMessage);
}
