import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _selectedConversion = 'FtoC';

  TextEditingController _controller = TextEditingController();

  String _result = '';

  List<String> _history = [];

  void _convertTemperature() {
    final inputText = _controller.text.trim();
    final inputValue = double.tryParse(inputText);

    if (inputValue == null) {
      setState(() {
        _result = "Invalid input";
      });
      return;
    }

    double convertedValue;
    String historyEntry;

    if (_selectedConversion == 'FtoC') {
      convertedValue = (inputValue - 32) * 5 / 9;
      historyEntry =
          "F to C: $inputValue => ${convertedValue.toStringAsFixed(2)}";
    } else {
      convertedValue = inputValue * 9 / 5 + 32;
      historyEntry =
          "C to F: $inputValue => ${convertedValue.toStringAsFixed(2)}";
    }

    _history.add(historyEntry);

    setState(() {
      _result = convertedValue.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Converter",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 11, 114, 198),
        ),

        body: SafeArea(
          child: Column(
            children: [
              Text(
                "Conversion:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      title: Text(
                        "Fahrenheit to Celsius",
                        style: TextStyle(fontSize: 10.6),
                      ),
                      value: 'FtoC',
                      groupValue: _selectedConversion,
                      onChanged: (value) {
                        setState(() {
                          _selectedConversion = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: Text(
                        "Celsius to Fahrenheit",
                        style: TextStyle(fontSize: 10.6),
                      ),
                      value: 'CtoF',
                      groupValue: _selectedConversion,
                      onChanged: (value) {
                        setState(() {
                          _selectedConversion = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 12.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Input',
                        ),
                      ),
                    ),

                    Container(
                      child: Text(
                        "=",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Expanded(
                      child: TextField(
                        controller: TextEditingController(text: _result),
                        readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Result',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                children: [
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _convertTemperature,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      textStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text(
                      "CONVERT",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: _history.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_history[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
