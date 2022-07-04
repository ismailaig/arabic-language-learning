abstract class NumberEvent {}

class NumberLoading extends NumberEvent
{

}

class NumberLoaded extends NumberEvent
{
  NumberLoaded();
}

class NumberError extends NumberEvent
{
  String erroMessage;
  NumberError(this.erroMessage);
}