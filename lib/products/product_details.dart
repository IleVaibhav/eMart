import 'package:e_commerce_admin/common_widget/text_widget.dart';
import 'package:e_commerce_admin/const/const.dart';
import 'package:get/get.dart';

class ProductDetail extends StatelessWidget {
  final dynamic data;
  const ProductDetail({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.grey.shade200,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_outlined,color: purpleColor)
        ),
        title: boldText(text: data['p_name'],color: purpleColor,size: 18),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.heightBox,
            VxSwiper.builder(
                enlargeCenterPage: true,
                autoPlay: true,
                height: 350,
                aspectRatio: 16/9,
                itemCount: data['p_imgs'].length,
                itemBuilder: (context,index){
                  return Image.network(data['p_imgs'][index],width: double.infinity,fit: BoxFit.contain).box.padding(const EdgeInsets.symmetric(horizontal: 5)).make();
                }
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('title',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17,color: Colors.grey.shade700)),
                  8.heightBox,
                  Row(
                    children: [
                      boldText(text: data['p_category'],color: fontGrey,size: 16),
                      10.widthBox,
                      normalText(text: data['p_subcategory'],color: fontGrey,size: 16)
                    ],
                  ),
                  10.heightBox,
                  VxRating(
                    isSelectable: false,
                    value: double.parse(data['p_rating']),
                    onRatingUpdate: (value){},
                    normalColor: Colors.grey,
                    selectionColor: Colors.deepOrangeAccent,
                    count: 5,
                    size: 25,
                    maxRating: 5,
                  ),
                  8.heightBox,
                  Text('₹${data["p_prize"]}',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16,color: Colors.red)),
                  10.heightBox,
                  // Obx(
                  //   () =>
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        5.heightBox,
                        Row(
                          children: [
                            3.widthBox,
                            SizedBox(
                              width: 100,
                              child: boldText(text: "Colour",color: darkGrey,size: 16)
                            ),
                            Row(
                              children: List.generate(
                                  data['p_colors'].length,
                                (index) => VxBox().roundedFull.color(Color(data['p_colors'][index])).margin(const EdgeInsets.symmetric(horizontal: 5)).size(35, 35).make().onTap(() {/*controller.changeColorIndex(index);*/})
                              )
                            )
                          ],
                        ).box.padding(const EdgeInsets.all(5)).make(),
                        10.heightBox,
                        Row(
                          children: [
                            5.widthBox,
                            SizedBox(
                              width: 100,
                              child: boldText(text: "Quantity",color: darkGrey,size: 16),
                            ),
                            normalText(text: data['p_quantity'],color: darkGrey,size: 16),
                          ],
                        ),
                        5.heightBox,
                      ],
                    ).box.white.roundedSM.shadowSm.make(),
                  6.heightBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Description :',style: TextStyle(fontSize: 16,color: Colors.grey.shade700,fontWeight: FontWeight.w500)),
                      5.heightBox,
                      Text(data['p_desc'],style: TextStyle(color: Colors.grey.shade700,fontWeight: FontWeight.w500)),
                    ],
                  ).box.padding(const EdgeInsets.all(8)).white.roundedSM.shadowSm.make(),

                  7.heightBox,
                  // ),
                ],
              ),
            ),

          ],
        ),
      ),

    );
  }
}
