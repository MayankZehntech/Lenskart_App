import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lenskart_clone/modules/Home/ui/home_screen.dart';
import 'package:lenskart_clone/modules/Login/bloc/login_bloc.dart';
import 'package:lenskart_clone/modules/Login/ui/signup_screen.dart';
import 'package:lenskart_clone/widgets/login_widgets/login_dash_line.dart';
import 'package:lenskart_clone/widgets/login_widgets/login_field.dart';
import 'package:lenskart_clone/widgets/login_widgets/login_offer_text.dart';
import 'package:lenskart_clone/widgets/login_widgets/login_terms_condition.dart';
import 'package:lenskart_clone/widgets/login_widgets/login_via_google.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode focusNodeEmail;
  final FocusNode focusNodePassword;
  final RegExp emailRegex;
  final VoidCallback onLogin;
  final BuildContext context;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.focusNodeEmail,
    required this.focusNodePassword,
    required this.emailRegex,
    required this.onLogin,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.of(context).size.height / 1.8,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //calling widgets for login and signup
                const Header(),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 231, 231, 231),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          const LoginOfferText(),
                          BlocConsumer<LoginBloc, LoginState>(
                            listener: (context, state) {
                              if (state is LoginSuccess) {
                                print('login successfull');
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomeScreen(),
                                  ),
                                );
                              } else if (state is LoginFailure) {
                                print('login failed');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Email or password is wrong, Please try again'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            builder: (context, state) {
                              if (state is LoginLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return LoginFields(
                                formKey: formKey,
                                emailController: emailController,
                                passwordController: passwordController,
                                focusNodeEmail: focusNodeEmail,
                                focusNodePassword: focusNodePassword,
                                emailRegex: emailRegex,
                                onLogin: onLogin,
                                context: context,
                              );
                            },
                          ),
                          const SizedBox(height: 15),
                          const DashLine(),
                          const LoginViaGoogle(),
                          const LoginpageTermsCondition(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 18, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Login',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                fontFamily: 'poppins'),
          ),
          TextButton(
            child: const Text(
              'Signup',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 18,
                  fontFamily: 'poppins'),
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignupScreen(),
                ),
                (route) => route.isFirst,
              );
            },
          ),
        ],
      ),
    );
  }
}
