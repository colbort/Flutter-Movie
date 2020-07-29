import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie/actions/adapt.dart';

import 'state.dart';

Widget buildView(
    PeopleDetailPageState state, Dispatch dispatch, ViewService viewService) {
  var adapter = viewService.buildAdapter();
  return Scaffold(
    //backgroundColor: Colors.grey[100],
    body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          ListView.builder(
            padding: EdgeInsets.only(bottom: Adapt.px(50)),
            itemBuilder: adapter.itemBuilder,
            itemCount: adapter.itemCount,
            physics: state.pageScrollPhysics,
          ),
          SafeArea(
            child: Container(
              margin: EdgeInsets.only(top: 10, right: Adapt.px(30)),
              width: Adapt.px(60),
              height: Adapt.px(60),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.black38),
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.of(viewService.context).pop(),
                icon: Icon(Icons.close),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
