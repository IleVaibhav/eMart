import 'package:e_commerce_admin/common_widget/text_widget.dart';
import 'package:e_commerce_admin/const/const.dart';
import 'package:e_commerce_admin/controllers/products_controller.dart';
import 'package:get/get.dart';

Widget productDropDown(hint,List<String> list,dropValue,ProductController controller)
{
  return Obx(
      () => DropdownButtonHideUnderline(
          child: DropdownButton(
            hint: normalText(text: hint,color: purpleColor),
            value: dropValue.value == '' ? null : dropValue.value,
            isExpanded: true,
            items: list.map((e) {
              return DropdownMenuItem(
                  value: e,
                  child: e.toString().text.make()
              );
            }).toList(),
            onChanged: (newValue) {
              if(hint == "Category") {
                controller.subCategoryValue.value = '';
                controller.populateSubCategoryList(newValue.toString());
              }
              dropValue.value = newValue.toString();
            },
          )
      ).box.white.roundedSM.padding(EdgeInsets.symmetric(horizontal: 10)).make()
  );
}