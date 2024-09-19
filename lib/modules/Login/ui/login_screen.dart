import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lenskart_clone/modules/Home/ui/home_screen.dart';
import 'package:lenskart_clone/modules/Login/bloc/login_bloc.dart';
import 'package:lenskart_clone/modules/Login/ui/signup_screen.dart';
import 'package:lenskart_clone/services/user_info_service.dart';
// import 'package:lenskart_clone/modules/signup/ui/signup_screen.dart';
import 'package:lenskart_clone/widgets/login_widgets/login_dash_line.dart';
import 'package:lenskart_clone/widgets/login_widgets/login_offer_text.dart';
import 'package:lenskart_clone/widgets/login_widgets/login_terms_condition.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();

  final _formKey = GlobalKey<FormState>();
  //   Its validate, save the form or reset the form
  final emailController = TextEditingController(); // STORE EMAIL ADDRESS
  final passwordController = TextEditingController();

  final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

  @override
  void dispose() {
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<LoginBloc>(context).add(
        LoginRequested(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        ),
      );
    }
    //passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
          FirebaseAuth.instance,
          GoogleSignIn(),
          UserInfoService(FirebaseAuth.instance, FirebaseFirestore.instance,
              FirebaseStorage.instance)),
      child: Scaffold(
        body: Stack(
          children: [
            // Background Image
            const BackgroundImage(
              imagePath: 'assets/images/login-harrypotter.jfif',
            ),
            // Login Container
            SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.7,
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
                          //login and signup
                          LoginSignupHeader(
                            frontText: 'Login',
                            backText: 'Signup',
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

                          //main login container start
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 231, 231, 231)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, right: 12, top: 10),
                                child: Column(
                                  children: [
                                    //buy 1 and get 1 text
                                    const LoginOfferText(),

                                    BlocConsumer<LoginBloc, LoginState>(
                                      listener: (context, state) {
                                        if (state is LoginSuccess) {
                                          //handle success state

                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HomeScreen()));
                                        } else if (state is LoginFailure) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
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
                                        return formFiled(context);
                                      },
                                    ),

                                    const SizedBox(height: 15),
                                    // Dashed Line with "OR"
                                    const DashLine(),

                                    //login via google section
                                    BlocConsumer<LoginBloc, LoginState>(
                                      listener: (context, state) {
                                        if (state is GoogleSigninSuccess) {
                                          print(
                                              "\n......\nMayank Bhai\n........\n");
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HomeScreen()));
                                        } else if (state is GoogleSigninFail ||
                                            state is GoogleSigninError) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Email or password is wrong, Please try again'),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      },
                                      builder: (BuildContext context,
                                          LoginState state) {
                                        return Stack(children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: TextButton(
                                              child: const Text(
                                                'Login via Google >',
                                                style: TextStyle(
                                                    fontFamily: 'poppins',
                                                    fontSize: 14,
                                                    color: Color.fromARGB(
                                                        255, 33, 100, 35),
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                              onPressed: () {
                                                context.read<LoginBloc>().add(
                                                    GoogleSignInRequested());
                                              },
                                            ),
                                          ),
                                          if (state is GoogleSigninLoading) ...[
                                            //Blur effect in background when authenticate

                                            BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 5, sigmaY: 5),
                                              child: Container(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              ),
                                            ),

                                            //show circular indicator
                                            const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          ]
                                        ]);
                                      },
                                    ),

                                    const LoginpageTermsCondition()
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Form formFiled(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              focusNode: _focusNodeEmail,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.mail_outline,
                  color: Color.fromARGB(255, 124, 8, 0),
                ),
                labelText: 'Email',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
              ),
              onChanged: (value) {
                if (value.length < 2) {
                  BlocProvider.of<LoginBloc>(context).add(EmailChanged(value));
                }
              },
              // validator: (_) =>
              //     BlocProvider.of<LoginBloc>(context).state.emailError,
              validator: (value) {
                // if form field is empty then it will show error.

                if (value == null || value.isEmpty) {
                  return 'Enter email';
                } else if (!emailRegex.hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: passwordController,
              obscureText: true,
              focusNode: _focusNodePassword,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.lock_outlined,
                  color: Color.fromARGB(255, 0, 23, 43),
                ),
                labelText: 'Password',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
              ),
              onChanged: (value) {
                if (value.length < 2) {
                  BlocProvider.of<LoginBloc>(context)
                      .add(PasswordChanged(value));
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter password';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
              return InkWell(
                  onTap: state.isFormValid ? () => _login(context) : null,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        //changing the color of button if both the field has some data
                        color: state.isFormValid
                            ? Colors.blue.shade900
                            : Colors.grey,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12))),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Center(
                          child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w700),
                      )),
                    ),
                  ));
            }),
          ],
        ));
  }
}

class LoginSignupHeader extends StatelessWidget {
  final String frontText;
  final String backText;
  final VoidCallback onPressed;
  const LoginSignupHeader({
    super.key,
    required this.frontText,
    required this.backText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 15, left: 18, bottom: 0, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              frontText,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'poppins'),
            ),
            TextButton(
              onPressed: onPressed,
              child: Text(
                backText,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 18,
                    fontFamily: 'poppins'),
              ),
            ),
          ],
        ));
  }
}

class BackgroundImage extends StatelessWidget {
  final String imagePath;
  const BackgroundImage({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.8,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          // NetworkImage(
          //   'https://static5.lenskart.com/media/uploads/h-p-genz-story-thumbnail-portrait.png',
          // ),

          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
