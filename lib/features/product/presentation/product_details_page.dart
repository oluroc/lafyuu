import 'package:flutter/material.dart';
import 'package:lafyuu/constants.dart';

import '../../../lists/items_list.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  List<Map<String, dynamic>> relatedProducts = [];

  int selectedSizeIndex = 2;
  int selectedColorIndex = 0;

  final List<double> sizes = [6, 6.5, 7, 7.5, 8, 8.5];

  final List<Color> colors = [
    Colors.amber,
    Colors.lightBlue,
    Colors.redAccent,
    Colors.green,
    Colors.deepPurple,
    Colors.indigo,
  ];

  void _loadRelatedProducts() {
    final currentCategory = widget.product['category']
        ?.toString()
        .toLowerCase();

    final currentId = widget.product['id'];

    relatedProducts = items.where((item) {
      final itemCategory = item['category']?.toString().toLowerCase();

      return itemCategory == currentCategory && item['id'] != currentId;
    }).toList();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadRelatedProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,

      appBar: AppBar(
        backgroundColor: kWhite,
        elevation: 0,
        iconTheme: const IconThemeData(color: kprimaryBlue),
        actions: [
          IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
        ],
      ),

      bottomNavigationBar: _buildAddToCart(),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),

            Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitle(),

                  const SizedBox(height: 6),

                  _buildRating(),

                  const SizedBox(height: 10),

                  _buildPrice(),

                  const SizedBox(height: 20),

                  _buildSizeSelector(),

                  const SizedBox(height: 20),

                  _buildColorSelector(),

                  const SizedBox(height: 20),

                  _buildDescription(),

                  const SizedBox(height: 20),

                  _buildReview(),

                  const SizedBox(height: 20),

                  _buildRelatedProducts(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- IMAGE ----------------

  Widget _buildImage() {
    return SizedBox(
      height: 260,

      child: PageView.builder(
        itemCount: 3,

        itemBuilder: (context, index) {
          return Image.asset(widget.product['image'], fit: BoxFit.contain);
        },
      ),
    );
  }

  // ---------------- TITLE ----------------

  Widget _buildTitle() {
    return Text(
      widget.product['name'],
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  // ---------------- RATING ----------------

  Widget _buildRating() {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 18),
        const Icon(Icons.star, color: Colors.amber, size: 18),
        const Icon(Icons.star, color: Colors.amber, size: 18),
        const Icon(Icons.star, color: Colors.amber, size: 18),
        const Icon(Icons.star_half, color: Colors.amber, size: 18),

        const SizedBox(width: 6),

        const Text("(4.5)"),
      ],
    );
  }

  // ---------------- PRICE ----------------

  Widget _buildPrice() {
    return Text(
      "\$${widget.product['price']}",
      style: const TextStyle(
        fontSize: 20,
        color: kprimaryBlue,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // ---------------- SIZE ----------------

  Widget _buildSizeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Text(
          "Select Size",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 10),

        SizedBox(
          height: 40,

          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: sizes.length,

            itemBuilder: (context, index) {
              final isSelected = index == selectedSizeIndex;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedSizeIndex = index;
                  });
                },

                child: Container(
                  width: 45,
                  margin: const EdgeInsets.only(right: 10),

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? kprimaryBlue : Colors.grey.shade300,
                    ),
                    color: isSelected
                        ? kprimaryBlue.withOpacity(0.1)
                        : Colors.white,
                  ),

                  child: Center(
                    child: Text(
                      sizes[index].toString(),
                      style: TextStyle(
                        color: isSelected ? kprimaryBlue : Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ---------------- COLOR ----------------

  Widget _buildColorSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Text(
          "Select Color",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 10),

        SizedBox(
          height: 40,

          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: colors.length,

            itemBuilder: (context, index) {
              final isSelected = index == selectedColorIndex;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedColorIndex = index;
                  });
                },

                child: Container(
                  width: 36,
                  margin: const EdgeInsets.only(right: 10),

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors[index],
                    border: Border.all(
                      color: isSelected ? kprimaryBlue : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ---------------- DESCRIPTION ----------------

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Text(
          "Specification",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 8),

        Text(
          widget.product['description'] ?? "No description available",
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  // ---------------- REVIEW ----------------

  Widget _buildReview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: const [
            Text(
              "Review Product",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Text("See More", style: TextStyle(color: kprimaryBlue)),
          ],
        ),

        const SizedBox(height: 10),

        Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage("assets/images/user.jpg"),
            ),

            const SizedBox(width: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: const [
                Text(
                  "James Lawson",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),

                SizedBox(height: 4),

                Text(
                  "Very comfortable and stylish!",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // ---------------- RELATED ----------------

  Widget _buildRelatedProducts() {
    if (relatedProducts.isEmpty) {
      return const SizedBox(); // hide section if none
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "You Might Also Like",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 10),

        SizedBox(
          height: 220,

          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: relatedProducts.length,

            itemBuilder: (context, index) {
              final product = relatedProducts[index];

              return InkWell(
                borderRadius: BorderRadius.circular(10),

                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailsPage(product: product),
                    ),
                  );
                },

                child: Container(
                  width: 150,
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(8),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),

                          child: Image.asset(
                            product['image'] ?? '',
                            fit: BoxFit.cover,
                            width: double.infinity,

                            errorBuilder: (_, __, ___) {
                              return const Icon(Icons.image);
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 6),

                      // Name
                      Text(
                        product['name'] ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 2),

                      // Price
                      Text(
                        "\$${product['price']}",
                        style: const TextStyle(
                          color: kprimaryBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ---------------- CART ----------------

  Widget _buildAddToCart() {
    return Container(
      padding: const EdgeInsets.all(12),

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kprimaryBlue,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        onPressed: () {},

        child: const Text("Add To Cart", style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
