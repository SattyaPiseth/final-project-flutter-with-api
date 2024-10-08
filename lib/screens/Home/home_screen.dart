// import 'package:ecommerce_mobile_app/models/product_model.dart';
import 'package:ecommerce_mobile_app/screens/Home/Widget/search_bar.dart';
import 'package:ecommerce_mobile_app/views/home/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../../models/categories.dart';
import '../../view_model/category_view_model.dart';
import '../../view_model/home_view_model.dart';
import 'Widget/home_app_bar.dart';
import 'Widget/image_slider.dart';

class HomeScreen extends StatefulWidget {
  final String token;
  const HomeScreen({super.key, required this.token});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentSlider = 0;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryViewModel>(context, listen: false).fetchCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 35),
              const CustomAppBar(),
              const SizedBox(height: 20),
              const MySearchBAR(),
              const SizedBox(height: 20),
              ImageSlider(
                currentSlide: currentSlider,
                onChange: (value) {
                  setState(() {
                    currentSlider = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              categoryItems(),
              const SizedBox(height: 20),
              if (selectedIndex == 0)
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Special For You",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      "See all",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 10),

              // GridView to display ProductCard
              ChangeNotifierProvider<ProductViewModel>(
                create: (_) =>
                ProductViewModel(token: widget.token)..fetchProducts(),
                child: Consumer<ProductViewModel>(
                  builder: (context, viewModel, child) {
                    if (viewModel.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (viewModel.errorMessage != null) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(viewModel.errorMessage!),
                            const SizedBox(height: 8.0),
                            ElevatedButton(
                              onPressed: () => viewModel.fetchProducts(),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    } else if (viewModel.productModel?.data?.isNotEmpty ==
                        true) {
                      return GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: viewModel.productModel!.data!.length,
                        itemBuilder: (context, index) {
                          var product = viewModel.productModel!.data![index];
                          return ProductCard(product: product);
                        },
                      );
                    } else {
                      return const Center(child: Text('No Products Available'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryItems() {
    return Consumer<CategoryViewModel>(
      builder: (context, categoryViewModel, child) {
        if (categoryViewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (categoryViewModel.errorMessage != null) {
          return Center(child: Text(categoryViewModel.errorMessage!));
        } else if (categoryViewModel.categoryListModel?.data?.isNotEmpty == true) {
          return SizedBox(
            height: 130,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryViewModel.categoryListModel!.data!.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                var category = categoryViewModel.categoryListModel!.data![index];
                bool isSelected = selectedIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: isSelected ? Colors.blue[200] : Colors.transparent,
                      boxShadow: isSelected
                          ? [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ]
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(category.images ?? ''),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category.name ?? 'Unknown',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(child: Text('No Categories Available'));
        }
      },
    );
  }
}
