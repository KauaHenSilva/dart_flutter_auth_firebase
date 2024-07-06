import 'package:dart_flutter_auth_firebase/models/auth.dart';
import 'package:dart_flutter_auth_firebase/widgets/my_elevation_button.dart';
import 'package:dart_flutter_auth_firebase/widgets/my_form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback onSignIn;
  const RegisterPage({super.key, required this.onSignIn});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  void signUp() {
    if (_formKey.currentState!.saveAndValidate()) {
      final values = _formKey.currentState!.value;

      final providerAuth = Provider.of<Auth>(context, listen: false);
      providerAuth.signUp(
        values['email'].toString(),
        values['password'].toString(),
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.android,
                  size: 100,
                ),
                const SizedBox(height: 75),
                Text(
                  "Sign up",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 16),
                Text(
                  'welcome back, you\'ve been missed!',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 50),
                FormBuilder(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      children: [
                        MyFormTextField(
                          name: 'email',
                          labelText: 'Email',
                          obscureText: false,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.email(),
                          ]),
                        ),
                        const SizedBox(height: 10),
                        MyFormTextField(
                          name: 'password',
                          labelText: 'Password',
                          obscureText: true,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.minLength(6)
                          ]),
                        ),
                        const SizedBox(height: 10),
                        MyFormTextField(
                          name: 'confirmPassword',
                          labelText: 'Confirm Password',
                          obscureText: true,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.minLength(6),
                            (val) {
                              if (val !=
                                  _formKey.currentState!.value['password']) {
                                return 'Password does not match';
                              }
                              return null;
                            }
                          ]),
                        ),
                        const SizedBox(height: 10),
                        MyElevationButton(
                          text: 'Sing up',
                          onPressed: signUp,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account?'),
                            TextButton(
                              onPressed: widget.onSignIn,
                              child: const Text(
                                'Sign in',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
