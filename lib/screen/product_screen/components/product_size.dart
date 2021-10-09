import 'package:flutter/material.dart';

class ProductSize extends StatefulWidget {
  final List productSizes;

  ProductSize({this.productSizes});

  @override
  _ProductSizeState createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  int _selected = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          for (int i = 0; i < widget.productSizes.length; i++)
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: (){
                setState(() {
                  _selected = i;
                });
              },
              child: Container(
                height: 42,
                width: 42,
                alignment: Alignment.center,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: _selected == i ? Theme.of(context).accentColor :Color(0xFFDCDCDC),
                    borderRadius: BorderRadius.circular(8.0)),
                child: Text(
                  widget.productSizes[i],
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                      color: Colors.black),
                ),
              ),
            )
        ],
      ),
    );
  }
}
