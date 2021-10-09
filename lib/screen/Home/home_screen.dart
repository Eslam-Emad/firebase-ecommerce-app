import 'package:FirebaseEcommerce/provider/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/custom_appbar.dart';
import 'components/product_item.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final products = watch(productsFutureProvider);
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: () => context.refresh(productsFutureProvider),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CustomAppBar(title: "Home"),
            products.when(
              data: (products) => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 24.0),
                  itemCount: products.docs.length,
                  itemBuilder: (context, index) => ProductItem(
                        id: products.docs[index].id,
                        name: products.docs[index]['name'],
                        price: products.docs[index]['price'],
                        image: products.docs[index]['images'][0],
                      )),
              loading: () => Center(child: CircularProgressIndicator()),
              error: (e, s) => Center(child: Text("Error")),
            )
          ],
        ),
      ),
    ));
  }
}
