import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';
import 'package:poolmate/presentation/detail/detail.dart';
import 'package:poolmate/presentation/screens/try.dart';
import 'dart:math';

import 'package:poolmate/presentation/widgets/my_text_button.dart';
// import 'package:poolmate/presentation/detail/detail.dart';

class OTPPage extends StatefulWidget {
  final String email;

  OTPPage(this.email);

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final TextEditingController _otpController = TextEditingController();
  late EmailAuth emailAuth;
  String? _generatedOTP;

  @override
  void initState() {
    super.initState();
    emailAuth = EmailAuth(sessionName: "PoolMate OTP Session");

    // Configuration for the email server
    emailAuth.config({
      "server": "smtp.gmail.com",
      "port": "465", // Changed to String
      "secure": "true", // Changed to String
    });

    _sendOTP();
  }

  void _sendOTP() async {
    _generatedOTP = _generateOTP();
    bool result = await emailAuth.sendOtp(
      recipientMail: widget.email,
      otpLength: 6,
    );

    if (result) {
      // You can send this message via your email service
      print("Your PoolMate OTP is: $_generatedOTP");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP sent to ${widget.email}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send OTP. Please try again.')),
      );
    }
  }

  String _generateOTP() {
    return Random().nextInt(999999).toString().padLeft(6, '0');
  }

  void _verifyOTP() {
    print('Generated OTP: $_generatedOTP');
    print('User input OTP: ${_otpController.text}');
    if (_otpController.text == _generatedOTP) {
      print('OTP Verified');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DetailScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid OTP. Please try again.')),
      );
    }
  }

  void _navigateToDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailScreen()), // Navigating to details.dart
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OTP Verification')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Enter the OTP sent to ${widget.email}'),
            SizedBox(height: 16),
            TextField(
              controller: _otpController,
              decoration: InputDecoration(labelText: 'OTP'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 24),
            MyTextButton(
                buttonName: 'Otp verify',
                onTap: _verifyOTP,
                bgColor: Colors.black,
                textColor: Colors.white),
            SizedBox(height: 16),
            MyTextButton(
                buttonName: 'sendOtp',
                onTap: _sendOTP,
                bgColor: Colors.black,
                textColor: Colors.white),
            SizedBox(height: 16),
            MyTextButton(
                buttonName: 'Go to Details',
                onTap: _navigateToDetails, // Redirect to details.dart
                bgColor: Colors.blue,
                textColor: Colors.white),
          ],
        ),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Center(
        child: Text('Welcome to PoolMate!', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
