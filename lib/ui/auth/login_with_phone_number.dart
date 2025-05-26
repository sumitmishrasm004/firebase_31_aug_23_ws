import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/auth/verify_code_screen.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:flutter_application_1/widgets/round_button.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  final phoneNumberController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;

  Future<void> loginWithPhoneNumber() async {
    setState(() {
      isLoading = true;
    });
    _auth.verifyPhoneNumber(
        phoneNumber: phoneNumberController.text,
        verificationCompleted: (_) {
          setState(() {
            isLoading = false;
          });
        },
        codeSent: (String verificationId, int? token) {
          setState(() {
            isLoading = false;
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      VerifyCodeScreen(verificationId: verificationId)));
        },
        verificationFailed: (error) {
          setState(() {
            isLoading = false;
          });
        },
        codeAutoRetrievalTimeout: (e) {
          Utils().toastMessage(e.toString());
          setState(() {
            isLoading = false;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: '+1 234 2332 345'),
            ),
            SizedBox(
              height: 50,
            ),
            RoundButton(
                title: 'Login',
                isLoading: isLoading,
                onTap: () async {
                  await loginWithPhoneNumber();
                })
          ],
        ),
      ),
    );
  }
}
