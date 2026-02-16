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
  static const int _maxLimit = 100;

  //initial couter value
  int _counter = 0;
  int _customIncrement = 1;
  List<int> _counterHistory = [];
  
  TextEditingController _incrementController = TextEditingController();

  Color get counterColor {
    if (_counter == 0) return Colors.red;
    if (_counter > 50) return Colors.green;
    return Colors.black;
  }

  void _saveToHistory() {
    _counterHistory.add(_counter);
    
  }

  void _incrementCounter() {
    setState(() {
      if (_counter + _customIncrement <= _maxLimit) {
        _counter += _customIncrement;
        _saveToHistory();
      }
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
        _saveToHistory();
      }
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      _saveToHistory();
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
              color: Colors.blue[100],
              padding: EdgeInsets.all(20),
              child: Text(
                '$_counter',
                style: TextStyle(
                  fontSize: 50.0,
                  color: counterColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (_counter >= _maxLimit)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Maximum limit reached!',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          SizedBox(height:20),

          Slider(
            min: 0,
            max: 100,
            value: _counter.toDouble(),
            onChanged: (double value) {
              setState(() {
                _counter = value.toInt();
                _saveToHistory();
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

          SizedBox(height: 20),

          Text(
            'Counter History:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Container(
            height: 100,
            child: _counterHistory.isEmpty
                ? Center(child: Text('No history yet'))
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _counterHistory.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '${_counterHistory[index]}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
