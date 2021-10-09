import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../../screen/product_screen/product_screen.dart';

class ProductItem extends StatelessWidget {
  final String name;
  final int price;
  final String image;
  final String id;

  ProductItem({
    this.image,
    this.name,
    this.price,
    this.id
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => ProductScreen(id: id , name: name)));
      },
      child: Container(
        height: 300,
        margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black, Colors.black54],
                          begin: Alignment.bottomCenter,
                          end: Alignment.center)),
                  height: 300,
                  child: Hero(
                    tag: id,
                    child: Image.network(
                      image,
                      width: size.width,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.medium,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20.0,
                  left: 10,
                  right: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(name,
                          style: Constants.kRegularHeadingBlack,
                        ),
                        Text(
                          "\$ ${price}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.red[400],
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
