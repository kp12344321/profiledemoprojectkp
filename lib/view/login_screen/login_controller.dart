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

  @override
  void onInit() {
    // TODO: implement onInit
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
    emailTextEditingController.text = loginResponse.email ?? '';
    passwordTextEditingController.text = loginResponse.password ?? '';
    value.value = loginResponse.rememberMe == 'true';
  }

  Future saveData() async {
    var response = LoginModel(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text,
        rememberMe: value.value.toString());
    await SessionManager.setLoginResponse(response);
  }
}
