import 'package:corona_user/models/chartHTTP.dart';
import 'package:corona_user/models/statewise.dart';
import 'package:corona_user/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StateDetailsPage extends StatefulWidget {
  StateDetailsPage({this.data});

  final Map data;

  @override
  State<StatefulWidget> createState() {
    return StateDetailsPageState();
  }
}

class StateDetailsPageState extends State<StateDetailsPage> {
  Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  TextEditingController _textEditingController = TextEditingController();
  String searchKeyWord = "";

  @override
  Widget build(BuildContext context) {
    //var chartData = widget.data;
    var data = widget.data["statewise"].sublist(1);
    final List<StateWise> chartData = [];
    widget.data["statewise"].sublist(1, 11).forEach((element) {
      chartData.add(StateWise(
          active: element['active'], stateCode: element['statecode']));
    });
    return Scaffold(
        backgroundColor: Color.fromRGBO(210, 34, 45, 0.7),
        body: CustomScrollView(slivers: [
          SliverAppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Color.fromRGBO(210, 34, 45, 1),
              expandedHeight: 230,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.all(0),
                // title: ,
                background: Container(
                  height: 230,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>[
                      Chart(
                        data: chartData,
                        title: 'Top 10 Affected States',
                      ),
                      Positioned(
                        right: MediaQuery.of(context).padding.right + 30,
                        top: MediaQuery.of(context).padding.top + 30,
                        child: FloatingActionButton(
                            child: Icon(Icons.zoom_out_map),
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    ),
                                  ),
                                  builder: (ctx) {
                                    return Container(
                                      height: 500,
                                      child: Padding(
                                        padding: const EdgeInsets.all(30.0),
                                        child: Image.network(
                                          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/India_COVID-19_cases_density_map.svg/768px-India_COVID-19_cases_density_map.svg.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  });
                            }),
                      ),
                    ],
                  ),
                ),
              )),
          SliverAppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Color.fromRGBO(210, 34, 45, 1),
            pinned: true,
            actions: <Widget>[],
            actionsIconTheme: IconThemeData(),
            title: Padding(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                height: 0.07 * MediaQuery.of(context).size.height,
                child: TextField(
                  controller: _textEditingController,
                  cursorColor: Colors.white70,
                  // autofocus: true,
                  enableInteractiveSelection: true,
                  enableSuggestions: true,
                  textAlign: TextAlign.center,
                  showCursor: true,
                  cursorRadius: Radius.circular(50),
                  //cursorWidth: 5,
                  decoration: InputDecoration(
                    labelStyle: GoogleFonts.quicksand(color: Colors.white),
                    labelText: "Search State",
                    fillColor: Colors.grey[900],
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(width: 2, color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(width: 2, color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(width: 3, color: Colors.white70),
                    ),
                  ),
                  style: GoogleFonts.quicksand(
                    color: Colors.white,
                    fontSize: 17,
                    //fontWeight: FontWeight.w500,
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchKeyWord = value.toLowerCase();
                    });
                  },
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (!(searchKeyWord.trim() == "" ||
                  data[index]["state"].toLowerCase().contains(searchKeyWord)))
                return Container();

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Card(
                  elevation: 10,
                  color: Color.fromRGBO(210, 34, 45, 1),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          data[index]["state"],
                          style: GoogleFonts.quicksand(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Confirmed",
                              style: GoogleFonts.quicksand(
                                fontSize: 17,
                                color: Colors.white70,
                              ),
                            ),
                            Text(
                              "${data[index]["confirmed"]}",
                              style: GoogleFonts.quicksand(
                                color: Colors.white70,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Active",
                              style: GoogleFonts.quicksand(
                                fontSize: 17,
                                color: Colors.white70,
                              ),
                            ),
                            Text(
                              "${data[index]["active"]}",
                              style: GoogleFonts.quicksand(
                                color: Colors.white70,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Recovered",
                              style: GoogleFonts.quicksand(
                                fontSize: 17,
                                color: Colors.white70,
                              ),
                            ),
                            Text(
                              "${data[index]["recovered"]}",
                              style: GoogleFonts.quicksand(
                                color: Colors.white70,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Deaths",
                              style: GoogleFonts.quicksand(
                                fontSize: 17,
                                color: Colors.white70,
                              ),
                            ),
                            Text(
                              "${data[index]["deaths"]}",
                              style: GoogleFonts.quicksand(
                                color: Colors.white70,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            childCount: widget.data["statewise"].length - 1,
          ))
        ]));
  }
}
