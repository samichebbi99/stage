import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_stage/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stage/utilities/customimage.dart';
import 'package:url_launcher/url_launcher.dart';

class PromoItem extends StatelessWidget {
  const PromoItem(
      {Key? key, required this.model, this.width = 350, this.height = 310})
      : super(key: key);
  final ProductModel model;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    String nom;
    String discount;
    nom = model.nom.toString();
    discount = model.discountAmount.toString();
    final Uri _url = Uri.parse(model.lien.toString());
    if (nom.toString().startsWith("\n")) {
      nom = nom.toString().substring(7);
    }
    if (discount.toString().startsWith("\n")) {
      discount = discount.toString().substring(29);
      discount = discount.toString().substring(0, discount.length - 15);
      discount = "-" + discount;
    }
    Future<void> _launchUrl() async {
      print(_url);
      if (!await launchUrl(_url)) {
        throw 'Could not launch $_url';
      }
    }

    return InkWell(
      onTap: _launchUrl,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 25, top: 25, right: 25, left: 25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black87.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Stack(
          children: [
            CustomImage(
              model.image.toString(),
              width: double.infinity,
              height: 190,
              radius: 15,
            ),
            RotationTransition(
              turns: new AlwaysStoppedAnimation(-25 / 360),
              child: Positioned(
                top: 30,
                left: 10,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 152, 34, 26),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black87.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Text(
                    discount.toString(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 170,
              right: 15,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xffed6b5b),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Text(
                  model.prix.toString(),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Positioned(
              top: 210,
              child: Container(
                width: width - 20,
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nom.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 30, 123, 117),
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getAttribute(Icons.price_change, Color(0xFF8A8989),
                            model.prixOriginal.toString()),
                        SizedBox(
                          width: 12,
                        ),
                        getAttribute2(Icons.shopping_cart, Color(0xFF8A8989),
                            model.disponibilite.toString()),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getAttribute(IconData icon, Color color, String info) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: color,
        ),
        SizedBox(
          width: 3,
        ),
        Text(
          info,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Color(0xFF8A8989),
              fontSize: 13,
              decoration: TextDecoration.lineThrough),
        ),
      ],
    );
  }

  getAttribute2(IconData icon, Color color, String info) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: color,
        ),
        SizedBox(
          width: 3,
        ),
        Text(
          info,
          maxLines: 1,
          overflow: TextOverflow.visible,
          style: TextStyle(
            color: Color(0xFF8A8989),
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
