
import 'package:auth_324/_common/_widgets/fitted_widget.dart';
import 'package:auth_324/_common/constants/app_functions.dart';
import 'package:auth_324/_common/data/d_password_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum EnumPasswordAIStrength{
  weak(label: "Weak",color: Colors.redAccent),
  fair(label: "Fair",color: Colors.yellowAccent),
  strong(label: "Strong",color: Colors.greenAccent);

  final String label;
  final Color color;
  const EnumPasswordAIStrength({required this.label,required this.color});
}

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

  Future<EnumPasswordAIStrength?> getAiScore() async{
    final client = GetConnect(timeout: const Duration(seconds: 30));
    EnumPasswordAIStrength? result;
    try{
      final response = await client.get("https://password-strength-backend.onrender.com/classify_password?password=$password");
      if(response.isOk){
        superPrint(response.body);
        if(response.statusCode! == 200){
          double point = double.tryParse(response.body["strength_score"].toString())??0;
          if(point==0){
            result = EnumPasswordAIStrength.weak;
          }
          else if(point == 1){
            result = EnumPasswordAIStrength.fair;
          }
          else if(point == 2){
            result = EnumPasswordAIStrength.strong;
          }

        }
      }
      else{

      }
    }
    catch(e){
      //
    }
    return result;
  }

}