import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin/common_widget/text_widget.dart';
import 'package:e_commerce_admin/const/const.dart';
import 'package:e_commerce_admin/const/firebase_const.dart';
import 'package:e_commerce_admin/services/store_services.dart';
import 'package:get/get.dart';
import 'chat_screen.dart';
import 'package:intl/intl.dart' as intl;

class MsgScreen extends StatelessWidget {
  const MsgScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: purpleColor,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: purpleColor,
        title: boldText(text: "Your Chats",size: 18),
      ),

      body: StreamBuilder(
        stream: StoreServices.getMessages(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white)
            );
          }
          else {
            var data = snapshot.data!.docs;
            return  Padding(
              padding: const EdgeInsets.all(5),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(
                      data.length,
                      (index) {
                        var t = data[index]['created_on'] == null
                            ? DateTime.now()
                            : data[index]['created_on'].toDate();
                        var time = intl.DateFormat("h:mma").format(t);
                        return Card(
                          color: Colors.grey.shade200,
                          child: ListTile(
                            // onTap: () => Get.to(() => const ChatScreen()),
                            leading: const CircleAvatar(
                              backgroundColor: purpleColor,
                              child: Icon(Icons.person,color: Colors.white,size: 30),
                            ),
                            title: boldText(text: data[index]['sender_name'],color: purpleColor),
                            subtitle: normalText(text: data[index]['last_msg'],color: purpleColor),
                            trailing: normalText(text: time,color: purpleColor),
                          ),
                        );
                      }
                  ),
                ),
              ),
            );
          }
        },

      ),

    );
  }
}
