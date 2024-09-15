import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api/utils/app_color.dart';

class ProductDetailsPage extends StatefulWidget {
  final int productId;

  ProductDetailsPage({required this.productId});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int _selectedImageIndex = 0; // To track which image is selected

  Future<Map<String, dynamic>> fetchProductDetails() async {
    final response = await http.get(Uri.parse(
        'https://www.beta.takesell.com.bd/api/v2/products/${widget.productId}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true &&
          data['data'] != null &&
          data['data'].isNotEmpty) {
        return data['data'][0]; // Get the first item from the data array
      } else {
        throw Exception('No product data available');
      }
    } else {
      throw Exception('Failed to load product details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchProductDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: Text('Product Details')),
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text('Product Details')),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Scaffold(
            appBar: AppBar(title: Text('Product Details')),
            body: Center(child: Text('No product data available')),
          );
        } else {
          final product = snapshot.data!;
          final productName = product['name'] ?? 'Unknown Product';
          final productMainPrice = product['main_price'] ?? 'N/A';
          final productStrokedPrice = product['stroked_price'] ?? 'N/A';
          final productSales = product['sales'] ?? 0;
          final productDescription = product['description'] ?? '';
          final List<dynamic> photos = product['photos'] ?? [];

          return Scaffold(
            appBar: AppBar(title: Text(productName)),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      photos.isNotEmpty
                          ? photos[_selectedImageIndex]['path'] ?? ''
                          : '',
                      fit: BoxFit.cover,
                      height: 280,
                      width: double.infinity,
                    ),
                    // Horizontal image thumbnails
                    SizedBox(
                      height: 100, // Height for the horizontal thumbnails list
                      child: ListView.builder(
                        scrollDirection:
                            Axis.horizontal, // Horizontal scrolling
                        itemCount: photos.length,
                        itemBuilder: (context, index) {
                          final photo = photos[index];
                          final imagePath = photo['path'] ?? '';
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedImageIndex = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: _selectedImageIndex == index
                                        ? Colors.blue
                                        : Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                                child: imagePath.isNotEmpty
                                    ? Image.network(
                                        imagePath,
                                        height: 100,
                                        width: 80,
                                        fit: BoxFit.cover,
                                      )
                                    : Icon(
                                        Icons.image_not_supported,
                                        size: 80,
                                      ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Selected Image Preview
                    
                    const SizedBox(height: 16),
                    Text(
                      productName,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Price: $productMainPrice',
                      style: TextStyle(color: AppColor.productPrice),
                    ),
                    Text('Discounted Price: $productStrokedPrice'),
                    Text('Sales: $productSales'),
                    const SizedBox(height: 16),
                    Text(
                      'Description:',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      productDescription.replaceAll(
                          RegExp(r'<[^>]*>'), ''), // Strip HTML tags
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
