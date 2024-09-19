// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:lenskart_clone/modules/MyProfile/bloc/profile_bloc.dart';
// import 'package:lenskart_clone/widgets/cart_page/bottom_navbar_bottom.dart';

// class EditProfile extends StatefulWidget {
//   final String uid;

//   const EditProfile({super.key, required this.uid});

//   @override
//   EditProfileState createState() => EditProfileState();
// }

// class EditProfileState extends State<EditProfile> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _mobileController = TextEditingController();
//   final TextEditingController _dobController = TextEditingController();
//   final TextEditingController _genderController = TextEditingController();
//   final String _gender = "Male";

//   void _showGenderPicker() {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return SizedBox(
//           height: 180,
//           child: Column(
//             children: <Widget>[
//               ListTile(
//                 title: const Text('Male'),
//                 onTap: () {
//                   context.read<ProfileBloc>().add(const GenderSelected('Male'));

//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 title: const Text('Female'),
//                 onTap: () {
//                   // _genderController.text = 'Female';
//                   context
//                       .read<ProfileBloc>()
//                       .add(const GenderSelected('Female'));

//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 title: const Text('Other'),
//                 onTap: () {
//                   // _genderController.text = 'Other';
//                   context
//                       .read<ProfileBloc>()
//                       .add(const GenderSelected('Others'));

