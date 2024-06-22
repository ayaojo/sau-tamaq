import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sau_tamaq_flutter/common/reusable_widgets.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
          showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text('Password reset email sent successfully'),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/Ornament.png',
                ),
                alignment: Alignment.topLeft,
                opacity: 0.45,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  backBtn(context),
                  const SizedBox(height: 150.0),
                  accountMainTextStyle('Сброс пароля'),
                  const SizedBox(height: 30.0),
                  textFieldForm('Почта', Icons.email, false, _emailController),
                  const SizedBox(height: 20),
                  MaterialButton(
                    onPressed: passwordReset,
                    color: Colors.deepPurple[200],
                    child: const Text('Сброс пароля'),
                  )
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     await FirebaseAuth.instance
                  //         .sendPasswordResetEmail(email: _emailController.text)
                  //         .then((value) {
                  //       showSnackBar(context, "send reset password email");
                  //     }).onError((error, stackTrace) {
                  //       showSnackBar(context, error.toString());
                  //     });
                  //   },
                  //   child: const Text('Сброс пароля'),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
