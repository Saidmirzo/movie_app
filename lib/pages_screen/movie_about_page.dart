// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:move_app/domain/models/about_movie_model.dart';
// import 'package:move_app/domain/models/movie_model.dart';
// import 'package:move_app/domain/providers/main_provider.dart';
// import 'package:move_app/domain/utils/const.dart';
// import 'package:provider/provider.dart';

// import '../domain/widgets/widgets.dart';

// class MovieDetailsPage extends StatelessWidget {
//   MovieDetailsPage(this.id, {Key? key}) : super(key: key);

//   MovieModel id;

//   late AboutMovieModel detail;

//   @override
//   Widget build(BuildContext context) {
//     var screenSize = MediaQuery.of(context).size;
//     return Consumer<MainProvider>(builder: (context, provider, child) {
//       if (provider.isLoad['loadAbout'] == false) provider.getMovieAbout(id.id!);
//       return Scaffold(
//         body: provider.isLoad['loadAbout'] == true
//             ? SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Stack(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 240.0),
//                           child: ClipPath(
//                             clipper: ArcClipper(),
//                             child: Image.network(
//                               "https://image.tmdb.org/t/p/w500/${id.backdropPath}",
//                               width: screenSize.width,
//                               height: 230.0,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           bottom: 32.0,
//                           left: 16.0,
//                           right: 16.0,
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(bottom: 70.0),
//                                 child: Material(
//                                   borderRadius:  BorderRadius.circular(4.0),
//                                   elevation: 2.0,
//                                   child: Image.network(
//                                     "https://image.tmdb.org/t/p/w500/${id.posterPath}",
//                                     fit: BoxFit.cover,
//                                     width: 140,
//                                     height: 200,
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(left: 16.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(top: 16.0),
//                                         child: Text(
//                                           id.originalTitle!,
//                                           style: sTextStyle(
//                                               color: Colors.black, size: 18),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(top: 8.0),
//                                         child: Row(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.end,
//                                           children: <Widget>[
//                                             Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Text(
//                                                   id.voteAverage.toString(),
//                                                   style: sTextStyle(
//                                                       fontWeight:
//                                                           FontWeight.w400,
//                                                       color: Colors.black),
//                                                 ),
//                                                 Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           top: 4.0),
//                                                   child: Text(
//                                                     'Ratings',
//                                                     style: sTextStyle(
//                                                         color: Colors.grey,
//                                                         size: 14),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 16.0),
//                                               child: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: <Widget>[
//                                                   // _buildRatingBar(theme),
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             top: 4.0,
//                                                             left: 4.0),
//                                                     child: Text(
//                                                       'Grade now',
//                                                       style: sTextStyle(
//                                                           color: Colors.grey,
//                                                           size: 14),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       // Padding(
//                                       //   padding:
//                                       //       const EdgeInsets.only(top: 12.0),
//                                       //   child: Wrap(
//                                       //     spacing: 8.0,
//                                       //     runSpacing: 4.0,
//                                       //     direction: Axis.horizontal,
//                                       //     children:
//                                       //         _buildCategoryChips(textTheme),
//                                       //   ),
//                                       // )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(0.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding:
//                                 const EdgeInsets.only(top: 8.0, left: 16.0),
//                             child: Text(
//                               'Synopsis',
//                               style: sTextStyle(color: Colors.black, size: 18),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(
//                                 top: 8.0, left: 16.0, right: 16.0),
//                             child: Text(
//                               id.overview!,
//                               style:
//                                   sTextStyle(color: Colors.black45, size: 16.0),
//                             ),
//                           ),
//                           // No expand-collapse in this tutorial, we just slap the "more"
//                           // button below the text like in the mockup.
//                           Padding(
//                             padding:
//                                 const EdgeInsets.only(left: 16.0, right: 16.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Text(
//                                   'more',
//                                   style: sTextStyle(
//                                       size: 16.0, color: Colors.black),
//                                 ),
//                                 const Icon(
//                                   Icons.keyboard_arrow_down,
//                                   size: 18.0,
//                                   color: Colors.black,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(
//                         top: 20.0,
//                         bottom: 50.0,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 16.0),
//                             child: Text(
//                               'Production Companies',
//                               style:
//                                   sTextStyle(size: 18.0, color: Colors.black),
//                             ),
//                           ),
//                           // SizedBox.fromSize(
//                           //   size: const Size.fromHeight(120.0),
//                           //   child: ListView.builder(
//                           //     itemCount: 2,
//                           //     scrollDirection: Axis.horizontal,
//                           //     padding:
//                           //         const EdgeInsets.only(top: 12.0, left: 20.0),
//                           //     itemBuilder: _buildCompanies,
//                           //   ),
//                           // ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             : const Center(
//                 child: CircularProgressIndicator(),
//               ),
//       );
//     });
//   }
// }
