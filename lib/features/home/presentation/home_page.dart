import 'package:flutter/material.dart';
import 'package:lafyuu/constants.dart';
import 'package:lafyuu/features/product/presentation/product_details_page.dart';
import 'package:lafyuu/lists/items_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> filteredItems = [];

  String selectedCategory = 'All';

  void filterItems(String category) {
    setState(() {
      selectedCategory = category;

      if (category == 'All') {
        filteredItems = items;
      } else {
        filteredItems = items
            .where((item) => item['category'] == category)
            .toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    filteredItems = items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kWhite,
        surfaceTintColor: kWhite,
        title: const Text(
          'Lafyuu',
          style: TextStyle(color: kprimaryBlue, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: kprimaryBlue),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔍 Search Bar
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 15),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),

            // 🏷 Category Row (Optional)
            SizedBox(
              height: 35,
              child: ListView(
                scrollDirection: .horizontal,
                children: [
                  buildCategoryChip('All'),
                  buildCategoryChip('Clothes'),
                  buildCategoryChip('Electronics'),
                  buildCategoryChip('Shoes'),
                  buildCategoryChip('Accessories'),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // 🛍 Grid of Item Cards
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.only(bottom: 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.72,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final product = filteredItems[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailsPage(product: product),
                        ),
                      );
                    },

                    child: _buildItemCard(product),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🌟 Category Chip Builder
  Widget buildCategoryChip(String label) {
    final isSelected = (label == selectedCategory);
    return GestureDetector(
      onTap: () => filterItems(label),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? kprimaryBlue : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

Widget _buildItemCard(Map item) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(color: Colors.grey.shade100, blurRadius: 5, spreadRadius: 2),
      ],
    ),

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Image
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              item['image'],
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Name
        Text(
          item['name'],
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),

        const SizedBox(height: 4),

        // Price
        Text(
          "\$${item['price']}",
          style: const TextStyle(
            color: kprimaryBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
