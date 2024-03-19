class RecommentProduct{
    final String imagePath;
    final String productName;
    final double price;
    final String size;

    RecommentProduct({required this.imagePath, required this.productName, required this.price, required this.size});
}

List <RecommentProduct> recommentproduct = [
  RecommentProduct(imagePath: 'assets/images/Rectangle 2493.png', productName: 'Mũ lưỡi trai', price: 75000, size: "phù hợp mọi kích cỡ"),
  RecommentProduct(imagePath: 'assets/images/Rectangle 2494.png', productName: 'Hoa tai Zara', price: 3250000, size: "phù hợp mọi kích cỡ"),
  RecommentProduct(imagePath: 'assets/images/Rectangle 2495.png', productName: 'Áo sweater len', price: 210000, size: "phù hợp mọi kích cỡ"),
  RecommentProduct(imagePath: 'assets/images/Rectangle 2496.png', productName: 'Quần vải', price: 140000, size: "phù hợp mọi kích cỡ"),
  RecommentProduct(imagePath: 'assets/images/Rectangle 2493.png', productName: 'Mũ lưỡi trai', price: 75000, size: "phù hợp mọi kích cỡ"),
  RecommentProduct(imagePath: 'assets/images/Rectangle 2494.png', productName: 'Hoa tai Zara', price: 3250000, size: "phù hợp mọi kích cỡ"),
  RecommentProduct(imagePath: 'assets/images/Rectangle 2495.png', productName: 'Áo sweater len', price: 210000, size: "phù hợp mọi kích cỡ"),
  RecommentProduct(imagePath: 'assets/images/Rectangle 2496.png', productName: 'Quần vải', price: 140000, size: "phù hợp mọi kích cỡ")
];
String formatPrice(double price) {
  return '${price.toString()} VND';
}
