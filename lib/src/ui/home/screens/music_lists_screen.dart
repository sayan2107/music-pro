import 'package:pro_music/generated/i18n.dart';
import 'package:pro_music/src/data/model/home/music_data/music_model.dart';
import 'package:pro_music/src/ui/home/bloc/music_bloc.dart';
import 'package:flutter/material.dart';
import 'package:pro_music/src/base/ui_event.dart';
import 'package:pro_music/src/infra/bloc/bloc_provider.dart';
import 'package:pro_music/src/infra/bloc/event_listener.dart';
import 'package:pro_music/src/ui/common/widgets/widget_mixin.dart';
import 'package:pro_music/src/ui/home/widgets/music_list_item_widget.dart';

class MusicListsScreen extends StatelessWidget {
  static const ROUTE_NAME = "/music_lists_screen_route";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: MusicBloc(),
      child: _MusicListsScreenInternal(),
    );
  }
}

class _MusicListsScreenInternal extends StatefulWidget {

  _MusicListsScreenInternal();

  @override
  _MusicListsScreenState createState() =>
      _MusicListsScreenState();
}

class _MusicListsScreenState extends State<_MusicListsScreenInternal> with CommonWidget{
  GlobalKey<ScaffoldState> _scafoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    //Fetch all music data from the network
    BlocProvider.of<MusicBloc>(context).getMusicData();
    return EventListener(
      BlocProvider
          .of<MusicBloc>(context)
          .uiEventStream,
      handleEvent,
      child: Scaffold(
        key: _scafoldKey,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Center(child: Text(S.of(context).text_music_list)),
//          leading: IconButton(
//            icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
//            onPressed: () => Navigator.pop(context),
//          ),
        ),
        body: StreamBuilder<MusicDataResponse>(
          stream: BlocProvider
              .of<MusicBloc>(context)
              .musicStream,
          builder:(BuildContext context, AsyncSnapshot<MusicDataResponse> snapshot)  {
            if(snapshot.hasError){
             return Container(
                 child: Text(S.of(context).text_something_went_wrong, style: TextStyle(color: Colors.red),)
              );
            }
            List<Results> musicLists = snapshot.data?.feed?.results;
             if(musicLists?.length==0){
                return Container(child: Text(S.of(context).text_nothing_found));
             }
             return ListView.builder(
                 itemCount: musicLists?.length,
                 itemBuilder: (BuildContext context, int index) {
                   return MusicListItemWidget(musicLists[index]);
                 });
          },
        )
      ),
    );
  }

  onClickGoToMusicDetails(Results musicItem){
    BlocProvider.of<MusicBloc>(context).redirectToMusicDetails(musicItem);
  }


  void handleEvent(UIEvent uiEvent) {
    if (uiEvent != null) {
      if (uiEvent is SnackBarEvent) {
        SnackBarEvent sbe = uiEvent;
        _scafoldKey.currentState.showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(milliseconds: 1500),
          content: Text(sbe.message),
        ));
      }else if(uiEvent is LoadingScreenUiEvent) {
        LoadingScreenUiEvent loading = uiEvent;
        if(loading.isVisible) {
          showLoader(context);
        }else {
          hideLoader(context);
        }
      }
    }
  }

}
