import 'dart:convert';
import 'package:dynamicvideosection/model/videocategory_model.dart';
import 'package:dynamicvideosection/ui_helper/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../utils/api_service.dart';

class VideosData extends StatefulWidget {
  const VideosData({super.key,required this.categoryName,required this.subcategoryId});

  final String categoryName;
  final int subcategoryId;


  @override
  State<VideosData> createState() => _VideosDataState();
}

class _VideosDataState extends State<VideosData>with SingleTickerProviderStateMixin {
  bool _isLiked = false;
  bool _isDisliked = false;
  int _likeCount = 0;


  late AnimationController _controller;
  late Animation<double> _animation;

  List<VideoModel> videoCategory = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
   getVideoData(widget.subcategoryId);



  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleLikedTap() {
    setState(() {
      if (_isLiked) {
        _likeCount--;
        _isLiked = false;
      } else {
        _likeCount++;
        _isLiked = true;
      }
      if (_isDisliked) {
        _isDisliked = false;
      }
    });
    _controller.forward().then((_) {
      _controller.reverse();
    });
  }

  void _handleDislikedTap() {
    setState(() {
      if (_isDisliked) {
        _isDisliked = false;
      } else {
        _isDisliked = true;
      }
      if (_isLiked) {
        _isLiked = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder(
     future: getVideoData(widget.subcategoryId),
      //future: null,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: CustomColors.clrwhite,
            appBar: AppBar(
              title: Text(widget.categoryName, style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                  color: CustomColors.clrorange),),
              centerTitle: true,
              leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back, color: CustomColors.clrblack,)),
            ),
            body: Column(
              children: [


                Container(
                  height: 250,
                  width: 300,
                  color: Colors.grey,
                ),


                // Scrolling buttons
                Padding(
                  padding: EdgeInsets.all(screenHeight * 0.02),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [

                        // Like & Dislike
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: CustomColors.clrborder)
                          ),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.03,
                                  vertical: screenWidth * 0.01),
                              child: Row(
                                children: [

                                  GestureDetector(onTap: () {
                                    _handleLikedTap();
                                  },
                                      child: Stack(
                                        children: <Widget>[

                                          Icon(_isLiked ? Icons.thumb_up : Icons
                                              .thumb_up_alt_outlined,
                                            color: _isLiked ? CustomColors
                                                .clrorange : CustomColors
                                                .clrborder,),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: ScaleTransition(
                                              scale: _animation,
                                              child: const Icon(
                                                Icons.thumb_up,
                                                color: CustomColors.clrorange,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                  const SizedBox(width: 5,),
                                  SizedBox(child: Text("${_likeCount}",
                                    style: const TextStyle(fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Roboto',
                                        color: CustomColors.clrborder,
                                        overflow: TextOverflow.ellipsis),
                                    maxLines: 1,)),

                                  const SizedBox(
                                    height: 24,
                                    child: VerticalDivider(
                                      thickness: 1,
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _handleDislikedTap();
                                          // _isDisliked = !_isDisliked;
                                          // _isLiked = false;
                                        });
                                      },
                                      child: Stack(
                                        children: <Widget>[
                                          Icon(_isDisliked
                                              ? Icons.thumb_down
                                              : Icons.thumb_down_alt_outlined,
                                            color: _isDisliked ? CustomColors
                                                .clrorange : CustomColors
                                                .clrborder,)
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Share
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.02),
                          child: GestureDetector(
                            onTap: () {

                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: CustomColors.clrborder)
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.03,
                                      vertical: screenWidth * 0.01),
                                  child: Row(
                                    children: [

                                      const ImageIcon(NetworkImage(
                                          "https://s3-alpha-sig.figma.com/img/4b68/f462/c54c6d88cbaf0c41c7558e1efb9b163e?Expires=1720396800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=YLP76WNNDSJqdFH5y3TKyjVhjUG2G5xQWrBSU2lVaulhptaNe2hexgOwSFeEoKfyRZL4K9wNKzcMQLeZ7tQulnuM9Jkeo4qxpOl0lIOf7UQbkGKH~h-ljpN9aT3P2Yp49uIv0QureZ2XTYCe8sV1E1Wqapype8a8CpfrcrLJ17cpLkilUbwjtvj62j3Q5PY5n9FffBnt-04u~Vth6Jw27eiFLmV7gFPBbAyQxc-k22Nwq-7eOE3EDN7b5anD6PWLk3t5gHw005GeMbO2QxhBwoTXCHJYEMFto3FoBpmGNgzGg~gYEAxo-44j5Fo5X5ZjfH9PzjiUv~imODqtzI2o8w__"),
                                          color: CustomColors.clrborder),
                                      SizedBox(width: screenWidth * 0.02,),
                                      const Text("Share", style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Roboto',
                                          color: CustomColors.clrborder),),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Views
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: CustomColors.clrborder)
                          ),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.03,
                                  vertical: screenWidth * 0.01),
                              child: Row(
                                children: [

                                  ImageIcon(NetworkImage(
                                      "https://s3-alpha-sig.figma.com/img/caab/e14b/607e4c26fca835765664efde98fc9683?Expires=1720396800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Mn-MUKctlVRFBRy2toWsevehgBZuN4SYaYZCvXpXfpO384BwxYOFntSjyIS0lyQQ5IGpXWDgjeZuVzVdjn76Q0zU9cGTfcgOQ4cTTcfWp~NUxxDUQoKSTMQVCqYPwvv39oJMMoBXLmUUuoYTGH8xT~UKnIooOBXQASwssszieiLM56fbMvV0HLFRxoCtR7JQrxctpq6Rq4aLGMJIRh9fQnkX8bcOstzwAZA9fgmaUV-wf4vJxewyUSdi9PfHgzXoXEcPz5hZwysT~cM40Gg2cFBDNj2Isvkf-FuJtIBw8peswR3WGHRcrPqRoWUsb-~2h6HNCuZSxTfAj-wIe5Aidw_"),
                                      color: CustomColors.clrborder),
                                  SizedBox(width: screenWidth * 0.02),
                                  Text.rich(
                                      TextSpan(
                                          children: [
                                            TextSpan(text: "1500",
                                                style: TextStyle(fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: 'Roboto',
                                                    color: CustomColors
                                                        .clrborder)),
                                            TextSpan(text: " View",
                                                style: TextStyle(fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: 'Roboto',
                                                    color: CustomColors
                                                        .clrborder)),
                                          ]
                                      )
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Save
                        SizedBox(width: screenWidth * 0.02),
                        GestureDetector(
                          onTap: () {

                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: CustomColors.clrborder)
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.03,
                                    vertical: screenWidth * 0.01),
                                child: Row(
                                  children: [

                                    const ImageIcon(NetworkImage(
                                        "https://s3-alpha-sig.figma.com/img/5ce0/8ba6/4426d51f34982c229b8af153e09db863?Expires=1720396800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=GUAPQ~w7qvx~pfUOY7II3HwehDzUF-SL~-gDOoyxGn0884YzCIYCkJ~Jv7~WFdOvWfiPlGRyzKuo2mrF0Yn9TEmXywya1F6liQgFrpnKweE4ocQrD7bCLV5-rZASxqihjVrUa3W7wZa0onMURlLzMP~jZOKAjch8FyB~1bIP8ati77ccLVEat33CjUeMpAcepnxM~BoNrre7zQSsJUYY8dIoM6Art0zbf-bKx91pCDTniBOqTXojqA3n~d4EsRawq8DPeh-YOKvLe~sjsNsRXZVkJmtux2FmOOwFzTcVzBConK1SJ0i0GhugBrxDDHBrj06vI9aPWptSMdzw7ksCWA__"),
                                      color: CustomColors.clrborder,),
                                    SizedBox(width: screenWidth * 0.02),
                                    const Text("Save", style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Roboto',
                                        color: CustomColors.clrborder),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                // Playlist

                Flexible(
                  child: ListView.builder(
                    // itemCount: videocategory.length,
                    itemCount: 10,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.only(left: screenWidth * 0.04,
                        bottom: screenHeight * 0.02,
                        right: screenWidth * 0.04),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          switch (index) {
                          //case 0: Navigator.push(context, MaterialPageRoute(builder: (context) => Videomovies(),));

                          //case 1: Navigator.push(context, MaterialPageRoute(builder: (context) => Videobhajan(),));

                          //case 2: Navigator.push(context, MaterialPageRoute(builder: (context) => Videoserials(),));

                          //case 4: Navigator.push(context, MaterialPageRoute(builder: (context) => Videobhajan(),));

                          //  case 5: Navigator.push(context, MaterialPageRoute(builder: (context) => Videobhajan(),));

                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenWidth * 0.02),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: CustomColors.clrskyblue
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.03,
                                      vertical: screenWidth * 0.03),
                                  child: Container(
                                    height: screenHeight * 0.1,
                                    width: screenWidth * 0.4,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: NetworkImage(""),
                                            fit: BoxFit.cover)
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: screenWidth * 0.03,
                                      horizontal: screenWidth * 0.01),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(width: screenWidth * 0.4,
                                          child: Text("Sampurn Ramayan",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: CustomColors.clrblack,
                                                fontFamily: 'Roboto',
                                                overflow: TextOverflow
                                                    .ellipsis), maxLines: 1,)),

                                      SizedBox(
                                        width: screenWidth * 0.4,
                                        child: const Text.rich(
                                            TextSpan(
                                                children: [

                                                  TextSpan(text: "Episodes:-",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .w500,
                                                          fontSize: 14,
                                                          color: CustomColors
                                                              .clrborder,
                                                          fontFamily: 'Roboto',
                                                          overflow: TextOverflow
                                                              .ellipsis)),
                                                  TextSpan(text: "1",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .w500,
                                                          fontSize: 14,
                                                          color: CustomColors
                                                              .clrborder,
                                                          fontFamily: 'Roboto',
                                                          overflow: TextOverflow
                                                              .ellipsis))

                                                ]
                                            )
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> getVideoData(int subcategoryId) async {
    final url = 'https://dev-mahakal.rizrv.in/api/v1/astro/get-by-youtube-category/$subcategoryId';
    final res = await ApiService().getVideo(url);
    print(res);
  }

}
