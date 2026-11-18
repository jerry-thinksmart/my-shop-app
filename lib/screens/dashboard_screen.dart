import 'package:flutter/material.dart';
import 'package:my_shop_app/provider/brand.dart';
import '../components/colors.dart';
import '../model/products.dart';
import '../components/shop_widgets.dart';
import './product_overview.dart';
import '../components/navigation.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = 'dashboard-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 120),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  HomeHeader(),
                  SizedBox(height: 24),
                  SearchBar(),
                  SizedBox(height: 24),
                  _SaleBanner(),
                  const SizedBox(height: 28),
                  const _SectionHeader(title: 'Top Brand'),
                  const SizedBox(height: 14),
                  const _BrandStrip(),
                  const SizedBox(height: 28),
                  const _SectionHeader(title: 'Special For You'),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 260,
                    child: Row(
                      children: [
                        Expanded(
                          child: ProductCard(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                ProductOverview.routeName,
                                arguments: demoProducts[0],
                              );
                            },
                            productUrl: 'assets/img/sale_banner.png',
                            productname: 'Nike SportWear',
                            price: 46.00,
                          ),
                        ),
                        SizedBox(width: 14),
                        Expanded(
                          child: ProductCard(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                ProductOverview.routeName,
                                arguments: demoProducts[0],
                              );
                            },
                            productUrl: 'assets/img/sale_banner.png',
                            productname: 'Nike SportWear',
                            price: 46.00,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18),
                  SizedBox(
                    height: 260,
                    child: Row(
                      children: [
                        Expanded(
                          child: ProductCard(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                ProductOverview.routeName,
                                arguments: demoProducts[0],
                              );
                            },
                            productUrl: 'assets/img/sale_banner.png',
                            productname: 'Nike SportWear',
                            price: 46.00,
                          ),
                        ),
                        SizedBox(width: 14),
                        Expanded(
                          child: ProductCard(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/product_overview',
                                arguments: demoProducts[0],
                              );
                            },
                            productUrl: 'assets/img/sale_banner.png',
                            productname: 'Nike SportWear',
                            price: 46.00,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
    children: [
      CircleAvatar(
        radius: 27,
        backgroundColor: ShopColors.saleBackground,
        child: Icon(Icons.person, size: 32, color: ShopColors.coral),
      ),
      Spacer(),
      CircleIconButton(
        icon: Icons.notifications_none,
        onTap: () {},
        badge: true,
      ),
      const SizedBox(width: 10),
      CircleIconButton(icon: Icons.shopping_cart_outlined, onTap: () {}),
    ],
  );
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(color: ShopColors.muted),
            prefixIcon: Icon(Icons.search, color: ShopColors.muted),
            filled: true,
            fillColor: ShopColors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 17),
          ),
        ),
      ),
      SizedBox(width: 10),
      CircleIconButton(icon: Icons.tune),
    ],
  );
}

class _SaleBanner extends StatelessWidget {
  const _SaleBanner();
  @override
  Widget build(BuildContext context) => Container(
    height: 190,
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
      color: ShopColors.saleBackground,
      borderRadius: BorderRadius.circular(26),
    ),
    child: Stack(
      children: [
        Positioned(
          right: -12,
          bottom: -12,
          width: 210,
          height: 205,
          child: ProductImage(url: demoProducts[3].imageUrl, borderRadius: 0),
        ),
        Positioned(
          left: 22,
          top: 22,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Today Only'),
              const SizedBox(height: 6),
              const Text(
                '80% OFF',
                style: TextStyle(fontSize: 31, fontWeight: FontWeight.w900),
              ),
              const Text('Super Discount', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 18),
              Container(
                decoration: BoxDecoration(
                  gradient: ShopColors.accentGradient,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Shop Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Text(
        title,
        style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
      ),
      const Spacer(),
      const Text('See All', style: TextStyle(color: Color(0xFF666666))),
    ],
  );
}

class _BrandStrip extends StatelessWidget {
  const _BrandStrip();
  @override
  Widget build(BuildContext context) {
    final brandvalue = Provider.of<Brand>(context, listen: false).getBrands();
    return SizedBox(
      height: 58,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          _BrandChip(label: 'Adidas', icon: '◢'),
          _BrandChip(label: 'Nike', icon: '✓'),
          _BrandChip(label: 'ZARA'),
          _BrandChip(label: 'GUCCI', icon: 'G'),
          _BrandChip(label: 'ebay'),
        ],
      ),
    );
  }
}

class _BrandChip extends StatelessWidget {
  const _BrandChip({required this.label, this.icon});
  final String label;
  final String? icon;
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(right: 10),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: ShopColors.surface,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Row(
      children: [
        if (icon != null) ...[
          Text(
            icon!,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
          ),
          const SizedBox(width: 7),
        ],
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    ),
  );
}
