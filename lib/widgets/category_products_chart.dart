import 'package:amazon_clone/model/sales.dart';
import 'package:charts_flutter/flutter.dart' as chart;
import 'package:flutter/material.dart';

class CategoryProductChart extends StatelessWidget {
  final List<chart.Series<Sales, String>> seriesList;
  const CategoryProductChart({super.key, required this.seriesList});

  @override
  Widget build(BuildContext context) {
    return chart.BarChart(
      seriesList,
      animate: true,
    );
  }
}
