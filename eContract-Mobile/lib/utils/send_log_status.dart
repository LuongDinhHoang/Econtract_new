abstract class SendLogStatus{
  const SendLogStatus();
}

class InitialSensLogStatus extends SendLogStatus{
  const InitialSensLogStatus();
}
class SendingLogStatus extends SendLogStatus{}
class SendLogSuccess extends SendLogStatus{}
class SendLogFail extends SendLogStatus{}