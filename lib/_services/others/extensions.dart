import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

const double figmaWidth = 430;
const double figmaHeight = 932;


extension CustomBox2 on int {
  Widget widthBox({bool xResponsive = true}) {
    if(xResponsive){
      return SizedBox(
        width: (this * (Get.width/figmaWidth)).toDouble(),
      );
    }
   else{
     return SizedBox(width: toDouble());
    }
  }

  Widget heightBox({bool xResponsive = true}) {
    if(xResponsive){
      return SizedBox(
        height: (this * (Get.height/figmaHeight)).toDouble(),
      );
    }
    else{
      return SizedBox(height: toDouble());
    }
  }

  ///getLocalizedFontSize
  double lfs(){
    return toDouble();
  }
}

extension CustomBox on double {
  Widget widthBox({bool xResponsive = true}) {
    if(xResponsive){
      return SizedBox(
        width: (this * (Get.width/figmaWidth)).toDouble(),
      );
    }
    else{
      return SizedBox(width: toDouble());
    }
  }

  Widget heightBox({bool xResponsive = true}) {
    if(xResponsive){
      return SizedBox(
        height: (this * (Get.height/figmaHeight)).toDouble(),
      );
    }
    else{
      return SizedBox(height: toDouble());
    }
  }

  ///getLocalizedFontSize
  double lfs(){
    return toDouble();
  }

  Widget networkImage({required String imageUrl, double borderRadius = 0}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: this,
        height: this,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) {
          return const Center(
            child: FittedBox(
              child: Icon(
                  Icons.image_not_supported_rounded
              ),
            ),
          );
        },
      ),
    );
  }
}


extension CustomDateTime on DateTime {
  String getDateKey() {
    return toString().substring(0, 10);
  }

  String getMDY() {
    return DateFormat('MMM d,yyyy').format(DateTime.parse(toString()));
  }
}

extension CustomList on List {
  String getCSV() {
    return toString()
        .replaceAll("[", "")
        .replaceAll("]", "")
        .removeAllWhitespace;
  }
}
