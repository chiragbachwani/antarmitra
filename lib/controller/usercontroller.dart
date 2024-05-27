import 'package:antarmitra/firebase_const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var userName = ''.obs;
  var userEmail = ''.obs;
  var userPassword = ''.obs;
  var userType = ''.obs;
  var userCertificate = ''.obs;
  var points = 0.obs;

  void setUserDetails({
    required String name,
    required String email,
    required String password,
    required String type,
    required String certificate,
  }) {
    userName.value = name;
    userEmail.value = email;
    userPassword.value = password;
    userType.value = type;
    userCertificate.value = certificate;
  }

  Future<Map<String, dynamic>?> getUserDetails() async {
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentuser!.uid)
          .get();

      if (documentSnapshot.exists) {
        return documentSnapshot.data() as Map<String, dynamic>?;
      } else {
        print('Document does not exist');
        return null;
      }
    } catch (e) {
      print('Error fetching document: $e');
      return null;
    }
  }


   Stream<DocumentSnapshot<Map<String, dynamic>>> getUserDetailsStream() {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(currentuser!.uid)
        .snapshots();
  }
}


