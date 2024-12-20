// Copyright 2018 the Charts project authors. Please see the AUTHORS file
// for details.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/// Donut chart example. This is a simple pie chart with a hole in the middle.
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sample/charts_flutter/flutter.dart' as charts;

class CustomDonutPieChart extends StatelessWidget {
  final List<charts.Series<dynamic, num>> seriesList;
  final bool animate;

  const CustomDonutPieChart(this.seriesList, {super.key, this.animate = true});

  /// Creates a [PieChart] with sample data and no transition.
  factory CustomDonutPieChart.withSampleData() {
    return CustomDonutPieChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }

  // EXCLUDE_FROM_GALLERY_DOCS_START
  // This section is excluded from being copied to the gallery.
  // It is used for creating random series data to demonstrate animation in
  // the example app only.
  factory CustomDonutPieChart.withRandomData() {
    return CustomDonutPieChart(_createRandomData());
  }

  /// Create random data.
  static List<charts.Series<LinearSales, int>> _createRandomData() {
    final random = Random();

    final data = [
      LinearSales(0, random.nextInt(100), Colors.green),
      LinearSales(1, random.nextInt(100), Colors.orange),
      LinearSales(2, random.nextInt(100), Colors.blue),
      LinearSales(3, random.nextInt(100), Colors.red),
    ];

    return [
      charts.Series<LinearSales, int>(
          id: 'Sales',
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.sales,
          data: data,
          colorFn: (sales, index) =>
              charts.ColorUtil.fromDartColor(sales.color),
          outsideLabelStyleAccessorFn: (sales, index) {
            return charts.TextStyleSpec(
                fontSize: 12,
                color: charts.ColorUtil.fromDartColor(sales.color));
          },
          labelAccessorFn: (row, index) {
            return '${row.year}: ${row.sales}';
          })
    ];
  }

  // EXCLUDE_FROM_GALLERY_DOCS_END

  @override
  Widget build(BuildContext context) {
    return charts.PieChart<num>(
      seriesList,
      animate: animate,
      defaultInteractions: true,
      // Configure the width of the pie slices to 60px. The remaining space in
      // the chart will be left as a hole in the center.
      // 图例
      behaviors: [
        // charts.DatumLegend(
        //   position: charts.BehaviorPosition.bottom,
        //   entryTextStyle: charts.TextStyleSpec(fontSize: 13),
        //   cellPadding: const EdgeInsets.symmetric(vertical: 2.0),
        //   horizontalFirst: false,
        // ),
        // charts.InitialSelection(selectedDataConfig: [
        //   charts.SeriesDatumConfig<int>('Purchases', 202),
        // ]),
        charts.DomainHighlighter(),
      ],
      // layoutConfig: charts.LayoutConfig(
      //     leftMarginSpec: common.MarginSpec.fromPercent(minPercent: 10,maxPercent: 80),
      //     topMarginSpec: common.MarginSpec.fixedPixel(1000),
      //     rightMarginSpec: common.MarginSpec.fixedPixel(200),
      //     bottomMarginSpec: common.MarginSpec.fixedPixel(500)),
      defaultRenderer: charts.ArcRendererConfig(
          arcWidth: 40,
          strokeWidthPx: 10,
          arcRendererDecorators: [
            charts.ArcLabelDecorator(
                showLeaderLines: true,
                outsideLabelStyleSpec: charts.TextStyleSpec(
                    color: charts.ColorUtil.fromDartColor(Colors.orange),
                    fontSize: 14),
                leaderLineColor: charts.ColorUtil.fromDartColor(Colors.red),
                leaderLineStyleSpec: charts.ArcLabelLeaderLineStyleSpec(
                    color: charts.ColorUtil.fromDartColor(Colors.green),
                    length: 15,
                    thickness: 1),
                labelPosition: charts.ArcLabelPosition.outside)
          ]),
      selectionModels: [
        charts.SelectionModelConfig(type: charts.SelectionModelType.info,changedListener: (model) {
          debugPrint('监听到变化：${model.selectedDatum[0].index}');
        }, updatedListener: (model) {
          debugPrint('监听到更新：${model.selectedSeries}');
        })
      ],
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      LinearSales(0, 100, Colors.green),
      LinearSales(1, 75, Colors.orange),
      LinearSales(2, 25, Colors.blue),
      LinearSales(3, 5, Colors.red),
    ];

    return [
      charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;
  final MaterialColor color;

  LinearSales(this.year, this.sales, this.color);
}
