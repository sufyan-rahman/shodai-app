class CartFavItem {
  final String id;
  final String imagePath;
  final String title;
  final String weight;
  final double price;

  CartFavItem({
    required this.id,
    required this.imagePath,
    required this.title,
    required this.weight,
    required this.price,
  });

  // Optionally, you can add equality and hashCode methods to ensure that
  // two CartItems with the same properties are considered equal.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartFavItem &&
        other.id == id &&
        other.imagePath == imagePath &&
        other.title == title &&
        other.weight == weight &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    imagePath.hashCode ^
    title.hashCode ^
    weight.hashCode ^
    price.hashCode;
  }
}
