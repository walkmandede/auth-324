import 'package:auth_324/_services/overlays_services/dialog/dialog_service.dart';
import 'package:auth_324/_services/theme_services/w_custom_theme_builder.dart';
import 'package:auth_324/modules/auth_main/v_auth_main_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  final String email;
  const HomePage({super.key,required this.email});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MyThemeBuilder(
      builder: (context, theme, themeController) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: theme.primary,
            actions: [
              IconButton(onPressed: () {
                Future.delayed(const Duration(milliseconds: 100)).then((value) {
                  DialogService().showTransactionDialog(
                    text: "Are you sure to log out!",
                    onClickYes: () {
                      Get.offAll(()=> const AuthMainPage());
                    },
                  );
                },);
              }, icon: const Icon(Icons.logout_rounded))
            ],
          ),
          backgroundColor: theme.background1,
          body: Center(
            child: Text(
              "Welcome! ${widget.email}",
              style: TextStyle(
                color: theme.text2,
                fontSize: 30
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
