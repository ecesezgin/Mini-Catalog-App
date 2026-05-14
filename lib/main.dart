import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/product_list_page.dart';
import 'pages/product_detail_page.dart';

void main() {
  runApp(const MiniCatalogApp());
}

class MiniCatalogApp extends StatelessWidget {
  const MiniCatalogApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Catalog App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey.shade100,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade800,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        useMaterial3: false, // Maintain classic look as taught in basic courses
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/products': (context) => const ProductListPage(),
        '/product_details': (context) => const ProductDetailPage(),
      },
    );
  }
}
