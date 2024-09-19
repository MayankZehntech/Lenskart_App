import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lenskart_clone/modules/Common_glasses/model/eyeglass_model.dart';

class EyeglassService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<EyeglassModel>> fetchEyeglassesByCategory(
      String genderType, String glassesCategory) async {
    QuerySnapshot snapshot = await _firestore
        .collection('Eye_Glasses')
        .where('genderType', isEqualTo: genderType)
        .where('glassesCategory', isEqualTo: glassesCategory)
        .get();

    return snapshot.docs.map((doc) => EyeglassModel.fromSnapshot(doc)).toList();
  }
}
