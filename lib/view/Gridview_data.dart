import 'package:dynamicvideosection/model/subcategory_model.dart';
import 'package:dynamicvideosection/ui_helper/custom_colors.dart';
import 'package:flutter/material.dart';

class GridviewData extends StatelessWidget {
   GridviewData({super.key,required this.subcategory});

   final List<KathaModel> subcategory;

   List<Color> colors = [Color.fromRGBO(255, 236, 208, 1),Color.fromRGBO(245, 236, 248, 1),Color.fromRGBO(245, 236, 248, 1),
    Color.fromRGBO(255, 236, 208, 1),Color.fromRGBO(223, 244, 235, 1),Color.fromRGBO(245, 236, 248, 1),Color.fromRGBO(245, 236, 248, 1),
    Color.fromRGBO(255, 236, 208, 1),Color.fromRGBO(223, 244, 235, 1),Color.fromRGBO(245, 236, 248, 1)];


  @override
  Widget build(BuildContext context) {

    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;

    return SafeArea(child: Scaffold(

      backgroundColor: CustomColors.clrwhite,

      body:  GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.02,vertical: screenwidth * 0.02),
        itemCount: subcategory.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
           childAspectRatio: screenwidth *  0.0019
        ),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.02,vertical: screenwidth * 0.02),
            child:  LayoutBuilder(
              builder: (context, constraints) {
                return  Container(
                  // height: constraints.maxHeight * 0.8,
                  // width: constraints.maxWidth * 0.8,
                  decoration: BoxDecoration(
                      color: colors[index],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
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
                          width: screenwidth * 0.44,
                          height: screenheight * 0.17,
                            decoration:   BoxDecoration(
                              color: Colors.blue,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(5)),
                                image: DecorationImage(image: NetworkImage(subcategory[index].image)) )
                        ),


                     Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            SizedBox(height: screenwidth * 0.02,),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.01),
                                    child: Text(subcategory[index].name,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 14,color: CustomColors.clrblack,fontFamily: 'Roboto',overflow: TextOverflow.ellipsis),maxLines: 1,)),

                            Padding(
                                    padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.01),
                                    child:Text("Hello I am Pravin I abgh",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12,color: CustomColors.clrblack,fontFamily: 'Roboto',overflow: TextOverflow.ellipsis),maxLines: 1,)),


                            SizedBox(height: screenwidth * 0.02,),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.02),
                                    child: Container(
                                      width: screenwidth * 0.40,
                                      height: screenheight * 0.05,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Color.fromRGBO(255, 118, 10, 1)
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("Watch Now",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,fontFamily: 'Roboto',color: Color.fromRGBO(255, 255, 255, 1)),),
                                                       SizedBox(width: 10),
                                                       Container(
                                                         height: 24,
                                                         width: 24,
                                                         decoration: BoxDecoration(
                                                           image: DecorationImage(
                                                               image: AssetImage("assets/image/mobile.png"),fit: BoxFit.cover),
                                                         ),
                                                       )
                                                     ],
                                                   ),
                                                 ),


                                  )],
                      ),

                               // Container(
                               //   width: screenwidth * 0.44,
                               //   height: screenheight * 0.15,
                               //   decoration: BoxDecoration(
                               //       color: colors[index],
                               //       border: Border(bottom: BorderSide(color: Colors.grey),right: BorderSide(color: Colors.grey),left: BorderSide(color: Colors.grey)),
                               //       borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
                               //   ),
                               //   child: Column(
                               //     crossAxisAlignment: CrossAxisAlignment.start,
                               //     children: [
                               //       SizedBox(height: screenwidth * 0.02,),
                               //       Padding(
                               //         padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.01),
                               //         child: Expanded(child: Text("Hello Pravin  Patidar i AM here",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 14,color: CustomColors.clrblack,fontFamily: 'Roboto',overflow: TextOverflow.ellipsis),maxLines: 1,)),
                               //       ),
                               //       Padding(
                               //         padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.01),
                               //         child: Expanded(child: Text("Hello I am Pravin I am A developer",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12,color: CustomColors.clrblack,fontFamily: 'Roboto',overflow: TextOverflow.ellipsis),maxLines: 1,)),
                               //       ),
                               //       SizedBox(height: screenwidth * 0.02,),
                               //       Padding(
                               //         padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.02),
                               //         child: Container(
                               //           width: screenwidth * 0.40,
                               //           height: screenheight * 0.05,
                               //           decoration: BoxDecoration(
                               //               borderRadius: BorderRadius.circular(10),
                               //               color: Color.fromRGBO(255, 118, 10, 1)
                               //           ),
                               //           child: Row(
                               //             mainAxisAlignment: MainAxisAlignment.center,
                               //             children: [
                               //               Text("Watch Now",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,fontFamily: 'Roboto',color: Color.fromRGBO(255, 255, 255, 1)),),
                               //                            SizedBox(width: 10),
                               //                            Container(
                               //                              height: 24,
                               //                              width: 24,
                               //                              decoration: BoxDecoration(
                               //                                image: DecorationImage(
                               //                                    image: AssetImage("assets/image/mobile.png"),fit: BoxFit.cover),
                               //                              ),
                               //                            )
                               //                          ],
                               //                        ),
                               //                      ),
                               //                    )
                               //                  ],
                               //                ),
                               //              ),






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
