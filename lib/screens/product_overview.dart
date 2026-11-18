import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/colors.dart';
import '../components/shop_widgets.dart';
import '../model/carts.dart';
import '../model/products.dart';
import '../provider/cart.dart';

class ProductOverview extends StatefulWidget {
  final Products product;
  const ProductOverview({super.key, required this.product});

  static const routeName = '/product_overview';

  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  String size = 'L';
  int quantity = 1;
  bool favorite = false;
  List<String> get gallery => widget.product.gallery.isEmpty
      ? [
          widget.product.imageUrl,
          widget.product.imageUrl,
          widget.product.imageUrl,
        ]
      : widget.product.gallery;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ShopPageHeader(title: 'Details Product'),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 390,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: ProductImage(url: gallery[0]),
                              ),
                              Positioned(
                                right: 12,
                                top: 12,
                                child: CircleIconButton(
                                  icon: favorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  size: 42,
                                  onTap: () =>
                                      setState(() => favorite = !favorite),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          flex: 4,
                          child: Row(
                            children: [
                              Expanded(child: ProductImage(url: gallery[1])),
                              const SizedBox(width: 12),
                              Expanded(child: ProductImage(url: gallery[2])),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.name,
                              style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              widget.product.category,
                              style: const TextStyle(color: ShopColors.muted),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '\$${widget.product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Select Size',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      for (final item in ['S', 'M', 'L', 'XL']) ...[
                        _SizeChip(
                          label: item,
                          selected: size == item,
                          onTap: () => setState(() => size = item),
                        ),
                        const SizedBox(width: 9),
                      ],
                      const Spacer(),
                      QuantityPicker(
                        value: quantity,
                        onMinus: () => setState(
                          () => quantity = quantity > 1 ? quantity - 1 : 1,
                        ),
                        onPlus: () => setState(() => quantity++),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.product.description,
                    style: const TextStyle(
                      color: ShopColors.muted,
                      height: 1.55,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 14),
            child: Row(
              children: [
                Expanded(
                  child: GradientButton(
                    label: 'Buy Now',
                    icon: Icons.shopping_cart_checkout,
                    onPressed: () {},
                  ),
                ),

                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 58,
                    child: FilledButton.tonalIcon(
                      onPressed: () {
                        context.read<Cart>().addCart(
                          Item(
                            id: widget.product.id,
                            product: widget.product,
                            quantity: quantity,
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added to cart')),
                        );
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add To Cart'),
                      style: FilledButton.styleFrom(
                        backgroundColor: ShopColors.surface,
                        foregroundColor: ShopColors.text,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _SizeChip extends StatelessWidget {
  const _SizeChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    customBorder: const CircleBorder(),
    child: Container(
      width: 43,
      height: 43,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? null : ShopColors.surface,
        gradient: selected ? ShopColors.accentGradient : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.white : ShopColors.muted,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

interface class Product {}
