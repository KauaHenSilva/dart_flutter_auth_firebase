import 'package:dart_flutter_auth_firebase/models/auth.dart';
import 'package:dart_flutter_auth_firebase/widgets/my_dialog.dart';
import 'package:dart_flutter_auth_firebase/widgets/my_elevated_button.dart';
import 'package:dart_flutter_auth_firebase/widgets/my_form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  void onPasswordReset() {
    if (_formKey.currentState!.saveAndValidate()) {
      final values = _formKey.currentState!.value;

      final auth = Provider.of<Auth>(context, listen: false)
          .resetPassword(values['email'].toString(), context);

      MyDialog(
        context: context,
        future: auth,
        showSuccessDialog: true,
        messageSuccess: "Check your email to reset your password.",
        titleSuccess: "Password reset",
      ).show().then((value) => Navigator.of(context).pop());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Enter your email to reset your password",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            FormBuilder(
              key: _formKey,
              child: MyFormTextField(
                name: 'email',
                labelText: 'Email',
                obscureText: false,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
              ),
            ),
            const SizedBox(height: 20),
            MyElevatedButton(
              onPressed: onPasswordReset,
              text: "Reset password",
            )
          ],
        ),
      ),
    );
  }
}
