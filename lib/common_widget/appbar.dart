import 'package:e_commerce_admin/common_widget/text_widget.dart';
import 'package:e_commerce_admin/const/const.dart';
import 'package:intl/intl.dart' as intl;

AppBar appBar({title})
{
  return AppBar(
    elevation: 1,
    backgroundColor: purpleColor,
    automaticallyImplyLeading: false,
    title: boldText(text: title,color: white,size: 18),
    actions: [
      Center(
        child: normalText(text: intl.DateFormat('EEEEEEEEE, MMM d, y').format(DateTime.now()),color: white,size: 15),
      ),
      10.widthBox
    ],
  );
}