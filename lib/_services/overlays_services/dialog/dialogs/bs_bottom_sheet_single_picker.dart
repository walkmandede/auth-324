import 'package:auth_324/_services/others/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../_common/constants/app_constants.dart';
import '../../../theme_services/c_theme_controller.dart';
import '../m_bottom_sheet_picker_model.dart';

class BsBottomSheetSinglePicker extends StatelessWidget {
  final List<BottomSheetPickerModel> data;
  final Function(BottomSheetPickerModel?) onClickSubmit;
  const BsBottomSheetSinglePicker({
    super.key,
    required this.data,
    required this.onClickSubmit,
});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<BottomSheetPickerModel?> selectedData = ValueNotifier(null);
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
                        top: Radius.circular(AppConstants.baseBorderRadiusXL)
                      )
                    ),
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
                              borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6
                              ),
                              child: TextField(
                                controller: TextEditingController(text: ""),
                                cursorColor: theme.text1,
                                style: TextStyle(
                                  color: theme.text1,
                                  fontSize: AppConstants.fontSizeL
                                ),
                                onChanged: (value) {
                                  query.value = value;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.search_rounded,color: theme.text1,)
                                ),
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
                                    List<BottomSheetPickerModel> filteredData = data.where((element) {
                                      String query = qy.toLowerCase().replaceAll(" ", "");
                                      return element.label.replaceAll(" ", "").toLowerCase().contains(query);
                                    },).toList();
                                    return  ListView.builder(
                                      itemCount: filteredData.length,
                                      itemBuilder: (context, index) {
                                        final eachData = filteredData[index];
                                        bool xSelected = sd == eachData;
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 6
                                          ),
                                          child: Row(
                                            children: [
                                              Radio<BottomSheetPickerModel>.adaptive(
                                                value: eachData,
                                                groupValue: selectedData.value,
                                                onChanged: (value) {
                                                  selectedData.value = value;
                                                },
                                              ),
                                              (c1.maxWidth * 0.005).widthBox(xResponsive: false),
                                              TextButton(onPressed: () {
                                                selectedData.value = eachData;
                                              }, child: Text(
                                                eachData.label,
                                                style: TextStyle(
                                                  color: xSelected?theme.primary:theme.text2,
                                                  fontSize: AppConstants.fontSizeL,
                                                ),
                                              ))
                                            ],
                                          ),
                                        );
                                      },);
                                  },
                                );
                              },
                            ),
                          ),
                          20.heightBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(onPressed: () {
                                Get.back();
                              }, child: Text("ပိတ်ရန်",style: TextStyle(color: theme.text2,fontSize: AppConstants.fontSizeL),)),
                              5.widthBox(),
                              SizedBox(
                                height: AppConstants.baseButtonHeightS,
                                child: ElevatedButton(onPressed: () {
                                  onClickSubmit(selectedData.value);
                                  Get.back();
                                }, child:  Text(
                                    "အတည်ပြုမည်",
                                  style: TextStyle(
                                    fontSize: AppConstants.fontSizeL
                                  ),
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
