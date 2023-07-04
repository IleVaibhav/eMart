import 'package:e_commerce_admin/common_widget/text_widget.dart';
import 'package:e_commerce_admin/const/const.dart';

Widget customTextField({label,hint,controller,isDesc = false})
{
  return TextFormField(
    controller: controller,
    maxLines: isDesc ? 5 : 1,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      label: normalText(text: label),
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white)
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white)
      ),
      hintText: hint,
      hintStyle: const TextStyle(color: lightGrey)
    ),
  );
}