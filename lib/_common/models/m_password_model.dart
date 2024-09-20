
import 'package:auth_324/_common/_widgets/fitted_widget.dart';
import 'package:auth_324/_common/constants/app_functions.dart';
import 'package:auth_324/_common/data/d_password_helper.dart';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class PasswordModel{
  String password;
  bool xHasUpperCase;
  bool xHasLowerCase;
  bool xHasDigit;
  bool xHasSpecial;
  bool xIsLengthAtLeastEight;
  bool xIsCommon;

  PasswordModel({
    required this.password,
    required this.xHasUpperCase,
    required this.xHasLowerCase,
    required this.xHasDigit,
    required this.xHasSpecial,
    required this.xIsLengthAtLeastEight,
    required this.xIsCommon,
  });

  factory PasswordModel.fromString({required String password}){
    PasswordHelper passwordHelper = PasswordHelper();
    bool xHasUpperCase = false;
    bool xHasLowerCase = false;
    bool xHasDigit = false;
    bool xHasSpecial = false;

    for(final each in password.characters.toList()){
      if(!xHasUpperCase){
        xHasUpperCase = passwordHelper.upperCaseLetters.contains(each);
      }
      if(!xHasLowerCase){
        xHasLowerCase = passwordHelper.lowerCaseLetters.contains(each);
      }
      if(!xHasDigit){
        xHasDigit = passwordHelper.digits.contains(each);
      }
      if(!xHasSpecial){
        xHasSpecial = passwordHelper.specialCharacters.contains(each);
      }
    }

    return PasswordModel(
      password: password,
      xHasDigit: xHasDigit,
      xHasLowerCase: xHasLowerCase,
      xHasSpecial: xHasSpecial,
      xHasUpperCase: xHasUpperCase,
      xIsLengthAtLeastEight: password.length>8,
      xIsCommon: passwordHelper.xPasswordWeak(password: password)
    );
  }

  Map<String,dynamic> toMap(){
    return {
      "password" : password,
      "xHasUpperCase" : xHasUpperCase,
      "xHasLowerCase" : xHasLowerCase,
      "xHasDigit" : xHasDigit,
      "xHasSpecial" : xHasSpecial,
      "xIsLengthAtLeastEight" : xIsLengthAtLeastEight,
      "xIsCommon" : xIsCommon,
    };
  }

  String getEstimatedDurationForBruteForce(){
    String result = "";
    return result;
  }

  void getAiScore() async{
    final interpreter = await Interpreter.fromAsset('assets/tf_models/password_strength_model.tflite');
    List<List<double>> input = [
      [8,1,5,1,1],  // (length,upperCaseCount,lowerCaseCount,DigitCount,SpecialCount)
    ];
    List output = List.filled(1, 0).reshape([1, 1]); // Assuming model has a single output
    interpreter.run(input, output);
    print("Prediction: ${output[0]}");
  }

}