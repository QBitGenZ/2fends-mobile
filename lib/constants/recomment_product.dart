import 'package:intl/intl.dart';

class RecommentProduct{
    final String imagePath;
    final String productName;
    final double price;
    final String size;
    final String description;

    RecommentProduct({required this.imagePath, required this.productName, required this.price, required this.size, required this.description});
}

List <RecommentProduct> recommentproduct = [
  RecommentProduct(imagePath: 'assets/images/Rectangle 2493.png', productName: 'Mũ lưỡi trai', price: 75000, size: "Phù hợp mọi kích cỡ", description: "Hoa tay ZARA phiên bản mạ vàng sản xuất 2022. Sản phẩm chỉ mới sử dụng 2 lần nên còn rất mới, độ mới khoảng 95%. Nếu có thắc mắc hãy liên hệ trực tiếp tôi. Tôi còn rất nhiều sản phẩm tốt, hãy xem gian hàng của tôi."),
  RecommentProduct(imagePath: 'assets/images/Rectangle 2494.png', productName: 'Hoa tai Zara', price: 3250000, size: "Phù hợp mọi kích cỡ", description: "Hoa tay ZARA phiên bản mạ vàng sản xuất 2022. Sản phẩm chỉ mới sử dụng 2 lần nên còn rất mới, độ mới khoảng 95%. Nếu có thắc mắc hãy liên hệ trực tiếp tôi. Tôi còn rất nhiều sản phẩm tốt, hãy xem gian hàng của tôi."),
  RecommentProduct(imagePath: 'assets/images/Rectangle 2495.png', productName: 'Áo sweater len', price: 210000, size: "Phù hợp mọi kích cỡ", description: "Hoa tay ZARA phiên bản mạ vàng sản xuất 2022. Sản phẩm chỉ mới sử dụng 2 lần nên còn rất mới, độ mới khoảng 95%. Nếu có thắc mắc hãy liên hệ trực tiếp tôi. Tôi còn rất nhiều sản phẩm tốt, hãy xem gian hàng của tôi."),
  RecommentProduct(imagePath: 'assets/images/Rectangle 2496.png', productName: 'Quần vải', price: 140000, size: "Phù hợp mọi kích cỡ", description: "Hoa tay ZARA phiên bản mạ vàng sản xuất 2022. Sản phẩm chỉ mới sử dụng 2 lần nên còn rất mới, độ mới khoảng 95%. Nếu có thắc mắc hãy liên hệ trực tiếp tôi. Tôi còn rất nhiều sản phẩm tốt, hãy xem gian hàng của tôi."),
  RecommentProduct(imagePath: 'assets/images/Rectangle 2493.png', productName: 'Mũ lưỡi trai', price: 75000, size: "Phù hợp mọi kích cỡ", description: "Hoa tay ZARA phiên bản mạ vàng sản xuất 2022. Sản phẩm chỉ mới sử dụng 2 lần nên còn rất mới, độ mới khoảng 95%. Nếu có thắc mắc hãy liên hệ trực tiếp tôi. Tôi còn rất nhiều sản phẩm tốt, hãy xem gian hàng của tôi."),
  RecommentProduct(imagePath: 'assets/images/Rectangle 2494.png', productName: 'Hoa tai Zara', price: 3250000, size: "Phù hợp mọi kích cỡ", description: "Hoa tay ZARA phiên bản mạ vàng sản xuất 2022. Sản phẩm chỉ mới sử dụng 2 lần nên còn rất mới, độ mới khoảng 95%. Nếu có thắc mắc hãy liên hệ trực tiếp tôi. Tôi còn rất nhiều sản phẩm tốt, hãy xem gian hàng của tôi."),
  RecommentProduct(imagePath: 'assets/images/Rectangle 2495.png', productName: 'Áo sweater len', price: 210000, size: "Phù hợp mọi kích cỡ", description: "Hoa tay ZARA phiên bản mạ vàng sản xuất 2022. Sản phẩm chỉ mới sử dụng 2 lần nên còn rất mới, độ mới khoảng 95%. Nếu có thắc mắc hãy liên hệ trực tiếp tôi. Tôi còn rất nhiều sản phẩm tốt, hãy xem gian hàng của tôi."),
  RecommentProduct(imagePath: 'assets/images/Rectangle 2496.png', productName: 'Quần vải', price: 140000, size: "Phù hợp mọi kích cỡ", description: "Hoa tay ZARA phiên bản mạ vàng sản xuất 2022. Sản phẩm chỉ mới sử dụng 2 lần nên còn rất mới, độ mới khoảng 95%. Nếu có thắc mắc hãy liên hệ trực tiếp tôi. Tôi còn rất nhiều sản phẩm tốt, hãy xem gian hàng của tôi.")
];
String formatPrice(double price) {
  var format = NumberFormat.currency(locale: "vi_VN", symbol: "VND");
  return '${format.format(price).toString()}';
}
