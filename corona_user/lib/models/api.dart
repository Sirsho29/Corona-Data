import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:fl_animated_linechart/chart/animated_line_chart.dart';
import 'package:fl_animated_linechart/chart/line_chart.dart';
import 'package:flutter/material.dart';

class EachChart extends StatefulWidget {
  final String type;
  final String name;
  final Color color;
  EachChart({
    @required this.type,
    @required this.name,
    @required this.color,
  });
  @override
  _EachChartState createState() => _EachChartState();
}

class _EachChartState extends State<EachChart> {
  List data = [];

  final months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  Future<String> getData() async {
    var response = await http.get(
      Uri.encodeFull('https://api.covid19india.org/data.json'),
      //headers: {"Accept": "application/json"},
    );
    //print(response.body);
    setState(() {
      var dataFromJson = jsonDecode(response.body);
      data = dataFromJson['cases_time_series'];
    });
    //print(data);
    return "Success";
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Map<DateTime, double> createLine() {
    Map<DateTime, double> fdata = {};
    for (int i = 0; i < data.length; i++) {
      fdata.addAll({
        DateTime.parse((months.indexOf(data[i]['date'].trim().split(' ')[1])) <
                10
            ? '20200${months.indexOf(data[i]['date'].trim().split(' ')[1]) + 1}${data[i]['date'].trim().split(' ')[0]}'
            : '2020${months.indexOf(data[i]['date'].trim().split(' ')[1]) + 1}${data[i]['date'].trim().split(' ')[0]}'): int
                .parse(data[i][widget.type])
            .toDouble(),
      });
    }
    //print(fdata);
    return fdata;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 40, 20, 20),
      child: Container(
        height: 400,
        child: AnimatedLineChart(
          LineChart.fromDateTimeMaps([
            createLine()
          ], [
            widget.color,
          ], [
            widget.name,
          ], tapTextFontWeight: FontWeight.bold),
          key: UniqueKey(),
        ),
      ),
    );
  }
}
