import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      title: 'Stateful Widget',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // A widget that will be started on the application startup
      home: CounterWidget(),
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  //initial couter value
  int _counter = 0;
  int _customIncrement = 1;
  
  TextEditingController _incrementController = TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter += _customIncrement;
    });
  }
  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  void dispose() {
    _incrementController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stateful Widget'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              color: Colors.blue,
              child: Text(
                //displays the current number
                '$_counter',
                style: TextStyle(fontSize: 50.0),
              ),
            ),
          ),
          Slider(
            min: 0,
            max: 100,
            value: _counter.toDouble(),
            onChanged: (double value) {
              setState(() {
                _counter = value.toInt();
              });
            },
            activeColor: Colors.blue,
            inactiveColor: Colors.red,
          ),

          SizedBox(height: 20),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
            child: TextField(
              controller: _incrementController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Custom Increment Value',
                hintText: 'Enter increment value (e.g., 5)',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _customIncrement = int.tryParse(value) ?? 1;
                });
              },
            ),
          ),
          SizedBox(height:20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _decrementCounter,
                child: Text('Decrement'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
              ),
              ElevatedButton(
                onPressed: _incrementCounter,
                child: Text('Increment'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
              ElevatedButton(
                onPressed: _resetCounter,
                child: Text('Reset'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
