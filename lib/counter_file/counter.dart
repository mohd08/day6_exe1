import 'dart:async';

enum CounterEvent {
  Increment,
}

class CounterBloc {
  final _eventController = StreamController<CounterEvent>();
  Stream<CounterEvent> get eventStream => _eventController.stream;
  Sink<CounterEvent> get eventSink => _eventController.sink;

  final _counterController = StreamController<int>();
  Stream<int> get counterStream => _counterController.stream;
  Sink<int> get counterSink => _counterController.sink;

  int _counter = 0;

  CounterBloc(){
  eventStream.listen((CounterEvent event) {

    if(event == CounterEvent.Increment) {
      ++ _counter;
      counterSink.add(_counter);
    }
  });
}

  void dispose() {
    _eventController.close();
    _counterController.close();
  }
}