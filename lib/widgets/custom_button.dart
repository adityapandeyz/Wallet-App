import 'package:flutter/material.dart';

/// A custom button widget that displays an image background and a text overlay.
class CustomButton extends StatelessWidget {
  final String hintText;
  final VoidCallback ontap;

  /// Creates a custom button.
  ///
  /// The [ontap] parameter is required and specifies the callback function to be called when the button is tapped.
  /// The [hintText] parameter is required and specifies the text to be displayed on the button.
  const CustomButton({
    Key? key,
    required this.ontap,
    required this.hintText,
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
          image: const DecorationImage(
            image: NetworkImage(
              'https://cdn.pixabay.com/photo/2023/04/13/15/51/ai-generated-7922898_1280.jpg',
            ),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.black45,
          ),
          child: Center(
            child: Text(
              hintText,
              style: const TextStyle(
                fontSize: 16,
                // fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
