import 'package:flutter/material.dart';
import '../model/products.dart';
import 'colors.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.height = 58,
  });
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final double height;
  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      gradient: ShopColors.accentGradient,
      borderRadius: BorderRadius.circular(30),
    ),
    child: SizedBox(
      height: height,
      width: double.infinity,
      child: TextButton.icon(
        onPressed: onPressed,
        icon: icon == null
            ? const SizedBox.shrink()
            : Icon(icon, color: Colors.white),
        label: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );
}

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    required this.icon,
    this.onTap,
    this.badge = false,
    this.size = 52,
  });
  final IconData icon;
  final VoidCallback? onTap;
  final bool badge;
  final double size;
  @override
  Widget build(BuildContext context) => Stack(
    clipBehavior: Clip.none,
    children: [
      Material(
        color: ShopColors.surface,
        shape: CircleBorder(),
        child: InkWell(
          customBorder: CircleBorder(),
          onTap: onTap,
          child: SizedBox.square(
            dimension: size,
            child: Icon(icon, color: ShopColors.text),
          ),
        ),
      ),
      if (badge)
        Positioned(
          top: 1,
          right: 3,
          child: Container(
            decoration: BoxDecoration(
              color: ShopColors.coral,

              shape: BoxShape.circle,
            ),
          ),
        ),
    ],
  );
}

class ShopPageHeader extends StatelessWidget {
  const ShopPageHeader({super.key, required this.title, this.onBack});
  final String title;
  final VoidCallback? onBack;
  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CircleIconButton(
        icon: Icons.arrow_back,
        onTap: onBack ?? () => Navigator.maybePop(context),
      ),

      // Navigator.pop(context);
      Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w800,
          fontFamily: 'Poppins',
        ),
      ),
      const CircleIconButton(icon: Icons.more_vert),
    ],
  );
}

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.borderRadius = 20,
  });
  final String url;
  final BoxFit fit;
  final double borderRadius;
  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(borderRadius),
    child: ColoredBox(
      color: ShopColors.surface,
      child: Image.network(
        url,
        fit: fit,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (_, _, _) => const Center(
          child: Icon(Icons.checkroom, size: 52, color: ShopColors.muted),
        ),
      ),
    ),
  );
}

class QuantityPicker extends StatelessWidget {
  const QuantityPicker({
    super.key,
    required this.value,
    required this.onMinus,
    required this.onPlus,
  });
  final int value;
  final VoidCallback onMinus;
  final VoidCallback onPlus;
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      _QuantityButton(icon: Icons.remove, onTap: onMinus),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          '$value',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      _QuantityButton(icon: Icons.add, onTap: onPlus, gradient: true),
    ],
  );
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({
    required this.icon,
    required this.onTap,
    this.gradient = false,
  });
  final IconData icon;
  final VoidCallback onTap;
  final bool gradient;
  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: gradient ? null : Colors.white,
      gradient: gradient ? ShopColors.accentGradient : null,
      shape: BoxShape.circle,
      boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 8)],
    ),
    child: IconButton(
      onPressed: onTap,
      icon: Icon(
        icon,
        size: 20,
        color: gradient ? Colors.white : ShopColors.text,
      ),
      constraints: const BoxConstraints.tightFor(width: 40, height: 40),
      padding: EdgeInsets.zero,
    ),
  );
}

class ProductCard extends StatelessWidget {
  final String productUrl;
  final String productname;
  final double price;
  final VoidCallback? onTap;
  const ProductCard({
    required this.productUrl,
    required this.productname,
    required this.price,
    this.onTap,
  });

  // @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(7),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
          border: Border.all(color: ShopColors.border),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: ColoredBox(
                        color: ShopColors.surface,
                        child: Image.asset(
                          productUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: CircleIconButton(
                      icon: Icons.favorite_border,
                      size: 36,
                    ),
                    top: 10,
                    right: 10,
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Text(productname, maxLines: 1, overflow: TextOverflow.ellipsis),
            SizedBox(height: 3),
            Row(
              children: [
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
                Spacer(),
                CircleIconButton(icon: Icons.add),
              ],
            ),

            // Text(),
          ],
        ),
      ),
    );
  }
}
