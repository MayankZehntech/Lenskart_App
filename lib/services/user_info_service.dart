import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lenskart_clone/modules/Common_glasses/model/eyeglass_model.dart';
import 'package:path_provider/path_provider.dart';

class UserInfoService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _firebaseStorage;

  UserInfoService(this._firebaseAuth, this._firestore, this._firebaseStorage);

  Future<void> storeUserInfo(User user) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        await _firestore
            .collection('users')
            .doc(user.uid)
            .update({'updatedAt': FieldValue.serverTimestamp()});
      } else {
        // Create a new document for a new user
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': user.displayName,
          'email': user.email,
          'photoUrl': user.photoURL ?? "",
          'mobile': user.phoneNumber ?? '',
          'dob': '',
          'gender': '',
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print('Error storing user info: $e');
    }

    // await _firestore.collection('users').doc(user.uid).set({
    //   'uid': user.uid,
    //   'name': user.displayName,
    //   'email': user.email,
    //   'photoUrl': user.photoURL ?? '',
    //   'createdAt': FieldValue.serverTimestamp(),
    // });
  }

  // Fetch user info
  Future<Map<String, dynamic>?> getUserInfo(String uid) async {
    DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
    return doc.data() as Map<String, dynamic>?;
  }

  // Update user info in the database
  Future<void> updateUserInfo(String uid, Map<String, dynamic> userInfo) async {
    await _firestore.collection('users').doc(uid).update(userInfo);
  }

  // Pick image from the gallery and upload to Firebase Storage
  Future<String?> pickImageAndUpload(String userId) async {
    final picker = ImagePicker();
    print('mayank bhai');
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    print('mayank Picked file path: ${pickedFile?.path}');

    if (pickedFile != null) {
      final file = File(pickedFile.path);

      // Compress the image
      final compressedFile = await _compressImage(file);

      final storageRef =
          _firebaseStorage.ref().child('profile_pictures').child('$userId.jpg');

      print('mayank Uploading to: ${storageRef.fullPath}');
      final uploadTask = storageRef.putFile(compressedFile);

      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      print('mayank Download URL: $downloadUrl');

      await _firestore.collection('users').doc(userId).update({
        'photoUrl': downloadUrl,
      });

      return downloadUrl;
    }

    return null;
  }

  // Helper function to compress image
  Future<File> _compressImage(File file) async {
    // Get temporary directory
    final directory = await getTemporaryDirectory();
    final tempPath = directory.path;

    // Define the path for the compressed file
    final compressedFilePath = '$tempPath/compressed_image.jpg';

    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      compressedFilePath,
      quality: 20, // Adjust quality as needed
    );
    if (compressedFile != null) {
      return File(compressedFile.path); // Convert XFile to File
    } else {
      throw Exception('Image compression failed');
    }
  }
}
