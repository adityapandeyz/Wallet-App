import 'package:flutter/material.dart';

/// A custom button widget with customizable properties.
class CustomBotton2 extends StatelessWidget {
  /// The text to be displayed on the button.
  final String hintText;

  /// The callback function to be executed when the button is tapped.
  final VoidCallback ontap;

  /// Determines whether the button color should be red or blue.
  final bool isColorRed;

  /// Creates a [CustomBotton2] widget.
  ///
  /// The [hintText], [ontap], and [isColorRed] parameters must not be null.
  const CustomBotton2({
    Key? key,
    required this.hintText,
    required this.ontap,
    required this.isColorRed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isColorRed ? Colors.red : Colors.blue,
        ),
        child: Center(
          child: Text(
            hintText,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
