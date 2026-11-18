import 'package:flutter/material.dart';
import 'package:my_shop_app/provider/brand.dart';
import 'package:my_shop_app/screens/brand_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/product_overview.dart';
import './model/products.dart';
import './provider/cart.dart';
import '../screens/cart_screen.dart';
import 'package:provider/provider.dart';
import '../screens/signup_screen.dart';
import 'package:provider/provider.dart';
import '../provider/auth.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) {
        return Auth();
      },
      child: const MyShopApp(),
    ),
  );
}

class MyShopApp extends StatelessWidget {
  const MyShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => Brand())),
        ChangeNotifierProvider(create: ((context) => Brand())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Shop',
        home: DashboardScreen(),
        routes: {
          '/dashboard-screen': (context) => DashboardScreen(),
          '/product_overview': (context) {
            final product =
                ModalRoute.of(context)!.settings.arguments as Products;
            return ProductOverview(product: product);
          },
          CartScreen.routeName: (context) => CartScreen(),
        },
      ),
    );
  }
}
