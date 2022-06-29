abstract class CourseEvent {}

class CourseLoading extends CourseEvent
{
  int page;
  CourseLoading(this.page);
}

class CourseLoaded extends CourseEvent
{
  CourseLoaded();
}

class CourseError extends CourseEvent
{
  String erroMessage;
  CourseError(this.erroMessage);
}