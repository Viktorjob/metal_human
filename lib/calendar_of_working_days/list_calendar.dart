import 'package:flutter/material.dart';


class BodyPartLegend extends StatelessWidget {

  final List<_LegendItem> items = [
    _LegendItem(color: Colors.red, label: 'Upper Body'),
    _LegendItem(color: Colors.yellow, label: 'Lower Body'),
    _LegendItem(color: Colors.green, label: 'Core'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 16,
                height: 16,
                color: item.color,
              ),
              const SizedBox(width: 8),
              Text(
                item.label,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _LegendItem {
  final Color color;
  final String label;

  _LegendItem({required this.color, required this.label});
}