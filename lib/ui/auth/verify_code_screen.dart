import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/auth/post/post_screen.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:flutter_application_1/widgets/round_button.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({super.key, required this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final verificationCodeController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;

  Future<void> verifyOtp() async {
    setState(() {
      isLoading = true;
    });
    final credential = PhoneAuthProvider.credential(verificationId: widget.verificationId, smsCode: verificationCodeController.text);
    try {
       setState(() {
      isLoading = false;
    });
      await _auth.signInWithCredential(credential);
      Utils().toastMessage("Verified otp successfully");
      Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen()));
    } catch (e) {
        setState(() {
      isLoading = false;
    });
    Utils().toastMessage(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: verificationCodeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: '6 digits code'),
            ),
            SizedBox(
              height: 50,
            ),
            RoundButton(
                title: 'Verify',
                isLoading: isLoading,
                onTap: () async {
                  await verifyOtp();
                })
          ],
        ),
      ),
    );
  }
}