// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../cart/application/bloc.dart';
// import '../../cart/application/cart_bloc.dart';
// import '../../cart/presentation/cart_screen.dart';
// import '../../cart/presentation/order_result_screen.dart';
// import '../widgets/menu_item_list.dart';

// class OrderScreen extends StatefulWidget {
//   const OrderScreen({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _OrderScreenState createState() => _OrderScreenState();
// }

// class _OrderScreenState extends State<OrderScreen> {
//   int index = 0;
//   final List<String> collectionsValues = [
//     "main_dishes",
//     "side_dishes",
//     "drinks"
//   ];
//   final List<String> collectionsNames = [
//     "Main Dishes",
//     "Side Dishes",
//     "Drinks"
//   ];

//   @override
//   void initState() {
//     // index = 0;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(collectionsNames[index]),
//         actions: [
//           Stack(
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.shopping_bag),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const CartScreen()),
//                   );
//                 },
//               ),
//               BlocBuilder<CartBloc, CartState>(
//                 builder: (context, state) {
//                   print('cart length');
//                   print(state.menuItems.length);
//                   return Positioned(
//                       top: 0.0,
//                       right: 4.0,
//                       child: Center(
//                         child: Text(
//                           state.menuItems.length.toString(),
//                           style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 18.0,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ));
//                 },
//               ),
//             ],
//           )
//         ],
//       ),
//       body: Center(
//           child: MenuItemList(
//         collectionName: collectionsValues[index],
//       )),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Theme.of(context).primaryColor,
//         onPressed: () {
//           if (index <= 1) {
//             setState(() {
//               index++;
//             });
//           } else if (index > 1) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => const OrderResultScreen()),
//             );
//           }
//         },
//         tooltip: 'next',
//         child: Icon(index <= 1 ? Icons.navigate_next : Icons.payment),
//       ),
//     );
//   }
// }
