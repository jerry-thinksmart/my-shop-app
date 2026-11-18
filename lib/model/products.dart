class Products {
  const Products({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.category,
    this.gallery = const [],
  });
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final String category;
  final List<String> gallery;
}

const demoProducts = [
  Products(
    id: 'hoodie-1',
    name: 'Cotton Hoodie',
    price: 86,
    imageUrl:
        'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?auto=format&fit=crop&w=900&q=85',
    category: 'Outerwear Men',
    description:
        'A cotton hoodie is a must-have for its softness, breathability, and effortless style. Ideal for any season, it keeps you comfortable while adding an easy layer to your everyday look.',
    gallery: [
      'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?auto=format&fit=crop&w=900&q=85',
      'https://images.unsplash.com/photo-1556821840-3a63f95609a7?auto=format&fit=crop&w=700&q=85',
      'https://images.unsplash.com/photo-1603252109303-2751441dd157?auto=format&fit=crop&w=700&q=85',
    ],
  ),
  Products(
    id: 'sportswear-1',
    name: 'Nike Sportswear',
    price: 46,
    imageUrl:
        'https://images.unsplash.com/photo-1556821840-3a63f95609a7?auto=format&fit=crop&w=700&q=85',
    description: 'Soft everyday sportswear.',
    category: 'Sportswear',
  ),
  Products(
    id: 'pullover-1',
    name: 'Pullover Hoodie',
    price: 36,
    imageUrl:
        'https://images.unsplash.com/photo-1578681994506-b8f463449011?auto=format&fit=crop&w=700&q=85',
    description: 'A relaxed pullover hoodie.',
    category: 'Outerwear',
  ),
  Products(
    id: 'jacket-1',
    name: 'Brown Jacket',
    price: 50,
    imageUrl:
        'https://images.unsplash.com/photo-1551028719-00167b16eac5?auto=format&fit=crop&w=700&q=85',
    description: 'A timeless brown jacket.',
    category: 'Jackets',
  ),
];
