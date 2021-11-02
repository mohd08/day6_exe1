import 'package:flutter/material.dart';
import 'counter_file/counter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
       home: HomePage(title: 'Flutter Demo Home Page'),
      );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  HomePageState createState() => HomePageState();
}


class HomePageState extends State<HomePage> {
  final CounterBloc _counterBloc = CounterBloc();

  @override 
  void dispose() {
    _counterBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            // wrap counter text with StreamBuilder
            // it rebuilds itself when new data comes in stream
            StreamBuilder<int>(
              //listen to the counterStream
              stream: _counterBloc.counterStream,
              initialData: 0,
              builder: (context, snapshot) {
                // get the data
                final counter = snapshot.data;
                return Text(
                  '$counter',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void _incrementCounter() {
  // add event to notify bloc
  _counterBloc.eventSink.add(CounterEvent.Increment);
}

}