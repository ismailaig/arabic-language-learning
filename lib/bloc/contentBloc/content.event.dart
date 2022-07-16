abstract class ContentEvent {}

class ContentLoading extends ContentEvent {
  int idLessons;

  ContentLoading(this.idLessons);
}

class ContentLoaded extends ContentEvent {
  ContentLoaded();
}

class ContentError extends ContentEvent {
  String erroMessage;

  ContentError(this.erroMessage);
}

class ContentPagination extends ContentEvent {}
