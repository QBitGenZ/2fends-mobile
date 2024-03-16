class RecommentProduct{
    final String imagePath;
    final String productName;
    final double price;

    RecommentProduct({required this.imagePath, required this.productName, required this.price});
}

List <RecommentProduct> recommentproduct = [
  RecommentProduct(imagePath: 'assets/images/Rectangle 2493.png', productName: 'Mũ lưỡi trai', price: 75000),
  RecommentProduct(imagePath: 'assets/images/Rectangle 2494.png', productName: 'Hoa tai Zara', price: 3250000),
  RecommentProduct(imagePath: 'assets/images/Rectangle 2495.png', productName: 'Áo sweater len', price: 210000),
  RecommentProduct(imagePath: 'assets/images/Rectangle 2496.png', productName: 'Quần vải', price: 140000),
  RecommentProduct(imagePath: 'assets/images/Rectangle 2493.png', productName: 'Mũ lưỡi trai', price: 75000),
  RecommentProduct(imagePath: 'assets/images/Rectangle 2494.png', productName: 'Hoa tai Zara', price: 3250000),
  RecommentProduct(imagePath: 'assets/images/Rectangle 2495.png', productName: 'Áo sweater len', price: 210000),
  RecommentProduct(imagePath: 'assets/images/Rectangle 2496.png', productName: 'Quần vải', price: 140000)
];
String formatPrice(double price) {
  return '${price.toString()} VND';
}
