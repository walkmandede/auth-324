import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../_common/constants/app_colors.dart';
import '../../../_common/constants/app_constants.dart';
import '../../../_common/constants/app_functions.dart';
import 'dialogs/loading_dialog.dart';
import 'dialogs/transaction_dialog.dart';

DialogRoute? dialogRoute;
SnackbarController? snackbarController;

class DialogService {
  void showTransactionDialog({
    required String text,
    Function()? onClickYes,
    Function()? onClickNo,
    String yesButtonText = "Continue",
    String noButtonText = "Cancel",
  }) {
    if (dialogRoute != null) {
      dismissDialog();
    }
    // ThemeController themeController = Get.find();
    dialogRoute = DialogRoute(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius),
          ),
          child: TransactionDialog(
            text: text,
            yesButtonText: yesButtonText,
            noButtonText: noButtonText,
            onClickYes: () {
              if (onClickYes != null) {
                onClickYes();
              }
            },
            onClickNo: () {
              if (onClickNo != null) {
                onClickNo();
              }
            },
          ),
        );
      },
    );
    Navigator.of(Get.context!).push(dialogRoute!);
  }

  void showSnack(
      {required String title,
      required String message,
      Color bgColor = Colors.black,
      int durationInMs = 2000}) {
    snackbarController = Get.snackbar(title, message,
        backgroundColor: bgColor.withOpacity(0.65),
        colorText: AppColors.white,
        duration: Duration(milliseconds: durationInMs));
  }

  void dismissSnackBar() {
    if (snackbarController != null) {
      snackbarController!.close(withAnimations: false);
    }
  }

  void showLoadingDialog({String loadingText = "Loading ... Please wait!"}) {
    if (dialogRoute != null) {
      dismissDialog();
    }
    dialogRoute = DialogRoute(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius),
          ),
          child: LoadingDialog(
            loadingText: loadingText,
          ),
        );
      },
    );
    Navigator.of(Get.context!).push(dialogRoute!);
  }

  void showCustomDialog({required Widget child}) {
    if (dialogRoute != null) {
      dismissDialog();
    }
    dialogRoute = DialogRoute(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(AppConstants.baseBorderRadius),
            ),
            child: child);
      },
    );
    Navigator.of(Get.context!).push(dialogRoute!);
  }

  void dismissDialog() {
    // dialog1Key.currentState!.pop();
    try {
      if (dialogRoute != null) {
        Navigator.of(Get.context!).removeRoute(dialogRoute!);
        dialogRoute = null;
      }
    } catch (e1, e2) {
      saveLogFromException(e1, e2);
      null;
    }
  }

  Future<void> showItemSelectBottomSheet() async {}

  // Future<void> showBottomSheetPicker() async{
  //   Get.bottomSheet(
  //     BsBottomSheetPicker()
  //   );
  // }
}
