import 'package:auth_324/_services/others/extensions.dart';
import 'package:auth_324/_services/theme_services/c_theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../_common/constants/app_constants.dart';
import '../m_bottom_sheet_picker_model.dart';

class BsBottomSheetMultiplePicker extends StatelessWidget {
  final List<BottomSheetPickerModel> data;
  final List<BottomSheetPickerModel> preSelectedData;
  final Function(List<BottomSheetPickerModel>) onClickSubmit;
  const BsBottomSheetMultiplePicker({
    super.key,
    required this.data,
    required this.preSelectedData,
    required this.onClickSubmit,
  });

  @override
  Widget build(BuildContext context) {
    ValueNotifier<List<BottomSheetPickerModel>> selectedData =
        ValueNotifier([...preSelectedData]);
    ValueNotifier<String> query = ValueNotifier("");
    return SizedBox.expand(
      child: LayoutBuilder(
        builder: (a1, c1) {
          return GetBuilder<ThemeController>(
            builder: (themeController) {
              return ValueListenableBuilder(
                valueListenable: themeController.currentTheme,
                builder: (context, theme, child) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                        color: theme.background2,
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(
                                AppConstants.baseBorderRadiusXL))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppConstants.basePadding,
                        vertical: AppConstants.basePadding,
                      ),
                      child: Column(
                        children: [
                          //
                          DecoratedBox(
                            decoration: BoxDecoration(
                                color: theme.text2.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(
                                    AppConstants.baseBorderRadius)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              child: TextField(
                                controller: TextEditingController(text: ""),
                                cursorColor: theme.text1,
                                style: TextStyle(
                                    color: theme.text1,
                                    fontSize: AppConstants.fontSizeL),
                                onChanged: (value) {
                                  query.value = value;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.search_rounded,
                                      color: theme.text1,
                                    )),
                              ),
                            ),
                          ),
                          20.heightBox(),
                          Expanded(
                            child: ValueListenableBuilder(
                              valueListenable: query,
                              builder: (context, qy, child) {
                                return ValueListenableBuilder(
                                  valueListenable: selectedData,
                                  builder: (context, sd, child) {
                                    List<BottomSheetPickerModel> filteredData =
                                        data.where(
                                      (element) {
                                        String query = qy
                                            .toLowerCase()
                                            .replaceAll(" ", "");
                                        return element.label
                                            .replaceAll(" ", "")
                                            .toLowerCase()
                                            .contains(query);
                                      },
                                    ).toList();
                                    return ListView.builder(
                                      itemCount: filteredData.length,
                                      itemBuilder: (context, index) {
                                        final eachData = filteredData[index];
                                        bool xSelected = false;
                                        for (var each in sd) {
                                          if (each.id == eachData.id) {
                                            xSelected = true;
                                            break;
                                          }
                                        }
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6),
                                          child: Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    final temp = [...sd];
                                                    if (!xSelected) {
                                                      //selected
                                                      temp.add(eachData);
                                                    } else {
                                                      //unselected
                                                      temp.removeWhere(
                                                        (element) {
                                                          return element.id ==
                                                              eachData.id;
                                                        },
                                                      );
                                                    }
                                                    selectedData.value = temp;
                                                  },
                                                  icon: Icon(
                                                    xSelected
                                                        ? Icons
                                                            .check_box_rounded
                                                        : Icons
                                                            .check_box_outline_blank_rounded,
                                                    color: xSelected
                                                        ? theme.primary
                                                        : theme.disableColor,
                                                  )),
                                              (c1.maxWidth * 0.005)
                                                  .widthBox(xResponsive: false),
                                              TextButton(
                                                  onPressed: () {
                                                    final temp = [...sd];
                                                    if (!xSelected) {
                                                      //selected
                                                      temp.add(eachData);
                                                    } else {
                                                      //unselected
                                                      temp.removeWhere(
                                                        (element) {
                                                          return element.id ==
                                                              eachData.id;
                                                        },
                                                      );
                                                    }
                                                    selectedData.value = temp;
                                                  },
                                                  child: Text(
                                                    eachData.label,
                                                    style: TextStyle(
                                                      color: xSelected
                                                          ? theme.primary
                                                          : theme.text2,
                                                      fontSize: AppConstants
                                                          .fontSizeL,
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          20.heightBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    "ပိတ်ရန်",
                                    style: TextStyle(
                                        color: theme.text2,
                                        fontSize: AppConstants.fontSizeL),
                                  )),
                              5.widthBox(),
                              TextButton(
                                  onPressed: () {
                                    selectedData.value = [];
                                  },
                                  child: Text(
                                    "ရှင်းရန်",
                                    style: TextStyle(
                                        color: theme.redDanger,
                                        fontSize: AppConstants.fontSizeL),
                                  )),
                              5.widthBox(),
                              SizedBox(
                                height: AppConstants.baseButtonHeightS,
                                child: ElevatedButton(
                                    onPressed: () {
                                      onClickSubmit(selectedData.value);
                                      Get.back();
                                    },
                                    child: Text(
                                      "အတည်ပြုမည်",
                                      style: TextStyle(
                                          fontSize: AppConstants.fontSizeL),
                                    )),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
