import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:poolmate/presentation/constants/constants.dart';
import 'package:poolmate/presentation/detail/detail.dart';
import 'package:poolmate/presentation/screens/otp.dart';
import 'package:poolmate/presentation/screens/signin_page.dart';
import 'package:poolmate/presentation/screens/user.dart';
import '../widgets/widget.dart'; // Ensure this import is valid
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool passwordVisibility = true;
 Future save() async {
  var res = await http.post(
    Uri.parse("http://localhost:8080/signin"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': user.email,
      'password': user.password,
    }),
  );

  print(res.body);
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => OTPPage()),
  );
}

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
                            key: const ValueKey(
                                'email_field'), // Provide a key if needed
                            hintText: 'Email',
                            inputType: TextInputType.emailAddress,
                          ),
                          MyPasswordField(
                            controller:
                                TextEditingController(text: user.password),
                            onChanged: (value) {
                              user.password = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Something';
                              }
                            },

                            key: const ValueKey(
                                'password_field'), // Provide a key if needed
                            isPasswordVisible: passwordVisibility,
                            onTap: () {
                              setState(() {
                                passwordVisibility = !passwordVisibility;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: kBodyText,
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigate to Sign In page
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
                    MyTextButton(
                      buttonName: 'Register',
                      onTap: () {
                        // Implement registration logic here
                        print('Email: ${user.email}');
                        print('Password: ${user.password}');

                        // Call the save method to register the user
                        save();

                        // Show a Snackbar on successful registration
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Registration successful!'),
                          ),
                        );
                      },
                      bgColor: Colors.white,
                      textColor: Colors.black87,
                    ),
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
