import 'package:flutter/cupertino.dart';
import 'package:pro_music/src/data/model/home/music_data/music_model.dart';
import 'package:pro_music/src/ui/home/screens/music_details_screen.dart';
import 'package:pro_music/src/utility/asset_constants.dart';
import 'package:pro_music/src/utility/color_constants.dart';

class MusicListItemWidget extends StatelessWidget {
  final Results _result;
  MusicListItemWidget(this._result);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(MusicDetailsScreen.ROUTE_NAME, arguments: _result);
        },
        child: Container(
          height: 150,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SafeArea(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: ColorConstants.light_gold,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                            width: 1,
                            color: ColorConstants.input_bg_color_dark)),
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 118.0, top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            _result?.kind.toUpperCase(),
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            _result?.name,
                            // style: widget.themeData.textTheme.body1,
                            overflow: TextOverflow.ellipsis,
                          ),

                          Text(
                            _result?.artistName,
                            // style: widget.themeData.textTheme.body1,
                            overflow: TextOverflow.ellipsis,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 8,
                child: Hero(
                  tag: '${_result?.id}',
                  child: SizedBox(
                    width: 100,
                    height: 125,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: FadeInImage(
                        image: NetworkImage(_result?.artworkUrl100),
                        fit: BoxFit.cover,
                        placeholder:
                        AssetImage(AssetConstants.ic_loading),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
