import 'package:flutter/material.dart';
import 'package:poolmate/presentation/constants/constants.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton({
    Key? key, // Changed to Key? to make it nullable
    required this.buttonName,
    required this.onTap,
    required this.bgColor,
    required this.textColor  }) : super(key: key);

  final String buttonName;
  final VoidCallback onTap; // Changed from Function to VoidCallback
  final Color bgColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: TextButton(
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.resolveWith(
            (states) => Colors.black12,
          ),
        ),
        onPressed: onTap,
        child: Text(
          buttonName,
          style: kButtonText.copyWith(color: textColor),
        ),
      ),
    );
  }
}
