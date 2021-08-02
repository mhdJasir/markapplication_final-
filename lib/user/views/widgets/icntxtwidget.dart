import 'package:flutter/material.dart';

class IconTxt extends StatelessWidget {
  final String icon;
  final String title;
  final double width;
  final double height;
  final Color color;
  final Function tap;
  IconTxt(
      {Key key,
      this.icon,
      this.title,
      this.color,
      this.tap,
      this.height,
      this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 111,
          width: 65,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: color, borderRadius: BorderRadius.circular(25)),
                  child: Image.asset(
                    icon,
                    height: height,
                    width: width,
                  )),
              SizedBox(
                height: 8,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: Colors.grey[700]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
