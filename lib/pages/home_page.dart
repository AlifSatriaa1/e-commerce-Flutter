import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

// Widgets
import '../widgets/home_app_bar.dart';
import '../widgets/categories_widget.dart';
import '../widgets/items_widget.dart';

// Pages
import 'cart_page.dart';
import 'account_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  
  static const Color shopeeOrange = Color(0xFFF94D00);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        physics: const BouncingScrollPhysics(),
        children: const [
          HomePageContent(),
          CartPage(),
          AccountPage(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        height: 60,
        backgroundColor: Colors.transparent,
        color: shopeeOrange,
        animationDuration: const Duration(milliseconds: 300),
        items: const [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.shopping_cart, size: 30, color: Colors.white),
          Icon(Icons.account_circle, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  bool _loading = false;

  static const Color shopeeOrange = Color(0xFFF94D00);

  Future<void> _refreshContent() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshContent,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          // Custom AppBar
          const HomeAppBar(),

          // Background kotak untuk konten utama
          Container(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            decoration: const BoxDecoration(
              color: Color(0xFFF5F6F8),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                // Search Bar
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: shopeeOrange),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search products...",
                          ),
                          onFieldSubmitted: (query) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Searching for '$query'")),
                            );
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.tune, color: shopeeOrange),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Filter coming soon!")),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // Categories Section
                _buildSectionHeader(
                  context,
                  title: "Categories",
                  onSeeAll: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("All categories coming soon!")),
                    );
                  },
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: _loading
                      ? const Padding(
                          padding: EdgeInsets.all(20),
                          child: CircularProgressIndicator(),
                        )
                      : const CategoriesWidget(),
                ),

                const SizedBox(height: 20),

                // Best Selling Section
                _buildSectionHeader(
                  context,
                  title: "Best Selling",
                  onSeeAll: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("All best sellers coming soon!")),
                    );
                  },
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: _loading
                      ? const Padding(
                          padding: EdgeInsets.all(20),
                          child: CircularProgressIndicator(),
                        )
                      : const ItemsWidget(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context,
      {required String title, required VoidCallback onSeeAll}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: shopeeOrange,
            ),
          ),
          GestureDetector(
            onTap: onSeeAll,
            child: const Text(
              "See all",
              style: TextStyle(
                fontSize: 14,
                color: shopeeOrange,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
