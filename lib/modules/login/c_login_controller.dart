import 'package:auth_324/modules/home/v_home_page.dart';
import 'package:auth_324/modules/register/v_register_page.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:auth_324/_common/constants/app_functions.dart';
import 'package:auth_324/_common/models/m_password_model.dart';
import 'package:auth_324/_services/database_services/database_service.dart';
import 'package:auth_324/_services/encrypt_service/encrypt_service.dart';
import 'package:auth_324/_services/overlays_services/dialog/dialog_service.dart';
import 'package:auth_324/modules/auth_main/v_auth_main_page.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:local_captcha/local_captcha.dart';

class LoginController extends GetxController{

  TextEditingController txtEmail = TextEditingController(text: "");
  TextEditingController txtOtp = TextEditingController(text: "");
  TextEditingController txtCaptcha = TextEditingController(text: "");
  TextEditingController txtPassword = TextEditingController(text: "");

  ValueNotifier<bool> xValidEmail = ValueNotifier(false);
  ValueNotifier<bool> xValidPassword = ValueNotifier(false);
  ValueNotifier<bool> xMatchPasswords = ValueNotifier(false);
  ValueNotifier<bool> xValidCaptcha = ValueNotifier(false);
  PageController pageController = PageController();
  LocalCaptchaController localCaptchaController = LocalCaptchaController();
  Timer captchaTimer = Timer(const Duration(seconds: 10), () {

  },);
  Timer otpTimer = Timer(const Duration(seconds: 30), () {

  },);
  final int _captchaTimerInSecond = 10;
  final int _otpTimerInSecond = 30;
  ValueNotifier<int> captchaRefreshCooldown = ValueNotifier(0);
  ValueNotifier<int> otpRefreshCooldown = ValueNotifier(0);
  ValueNotifier<bool> xObscured = ValueNotifier(true);

  @override
  void onInit() {
    super.onInit();
    initLoad();
  }

  @override
  void onClose() {
    captchaTimer.cancel();
    otpTimer.cancel();
    super.onClose();
  }


  Future<void> initLoad() async{
    EmailOTP.config(
      appName: 'E-commerce Application - Login OTP',
      otpType: OTPType.numeric,
      expiry : 30000,
      emailTheme: EmailTheme.v5,
      appEmail: 'kyawphyoehan2995@gmail.com',
      otpLength: 6,
    );
    txtEmail.addListener(() {
      const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
          r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
          r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
          r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
          r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
          r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
          r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
      final regex = RegExp(pattern);
      final value = txtEmail.text;
      if(value.isEmpty || !regex.hasMatch(value)){
        xValidEmail.value = false;
      }
      else{
        xValidEmail.value = true;
      }
    },);
    refreshCaptcha();
  }

  void _resetCaptchaTimer(){
    captchaTimer.cancel();
    captchaRefreshCooldown.value = _captchaTimerInSecond;
    captchaTimer = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        captchaRefreshCooldown.value = _captchaTimerInSecond - timer.tick;
        if(captchaRefreshCooldown.value < 1){
          timer.cancel();
        }
      },
    );
  }

  void _resetOtpTimer(){
    otpTimer.cancel();
    otpRefreshCooldown.value = _otpTimerInSecond;
    otpTimer = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        otpRefreshCooldown.value = _otpTimerInSecond - timer.tick;
        if(otpRefreshCooldown.value < 1){
          timer.cancel();
        }
      },
    );
  }

  void refreshCaptcha(){
    if(captchaRefreshCooldown.value<=0){
      localCaptchaController.refresh();
      _resetCaptchaTimer();
    }
  }

  Future<void> validateCaptcha() async{
    final query = txtCaptcha.text;
    try{
      final result = localCaptchaController.validate(query);
      if(result == LocalCaptchaValidation.valid){
        xValidCaptcha.value = true;
        DialogService().showSnack(title: "Valid Code", message: "Captcha is valid! Press next to continue");
      }
      else if(result == LocalCaptchaValidation.invalidCode){
        xValidCaptcha.value = false;
        DialogService().showSnack(title: "Invalid Code", message: "Captcha is invalid! Please try again!");
      }
      else if(result == LocalCaptchaValidation.codeExpired){
        xValidCaptcha.value = false;
        DialogService().showSnack(title: "Expired", message: "Captcha is expired! Please refresh and try again!");
      }
    }
    catch(e1,e2){
      saveLogFromException(e1, e2);
    }
  }

  Future<void> onClickEmailNext() async{
    DialogService().showLoadingDialog();
    DatabaseService databaseService = DatabaseService();
    final dbResult = await databaseService.isEmailRegistered(txtEmail.text);
    superPrint(dbResult);
    DialogService().dismissDialog();
    if(dbResult==null){
      DialogService().showTransactionDialog(
        text: "There is no such email in our system! Please register to continue!",
        yesButtonText: "Register Now",
        noButtonText: "Cancel",
        onClickYes: () {
          Get.offAll(()=> const RegisterPage());
        },
      );
    }
    else{
      DialogService().showLoadingDialog();
      bool otpResult = false;
      try{
        otpResult = await sendOTP();
      }
      catch(e){
        //
        DialogService().showTransactionDialog(text: "Something went wrong! Try again later!");
      }
      DialogService().dismissDialog();

      if(otpResult){
        pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.linear);
      }
      else{
        DialogService().showTransactionDialog(text: "Something went wrong! Try again later!");
      }

    }
  }

  Future<bool> sendOTP() async{
    bool result = false;
    if(otpRefreshCooldown.value<=0){
      _resetOtpTimer();
      try{
        result = await EmailOTP.sendOTP(email: txtEmail.text);
      }
      catch(e1,e2){
        saveLogFromException(e1, e2);
      }
    }
    return result;
  }

  Future<void> onClickOtpNext() async{
    bool result = false;
    try{
      result = EmailOTP.verifyOTP(otp: txtOtp.text);
    }
    catch(e1,e2){
      saveLogFromException(e1, e2);
    }

    if(result){
      pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.linear);
    }
    else{
      DialogService().showTransactionDialog(text: "Invalid OTP code!");
    }

  }

  Future<void> onClickPasswordNext() async{

    DialogService().showLoadingDialog(loadingText: "Loading ... Please wait!");
    dynamic dbResult = "Something went wrong!";
    try{
      EncryptService encryptService = EncryptService();
      final email = txtEmail.text;
      final password = txtPassword.text;
      final encryptedPwd = encryptService.encryptText(plainText: password);
      if(encryptedPwd==null){
        throw Exception("Fail to encrypt password!");
      }
      DatabaseService databaseService = DatabaseService();
      dbResult = await databaseService.login(
        email: email,
        password: encryptedPwd,
      );
    }
    catch(e){
      superPrint(e);
      //
    }
    DialogService().dismissDialog();
    superPrint(dbResult);
    if(dbResult is String){
      // fail
      DialogService().showTransactionDialog(text: dbResult);
      Get.offAll(()=>  HomePage(email: txtEmail.text));
    }
    else{
      superPrint(dbResult);
      //fail
    }
  }


  Future<void> onClickCaptchaNext() async{
    pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }

}