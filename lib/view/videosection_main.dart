// import 'dart:convert';
// import 'package:flutter/material.dart';
// import '../model/categories_model.dart';
// import '../model/subcategory_model.dart';
// import '../ui_helper/custom_colors.dart';
// import '../utils/api_service.dart';
// import '../view/Gridview_data.dart';
//
// class VideosectionMain extends StatefulWidget {
//   const VideosectionMain({super.key});
//
//   @override
//   State<VideosectionMain> createState() => _VideosectionMainState();
// }
//
// class _VideosectionMainState extends State<VideosectionMain> with TickerProviderStateMixin {
//   var category = <CategoriesModel>[];
//   bool _isGridView = true;
//
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     getCategoryData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var screenheight = MediaQuery.of(context).size.height;
//     var screenwidth = MediaQuery.of(context).size.width;
//
//     return FutureBuilder(
//       future: getCategoryData(),
//       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }
//
//         if (snapshot.hasError) {
//           return Scaffold(
//             body: Center(child: Text('Error: ${snapshot.error}')),
//           );
//         }
//
//         return DefaultTabController(
//           length: category.length,
//           child: Scaffold(
//             appBar: PreferredSize(
//               preferredSize: Size(screenwidth * 0.01, screenwidth * 0.38),
//               child: AppBar(
//                 backgroundColor: Colors.white,
//                 title: const Text(
//                   "Video",
//                   style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       color: CustomColors.clrorange,
//                       fontSize: 24,
//                       fontFamily: 'Roboto'),
//                 ),
//                 centerTitle: true,
//                 leading: const Icon(Icons.arrow_back, color: CustomColors.clrblack, size: 24),
//                 flexibleSpace: Padding(
//                   padding: EdgeInsets.only(left: screenwidth * 0.03, top: screenwidth * 0.15),
//                   child: Row(
//                     children: [
//                       Container(
//                         height: screenheight * 0.06,
//                         width: screenwidth * 0.7,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: CustomColors.clrgreydark, width: 0.8),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Center(
//                           child: TextField(
//                             decoration: InputDecoration(
//                               hintText: "Search",
//                               border: InputBorder.none,
//                               labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Roboto'),
//                               prefixIcon: Icon(Icons.search),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: screenwidth * 0.03),
//                       Container(
//                         height: screenheight * 0.06,
//                         width: screenwidth * 0.2,
//                         decoration: BoxDecoration(
//                           color: CustomColors.clrgreydark,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   _isGridView = true;
//                                 });
//                               },
//                               child: Container(
//                                 height: screenheight * 0.04,
//                                 width: screenwidth * 0.08,
//                                 decoration: BoxDecoration(
//                                   color: _isGridView ? CustomColors.clrwhite : null,
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 child: ImageIcon(
//                                   NetworkImage("https://cdn0.iconfinder.com/data/icons/rounded-basics/24/svg-rounded_list-512.png"),
//                                   color: _isGridView ? CustomColors.clrorange : Colors.black,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: 8),
//                             GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   _isGridView = false;
//                                 });
//                               },
//                               child: Container(
//                                 height: screenheight * 0.04,
//                                 width: screenwidth * 0.08,
//                                 decoration: BoxDecoration(
//                                   color: !_isGridView ? CustomColors.clrwhite : null,
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 child: ImageIcon(
//                                   AssetImage("assets/image/iconcube.png"),
//                                   color: !_isGridView ? CustomColors.clrorange : CustomColors.clrblack,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 bottom: TabBar(
//                   controller: _tabController,
//                   dividerColor: Colors.transparent,
//                   unselectedLabelColor: Colors.grey,
//                   labelColor: Colors.black,
//                   tabAlignment: TabAlignment.start,
//                   indicatorColor: Colors.orange,
//                   labelPadding: EdgeInsets.symmetric(horizontal: 18),
//                   labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Roboto'),
//                   indicatorSize: TabBarIndicatorSize.tab,
//                   isScrollable: true,
//                   tabs: List.generate(
//                     category.length,
//                         (int index) => Tab(text: category[index].name),
//                   ),
//                 ),
//               ),
//             ),
//             body: TabBarView(
//               controller: _tabController,
//               children: List.generate(
//                 category.length,
//                     (int index) {
//                   final categoryId = category[index].id;
//
//                   return FutureBuilder<List<KathaModel>>(
//                     future: getSubcategoryData(categoryId),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(child: CircularProgressIndicator());
//                       }
//
//                       if (snapshot.hasError) {
//                         return Center(child: Text('Error: ${snapshot.error}'));
//                       }
//
//                       final subcategories = snapshot.data ?? [];
//
//                       return GridviewData(subcategory: subcategories);
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Future<void> getCategoryData() async {
//     final res = await ApiService().getCategory('https://dev-mahakal.rizrv.in/api/v1/astro/youtube/video/category');
//     List cdata = res['videoCategory'];
//     category = categoriesModelFromJson(jsonEncode(cdata));
//
//     // Initialize TabController here after getting categories
//     _tabController = TabController(length: category.length, vsync: this);
//
//     setState(() {});
//   }
//
//   Future<List<KathaModel>> getSubcategoryData(int categoryId) async {
//     final url = 'https://dev-mahakal.rizrv.in/api/v1/astro/get-by-youtube-category/$categoryId';
//     final res = await ApiService().getSubcategory(url);
//     return kathaModelFromJson(jsonEncode(res));
//   }
// }



import 'dart:convert';

import 'package:dynamicvideosection/view/Gridview_data.dart';
import 'package:flutter/material.dart';

import '../model/categories_model.dart';
import '../model/subcategory_model.dart';
import '../ui_helper/custom_colors.dart';
import '../utils/api_service.dart';

class VideosectionMain extends StatefulWidget {
  const VideosectionMain({super.key});

  @override
  State<VideosectionMain> createState() => _VideosectionMainState();
}

class _VideosectionMainState extends State<VideosectionMain> {





  var category = <CategoriesModel>[];
  List<KathaModel> subcategory = [];

  bool _isGridView = true;


  @override
  void initState() {
    getCategoryData();
    setState(() {
      // _tabController = TabController(length: category.length, vsync: this);
      // _tabController = TabController(length: 3, vsync: this);

    });
    // _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;

    return FutureBuilder(
      future: getCategoryData(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return SafeArea(
            child: DefaultTabController(
              length: category.length,
              child: Scaffold(

                appBar: PreferredSize(
                  preferredSize: Size(screenwidth * 0.01, screenwidth * 0.38),
                  child: AppBar(
                    backgroundColor: Colors.white,
                    title: const Text("Video", style: TextStyle(fontWeight: FontWeight.w600, color: CustomColors.clrorange, fontSize: 24, fontFamily: 'Roboto'),),
                    centerTitle: true,
                    leading: const Icon(
                        Icons.arrow_back, color: CustomColors.clrblack, size: 24),
                    flexibleSpace: Padding(
                      padding: EdgeInsets.only(left: screenwidth * 0.03, top:screenwidth * 0.15),

                      child: Row(
                        children: [
                          Container(
                              height: screenheight * 0.06,
                              width: screenwidth * 0.7,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: CustomColors.clrgreydark, width: 0.8),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(
                                child: TextField(
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

                          SizedBox(width: screenwidth * 0.03,),
                          Container(
                            height: screenheight * 0.06,
                            width: screenwidth * 0.2,
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
                                      // child: Icon(Icons.menu,color: _isGridView ? Colors.deepOrange : Colors.black,)
                                      child: Container(
                                        height: screenheight * 0.04,
                                        width: screenwidth * 0.08,
                                        decoration: BoxDecoration(
                                          color: _isGridView ? CustomColors.clrwhite
                                              : null,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: ImageIcon(NetworkImage("https://cdn0.iconfinder.com/data/icons/rounded-basics/24/svg-rounded_list-512.png"),
                                            color: _isGridView ? CustomColors.clrorange: Colors.black),
                                      )
                                  ),
                                  SizedBox(width: 8,),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _isGridView = false;
                                        });
                                      },
                                      child: Container(
                                        height: screenheight * 0.04,
                                        width: screenwidth * 0.08,
                                        decoration: BoxDecoration(
                                          color: _isGridView
                                              ? null
                                              : Colors.white,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: ImageIcon(
                                            AssetImage("assets/image/iconcube.png"),
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

                    bottom: TabBar(

                      //controller: _tabController,
                      dividerColor: Colors.transparent,
                      unselectedLabelColor: Colors.grey,
                      labelColor: Colors.black,
                      tabAlignment: TabAlignment.start,
                      indicatorColor: Colors.orange,
                      labelPadding: EdgeInsets.symmetric(horizontal: 18),
                      labelStyle: TextStyle(fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto'),
                      indicatorSize: TabBarIndicatorSize.tab,
                      isScrollable: true,
                        tabs: List.generate(category.length, (int index)=> Tab(text: category[index].name)),
                    ),
                  ),
                ),


//                 body: FutureBuilder(
//                   future: getSubcategoriesData(),
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData) {
//                       Map<int, List<KathaModel>> subcategories = snapshot.data!;
//                       return DefaultTabController(
//                         length: subcategories.length,
//                         child: Scaffold(
//
//                           appBar: AppBar(
//                             bottom: TabBar(
// isScrollable: true,
// tabs: subcategories.keys.map((id) {
// return Tab(text: 'Ka');
// }).toList(),
// ),
//                           ),
//
//                           body: TabBarView(
//                             children: subcategories.entries.map((entry) {
//                               return GridviewData(subcategory: entry.value);
//                             }).toList(),
//                           ),
//                         ),
//                       );
//                     } else {
//                       return Center(child: CircularProgressIndicator());
//                     }
//                   },
//                 ),


                body:  TabBarView(
                children: category.map((category) {
                return FutureBuilder(
                future: getSubcategoryData(category.id),
                builder: (context, snapshot) {
                if (snapshot.hasData) {
                List<KathaModel> subcategory = snapshot.data!;
               return GridviewData(subcategory: subcategory);
               } else {
               return Center(child: CircularProgressIndicator());
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

  Future getCategoryData() async {
    final res = await ApiService().getCategory('https://dev-mahakal.rizrv.in/api/v1/astro/youtube/video/category');
    // print(res);
    List cdata = res['videoCategory'];
    // print('cdata $cdata');
    category = categoriesModelFromJson(jsonEncode(cdata));
    print(category[0].name);
    // category = cdata.map((e) => CategoriesModel.fromJson(e)).toList();
  }

  // Future getSubcategoryData() async {
  //   final responsedata = await ApiService().getSubcategory('https://dev-mahakal.rizrv.in/api/v1/astro/get-by-youtube-category/42');
  //   //print(responsedata);
  //
  //   subcategory.clear(); // Add this line to clear the list
  //   responsedata.forEach((element) {
  //     subcategory.add(KathaModel.fromJson(element));
  //
  //     print(subcategory);
  //   });
  //
  // }

  // Future<List<KathaModel>> getSubcategoryData(int categoryId) async {
  //   final responsedata = await ApiService().getSubcategory('https://dev-mahakal.rizrv.in/api/v1/astro/get-by-youtube-category/$categoryId');
  //   return kathaModelFromJson(jsonEncode(responsedata));
  // }

  // Future<Map<int, List<KathaModel>>> getSubcategoriesData() async {
  //   List<int> categoryIds = [42, 43, 44, 45,]; // Add the category IDs you want to fetch
  //   Map<int, List<KathaModel>> subcategories = {};
  //
  //   for (int id in categoryIds) {
  //     final responsedata = await ApiService().getSubcategory('https://dev-mahakal.rizrv.in/api/v1/astro/get-by-youtube-category/$id');
  //     List<KathaModel> subcategory = kathaModelFromJson(jsonEncode(responsedata));
  //     subcategories[id] = subcategory;
  //   }
  //
  //   return subcategories;
  // }

  Future<List<KathaModel>> getSubcategoryData(int categoryId) async {
    final url = 'https://dev-mahakal.rizrv.in/api/v1/astro/get-by-youtube-category/$categoryId';
    final res = await ApiService().getSubcategory(url);
    return kathaModelFromJson(jsonEncode(res));
  }

}
// TabBar(
// isScrollable: true,
// tabs: subcategories.keys.map((id) {
// return Tab(text: 'Category $id');
// }).toList(),
// ),
