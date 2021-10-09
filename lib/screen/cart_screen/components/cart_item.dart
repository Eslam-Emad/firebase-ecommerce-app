import 'package:FirebaseEcommerce/constants/constants.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final String size;
  final String description;

  CartItem({
    this.image,
    this.name,
    this.price,
    this.size,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: double.infinity,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 90.0,
            width: 90.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                image,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.low,
              ),
            ),
          ),
          SizedBox(width: 15),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Constants.kRegularHeadingBlack,
              ),
              Text(
                price,
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.red.shade400,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "size - $size",
                style: Constants.kRegularHeadingBlack,
              )
            ],
          )
        ],
      ),
    );
  }
}
