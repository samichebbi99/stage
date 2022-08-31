import 'package:flutter/material.dart';
import 'package:flutter_stage/api/apicalls.dart';
import 'package:flutter_stage/widgets/listelement.dart';

class TagView extends StatefulWidget {
  TagView({Key? key, required this.tag}) : super(key: key);
  final String tag;

  @override
  State<TagView> createState() => _TagViewState();
}

class _TagViewState extends State<TagView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xfff9ac66),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width - 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
          ),
          Flexible(
            child: FutureBuilder(
              future: ApiInstance().getData(widget.tag.toString()),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  //clear the snapshot data

                  if (snapshot.data.length == 0) {
                    return Center(
                        child: Container(
                      width: 350,
                      height: 200,
                      child: Text(
                        "Une erreur s'est produite.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17.0,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          color: Color(0xff979797),
                        ),
                      ),
                    ));
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return ListElement(model: snapshot.data[index]);
                        });
                  }
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: CircularProgressIndicator()),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
