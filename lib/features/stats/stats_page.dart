import 'package:despesas_app/common/constants/constants.dart';
import 'package:despesas_app/common/extensions/extensions.dart';
import 'package:despesas_app/locator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../common/widgets/widgets.dart';
import 'stats_controller.dart';
import 'stats_state.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> with SingleTickerProviderStateMixin {
  final _statsController = locator.get<StatsController>();
  late final TabController _periodTabController;

  @override
  void initState() {
    super.initState();
    _statsController.getTrasactionsByPeriod();
    _periodTabController = TabController(
      initialIndex: _statsController.selectedPeriod.index,
      length: _statsController.periods.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _periodTabController.dispose();
    super.dispose();
  }

  String _getPeriodLabel(StatsPeriod period) {
    switch (period) {
      case StatsPeriod.day:
        return 'Dia';
      case StatsPeriod.week:
        return 'Semana';
      case StatsPeriod.month:
        return 'Mês';
      case StatsPeriod.year:
        return 'Ano';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AppHeader.noBackground(title: 'Estatísticas'),
          Positioned(
            top: 150.h,
            left: 8.w,
            right: 8.w,
            bottom: 0,
            child: Column(
              children: [
                StatefulBuilder(
                  builder: (context, setState) {
                    return TabBar(
                      controller: _periodTabController,
                      onTap: (index) => setState(() {
                        _statsController.getTrasactionsByPeriod(period: StatsPeriod.values[index]);
                      }),
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0), // mais arredondado
                        color: AppColors.green,
                      ),
                      indicatorSize: TabBarIndicatorSize.tab, // o indicador cobre o tab inteiro
                      splashBorderRadius: BorderRadius.circular(12.0),
                      tabs: _statsController.periods
                          .map(
                            (e) => Container(
                              height: 36, // aumenta a altura do container
                              alignment: Alignment.center,
                              child: Text(
                                _getPeriodLabel(e), // traduz nomes para português
                                textAlign: TextAlign.center,
                                style: _statsController.selectedPeriod == e
                                    ? AppTextStyles.smallText13.copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w600,
                                      )
                                    : AppTextStyles.smallText13.copyWith(
                                        color: AppColors.green,
                                      ),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
                const SizedBox(height: 32.0),
                Flexible(
                  child: AnimatedBuilder(
                    animation: _statsController,
                    builder: (context, child) {
                      if (_statsController.state is StatsStateLoading) {
                        return const Center(
                          child: CustomCircularProgressIndicator(
                            color: AppColors.green,
                          ),
                        );
                      }

                      if (_statsController.state is StatsStateSuccess) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 24.0,
                          ),
                          child: LineChart(
                            LineChartData(
                              lineTouchData: LineTouchData(
                                touchTooltipData: LineTouchTooltipData(
                                  tooltipBorder: const BorderSide(
                                    color: AppColors.greenOne,
                                  ),
                                  tooltipBgColor: AppColors.antiFlashWhite,
                                  getTooltipItems: (touchedSpots) {
                                    return touchedSpots.map((e) {
                                      return LineTooltipItem(
                                        '\$${e.y.toStringAsFixed(2)}',
                                        AppTextStyles.smallText.copyWith(
                                          color: AppColors.greenOne,
                                        ),
                                      );
                                    }).toList();
                                  },
                                ),
                              ),
                              gridData: const FlGridData(show: false),
                              titlesData: FlTitlesData(
                                show: true,
                                rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 30,
                                    interval: _statsController.interval,
                                    getTitlesWidget: (value, meta) {
                                      String text;

                                      switch (_statsController.selectedPeriod) {
                                        case StatsPeriod.day:
                                          text = '${value.toInt()}h';

                                        case StatsPeriod.week:
                                          text = _statsController.dayName(value);

                                        case StatsPeriod.month:
                                          text = 'W${(value + 1).toInt()}';

                                        case StatsPeriod.year:
                                          text = _statsController.monthName(value);
                                      }

                                      return Text(text);
                                    },
                                  ),
                                ),
                                leftTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                              borderData: FlBorderData(show: false),
                              minX: _statsController.minX,
                              maxX: _statsController.maxX,
                              minY: _statsController.minY,
                              maxY: _statsController.maxY,
                              lineBarsData: [
                                LineChartBarData(
                                  preventCurveOverShooting: true,
                                  spots: _statsController.valueSpots,
                                  isCurved: true,
                                  barWidth: 2,
                                  color: AppColors.green,
                                  dotData: const FlDotData(show: false),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.green.withOpacity(0.20),
                                        AppColors.greenOne.withOpacity(0),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Top Transações',
                        style: AppTextStyles.mediumText18,
                      ),
                      GestureDetector(
                        onTap: _statsController.sortTransactions,
                        child: const Icon(
                          Icons.sort,
                          color: AppColors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: AnimatedBuilder(
                      animation: _statsController,
                      builder: (context, child) {
                        if (_statsController.state is StatsStateLoading) {
                          return const Center(
                            child: CustomCircularProgressIndicator(
                              color: AppColors.green,
                            ),
                          );
                        }
                        return TransactionListView(
                          transactionList: _statsController.transactions,
                          onChange: () {
                            _statsController.getTrasactionsByPeriod();
                          },
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
