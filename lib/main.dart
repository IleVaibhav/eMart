import 'package:e_commerce_admin/auth_screen/sign_in.dart';
import 'package:e_commerce_admin/const/const.dart';
import 'package:e_commerce_admin/const/firebase_const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'bottom_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  var isLoggedIn = false;

  checkUser() {
    auth.authStateChanges().listen((User? user) {
      if(user == null && mounted) {
        isLoggedIn = false;
      }
      else {
        isLoggedIn = true;
      }
    });  
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appname,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          color: Colors.transparent,
          elevation: 0
        )
      ),
      home: isLoggedIn ? const SignInScreen() : const BottomNav()
    );
  }
}