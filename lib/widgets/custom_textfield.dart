import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A custom text field widget that can be used to input text.
class CustomTextField extends StatefulWidget {
  /// The number of lines for the text field.
  final int lines;

  /// The controller for the text field.
  final TextEditingController controller;

  /// The hint text to be displayed in the text field.
  final String hintText;

  /// The title text to be displayed above the text field.
  final String titleText;

  /// Determines if the title text is required or not.
  final bool isTitleRequired;

  /// Determines if the text should be obscured (e.g., for password fields).
  final bool obscureText;

  /// The validator function for the text field.
  final customTextFieldValidator;

  /// Determines if the text field should be autofocused.
  final bool autofocus;

  /// The type of keyboard to be displayed for the text field.
  final TextInputType textInputType;

  /// The action to be performed when the user submits the text field.
  final TextInputAction textInputAction;

  /// Creates a custom text field widget.
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.titleText = '',
    this.isTitleRequired = false,
    this.obscureText = false,
    this.customTextFieldValidator,
    this.lines = 1,
    this.autofocus = false,
    required this.textInputAction,
    this.textInputType = TextInputType.text,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Display the title text if it is required
        widget.isTitleRequired
            ? Text(
                widget.titleText,
                style: GoogleFonts.jost(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              )
            : const SizedBox(),
        const SizedBox(
          height: 4,
        ),
        TextFormField(
          maxLines: widget.lines,
          controller: widget.controller,
          autofocus: widget.autofocus,
          keyboardType: widget.textInputType,
          textInputAction: widget.textInputAction,
          decoration: InputDecoration(
            hintText: widget.hintText,
            filled: true,
            hintStyle: GoogleFonts.jost(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            contentPadding: const EdgeInsets.only(
                left: 18.0, bottom: 16.0, top: 16.0, right: 18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      isObscured ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isObscured = !isObscured;
                      });
                    },
                  )
                : const SizedBox(),
          ),
          validator: (val) {
            if (val!.isEmpty) {
              return 'Please enter ${widget.titleText.isNotEmpty == true ? widget.titleText : widget.hintText}';
            }
            return null;
          },
          obscureText: isObscured ? widget.obscureText : false,
        ),
      ],
    );
  }
}
