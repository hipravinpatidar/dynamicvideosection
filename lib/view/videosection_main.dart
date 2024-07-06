import 'dart:convert';
import 'package:dynamicvideosection/view/Gridview_data.dart';
import 'package:dynamicvideosection/view/Listview_data.dart';
import 'package:dynamicvideosection/view/videos_data.dart';
import 'package:flutter/material.dart';
import '../model/categories_model.dart';
import '../model/subcategory_model.dart';
import '../ui_helper/custom_colors.dart';
import '../utils/api_service.dart';

class VideoSectionMain extends StatefulWidget {
  const VideoSectionMain({super.key});

  @override
  State<VideoSectionMain> createState() => _VideoSectionMainState();
}

class _VideoSectionMainState extends State<VideoSectionMain> {

  var category = <CategoriesModel>[];
  var subcategory = <KathaModel>[];

  bool _isGridView = true;

  String _search = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    getCategoryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder(
      future: getCategoryData(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return SafeArea(
            child: DefaultTabController(
              //length: category.length,
              length: category.where((element) => element.name!.toLowerCase().contains(_search.toLowerCase())).toList().length,
              child: Scaffold(

                appBar: PreferredSize(
                  preferredSize: Size(screenWidth * 0.01, screenWidth * 0.40),
                  child: AppBar(
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    backgroundColor: Colors.white,
                    title: const Text("Video", style: TextStyle(fontWeight: FontWeight.w600, color: CustomColors.clrorange, fontSize: 24, fontFamily: 'Roboto'),),
                    centerTitle: true,
                    leading: const Icon(
                        Icons.arrow_back, color: CustomColors.clrblack, size: 24),
                    flexibleSpace: Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.03, top:screenWidth * 0.15),

                      child: Row(
                        children: [
                          Container(
                              height: screenHeight * 0.06,
                              width: screenWidth * 0.7,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: CustomColors.clrgreydark, width: 0.8),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(
                                child: TextField(
                                  controller: _searchController,
                                  onChanged: (value) {
                                    setState(() {
                                      _search = value;
                                    });
                                  },

                                  decoration: InputDecoration(
                                      hintText: "Search",
                                      border: InputBorder.none,
                                      labelStyle: TextStyle(fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Roboto'),
                                      prefixIcon: Icon(Icons.search)
                                  ),
                                ),
                              )
                          ),

                          SizedBox(width: screenWidth * 0.03,),
                          Container(
                            height: screenHeight * 0.06,
                            width: screenWidth * 0.2,
                            decoration: BoxDecoration(
                              color: CustomColors.clrgreydark,
                              borderRadius: BorderRadius.circular(10),
                            ),

                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _isGridView = true;
                                        });
                                      },
                                      child: Container(
                                        height: screenHeight * 0.04,
                                        width: screenWidth * 0.08,
                                        decoration: BoxDecoration(
                                          color: _isGridView ? CustomColors.clrwhite
                                              : null,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: ImageIcon(NetworkImage("https://cdn0.iconfinder.com/data/icons/rounded-basics/24/svg-rounded_list-512.png"),
                                            color: _isGridView ? CustomColors.clrorange: Colors.black),
                                      )
                                  ),
                                  const SizedBox(width: 8,),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _isGridView = false;
                                        });
                                      },
                                      child: Container(
                                        height: screenHeight * 0.04,
                                        width: screenWidth * 0.08,
                                        decoration: BoxDecoration(
                                          color: _isGridView
                                              ? null
                                              : Colors.white,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: ImageIcon(
                                            const AssetImage("assets/image/iconcube.png"),
                                            color: _isGridView
                                                ? CustomColors.clrblack
                                                : CustomColors.clrorange),
                                      )
                                   ),
                                  ]
                                 ),
                               ),
                             ],
                          ),
                        ),

                    // Category Data

                    bottom: TabBar(
                      dividerColor: Colors.transparent,
                      unselectedLabelColor: Colors.grey,
                      labelColor: Colors.black,
                      tabAlignment: TabAlignment.start,
                      indicatorColor: Colors.orange,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 18),
                      labelStyle: const TextStyle(fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto'),
                      indicatorSize: TabBarIndicatorSize.tab,
                      isScrollable: true,
                       // tabs: List.generate(category.length, (int index)=> Tab(text: category[index].name)),
                      tabs: List.generate(category.where((element) => element.name!.toLowerCase().contains(_search.toLowerCase())).toList().length, (int index)=> Tab(text: category.where((element) => element.name!.toLowerCase().contains(_search.toLowerCase())).toList()[index].name)),

                    ),
                  ),
                ),

                // My SubCategory Data

                body:  TabBarView(
               // children: category.map((category) {
                  children: category.where((element) => element.name!.toLowerCase().contains(_search.toLowerCase())).toList().map((category) {
                    return FutureBuilder(
                future: getSubcategoryData(category.id),
                builder: (context, snapshot) {
                if (snapshot.hasData) {
                List<KathaModel> subcategory = snapshot.data!;
               return _isGridView ? ListviewData(subcategory: subcategory,onButtonClicked: ( KathaModel subcategory){
                 print(subcategory.id);
                 Navigator.push(context, MaterialPageRoute(builder:(context)=> VideosData(categoryName: category.name,subcategoryId: subcategory.id,)));


               },) : GridviewData(subcategory: subcategory,onButtonClicked: ( KathaModel subcategory){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => VideosData(categoryName: category.name,subcategoryId: subcategory.id,),));
               },);

               } else {
               return const Center(child: CircularProgressIndicator());
                 }
                },
               );
              }).toList(),
              ),
              ),
            ));
          },
        );
     }

  // Category API

  Future getCategoryData() async {
    final res = await ApiService().getCategory('https://dev-mahakal.rizrv.in/api/v1/astro/youtube/video/category');
    List cdata = res['videoCategory'];
    category = categoriesModelFromJson(jsonEncode(cdata));
  }

  // SubCategory API

  Future<List<KathaModel>> getSubcategoryData(int categoryId) async {
    final url = 'https://dev-mahakal.rizrv.in/api/v1/astro/get-by-youtube-category/$categoryId';
    final res = await ApiService().getSubcategory(url);
    return kathaModelFromJson(jsonEncode(res));
  }
}
