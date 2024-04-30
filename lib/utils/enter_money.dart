// import 'package:flutter/material.dart';
// import 'package:fends_mobile/utils/pay.dart';
//
// class EnterMoneyPage extends StatefulWidget {
//   const EnterMoneyPage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<EnterMoneyPage> createState() => _EnterMoneyPageState();
// }
//
// class _EnterMoneyPageState extends State<EnterMoneyPage> {
//   TextEditingController moneyController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 controller: moneyController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   hintText: "Nhập số tiền muốn thanh toán",
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               child: Text("Thanh toán"),
//               onPressed: () {
//                 int? money = int.tryParse(moneyController.text);
//                 if (money == null) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       backgroundColor: Colors.red,
//                       content: Text("Số tiền không hợp lệ", style: TextStyle(color: Colors.white)),
//                     )
//                   );
//                   return;
//                 }
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) =>
//                         // PayScreen(money: moneyController.text),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ), // This trailing comma makes auto-formatting nicer for build methods.
//       ),
//     );
//   }
// }
