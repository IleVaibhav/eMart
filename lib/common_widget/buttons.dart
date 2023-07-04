import 'package:e_commerce_admin/common_widget/text_widget.dart';
import 'package:e_commerce_admin/const/const.dart';

Widget ourButton({title,color = purpleColor,onPress})
{
  return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.all(10),
        backgroundColor: color
      ),
      child: normalText(text: title,size: 17),
  );
}

