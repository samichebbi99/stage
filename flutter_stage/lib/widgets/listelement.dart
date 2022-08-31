import 'package:flutter/material.dart';
import 'package:flutter_stage/models/product.dart';

class ListElement extends StatelessWidget {
  ListElement({Key? key, required this.model}) : super(key: key);
  ProductModel model;

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

    return Container(
        margin: EdgeInsets.fromLTRB(50, 5, 50, 5),
        padding: EdgeInsets.all(15),
        width: 250,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0.5,
              blurRadius: 5,
              offset: Offset(2, 5), // changes position of shadow
            ),
          ],
          border: Border.all(
            color: Colors.grey,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 248, 248, 248),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(child: Image.network(model.image.toString())),
            SizedBox(
              width: 15,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nom.toString(),
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 30, 123, 117),
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Reference: " + model.reference.toString(),
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 11,
                        color: Color.fromARGB(255, 141, 141, 141),
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    overflow: TextOverflow.ellipsis,
                    model.description.toString(),
                    maxLines: 12,
                  )
                ],
              ),
            ),
            SizedBox(
              width: 70,
            ),
            Flexible(
              child: Column(
                children: [
                  Text(
                    model.disponibilite.toString(),
                    style: TextStyle(
                        color: Colors.indigoAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    model.prix.toString(),
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 167, 42, 34),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  model.promotion.toString().toLowerCase() == "promo"
                      ? Text(
                          model.prixOriginal.toString(),
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                              color: Color.fromARGB(255, 167, 42, 34),
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              decoration: TextDecoration.lineThrough),
                        )
                      : Container()
                ],
              ),
            )
          ],
        ));
  }
}
