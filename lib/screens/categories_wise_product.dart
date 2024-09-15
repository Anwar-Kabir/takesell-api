




import 'package:flutter/material.dart';
import 'package:rest_api/Model/category_product.dart';
import 'package:rest_api/providers/api_service.dart';
import 'package:rest_api/utils/app_color.dart';
 

class CategoryPage extends StatefulWidget {
  final String categoryName;
  final int categoryId;

  CategoryPage({required this.categoryName, required this.categoryId});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final ApiService apiService = ApiService();
  late Future<List<Product>> categoryProducts;

  @override
  void initState() {
    super.initState();
    // Fetch products for the category when the page is loaded
    categoryProducts = apiService.fetchCategoryProducts(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName), // Title will be the category name
      ),
      body: FutureBuilder<List<Product>>(
        future: categoryProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return buildProductList(snapshot.data!);
          }
        },
      ),
    );
  }

  // Build a list of products
  Widget buildProductList(List<Product> products) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return SizedBox(
          height: 120,
          child: Card(
            child: ListTile(
              leading: Image.network(
                product.thumbnailImage,
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
              title: Text(product.name),
              subtitle: Text('Price: ${product.mainPrice}', style: const TextStyle(color: AppColor.productPrice),),
              trailing: Text('Sales: ${product.sales}'),
            ),
          ),
        );
      },
    );
  }
}
