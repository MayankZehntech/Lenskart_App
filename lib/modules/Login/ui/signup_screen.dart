import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lenskart_clone/modules/Home/ui/home_screen.dart';
import 'package:lenskart_clone/modules/Login/bloc/login_bloc.dart';
import 'package:lenskart_clone/modules/Login/ui/login_screen.dart';
import 'package:lenskart_clone/services/user_info_service.dart';
import 'package:lenskart_clone/widgets/login_widgets/login_dash_line.dart';
import 'package:lenskart_clone/widgets/login_widgets/login_offer_text.dart';
import 'package:lenskart_clone/widgets/login_widgets/login_terms_condition.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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

  void _signUp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context
          .read<LoginBloc>()
          .add(SignupRequested(emailController.text, passwordController.text));
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
              imagePath:
                  'assets/images/Matte_Essentials-genz-reel-thumbnail-preview.webp',
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
                            backText: 'Login',
                            frontText: 'Signin',
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
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

                                    //Signup via google section
                                    BlocConsumer<LoginBloc, LoginState>(
                                      listener: (context, state) {
                                        if (state is GoogleSigninSuccess) {
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
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: TextButton(
                                            child: const Text(
                                              'Signup via Google >',
                                              style: TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontSize: 14,
                                                  color: Color.fromARGB(
                                                      255, 33, 100, 35),
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            onPressed: () {
                                              context
                                                  .read<LoginBloc>()
                                                  .add(GoogleSignInRequested());
                                            },
                                          ),
                                        );
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
                labelText: 'Create Password',
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
                  return 'Create password';
                } else if (value.length < 6) {
                  return 'Password must be atleast 6 character';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
              return InkWell(
                  onTap: state.isFormValid ? () => _signUp(context) : null,
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
                        'Signup',
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
  // final FocusNode _focusNodeEmail = FocusNode();
  // final FocusNode _focusNodePassword = FocusNode();

  // final _formKey = GlobalKey<FormState>();
  // //   Its validate, save the form or reset the form
  // final emailController = TextEditingController(); // STORE EMAIL ADDRESS
  // final passwordController = TextEditingController();

  // final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

  // @override
  // void dispose() {
  //   _focusNodeEmail.dispose();
  //   _focusNodePassword.dispose();
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.dispose();
  // }

  // void _signUp(BuildContext context) {
  //   if (_formKey.currentState!.validate()) {
  //     context
  //         .read<LoginBloc>()
  //         .add(SignupRequested(emailController.text, passwordController.text));
  //   }
  //   passwordController.clear();
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return BlocProvider(
  //     create: (context) => LoginBloc(FirebaseAuth.instance, GoogleSignIn(),
  //         UserInfoService(FirebaseAuth.instance, FirebaseFirestore.instance)),
  //     child: Scaffold(
  //       body: Stack(
  //         children: [
  //           // Background Image
  //           Container(
  //             height: MediaQuery.of(context).size.height / 1.6,
  //             width: MediaQuery.of(context).size.width,
  //             decoration: const BoxDecoration(
  //               image: DecorationImage(
  //                 image: NetworkImage(
  //                   'https://static1.lenskart.com/media/desktop/img/2-Aug-24/Dark-Night/reel/Bat-man-genz-story-thumbnail-portrait.jpg',
  //                 ),
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //           ),
  //           // Login Container
  //           SingleChildScrollView(
  //             child: SizedBox(
  //               height: MediaQuery.of(context).size.height,
  //               child: Align(
  //                 alignment: Alignment.bottomCenter,
  //                 child: Container(
  //                   height: MediaQuery.of(context).size.height / 1.8,
  //                   width: double.infinity,
  //                   decoration: BoxDecoration(
  //                     color: Colors.white.withOpacity(0.9),
  //                     borderRadius: const BorderRadius.only(
  //                       topLeft: Radius.circular(18),
  //                       topRight: Radius.circular(18),
  //                     ),
  //                   ),
  //                   child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Padding(
  //                             padding: const EdgeInsets.only(
  //                                 top: 15, left: 18, bottom: 0, right: 8),
  //                             child: Row(
  //                               mainAxisAlignment:
  //                                   MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 const Text(
  //                                   'Signup',
  //                                   style: TextStyle(
  //                                       fontWeight: FontWeight.bold,
  //                                       fontSize: 18,
  //                                       fontFamily: 'poppins'),
  //                                 ),
  //                                 TextButton(
  //                                   child: const Text(
  //                                     'Login',
  //                                     style: TextStyle(
  //                                         fontWeight: FontWeight.bold,
  //                                         color: Colors.grey,
  //                                         fontSize: 18,
  //                                         fontFamily: 'poppins'),
  //                                   ),
  //                                   onPressed: () {
  //                                     Navigator.pushAndRemoveUntil(
  //                                       context,
  //                                       MaterialPageRoute(
  //                                         builder: (context) =>
  //                                             const LoginScreen(),
  //                                       ),
  //                                       (route) => route.isFirst,
  //                                     );
  //                                   },
  //                                 ),
  //                               ],
  //                             )),
  //                         Expanded(
  //                           child: Container(
  //                             width: double.infinity,
  //                             decoration: const BoxDecoration(
  //                                 color: Color.fromARGB(255, 231, 231, 231)),
  //                             child: Padding(
  //                               padding: const EdgeInsets.all(12.0),
  //                               child: Column(
  //                                 children: [
  //                                   Padding(
  //                                     padding: const EdgeInsets.only(
  //                                       bottom: 25,
  //                                     ),
  //                                     child: RichText(
  //                                       text: const TextSpan(
  //                                           style: TextStyle(
  //                                               fontSize: 16,
  //                                               fontWeight: FontWeight.w600,
  //                                               fontFamily: 'poppins',
  //                                               color: Color.fromARGB(
  //                                                   255, 0, 16, 29)),
  //                                           children: <TextSpan>[
  //                                             TextSpan(
  //                                                 text:
  //                                                     'Signup and avail Buy 1 Get 1 Free with'),
  //                                             TextSpan(
  //                                                 text: ' GOLD',
  //                                                 style: TextStyle(
  //                                                     fontSize: 19,
  //                                                     fontFamily: 'poppins',
  //                                                     fontWeight:
  //                                                         FontWeight.normal,
  //                                                     color: Color.fromARGB(
  //                                                         255, 223, 187, 91)))
  //                                           ]),
  //                                     ),
  //                                   ),
  //                                   BlocConsumer<LoginBloc, LoginState>(
  //                                     listener: (context, state) {
  //                                       if (state is LoginSuccess) {
  //                                         //handle success state
  //                                         ScaffoldMessenger.of(context)
  //                                             .showSnackBar(
  //                                           const SnackBar(
  //                                             content: Text(
  //                                                 'You signup successfully, Login again'),
  //                                             backgroundColor: Colors.green,
  //                                           ),
  //                                         );
  //                                         Future.delayed(
  //                                             const Duration(seconds: 1));

  //                                         Navigator.pushReplacement(
  //                                             context,
  //                                             MaterialPageRoute(
  //                                               builder: (context) =>
  //                                                   const LoginScreen(),
  //                                             ));
  //                                       } else if (state is LoginFailure) {
  //                                         ScaffoldMessenger.of(context)
  //                                             .showSnackBar(
  //                                           const SnackBar(
  //                                             content: Text(
  //                                                 'This email already in use'),
  //                                             backgroundColor: Colors.red,
  //                                           ),
  //                                         );
  //                                       }
  //                                     },
  //                                     builder: (context, state) {
  //                                       if (state is LoginLoading) {
  //                                         return const Center(
  //                                           child: CircularProgressIndicator(),
  //                                         );
  //                                       }
  //                                       return Form(
  //                                           key: _formKey,
  //                                           child: Column(
  //                                             children: [
  //                                               TextFormField(
  //                                                 keyboardType: TextInputType
  //                                                     .emailAddress,
  //                                                 controller: emailController,
  //                                                 focusNode: _focusNodeEmail,
  //                                                 decoration:
  //                                                     const InputDecoration(
  //                                                   prefixIcon: Icon(
  //                                                     Icons.mail_outline,
  //                                                     color: Color.fromARGB(
  //                                                         255, 124, 8, 0),
  //                                                   ),
  //                                                   labelText: 'Email',
  //                                                   border: OutlineInputBorder(
  //                                                       borderRadius:
  //                                                           BorderRadius.all(
  //                                                               Radius.circular(
  //                                                                   12))),
  //                                                 ),
  //                                                 validator: (value) {
  //                                                   // if form field is empty then it will show error.
  //                                                   if (value!.isEmpty) {
  //                                                     return 'Enter email';
  //                                                   } else if (!emailRegex
  //                                                       .hasMatch(value)) {
  //                                                     return 'Please enter a valid email address';
  //                                                   }
  //                                                   return null;
  //                                                 },
  //                                               ),
  //                                               const SizedBox(height: 10),
  //                                               TextFormField(
  //                                                 keyboardType:
  //                                                     TextInputType.text,
  //                                                 controller:
  //                                                     passwordController,
  //                                                 obscureText: true,
  //                                                 focusNode: _focusNodePassword,
  //                                                 decoration:
  //                                                     const InputDecoration(
  //                                                   prefixIcon: Icon(
  //                                                     Icons.lock_outlined,
  //                                                     color: Color.fromARGB(
  //                                                         255, 0, 23, 43),
  //                                                   ),
  //                                                   labelText: 'Password',
  //                                                   border: OutlineInputBorder(
  //                                                       borderRadius:
  //                                                           BorderRadius.all(
  //                                                               Radius.circular(
  //                                                                   12))),
  //                                                 ),
  //                                                 validator: (value) {
  //                                                   if (value!.isEmpty) {
  //                                                     return 'Enter password';
  //                                                   }
  //                                                   return null;
  //                                                 },
  //                                               ),
  //                                               const SizedBox(height: 30),
  //                                               InkWell(
  //                                                   onTap: () =>
  //                                                       _signUp(context),
  //                                                   child: Container(
  //                                                     width:
  //                                                         MediaQuery.of(context)
  //                                                             .size
  //                                                             .width,
  //                                                     decoration: const BoxDecoration(
  //                                                         color: Colors.grey,
  //                                                         borderRadius:
  //                                                             BorderRadius.all(
  //                                                                 Radius
  //                                                                     .circular(
  //                                                                         12))),
  //                                                     child: const Padding(
  //                                                       padding: EdgeInsets.all(
  //                                                           12.0),
  //                                                       child: Center(
  //                                                           child: Text(
  //                                                         'Signup',
  //                                                         style: TextStyle(
  //                                                             color:
  //                                                                 Colors.white,
  //                                                             fontSize: 18,
  //                                                             fontFamily:
  //                                                                 'poppins',
  //                                                             fontWeight:
  //                                                                 FontWeight
  //                                                                     .w700),
  //                                                       )),
  //                                                     ),
  //                                                   )),
  //                                             ],
  //                                           ));
  //                                     },
  //                                   ),

  //                                   const SizedBox(height: 15),
  //                                   // Dashed Line with "OR"
  //                                   const DashLine(),

  //                                   //login via google section
  //                                   Padding(
  //                                     padding: const EdgeInsets.only(top: 10),
  //                                     child: TextButton(
  //                                       child: const Text(
  //                                         'Signup via Google >',
  //                                         style: TextStyle(
  //                                             fontFamily: 'poppins',
  //                                             fontSize: 14,
  //                                             color: Color.fromARGB(
  //                                                 255, 33, 100, 35),
  //                                             fontWeight: FontWeight.w800),
  //                                       ),
  //                                       onPressed: () {},
  //                                     ),
  //                                   ),

  //                                   const LoginpageTermsCondition()
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ]),
  //                 ),
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
