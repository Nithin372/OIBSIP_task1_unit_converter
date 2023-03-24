import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class Conversion {
  final String name;
  final double multiplier;

  Conversion({required this.name, required this.multiplier});
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();
  final _conversions = [
    Conversion(name: 'Millimeter to Kilometer', multiplier: 0.000001),
    Conversion(name: 'Centimeter to Kilometer', multiplier: 0.00001),
    Conversion(name: 'Meter to Kilometer', multiplier: 0.001),
    Conversion(name: 'Kilometer to Kilometer', multiplier: 1),
    Conversion(name: 'Mile to Kilometer', multiplier: 1.60934),
  ];
  Conversion? _selectedConversion;
  void _convert() {
    if (_selectedConversion == null) {
      return;
    }

    final value = double.tryParse(_controller.text);
    if (value == null) {
      return;
    }

    final result = value * _selectedConversion!.multiplier;
    final resultString = result.toStringAsFixed(2);
    const SizedBox(
      height: 40,
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Conversion Result'),
          content:
              Text('$value ${_selectedConversion!.name} = $resultString km'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Length Unit Converter")),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButton<Conversion>(
                isExpanded: true,
                value: _selectedConversion,
                onChanged: (value) {
                  setState(() {
                    _selectedConversion = value;
                  });
                },
                items: _conversions
                    .map((conversion) => DropdownMenuItem(
                          value: conversion,
                          child: Text(conversion.name),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _controller,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  hintText: 'Enter value to convert',
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _convert();
                },
                child: const Text('Convert'),
              ),
              TextButton(
                  child: const Text('Clear'),
                  onPressed: () {
                    setState(() {
                      _controller.text = '';
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
