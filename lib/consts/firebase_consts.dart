import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;

const UsersCollection = "users";
const productCollection = "products";
const cartCollection = "cart";
const chatCollection = "chats";
const msgCollection = "messages";
const ordersCollection = "orders";