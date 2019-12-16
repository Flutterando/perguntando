import 'package:flutter/material.dart';
import 'package:perguntando/src/home/home_module.dart';
import 'package:perguntando/src/home/pages/event/event_module.dart';
import 'package:perguntando/src/shared/card/card_widget.dart';
import 'package:perguntando/src/shared/models/event/event_model.dart';
import 'package:perguntando/src/shared/widgets/drawer/custom_drawer.dart';
import 'appbar/appbar_widget.dart';
import 'background/background_widget.dart';
import 'bottom/bottom_widget.dart';
import 'home_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _bloc = HomeModule.to.getBloc<HomeBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      body: Stack(
        children: <Widget>[
         const BackgroundWidget(),
          FutureBuilder<List<EventModel>>(
              future: _bloc.events,
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot == null) {
                  return ListView.separated(
                    padding: EdgeInsets.fromLTRB(
                      40,
                      60 + MediaQuery.of(context).viewPadding.top,
                      40,
                      80 + MediaQuery.of(context).viewPadding.bottom,
                    ),
                    itemCount: 6,
                    physics:const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) => const CardShimmer(),
                    separatorBuilder: (_, index) => const SizedBox(height: 25),
                  );
                }

                return ListView.separated(
                  padding: EdgeInsets.fromLTRB(
                    40,
                    60 + MediaQuery.of(context).viewPadding.top,
                    40,
                    80 + MediaQuery.of(context).viewPadding.bottom,
                  ),
                  itemCount: snapshot.data.length,
                  physics:const BouncingScrollPhysics(),
                  itemBuilder: (_, index) {
                    var date = snapshot?.data[index]?.infoDate;

                    return CardWidget(
                      title: snapshot.data[index].title,
                      subtitle:
                          "${snapshot.data[index].city}/${snapshot.data[index].state}",
                      date:
                          "${date.day.toString().padLeft(2, "0")}-${date.month.toString().padLeft(2, "0")}-${date.year}",
                      imageUrl: snapshot.data[index].urlPhoto ??
                          "https://eventostech.com.br/wp-content/uploads/2019/06/flutter-talks-br-eventostech-800x450.jpg",
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return EventModule(snapshot.data[index]);
                        }));
                      },
                    );
                  },
                  separatorBuilder: (_, index) {
                    return const SizedBox(height: 25);
                  },
                );
              }),
        const  Positioned(
            bottom: 0,
            child:  BottomWidget(),
          ),
        const  AppbarWidget(),
        ],
      ),
    );
  }
}
