import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Convertidor de Temperaturas en la Planta',
      theme: ThemeData(
        primaryColor: Colors.purple, // Color de la barra de navegación
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TemperatureConverterScreen(),
    );
  }
}

class TemperatureConverterScreen extends StatefulWidget {
  @override
  _TemperatureConverterScreenState createState() =>
      _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState
    extends State<TemperatureConverterScreen> {
  double _inputTemperature = 0;
  double _outputTemperature = 0;
  String _fromUnit = 'Celsius';
  String _toUnit = 'Fahrenheit';

  void _convertTemperature() {
    setState(() {
      if (_fromUnit == 'Celsius' && _toUnit == 'Fahrenheit') {
        _outputTemperature = (_inputTemperature * 9 / 5) + 32;
      } else if (_fromUnit == 'Fahrenheit' && _toUnit == 'Celsius') {
        _outputTemperature = (_inputTemperature - 32) * 5 / 9;
      } else {
        _outputTemperature = _inputTemperature;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Convertidor de Temperaturas en la Planta'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _inputTemperature = double.tryParse(value) ?? 0;
                });
              },
              decoration: InputDecoration(
                labelText: 'Temperatura ($_fromUnit)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                DropdownButton<String>(
                  value: _fromUnit,
                  onChanged: (newValue) {
                    setState(() {
                      _fromUnit = newValue!;
                      _convertTemperature();
                    });
                  },
                  items: ['Celsius', 'Fahrenheit', 'Kelvin']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      final temp = _fromUnit;
                      _fromUnit = _toUnit;
                      _toUnit = temp;
                      _convertTemperature();
                    });
                  },
                  icon: Icon(Icons.swap_horiz),
                ),
                DropdownButton<String>(
                  value: _toUnit,
                  onChanged: (newValue) {
                    setState(() {
                      _toUnit = newValue!;
                      _convertTemperature();
                    });
                  },
                  items: ['Celsius', 'Fahrenheit', 'Kelvin']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              '$_outputTemperature $_toUnit',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
