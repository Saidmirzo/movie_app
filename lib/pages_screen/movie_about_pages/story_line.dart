import 'package:flutter/material.dart';
import 'package:move_app/domain/utils/const.dart';

class StoryLine extends StatelessWidget {
  StoryLine(this.storyline);

  final String storyline;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = Theme.of(context).textTheme;

    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 16.0),
          child:  Text(
            'Synopsis',
            style: sTextStyle(size: 18.0, color: Colors.black),
          ),
        ),
         Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
          child:  Text(
            storyline,
            style:
                sTextStyle(color: Colors.black45, size: 16.0),
          ),
        ),
        // No expand-collapse in this tutorial, we just slap the "more"
        // button below the text like in the mockup.
         Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
               Text(
                'more',
                style: sTextStyle(size: 16.0, color: Colors.black),
              ),
              const  Icon(
                Icons.keyboard_arrow_down,
                size: 18.0,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
