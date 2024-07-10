import 'dart:async';
import 'dart:convert';
import 'package:dynamicvideosection/model/videocategory_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../ui_helper/custom_colors.dart';
import '../utils/api_service.dart';

class YoutubeScreen extends StatefulWidget {
  const YoutubeScreen({super.key,required this.subcategoryId,required this.categoryName});

  final String categoryName;
  final int subcategoryId;

  @override
  State<YoutubeScreen> createState() => _YoutubeScreenState();
}

class _YoutubeScreenState extends State<YoutubeScreen> {
  late YoutubePlayerController youtubePlayerController;
  late YoutubeMetaData videoMetaData;
  var isPlayerReady = false;
  var isLoading = false;

  List<VideoModel> videoCategory = [];

  Timer? _loadingTimer;

  Future<void> getVideoData(int subcategoryId) async {
    isLoading = true;
    _loadingTimer = Timer(const Duration(seconds: 5), () {
      if (isLoading) {
        _showNoVideosAvailableDialog();
      }
    });
    final url = 'https://dev-mahakal.rizrv.in/api/v1/astro/getVideosBySubcategory/$subcategoryId';
    final response = await ApiService().getVideo(url);
    videoCategory = videoModelFromJson(jsonEncode(response['data']));
    if (videoCategory.isEmpty) {
      _showNoVideosAvailableDialog();
    } else {
      final videoID = YoutubePlayer.convertUrlToId(videoCategory[0].url);
      videoMetaData = const YoutubeMetaData();
      youtubePlayerController = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: const YoutubePlayerFlags(
          useHybridComposition: true,
          mute: false,
          autoPlay: true,
        ),
      )..addListener(listener);
      isLoading = false;
      setState(() {});
    }
    _loadingTimer?.cancel();
  }

  @override
  void initState() {
    getVideoData(widget.subcategoryId);
    super.initState();
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: '',
      flags: const YoutubePlayerFlags(
        useHybridComposition: true,
        mute: false,
        autoPlay: true,
      ),
    );
  }

  void listener() {
    if (isPlayerReady && mounted && !youtubePlayerController.value.isFullScreen) {
      setState(() {
        videoMetaData = youtubePlayerController.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    youtubePlayerController.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    youtubePlayerController.dispose();
    super.dispose();
  }

   _showNoVideosAvailableDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shadowColor: Colors.black,
          backgroundColor: CustomColors.clrwhite,
          title: const Text('No Videos Available'),
          content: const Text('Sorry, no videos are available for this category.'),
          actions: [
            ElevatedButton(
              child: const Text('Go Back',style: TextStyle(color: CustomColors.clrblack),),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: CustomColors.clrwhite,
            appBar: AppBar(
              title: Text(widget.categoryName, style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                  color: CustomColors.clrorange),),
              //centerTitle: true,
              leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back, color: CustomColors.clrblack,)),
            ),
            body: SafeArea(
              child: isLoading
                ? const Center(child: CircularProgressIndicator(color: Colors.red,),)
              : YoutubePlayerBuilder(
                onExitFullScreen: () {
                  // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
                  SystemChrome.setPreferredOrientations(
                      DeviceOrientation.values);
                },
                player: YoutubePlayer(controller: youtubePlayerController),
                builder: (BuildContext context, Widget wid) {
                  return Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: YoutubePlayer(
                            thumbnail: Image.network("https://dev-mahakal.rizrv.in/storage/app/public/video-img/${videoCategory[0].image}"),
                            controller: youtubePlayerController,
                            showVideoProgressIndicator: true,
                            onReady: () {
                              isPlayerReady = true;
                              print('Player is ready.');
                            },
                          ),
                        ),
                      ),

                      Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(7),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Theme
                                  .of(context)
                                  .primaryColor
                                  .withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text(widget.categoryName, style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold,color: CustomColors.clrorange),)),

                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 3.0,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 20,
                                crossAxisCount: 1,
                              ),
                              itemCount: videoCategory.length,
                              //itemCount: 5,
                              itemBuilder: (BuildContext ctx, int index) {
                                return InkWell(
                                  onTap: () {
                                    youtubePlayerController.load(
                                        YoutubePlayer.convertUrlToId(videoCategory[index].url)!);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade600),
                                        borderRadius: BorderRadius.circular(
                                            10)),
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                              BorderRadius.circular(7),
                                              image: DecorationImage(
                                                  image: NetworkImage("https://dev-mahakal.rizrv.in/storage/app/public/video-img/${videoCategory[index].image}"),
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, top: 5, bottom: 5),
                                            child: Text(videoCategory[index].name,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight
                                                      .w500),),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          );
  }

}

