import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductDetailsPage extends StatefulWidget {
  final int productId;

  const ProductDetailsPage({Key? key, required this.productId})
      : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late Future<Map<String, dynamic>> productDetails;

  @override
  void initState() {
    super.initState();
    productDetails = fetchProductDetails(widget.productId);
  }

  Future<Map<String, dynamic>> fetchProductDetails(int id) async {
    final response = await http
        .get(Uri.parse('https://www.beta.takesell.com.bd/api/v2/products/$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'][0];
    } else {
      throw Exception('Failed to load product details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: productDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data available'));
          } else {
            final product = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(product['thumbnail_image']),
                  const SizedBox(height: 16),
                  Text(
                    product['name'],
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Price: ${product['main_price']}'),
                  const SizedBox(height: 8),
                  Text('Stroked Price: ${product['stroked_price']}'),
                  const SizedBox(height: 8),
                  Text('Sales: ${product['sales']}'),
                  const SizedBox(height: 8),
                  Text('Rating: ${product['rating']}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Handle the button press, e.g., add to cart or checkout
                    },
                    child: const Text('Add to Cart'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
