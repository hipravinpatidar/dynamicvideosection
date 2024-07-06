import 'package:dynamicvideosection/model/subcategory_model.dart';
import 'package:dynamicvideosection/ui_helper/custom_colors.dart';
import 'package:flutter/material.dart';

class GridviewData extends StatelessWidget {
   const GridviewData({super.key,required this.subcategory,required this.onButtonClicked});

   final List<KathaModel> subcategory;
   final Function(KathaModel) onButtonClicked;


  @override
  Widget build(BuildContext context) {

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(child: Scaffold(

      backgroundColor: CustomColors.clrwhite,

      body:  GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02,vertical: screenWidth * 0.02),
        itemCount: subcategory.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
         // childAspectRatio: screenWidth / (screenHeight / 1.2), // adjust the aspect ratio based on your design

          childAspectRatio: screenWidth<500 ? 0.78 : 0.9
          // childAspectRatio: screenWidth *  0.0019
          //childAspectRatio: screenwidth * 0.0018
         // childAspectRatio: screenheight * 0.0010
        ),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02,vertical: screenWidth * 0.02),
            child:  LayoutBuilder(
              builder: (context, constraints) {
                return  Container(
                  // height: constraints.maxHeight * 0.8,
                  // width: constraints.maxWidth * 0.8,
                  decoration: BoxDecoration(
                      color: CustomColors.clrskyblue,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(color: Colors.grey,
                            spreadRadius: 0.5,
                            blurRadius: 1.5,
                            offset: Offset(0, 0.5))
                      ]
                  ),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Container(
                          // width: screenwidth * 0.44,
                          // height: screenheight * 0.17,
                        height: constraints.maxHeight * 0.6,
                            width: constraints.maxWidth * 1,
                            decoration:BoxDecoration(
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(5)),
                               image: DecorationImage(image: NetworkImage("https://dev-mahakal.rizrv.in/storage/app/public/video-subcategory-img/${subcategory[index].image}"),fit: BoxFit.cover) )
                        ),


                     Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            SizedBox(height: screenWidth * 0.02,),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                                    child: SizedBox(child: Text(subcategory[index].name,style: const TextStyle(fontWeight: FontWeight.w700,fontSize: 14,color: CustomColors.clrblack,fontFamily: 'Roboto',overflow: TextOverflow.ellipsis),maxLines: 1,))),

                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                                    child: SizedBox(child: Text("",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12,color: CustomColors.clrblack,fontFamily: 'Roboto',overflow: TextOverflow.ellipsis),maxLines: 1,))),


                            SizedBox(height: screenWidth * 0.02,),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                                    child: GestureDetector(
                                      onTap: () {
                                        onButtonClicked(subcategory[index]);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: CustomColors.clrorange
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03,vertical: screenWidth * 0.01),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Text("Watch Now",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,fontFamily: 'Roboto',color: Color.fromRGBO(255, 255, 255, 1)),),
                                                           const SizedBox(width: 10),
                                                           Container(
                                                             height: 24,
                                                             width: 24,
                                                             decoration: const BoxDecoration(
                                                               image: DecorationImage(
                                                                   image: AssetImage("assets/image/mobile.png"),fit: BoxFit.cover),
                                                             ),
                                                           )
                                                         ],
                                                       ),
                                                     ),
                                                   ),
                                                )
                                               )
                                             ]
                                           ),
                                    ],
                                ),
                             );
                         },
                        ),
                     );
                   },),
               ));
            }
}
