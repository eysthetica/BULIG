import 'package:flutter/material.dart';

class YourWidget extends StatefulWidget {
  @override
  _YourWidgetState createState() => _YourWidgetState();
}

class _YourWidgetState extends State<YourWidget> {
  double selectedReviewValue = 0.0; // Default value

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Select Minimum Review Value: $selectedReviewValue'),
          SizedBox(height: 10),
          Slider(
            value: selectedReviewValue,
            onChanged: (value) {
              setState(() {
                selectedReviewValue = value;
              });
            },
            min: 0.0,
            max: 100.0, // Adjust the maximum value as needed
            divisions:
                100, // Optional: Define the number of divisions on the slider
            label: selectedReviewValue.toString(),
          ),
        ],
      ),
    );
  }
}
