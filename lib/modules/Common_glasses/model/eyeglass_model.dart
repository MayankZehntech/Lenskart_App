import 'package:cloud_firestore/cloud_firestore.dart';

class EyeglassModel {
  final String name;
  final String subheading;
  final double price;
  final String color;
  final List<String> photos;
  final String genderType;
  final String glassesCategory;

  EyeglassModel(
      {required this.name,
      required this.subheading,
      required this.price,
      required this.color,
      required this.photos,
      required this.genderType,
      required this.glassesCategory});

  factory EyeglassModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return EyeglassModel(
      name: data['name'],
      subheading: data['subheading'],
      price: data['price'].toDouble(),
      color: data['color'],
      photos: List<String>.from(data['photos']),
      genderType: data['genderType'],
      glassesCategory: data['glassesCategory'],
    );
  }
}
