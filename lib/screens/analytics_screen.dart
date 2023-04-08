import 'package:amazon_clone/constants/order_apis.dart';
import 'package:amazon_clone/model/sales.dart';
import 'package:amazon_clone/widgets/category_products_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  int? totalEarnings;
  List<Sales>? sales;
  @override
  void initState() {
    super.initState();
    fetchTotalEarnings();
  }

  fetchTotalEarnings() async {
    var earningsData = await OrderApis().fetchAdminAnlytics(context);
    totalEarnings = earningsData['totalEarnings'];
    sales = earningsData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return totalEarnings == null || sales == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Text('\$$totalEarnings'),
              SizedBox(
                height: 250,
                child: sales != null && totalEarnings != null
                    ? CategoryProductChart(
                        seriesList: [
                          charts.Series(
                            id: 'Sales',
                            data: sales!,
                            domainFn: (Sales sales, _) => sales.label,
                            measureFn: (Sales sales, _) => sales.earnings,
                          ),
                        ],
                      )
                    : Container(),
              )
            ],
          );
  }
}
