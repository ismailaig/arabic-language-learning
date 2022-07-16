abstract class CourseEvent {}

class CourseLoading extends CourseEvent {}

class CourseLoaded extends CourseEvent {
  CourseLoaded();
}

class CourseError extends CourseEvent {
  String erroMessage;

  CourseError(this.erroMessage);
}
