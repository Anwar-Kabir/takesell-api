import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rest_api/Model/featured_category.dart';
import 'package:rest_api/Model/slider_model.dart';
import 'package:rest_api/Model/todays_deal.dart';
import 'package:rest_api/providers/api_service.dart';
import 'package:rest_api/screens/categories_wise_product.dart';
import 'package:rest_api/screens/featured_product_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final ApiService apiService = ApiService();

  late Future<List<SliderModel>> sliders;
  late Future<List<FeaturedCategory>> featuredCategories;
  late Future<List<TodaysDeal>> todaysDeals;
  late Future<List<TodaysDeal>> featuredProducts;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    sliders = apiService.fetchSliders();
    featuredCategories = apiService.fetchFeaturedCategories();
    todaysDeals = apiService.fetchTodaysDeals();
    featuredProducts = apiService.fetchFeaturedProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Sliders
              FutureBuilder<List<SliderModel>>(
                future: sliders,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return buildSliders(snapshot.data!);
                  }
                },
              ),
              const SizedBox(height: 10),

              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Featured Categories",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),

              //Featured Categories
              FutureBuilder<List<FeaturedCategory>>(
                future: featuredCategories,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return buildFeaturedCategories(snapshot.data!);
                  }
                },
              ),

              const SizedBox(height: 10),

              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Featured Products",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),

              // Featured Products

              FutureBuilder<List<TodaysDeal>>(
                future: featuredProducts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return buildFeaturedProducts(
                      snapshot.data!,
                    );
                  }
                },
              ),

              const SizedBox(height: 10),

              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Today's Deals",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),

              // Today's Deals
              FutureBuilder<List<TodaysDeal>>(
                future: todaysDeals,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return buildTodaysDeals(snapshot.data!);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Slider with auto-slide and dots
  Widget buildSliders(List<SliderModel> sliders) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: sliders.map((slider) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                slider.photo ?? 'https://via.placeholder.com/150',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: sliders.map((slider) {
            int index = sliders.indexOf(slider);
            return Container(
              width: 8.0,
              height: 8.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // Featured Categories
  Widget buildFeaturedCategories(List<FeaturedCategory> categories) {
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              // Navigate to the new CategoryPage with category name and id
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryPage(
                    categoryName: category.name,
                    categoryId: category.id,
                  ),
                ),
              );
            },
            child: Container(
              width: 120,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        category.banner,
                        height: 100,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Today's Deals

  Widget buildTodaysDeals(List<TodaysDeal> deals) {
    return Column(
      children: deals.map((deal) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsPage(productId: deal.id),
              ),
            );
          },
          child: Card(
            child: Row(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      deal.thumbnailImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        deal.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text('Price: ${deal.mainPrice}'),
                      Text('Sales: ${deal.sales}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // Featured Products
  Widget buildFeaturedProducts(List<TodaysDeal> products) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: products.map((product) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductDetailsPage(productId: product.id),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                width: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          product.thumbnailImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        product.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Price: ${product.mainPrice}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Sales: ${product.sales}'),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
