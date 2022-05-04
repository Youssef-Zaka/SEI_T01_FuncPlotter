import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'package:eval_ex/expression.dart';

class Graph extends StatefulWidget {
  const Graph(
      {Key? key, required this.start, required this.end, required this.exp})
      : super(key: key);

  final double start, end;
  final String exp;

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  @override
  Widget build(BuildContext context) {
    List<Data> data = [];
    Expression exp = Expression(widget.exp);

    //calculate step size as a fraction of the range
    double step = (widget.end - widget.start).abs() / 2000;

    for (double i = widget.start; i <= widget.end; i += step) {
      try {
        exp.setStringVariable('x', i.toString());
        var y = exp.eval()?.toDouble();
        if (y != null) {
          if (y.isNaN) {
            y = 0;
          }
        }
        data.add(Data(i, y ?? 0));
      } catch (e) {
        // print(e);
      }
    }

    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth * 0.9,
            height: MediaQuery.of(context).size.height * 0.6,
            color: Colors.blueGrey.shade100,
            child: SfCartesianChart(
              primaryXAxis: NumericAxis(),
              primaryYAxis: NumericAxis(),
              zoomPanBehavior: ZoomPanBehavior(
                enablePanning: true,
                enableMouseWheelZooming: true,
              ),
              series: <LineSeries<Data, double>>[
                LineSeries<Data, double>(
                    // Bind data source
                    dataSource: data.isNotEmpty ? data : [Data(0, 0)],
                    xValueMapper: (Data d, _) => d.x,
                    yValueMapper: (Data d, _) => d.y)
              ],
            ),
          );
        },
      ),
    );
  }
}

class Data {
  Data(this.x, this.y);
  final double x;
  final double y;
}
