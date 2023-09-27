import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profiledemoproject/model/login_model.dart';
import 'package:profiledemoproject/utils/sessionmanager.dart';

class LoginController extends GetxController {
  RxBool value = false.obs;
  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  RxBool isVisible = false.obs;
  final formKey = GlobalKey<FormState>();

  LoginModel loginResponse = LoginModel();
  String editedEmail = '';

  @override
  void onInit() {
    getLoginResponse();
    super.onInit();
  }

  getLoginResponse() async {
    await SessionManager.getLoginResponse().then((value) {
      if (value != null) {
        loginResponse = value;
      } else {
        loginResponse =
            LoginModel(email: '', password: '', rememberMe: 'false');
      }
    });
    passwordTextEditingController.text = loginResponse.password ?? '';
    value.value = loginResponse.rememberMe == 'true';
    await SessionManager.getUserDetails().then((user) {
      print('user: ${user!.email}');
      editedEmail = user.email ?? '';
      emailTextEditingController.text =
          loginResponse.rememberMe == 'true' ? user.email ?? '' : '';
    });
  }

  Future saveData() async {
    print('value: herer $value');
    var response = LoginModel(
        email: value.value == true
            ? emailTextEditingController.text
            : emailTextEditingController.text,
        password: value.value == true ? passwordTextEditingController.text : '',
        rememberMe: value.value == true ? value.value.toString() : 'false');
    await SessionManager.setLoginResponse(response);
  }
}
