import 'package:eazz_admin/Caches/receipt_cache.dart';
import 'package:eazz_admin/Pages/Authentication/authentication.dart';
import 'package:eazz_admin/Pages/Homepage/homepage.dart';
// import 'package:eazz_admin/Pages/Homepage/homepage.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => ReceiptCache())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  tokenCheck() async {
    const storage = FlutterSecureStorage();
    var accessToken = await storage.read(key: 'access_token');
    if (accessToken == null || accessToken.isEmpty) {
      return const Authentication();
    }
    return const HomePage();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const Authentication());
  }
}
