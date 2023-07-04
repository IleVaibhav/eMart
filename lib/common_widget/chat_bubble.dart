import 'package:e_commerce_admin/common_widget/text_widget.dart';
import 'package:e_commerce_admin/const/const.dart';

Widget chatBubble()
{
  return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(bottom: 5),
        decoration: const BoxDecoration(
          color: textfieldGrey,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10)
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            normalText(text: "Your MSG . . . ",color: purpleColor),
            2.heightBox,
            normalText(text: "msg time",color: darkGrey,size: 10)
          ],
        ),
      )
  );
}