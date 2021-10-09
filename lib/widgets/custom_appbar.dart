import 'package:FirebaseEcommerce/constants/constants.dart';
import 'package:FirebaseEcommerce/provider/riverpod.dart';
import 'package:FirebaseEcommerce/screen/cart_screen/cart_screen.dart';
import 'package:FirebaseEcommerce/screen/saved_screen/saved_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends ConsumerWidget {
  final bool hasBackArrow;
  final String title;

  CustomAppBar({
    this.hasBackArrow = false,
    @required this.title,
  }) : assert(title != null);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final cartItems = watch(cartItemsListProvider);

    return Container(
      padding:
          const EdgeInsets.only(top: 56.0, left: 24, right: 24, bottom: 24),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (hasBackArrow)
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ))),
            ),
          Text(title, style: Constants.kBoldHeadingBlack),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreen()));
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: cartItems.when(
                      data: (items) {
                        final cartItemsLength = items.docs.length;
                        return Text(
                          cartItemsLength.toString(),
                          style: Constants.kRegularHeadingWhite,
                        );
                      },
                      loading: () => Container(),
                      error: (e, s) => Container())),
            ),
          ),
        ],
      ),
    );
  }
}
