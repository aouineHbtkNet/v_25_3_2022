import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';


class ImagewidgetNoButton extends StatelessWidget {
  var networkImageUrl;
   ImagewidgetNoButton({Key? key,
    required this.networkImageUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  networkImageUrl ==  null
        ? Container(
        foregroundDecoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Constants.ASSET_PLACE_HOLDER_IMAGE), fit: BoxFit.none),
        ),
    )
        : Container(
          child: Image.network('https://hbtknet.com/storage/notes/$networkImageUrl',fit: BoxFit.fill,),
        );
  }
}
