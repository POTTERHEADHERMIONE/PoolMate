import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:poolmate/presentation/constants/constants.dart';
import 'package:poolmate/presentation/screens/otp.dart';
import 'package:poolmate/presentation/screens/signin_page.dart';
import 'package:poolmate/presentation/screens/user.dart';
import '../widgets/widget.dart'; // Ensure this import is valid

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool passwordVisibility = true;
  User user = User("", "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image(
            width: 24,
            color: Colors.white,
            image: Svg('assets/images/back_arrow.svg'),
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Register",
                            style: kHeadline,
                          ),
                          Text(
                            "Create a new account to get started.",
                            style: kBodyText2,
                          ),
                          SizedBox(height: 50),
                          MyTextField(
                            controller: TextEditingController(text: user.email),
                            onChanged: (value) {
                              user.email = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Something';
                              }
                            },
                            key: const ValueKey('email_field'),
                            hintText: 'Email',
                            inputType: TextInputType.emailAddress,
                          ),
                          MyPasswordField(
                            controller: TextEditingController(text: user.password),
                            onChanged: (value) {
                              user.password = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Something';
                              }
                            },
                            key: const ValueKey('password_field'),
                            isPasswordVisible: passwordVisibility,
                            onTap: () {
                              setState(() {
                                passwordVisibility = !passwordVisibility;
                              });
                            },
                          ),
                          SizedBox(height: 30), // Space between the form and button
                          MyTextButton(
                            buttonName: 'Register',
                            onTap: () {
                              // Print the user input for testing
                              print('Email: ${user.email}');
                              print('Password: ${user.password}');

                              // Navigate to OTPPage after registration
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => OTPPage(user.email)),
                              );

                              // Show a Snackbar on register attempt
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Attempting to register...'),
                                ),
                              );
                            },
                            bgColor: Colors.white,
                            textColor: Colors.black87,
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: kBodyText,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Sign In",
                            style: kBodyText.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