//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     DateTime? selectedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );
//     if (selectedDate != null) {
//       _dobController.text = selectedDate.toLocal().toString().split(' ')[0];
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     // Fetch user info when the page is opened
//     context.read<ProfileBloc>().add(FetchUserProfile(widget.uid));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Edit Profile"),
//       ),
//       body: BlocListener<ProfileBloc, ProfileState>(
//         listener: (context, state) {
//           if (state is ProfileLoaded) {
//             // Pre-fill fields when data is loaded
//             _preFillUserData(state.userInfo);
//             // _nameController.text = state.userInfo['name'] ?? '';
//             // _emailController.text = state.userInfo['email'] ?? '';
//             // _mobileController.text = state.userInfo['mobile'] ?? '';
//             // _dobController.text = state.userInfo['dob'] ?? '';
//             // _genderController.text = state.userInfo['gender'] ?? 'Male';
//           } else if (state is ProfileUpdated) {
//             // Handle successful update
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Profile updated successfully')),
//             );
//             Navigator.pop(context);
//           }
//         },
//         child: BlocBuilder<ProfileBloc, ProfileState>(
//           builder: (context, state) {
//             if (state is ProfileLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is ProfileLoaded) {
//               // user info for profile
//               final userInfo = state.userInfo;
//               return Container(
//                 padding: const EdgeInsets.only(left: 15, right: 15, top: 25),
//                 decoration: const BoxDecoration(
//                   border: Border(
//                     top: BorderSide(color: Color.fromARGB(255, 224, 224, 224)),
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     Expanded(
//                       child: SingleChildScrollView(
//                         child: Column(
//                           children: [
//                             buildProfileImage(),

//                             // ),
//                             const SizedBox(height: 20),
//                             Form(
//                               key: _formKey,
//                               child: Column(
//                                 children: [
//                                   //name textfield of users
//                                   Container(
//                                     padding: const EdgeInsets.only(top: 8),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(12),
//                                       border:
//                                           Border.all(color: Colors.grey[400]!),
//                                     ),
//                                     child: Row(
//                                       children: [
//                                         Expanded(
//                                           child: TextFormField(
//                                             controller: _nameController,
//                                             decoration: const InputDecoration(
//                                               labelText: 'Name',
//                                               border: InputBorder.none,
//                                               contentPadding:
//                                                   EdgeInsets.symmetric(
//                                                       horizontal: 15),
//                                             ),
//                                             validator: (value) {
//                                               if (value == null ||
//                                                   value.isEmpty) {
//                                                 return 'Please enter your name';
//                                               } else if (value.length < 2) {
//                                                 return 'Name should be atleast 3 character';
//                                               }
//                                               return null;
//                                             },
//                                           ),
//                                         ),
//                                         IconButton(
//                                           icon:
//                                               const Icon(Icons.cancel_outlined),
//                                           onPressed: () =>
//                                               _nameController.clear(),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   const SizedBox(height: 20),
//                                   //email field

//                                   Container(
//                                     padding: const EdgeInsets.only(top: 8),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(12),
//                                       border:
//                                           Border.all(color: Colors.grey[400]!),
//                                     ),
//                                     child: Row(
//                                       children: [
//                                         Expanded(
//                                           child: TextFormField(
//                                             controller: _emailController,
//                                             readOnly: true,
//                                             decoration: const InputDecoration(
//                                               labelText: 'Email',
//                                               border: InputBorder.none,
//                                               contentPadding:
//                                                   EdgeInsets.symmetric(
//                                                       horizontal: 15),
//                                             ),
//                                           ),
//                                         ),
//                                         TextButton(
//                                           onPressed: () {
//                                             // Add email functionality here
//                                           },
//                                           child: const Text(
//                                             'Add',
//                                             style: TextStyle(
//                                                 color: Colors.green,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   const SizedBox(height: 20),

//                                   //mobile number textfield
//                                   Container(
//                                     padding: const EdgeInsets.only(top: 8),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(12),
//                                       border:
//                                           Border.all(color: Colors.grey[400]!),
//                                     ),
//                                     child: Row(
//                                       children: [
//                                         Expanded(
//                                           child: TextFormField(
//                                             controller: _mobileController,
//                                             keyboardType: TextInputType.phone,
//                                             decoration: const InputDecoration(
//                                               labelText: 'Contact number',
//                                               border: InputBorder.none,
//                                               contentPadding:
//                                                   EdgeInsets.symmetric(
//                                                       horizontal: 15),
//                                             ),
//                                             validator: (value) {
//                                               if (value == null ||
//                                                   value.isEmpty) {
//                                                 return 'Please enter your contact number';
//                                               }
//                                               return null;
//                                             },
//                                           ),
//                                         ),
//                                         Container(
//                                           margin:
//                                               const EdgeInsets.only(right: 15),
//                                           padding: const EdgeInsets.all(6),
//                                           decoration: const BoxDecoration(
//                                             shape: BoxShape.circle,
//                                             color: Colors.green,
//                                           ),
//                                           child: const Icon(
//                                             Icons.check,
//                                             color: Colors.white,
//                                             size: 15,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   const SizedBox(height: 20),

//                                   //date of birth feild

//                                   Container(
//                                     padding: const EdgeInsets.only(top: 8),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(12),
//                                       border:
//                                           Border.all(color: Colors.grey[400]!),
//                                     ),
//                                     child: Row(
//                                       children: [
//                                         Expanded(
//                                           child: TextField(
//                                             controller: _dobController,
//                                             readOnly: true,
//                                             decoration: const InputDecoration(
//                                               labelText: 'Date of Birth',
//                                               border: InputBorder.none,
//                                               contentPadding:
//                                                   EdgeInsets.symmetric(
//                                                       horizontal: 15),
//                                             ),
//                                           ),
//                                         ),
//                                         IconButton(
//                                           icon:
//                                               const Icon(Icons.calendar_today),
//                                           onPressed: () => _selectDate(context),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   const SizedBox(height: 20),

//                                   //gender menu
//                                   Container(
//                                     padding: const EdgeInsets.only(top: 8),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(12),
//                                       border:
//                                           Border.all(color: Colors.grey[400]!),
//                                     ),
//                                     child: Row(
//                                       children: [
//                                         Expanded(
//                                           child: TextField(
//                                             controller: _genderController,
//                                             readOnly:
//                                                 true, // Prevents editing the field manually
//                                             decoration: const InputDecoration(
//                                               labelText: 'Gender',
//                                               border: InputBorder.none,
//                                               contentPadding:
//                                                   EdgeInsets.symmetric(
//                                                       horizontal: 15),
//                                             ),
//                                             onTap:
//                                                 _showGenderPicker, // Opens gender picker on tap
//                                           ),
//                                         ),
//                                         const Icon(Icons.arrow_drop_down),
//                                       ],
//                                     ),
//                                   ),

//                                   const SizedBox(height: 20),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     BottomNavbarButton(
//                         buttonText: 'Update Profile',
//                         onPress: () {
//                           if (_formKey.currentState!.validate()) {
//                             // Update profile
//                             context.read<ProfileBloc>().add(
//                                   UpdateUserProfile(widget.uid, {
//                                     'name': _nameController.text,
//                                     'mobile': _mobileController.text,
//                                     'dob': _dobController.text,
//                                     'gender': _gender,
//                                   }),
//                                 );
//                           }
//                           context
//                               .read<ProfileBloc>()
//                               .add(FetchUserProfile(widget.uid));
//                         })
//                   ],
//                 ),
//               );
//             } else if (state is ProfileError) {
//               return Center(child: Text(state.message));
//             }
//             return const SizedBox();
//           },
//         ),
//       ),
//     );
//   }

//   // Method to pre-fill user data in fields
//   void _preFillUserData(Map<String, dynamic> userInfo) {
//     _nameController.text = userInfo['name'] ?? '';
//     _emailController.text = userInfo['email'] ?? '';
//     _mobileController.text = userInfo['mobile'] ?? '';
//     _dobController.text = userInfo['dob'] ?? '';
//     _genderController.text = userInfo['gender'] ?? 'Male';
//   }

//   Widget buildProfileImage() {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         // Circle Avatar for Profile Image
//         BlocBuilder<ProfileBloc, ProfileState>(
//           builder: (context, state) {
//             String? photoUrl;
//             if (state is ProfileLoaded) {
//               photoUrl = state.userInfo['photoUrl'];
//             }
//             return CircleAvatar(
//               radius: 60,
//               backgroundImage: photoUrl != null
//                   ? NetworkImage(photoUrl)
//                   : const AssetImage('assets/images/user_image.jpg')
//                       as ImageProvider,
//             );
//           },
//         ),

//         // Positioned Edit Button
//         Positioned(
//           bottom: 0,
//           right: 0,
//           child: GestureDetector(
//             onTap: () {
//               context.read<ProfileBloc>().add(UpdateProfilePicture(widget.uid));
//             },
//             child: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.white,
//                 border: Border.all(color: Colors.grey.shade400, width: 2),
//               ),
//               child: const Icon(Icons.edit, color: Colors.black),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lenskart_clone/modules/MyProfile/bloc/profile_bloc.dart';
import 'package:lenskart_clone/widgets/cart_page/bottom_navbar_bottom.dart';

class EditProfile extends StatefulWidget {
  final String uid;

  const EditProfile({super.key, required this.uid});

  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final String _gender = "Male";

  @override
  void initState() {
    super.initState();
    // Fetch user info when the page is opened
    context.read<ProfileBloc>().add(FetchUserProfile(widget.uid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoaded) {
            // Pre-fill fields when data is loaded
            _preFillUserData(state.userInfo);
          } else if (state is ProfileUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully')),
            );
            Navigator.pop(context);
          }
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded) {
              return _buildProfileForm(context);
            } else if (state is ProfileError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  // Method to pre-fill user data in fields
  void _preFillUserData(Map<String, dynamic> userInfo) {
    _nameController.text = userInfo['name'] ?? '';
    _emailController.text = userInfo['email'] ?? '';
    _mobileController.text = userInfo['mobile'] ?? '';
    _dobController.text = userInfo['dob'] ?? '';
    _genderController.text = userInfo['gender'] ?? 'Male';
  }

  // Method to build the profile form
  Widget _buildProfileForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 25),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildProfileImage(),
                  const SizedBox(height: 20),
                  _buildFormFields(),
                ],
              ),
            ),
          ),
          BottomNavbarButton(
            buttonText: 'Update Profile',
            onPress: _onUpdateProfilePressed,
          ),
        ],
      ),
    );
  }

  // Build profile image widget
  Widget _buildProfileImage() {
    return Stack(
      alignment: Alignment.center,
      children: [
        BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            String? photoUrl;
            if (state is ProfileLoaded) {
              photoUrl = state.userInfo['photoUrl'];
            }
            return CircleAvatar(
              radius: 60,
              backgroundImage: photoUrl != null
                  ? NetworkImage(photoUrl)
                  : const AssetImage('assets/images/user_image.jpg')
                      as ImageProvider,
            );
          },
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              context.read<ProfileBloc>().add(UpdateProfilePicture(widget.uid));
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade400, width: 2),
              ),
              child: const Icon(Icons.edit, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  // Method to handle update profile button press
  void _onUpdateProfilePressed() {
    if (_formKey.currentState!.validate()) {
      context.read<ProfileBloc>().add(UpdateUserProfile(widget.uid, {
            'name': _nameController.text,
            'mobile': _mobileController.text,
            'dob': _dobController.text,
            'gender': _gender,
          }));
    }
  }

  // Build form fields widget
  Widget _buildFormFields() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTextField(
            controller: _nameController,
            labelText: 'Name',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              } else if (value.length < 2) {
                return 'Name should be at least 3 characters';
              }
              return null;
            },
            isClearable: true,
          ),
          const SizedBox(height: 20),
          _buildEmailField(),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _mobileController,
            labelText: 'Contact number',
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your contact number';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildDateField(),
          const SizedBox(height: 20),
          _buildGenderField(),
        ],
      ),
    );
  }

  // Reusable text field method
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    bool isClearable = false,
  }) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[400]!),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                labelText: labelText,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              ),
              keyboardType: keyboardType,
              validator: validator,
            ),
          ),
          if (isClearable)
            IconButton(
              icon: const Icon(Icons.cancel_outlined),
              onPressed: () => controller.clear(),
            ),
        ],
      ),
    );
  }

  // Method to build email field with "Add" button
  Widget _buildEmailField() {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[400]!),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _emailController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              // Add email functionality here
            },
            child: const Text(
              'Add',
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // Method to build date field
  Widget _buildDateField() {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[400]!),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _dobController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Date of Birth',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context),
          ),
        ],
      ),
    );
  }

  // Method to build gender field
  Widget _buildGenderField() {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[400]!),
      ),
      child: DropdownButtonFormField<String>(
        value: _gender,
        items: const [
          DropdownMenuItem(value: 'Male', child: Text('Male')),
          DropdownMenuItem(value: 'Female', child: Text('Female')),
        ],
        onChanged: (newValue) {
          setState(() {
            _genderController.text = newValue ?? 'Male';
          });
        },
        decoration: const InputDecoration(
          labelText: 'Gender',
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
        ),
      ),
    );
  }

  // Method to handle date selection
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _dobController.text = pickedDate.toLocal().toString().split(' ')[0];
      });
    }
  }
}
