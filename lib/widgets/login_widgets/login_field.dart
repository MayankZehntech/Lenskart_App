// import 'package:flutter/material.dart';

// class LoginFields extends StatelessWidget {
//   final GlobalKey<FormState> formKey;
//   final TextEditingController emailController;
//   final TextEditingController passwordController;
//   final FocusNode focusNodeEmail;
//   final FocusNode focusNodePassword;
//   final RegExp emailRegex;
//   final VoidCallback onLogin;

//   const LoginFields({
//     super.key,
//     required this.formKey,
//     required this.emailController,
//     required this.passwordController,
//     required this.focusNodeEmail,
//     required this.focusNodePassword,
//     required this.emailRegex,
//     required this.onLogin,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: formKey,
//       child: Column(
//         children: [
//           TextFormField(
//             keyboardType: TextInputType.emailAddress,
//             controller: emailController,
//             focusNode: focusNodeEmail,
//             decoration: const InputDecoration(
//               prefixIcon: Icon(
//                 Icons.mail_outline,
//                 color: Color.fromARGB(255, 124, 8, 0),
//               ),
//               labelText: 'Email',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(12)),
//               ),
//             ),
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Enter email';
//               } else if (!emailRegex.hasMatch(value)) {
//                 return 'Please enter a valid email address';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 10),
//           TextFormField(
//             keyboardType: TextInputType.text,
//             controller: passwordController,
//             obscureText: true,
//             focusNode: focusNodePassword,
//             decoration: const InputDecoration(
//               prefixIcon: Icon(
//                 Icons.lock_outlined,
//                 color: Color.fromARGB(255, 0, 23, 43),
//               ),
//               labelText: 'Password',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(12)),
//               ),
//             ),
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Enter password';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 20),
//           InkWell(
//             onTap: onLogin,
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               decoration: const BoxDecoration(
//                 color: Colors.grey,
//                 borderRadius: BorderRadius.all(Radius.circular(12)),
//               ),
//               child: const Padding(
//                 padding: EdgeInsets.all(12.0),
//                 child: Center(
//                   child: Text(
//                     'Login',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontFamily: 'poppins',
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class LoginFields extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode focusNodeEmail;
  final FocusNode focusNodePassword;
  final RegExp emailRegex;
  final VoidCallback onLogin;
  final BuildContext context;

  const LoginFields({
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
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            focusNode: focusNodeEmail,
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.mail_outline,
                color: Color.fromARGB(255, 124, 8, 0),
              ),
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
            validator: (value) {
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
            focusNode: focusNodePassword,
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.lock_outlined,
                color: Color.fromARGB(255, 0, 23, 43),
              ),
              labelText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter password';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: onLogin,
              child: const Text(
                'Login',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
