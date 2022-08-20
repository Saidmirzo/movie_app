import 'package:flutter/material.dart';
import 'package:move_app/domain/utils/const.dart';

import '../../domain/models/about_movie_model.dart';

class ProductionCompaniesScroller extends StatelessWidget {
  ProductionCompaniesScroller(this.productionCompanies);

  final List<ProductionCompanies> productionCompanies;

  Widget _buildCompanies(BuildContext context, int index) {
    var companies = productionCompanies[index];
    return  Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child:  Column(
        children: [
           CircleAvatar(
            backgroundImage:  NetworkImage(companies.logoPath != null
                ? "https://image.tmdb.org/t/p/w500/${companies.logoPath}"
                : "https://i.ibb.co/RPKnckW/ic-launcher-movies.png",
                ),
                
            radius: 35.0,
          ),
           Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child:  Text(companies.name!,),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child:  Text(
            'Production Companies',
            style: sTextStyle(size: 18.0, color: Colors.black),
          ),
        ),
         SizedBox.fromSize(
          size: const Size.fromHeight(120.0),
          child:  ListView.builder(
            itemCount: productionCompanies.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(top: 12.0, left: 20.0),
            itemBuilder: _buildCompanies,
          ),
        ),
      ],
    );
  }
}
