import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/colors.dart';
import '../components/shop_widgets.dart';
import '../model/carts.dart';
import '../provider/cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, this.initialProduct});
  final Object? initialProduct;

  static const routeName = '/cart-screen';

  @override
  Widget build(BuildContext context) {
    return _CartScreen(items: context.watch<Cart>().items);
  }
}

class _CartScreen extends StatelessWidget {
  const _CartScreen({required this.items});
  final List<Item> items;
  double get subtotal =>
      items.fold(0, (sum, item) => sum + item.product.price * item.quantity);
  @override
  Widget build(BuildContext context) {
    const discount = 25.0;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                child: Column(
                  children: [
                    const ShopPageHeader(title: 'My Cart'),
                    const SizedBox(height: 24),
                    for (final item in items)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: _CartItem(
                          item: item,
                          onDelete: () => context.read<Cart>().removeCart(item),
                          onMinus: () {
                            if (item.quantity > 1) {
                              context.read<Cart>().updateQuantity(
                                item,
                                item.quantity - 1,
                              );
                            }
                          },
                          onPlus: () {
                            context.read<Cart>().updateQuantity(
                              item,
                              item.quantity + 1,
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 4),
                    _SummaryCard(subtotal: subtotal, discount: discount),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 14),
              child: GradientButton(
                label: 'Checkout',
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Checkout is ready!')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartItem extends StatelessWidget {
  const _CartItem({
    required this.item,
    required this.onDelete,
    required this.onMinus,
    required this.onPlus,
  });
  final Item item;
  final VoidCallback onDelete, onMinus, onPlus;
  @override
  Widget build(BuildContext context) => Container(
    height: 150,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border.all(color: ShopColors.border),
      borderRadius: BorderRadius.circular(22),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 118,
          child: ProductImage(url: item.product.imageUrl, borderRadius: 15),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      item.product.name,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onDelete,
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Color(0xFFEF5B32),
                    ),
                  ),
                ],
              ),
              const Text(
                'Size: L',
                style: TextStyle(color: ShopColors.muted, fontSize: 12),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    '\$${item.product.price.toStringAsFixed(2)} USD',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),
                  QuantityPicker(
                    value: item.quantity,
                    onMinus: onMinus,
                    onPlus: onPlus,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.subtotal, required this.discount});
  final double subtotal, discount;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(color: ShopColors.border),
      borderRadius: BorderRadius.circular(22),
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
            color: ShopColors.surface,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Row(
            children: [
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter Discount Code',
                    border: InputBorder.none,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Apply',
                  style: TextStyle(color: ShopColors.text),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _PriceRow(label: 'Sub total :', value: subtotal),
        const SizedBox(height: 16),
        _PriceRow(label: 'Discount :', value: discount),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Divider(color: ShopColors.border),
        ),
        _PriceRow(label: 'total :', value: subtotal - discount, strong: true),
      ],
    ),
  );
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.label,
    required this.value,
    this.strong = false,
  });
  final String label;
  final double value;
  final bool strong;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Text(
        label,
        style: TextStyle(
          color: strong ? ShopColors.muted : ShopColors.muted,
          fontSize: 16,
        ),
      ),
      const Spacer(),
      Text(
        '\$${value.toStringAsFixed(2)}',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: strong ? 18 : 16,
        ),
      ),
    ],
  );
}
