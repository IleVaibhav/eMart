import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_user/consts/consts.dart';
import 'package:e_commerce_user/services/firestore_services.dart';
import 'package:flutter/material.dart';

class MyWishlistScreen extends StatelessWidget {
  const MyWishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        title: Text("My WishList ...",style: TextStyle(color: Colors.grey.shade700,fontFamily: semibold)),
      ),

      body: StreamBuilder(
        stream: Firestore_Services.getWishlist(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator(color: Colors.red));
          }
          else if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Your Wishlist is Empty ....",style: TextStyle(color: darkFontGrey,fontSize: 20)));
          }
          else {
            var data = snapshot.data!.docs;
            return Column(
              children: [
                Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context,int index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                          child: ListTile(
                            tileColor: Colors.grey.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(color: Colors.grey.shade300),
                            ),
                            leading: Image.network(data[index]['p_imgs'][0]),
                            title: Text(data[index]['p_name'],style: const TextStyle(color: Colors.red,fontFamily: bold,fontSize: 18)),
                            subtitle: Text("₹${data[index]['p_prize']}",style: TextStyle(color: Colors.grey.shade800,fontFamily: semibold)),
                            trailing: IconButton(
                                icon: const Icon(Icons.favorite_rounded,color: Colors.red),
                                onPressed: () {
                                  firestore
                                  .collection(productCollection)
                                  .doc(data[index].id)
                                  .set(
                                      {'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])},
                                      SetOptions(merge: true)
                                  );
                                }
                            ),
                          ),
                        );
                      },
                    )
                )
              ],
            );
          }
        },
      ),
    );
  }
}