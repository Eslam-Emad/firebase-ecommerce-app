import 'package:flutter/material.dart';

class ImageSwipe extends StatefulWidget {
  final List photosList;

  ImageSwipe({this.photosList});

  @override
  _ImageSwipeState createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<ImageSwipe> {
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        child: Stack(
          children: [
            PageView(
              onPageChanged: (index) {
                setState(() {
                  _selectedPage = index;
                });
              },
              children: [
                for (int i = 0; i < widget.photosList.length; i++)
                  Image.network(
                    widget.photosList[i],
                    fit: BoxFit.cover,
                  ),
              ],
            ),
            Positioned(
                bottom: 20,
                right: 0,
                left: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < widget.photosList.length; i++)
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        height: 10.0,
                        width: _selectedPage == i ? 24.0 : 11.0,
                        margin: const EdgeInsets.only(left: 5.0),
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(24.0)),
                      )
                  ],
                ))
          ],
        ));
  }
}
