import 'package:get/get.dart';

class UserController extends GetxController {
  var userName = ''.obs;
  var userEmail = ''.obs;
  var userPassword = ''.obs;
  var userType = ''.obs;
  var userCertificate = ''.obs;

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
}
