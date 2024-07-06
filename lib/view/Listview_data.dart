import 'package:dynamicvideosection/model/subcategory_model.dart';
import 'package:dynamicvideosection/ui_helper/custom_colors.dart';
import 'package:dynamicvideosection/view/videos_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ListviewData extends StatelessWidget {
  const ListviewData({super.key,required this.subcategory,required this.onButtonClicked});

  final List<KathaModel>subcategory;
  final Function(KathaModel) onButtonClicked;

  @override
  Widget build(BuildContext context) {

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(child: Scaffold(

      backgroundColor: CustomColors.clrwhite,
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: subcategory.length,
              padding: EdgeInsets.only(left: screenWidth * 0.04,bottom: screenHeight * 0.02,right: screenWidth * 0.04),
              shrinkWrap: true,
              itemBuilder: (context, index) {

                return  Padding(
                      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
                      child: Container(
                        // width: screenwidth * 0.5,
                        // height: screenheight * 0.25/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:CustomColors.clrskyblue

                        ),
                        child: Row(
                          children: [

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03,vertical: screenWidth * 0.03),
                              child: Container(
                                height: screenHeight * 0.1,
                                width: screenWidth * 0.2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(image: NetworkImage("https://dev-mahakal.rizrv.in/storage/app/public/video-subcategory-img/${subcategory[index].image}"),fit: BoxFit.cover)
                                ),
                              ),
                            ),

                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: screenWidth * 0.02,),
                                  SizedBox(width: screenWidth * 0.6, child: Text(subcategory[index].name,style:  const TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: CustomColors.clrblack,fontFamily: 'Roboto',overflow: TextOverflow.ellipsis),maxLines: 1,)),
                                  SizedBox(width: screenWidth * 0.6, child: const Text("",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: CustomColors.clrblack,fontFamily: 'Roboto',overflow: TextOverflow.ellipsis),maxLines: 1,)),


                                  Padding(
                                    padding: EdgeInsets.only(right: screenWidth * 0.01,bottom: screenWidth * 0.03),
                                    child: GestureDetector(

                                      onTap: () async{

                                        // // Make API call to get videos by subcategory
                                        // final response = await http.get(Uri.parse(
                                        //     'https://dev-mahakal.rizrv.in/api/v1/astro/getVideosBySubcategory/${subcategory[index].id}'));
                                        //
                                        // if (response.statusCode == 200) {
                                        //   // Parse the response and play the video
                                        //   // For example, you can use a video player package like `video_player`
                                        //   // and play the video with the received URL
                                        //   print('Video URL: ${response.body}');
                                        //   // Play the video here
                                        // } else {
                                        //   print('Error: ${response.statusCode}');
                                        // }

                                        onButtonClicked(subcategory[index]);

                                      },

                                      child: Container(
                                        width: screenWidth * 0.6,
                                        height: screenHeight * 0.05,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: CustomColors.clrorange
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Text("Watch Now",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'Roboto',color: CustomColors.clrwhite),),

                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                                              child: Container(
                                                height: screenHeight * 0.05,
                                                width: screenWidth * 0.06,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage("assets/image/mobile.png")),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                 );
               },),
            )
          ],
        ),
      )
    );
  }
}
