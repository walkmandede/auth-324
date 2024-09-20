import 'package:flutter/material.dart';


final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class SuperBarColor {
  Color topBarColor;
  Color botBarColor;
  bool xTopIconWhite;
  bool xBotIconWhite;
  SuperBarColor(
      {this.xTopIconWhite = false,
      this.xBotIconWhite = false,
      this.topBarColor = Colors.white,
      this.botBarColor = Colors.white});

  factory SuperBarColor.defaultValue() {
    return SuperBarColor(
        botBarColor: Colors.transparent,
        topBarColor: Colors.transparent,
        xBotIconWhite: false,
        xTopIconWhite: false);
  }
}

SuperBarColor defaultSuperBar = SuperBarColor(
    botBarColor: Colors.transparent,
    topBarColor: Colors.transparent,
    xBotIconWhite: false,
    xTopIconWhite: false);

// void setSuperBarColor({required SuperBarColor superBarColor}) {
//   Future.delayed(const Duration(milliseconds: 200)).then((value) {
//     FlutterStatusbarcolor.setStatusBarColor(superBarColor.topBarColor,
//         animate: true);
//     FlutterStatusbarcolor.setNavigationBarColor(superBarColor.botBarColor,
//         animate: true);
//     FlutterStatusbarcolor.setNavigationBarWhiteForeground(
//         superBarColor.xBotIconWhite);
//     FlutterStatusbarcolor.setStatusBarWhiteForeground(
//         superBarColor.xTopIconWhite);
//
//     SystemChrome.setSystemUIOverlayStyle(
//         SystemUiOverlayStyle(
//           statusBarBrightness: superBarColor.xTopIconWhite?Brightness.dark:Brightness.light,
//           statusBarIconBrightness: superBarColor.xTopIconWhite?Brightness.dark:Brightness.light,
//           systemStatusBarContrastEnforced: true,
//           systemNavigationBarIconBrightness: superBarColor.xTopIconWhite?Brightness.dark:Brightness.light,
//         )
//     );
//   });
// }

class FlutterSuperScaffold extends StatefulWidget {
  final String id;
  final Widget body;
  final SuperBarColor? superBarColor;
  final Color backgroundColor;
  final PreferredSizeWidget? appBar;
  final bool isTopSafe;
  final bool isBotSafe;
  final bool isResizeToAvoidBottomInset;
  final FloatingActionButton? floatingActionButton;
  final VoidCallback? onWillPop;
  final bool isWillPop;
  final bool xFlexibleBody;
  final Widget? drawer;
  const FlutterSuperScaffold(
      {Key? key,
      this.id = "",
      required this.body,
      this.floatingActionButton,
      this.superBarColor,
      this.backgroundColor = Colors.white,
      this.appBar,
      this.isBotSafe = true,
      this.isTopSafe = true,
      this.isResizeToAvoidBottomInset = true,
      this.onWillPop,
      this.xFlexibleBody = false,
      this.isWillPop = true,
      this.drawer})
      : super(key: key);

  @override
  State<FlutterSuperScaffold> createState() => _FlutterSuperScaffoldState();
}

class _FlutterSuperScaffoldState extends State<FlutterSuperScaffold>
    with RouteAware {
  @override
  void didPopNext() {
    super.didPopNext();
    whenPageIsRevealed();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  void whenPageIsRevealed() async {
    // superPrint("The page is revealed / ${widget.superBarColor!.topBarColor}",title: "${Get.currentRoute} / id : ${widget.id}");
    await Future.delayed(const Duration(milliseconds: 10));
    try {
      if (widget.superBarColor == null) {
        // FlutterStatusbarcolor.setStatusBarColor(Colors.transparent,
        //     animate: true);
        // FlutterStatusbarcolor.setNavigationBarColor(Colors.transparent,
        //     animate: true);
        // FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
        // FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
      } else {
      }
    } catch (e1) {
      null;
    }
  }

  @override
  void didPop() {
    //This method will be called from your observer
    // whenPageIsRevealed();
  }

  @override
  Widget build(BuildContext context) {
    whenPageIsRevealed();
    return PopScope(
      onPopInvoked: (bool value) async {
        if (widget.onWillPop != null) {
          widget.onWillPop!();
        }
      },
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          key: widget.key,
          appBar: widget.appBar,
          drawer: widget.drawer,
          backgroundColor: widget.backgroundColor,
          floatingActionButton: widget.floatingActionButton,
          resizeToAvoidBottomInset: widget.isResizeToAvoidBottomInset,
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Builder(
                  builder: (context) {
                    if (widget.isTopSafe) {
                      if (widget.superBarColor != null) {
                        return topPadding(widget.superBarColor!.topBarColor);
                      } else {
                        return topPadding(Colors.transparent);
                      }
                    } else {
                      return Container();
                    }
                  },
                ),
                widget.xFlexibleBody
                    ? Flexible(child: widget.body)
                    : Expanded(child: widget.body),
                Builder(
                  builder: (context) {
                    if (widget.isBotSafe) {
                      if (widget.superBarColor != null) {
                        return topPadding(widget.superBarColor!.botBarColor);
                      } else {
                        return topPadding(Colors.transparent);
                      }
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget topPadding(Color color) {
    return Container(
      width: double.maxFinite,
      height: MediaQuery.of(context).padding.top,
      color: color,
    );
  }

  Widget botPadding(Color color) {
    return Container(
      width: double.maxFinite,
      height: MediaQuery.of(context).padding.bottom,
      color: color,
    );
  }
}
