import 'package:FirebaseEcommerce/constants/constants.dart';
import 'package:FirebaseEcommerce/provider/riverpod.dart';
import 'package:FirebaseEcommerce/screen/cart_screen/cart_screen.dart';
import 'package:FirebaseEcommerce/services/Firebase/firebase.dart';
import 'package:FirebaseEcommerce/widgets/Alert.dart';
import 'package:FirebaseEcommerce/widgets/custom_appbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'components/image_swipe.dart';
import 'components/product_size.dart';

class ProductScreen extends ConsumerWidget {
  final String id;
  final String name;

  ProductScreen({this.name, this.id});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final products = watch(productProvider(id));
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(title: name, hasBackArrow: true),
            products.when(
              error: (e, s) => Center(child: Text('error')),
              loading: () => Center(
                child: CircularProgressIndicator(),
              ),
              data: (product) {
                // lists
                final List photosList = product['images'];
                final List productSizes = product['sizes'];
                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ImageSwipe(photosList: photosList),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 24.0, bottom: 8.0, left: 24.0, right: 24.0),
                      child: Text(product["name"],
                          style: Constants.kRegularHeadingBlack),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 24.0),
                      child: Text("\$${product["price"]}",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Theme.of(context).accentColor)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 24.0, left: 24.0, right: 24.0, top: 8.0),
                      child: Text(product["desc"],
                          style: TextStyle(fontSize: 16.0, color: Colors.grey)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 24.0),
                      child: Text('Select Size',
                          style: Constants.kRegularHeadingBlack),
                    ),
                    ProductSize(productSizes: productSizes),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            margin: const EdgeInsets.only(left: 20.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(0xFFDCDCDC),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Icon(Icons.bookmark_border, size: 30),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                context.read(addToCartProvider(id));
                                Alert.showSnackBar(
                                  context: context,
                                  content: "item added to cart",
                                  key: _scaffoldKey,
                                );

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CartScreen()));
                              },
                              child: Container(
                                height: 60,
                                alignment: Alignment.center,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 10.0),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Text('Add to cart',
                                    style: Constants.kBoldHeadingWhite),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
