import 'package:e_commerce_admin/common_widget/text_widget.dart';
import 'package:e_commerce_admin/const/const.dart';
Widget orderPlaceDetails({color,title1,detail1,title2,detail2})
{
  return Container(
    width: double.infinity * 0.5,
    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
    child: Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              boldText(text: title1,color: purpleColor),
              Row(
                children: [
                  boldText(text: detail1,color: fontGrey),
                  2.widthBox,
                  CircleAvatar(
                      maxRadius: 8,
                      backgroundColor: color != null ? color : Colors.transparent
                  ),
                ],
              ),

            ],
          ),
        ),
        Expanded(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            boldText(text: title2,color: purpleColor),
            boldText(text: detail2,color: fontGrey),
          ],
        )
    )
      ],
    ),
  );
}