import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class TeamColorPicker extends StatefulWidget {
  static Color color = Colors.red;
  const TeamColorPicker({super.key});

  @override
  State<TeamColorPicker> createState() => _TeamColorPickerState();
}

class _TeamColorPickerState extends State<TeamColorPicker> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Pick a color!'),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: TeamColorPicker.color,
                onColorChanged: (value) => setState(() {
                  TeamColorPicker.color = value;
                }),
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Got it'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40),
        constraints: const BoxConstraints(maxHeight: 20, maxWidth: 20),
        color: TeamColorPicker.color,
      ),
    );
  }
}
