import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lenskart_clone/modules/MyProfile/ui/edit_profile.dart';
import 'package:lenskart_clone/services/user_info_service.dart';

class UserProfileSection extends StatefulWidget {
  final String uid;
  const UserProfileSection({
    super.key,
    required this.uid,
  });

  @override
  State<UserProfileSection> createState() => _UserProfileSectionState();
}

class _UserProfileSectionState extends State<UserProfileSection> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final UserInfoService userService = UserInfoService(
        firebaseAuth, FirebaseFirestore.instance, FirebaseStorage.instance);

    return FutureBuilder<Map<String, dynamic>?>(
      future: userService.getUserInfo(firebaseAuth.currentUser?.uid ?? ''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No user info available'));
        } else {
          var userInfo = snapshot.data!;
          return Container(
            padding:
                const EdgeInsets.only(left: 12, right: 12, top: 24, bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: const Color.fromARGB(255, 236, 236, 236),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.purple[50],
                  backgroundImage: NetworkImage(userInfo['photoUrl']),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userInfo['name'] ?? 'User Name',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(userInfo['email'] ?? 'user email'),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditProfile(uid: widget.uid),
                            ),
                          );
                        },
                        child: Text(
                          'Edit Profile  >',
                          style: TextStyle(
                            color: Colors.green[900],
                            decoration: TextDecoration.underline,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  'assets/images/qr_code.png',
                  width: 90,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
