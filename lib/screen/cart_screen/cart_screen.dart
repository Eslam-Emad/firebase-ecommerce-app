import 'package:FirebaseEcommerce/provider/riverpod.dart';
import 'package:FirebaseEcommerce/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/cart_item.dart';

class CartScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final cartItems = watch(cartItemsListProvider);
    final products = watch(productsFutureProvider);

    return Scaffold(
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: cartItems.when(
              data: (items) {
                return Column(
                  children: [
                    CustomAppBar(title: 'Cart', hasBackArrow: true),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: items.docs.length,
                        itemBuilder: (context, index) {
                          return CartItem(
                            size: items.docs[index]['size'].toString(),
                            name: products.data.value.docs[index]['name'],
                            image: products.data.value.docs[index]['images'][0],
                            description: products.data.value.docs[index]['desc'],
                            price: products.data.value.docs[index]['price'].toString(),
                          );
                        })
                  ],
                );
              },
              loading: () => Center(child: CircularProgressIndicator()),
              error: (e, s) => Center(child: Text("Error")))),
    );
  }
}
