import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Calculator',
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _currentNumber = "";
  double _firstNumber = 0;
  String _operation = "";
  bool _isNewNumber = true;
  bool _isDarkMode = false;

  // Get theme-based colors
  Color get _backgroundColor => _isDarkMode ? Colors.black : Colors.white;
  Color get _textColor => _isDarkMode ? Colors.white : Colors.black;
  Color get _buttonColor => _isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;
  Color get _operatorColor => _isDarkMode ? Colors.blue[700]! : Colors.blue;
  Color get _clearButtonColor => _isDarkMode ? Colors.red[900]! : Colors.red;

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _currentNumber = "";
        _firstNumber = 0;
        _operation = "";
        _isNewNumber = true;
      } else if (buttonText == "+" || buttonText == "-" || 
                 buttonText == "×" || buttonText == "÷") {
        if (_currentNumber.isNotEmpty) {
          _firstNumber = double.parse(_currentNumber);
          _operation = buttonText;
          _isNewNumber = true;
        }
      } else if (buttonText == "=") {
        if (_currentNumber.isNotEmpty && _operation.isNotEmpty) {
          double secondNumber = double.parse(_currentNumber);
          switch (_operation) {
            case "+":
              _output = (_firstNumber + secondNumber).toString();
              break;
            case "-":
              _output = (_firstNumber - secondNumber).toString();
              break;
            case "×":
              _output = (_firstNumber * secondNumber).toString();
              break;
            case "÷":
              _output = (_firstNumber / secondNumber).toString();
              break;
          }
          _currentNumber = _output;
          _operation = "";
        }
      } else if (buttonText == ".") {
        if (!_currentNumber.contains(".")) {
          _currentNumber = _currentNumber.isEmpty ? "0." : _currentNumber + ".";
          _output = _currentNumber;
        }
      } else {
        if (_isNewNumber) {
          _currentNumber = buttonText;
          _isNewNumber = false;
        } else {
          _currentNumber += buttonText;
        }
        _output = _currentNumber;
      }
    });
  }

  Widget _buildButton(String buttonText, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? _buttonColor,
            foregroundColor: _textColor,
            padding: const EdgeInsets.all(24.0),
          ),
          onPressed: () => _onButtonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 24.0,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Calculator'),
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                setState(() {
                  _isDarkMode = !_isDarkMode;
                });
              },
            ),
          ],
        ),
        body: Container(
          color: _backgroundColor,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                  horizontal: 12.0,
                ),
                child: Text(
                  _output,
                  style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                    color: _textColor,
                  ),
                ),
              ),
              const Expanded(
                child: Divider(),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      _buildButton("7"),
                      _buildButton("8"),
                      _buildButton("9"),
                      _buildButton("÷", color: _operatorColor),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton("4"),
                      _buildButton("5"),
                      _buildButton("6"),
                      _buildButton("×", color: _operatorColor),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton("1"),
                      _buildButton("2"),
                      _buildButton("3"),
                      _buildButton("-", color: _operatorColor),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton("0"),
                      _buildButton("."),
                      _buildButton("=", color: _operatorColor),
                      _buildButton("+", color: _operatorColor),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton("C", color: _clearButtonColor),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}