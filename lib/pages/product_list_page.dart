import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<Product> products = [];
  List<Product> filteredProducts = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final client = HttpClient();
      final request = await client.getUrl(
        Uri.parse('https://wantapi.com/products.php'),
      );
      final response = await request.close();
      final body = await response.transform(utf8.decoder).join();
      client.close();

      final Map<String, dynamic> json = jsonDecode(body);
      final List<dynamic> dataList = json['data'];
      final loaded = dataList.map((e) => Product.fromJson(e)).toList();

      setState(() {
        products = loaded;
        filteredProducts = loaded;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load products. Check your connection.';
        isLoading = false;
      });
    }
  }

  void _filterProducts(String query) {
    setState(() {
      filteredProducts = products
          .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Catalog'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: _filterProducts,
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : errorMessage != null
                    ? Center(child: Text(errorMessage!))
                    : filteredProducts.isEmpty
                        ? const Center(child: Text('No products found.'))
                        : GridView.builder(
                            padding: const EdgeInsets.all(8.0),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: filteredProducts.length,
                            itemBuilder: (context, index) {
                              final product = filteredProducts[index];
                              return ProductCard(
                                product: product,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/product_details',
                                    arguments: product,
                                  );
                                },
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }
}
