import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_data_app/providers/user_data_provider.dart';
import 'package:user_data_app/screens/Register/register_page.dart';
import 'package:user_data_app/screens/main_page.dart';

import '../../widgets/custom_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isObscure = true;
  final formKey = GlobalKey<FormState>();

  Widget passwordVisibility() {
    return IconButton(
      onPressed: () {
        setState(() {
          isObscure = !isObscure;
        });
      },
      icon: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Icon(
          isObscure ? Icons.visibility_off_rounded : Icons.visibility_rounded,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Login..",
                style: TextStyle(
                  fontSize: 46,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                controller: emailController,
                hintText: "E-mail",
                regExp: RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$'),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                controller: passwordController,
                hintText: "Password",
                regExp: RegExp(r''),
                isObscureText: isObscure,
                suffixIcon: passwordVisibility(),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    if(formKey.currentState!.validate()){
                      if (Provider.of<UserDataProvider>(context, listen: false).login(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      )) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainPage(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Incorrect Email or Password!!"),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     const Text("Don't have an account,"),
              //     TextButton(
              //       onPressed: () {
              //         Navigator.pushReplacement(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => const RegisterPage(),
              //           ),
              //         );
              //       },
              //       child: const Text("Register"),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
