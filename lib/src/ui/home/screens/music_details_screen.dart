import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:pro_music/src/data/model/home/music_data/music_model.dart';
import 'package:pro_music/src/infra/bloc/bloc_provider.dart';
import 'package:pro_music/src/ui/common/utils/text_utils.dart';
import 'package:pro_music/src/ui/home/bloc/music_bloc.dart';
import 'package:pro_music/src/utility/asset_constants.dart';
import 'package:pro_music/src/utility/color_constants.dart';

class MusicDetailsScreen extends StatelessWidget {
  static const ROUTE_NAME = "/music_details_screen_route";
  final Results _result;
  MusicDetailsScreen(this._result);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: MusicBloc(),
      child: _MusicDetailsScreenInternal(_result),
    );
  }
}


class _MusicDetailsScreenInternal extends StatefulWidget {
  final Results _result;
  _MusicDetailsScreenInternal(this._result);

  @override
  _MusicDetailsScreenState createState() =>
      _MusicDetailsScreenState(_result);
}

class _MusicDetailsScreenState extends State<_MusicDetailsScreenInternal> {
  final Results _result;
  _MusicDetailsScreenState(this._result);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    TextUtils.isEmpty(_result.artistUrl)
                        ? Image.asset(
                      AssetConstants.ic_nothing_found,
                      fit: BoxFit.cover,
                    )
                        : FadeInImage(
                      width: double.infinity,
                      height: double.infinity,
                      image: NetworkImage(_result.artworkUrl100),
                      fit: BoxFit.cover,
                      placeholder:
                      AssetImage(AssetConstants.ic_loading),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: ColorConstants.light_gold,
                ),
              )
            ],
          ),
          Column(
            children: <Widget>[
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: ColorConstants.input_bg_color,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: Stack(
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 220, 0, 0),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            color: ColorConstants.light_gold,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 120.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[

                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Flexible(
                                                fit: FlexFit.loose,
                                                child: Text(
                                                  _result.name,
                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                  maxLines: 3,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, bottom: 4.0),
                                              child: Text(
                                                'Artist : ${_result.artistName}',
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                            ),

                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, bottom: 4.0),
                                              child: Text(
                                                'Release Date : ${_result.releaseDate}',
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, bottom: 4.0),
                                              child: Text(
                                                'Tags:',
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                          width: double.infinity,
                                          height: 50,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: _result.genres.length,
                                            physics: AlwaysScrollableScrollPhysics(),
                                            itemBuilder: (BuildContext context, int index){
                                              return Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(
                                                  color: ColorConstants.input_border_color,
                                                  height: 30,
                                                  width: 100,
                                                  child: Center(child: Text( _result.genres[index].name)),
                                                ),
                                              );
                                            },
                                          ),
                                        )

                                      ],
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
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
