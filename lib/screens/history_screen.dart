import 'package:blood_pressure_tracker/database/database.dart';
import 'package:blood_pressure_tracker/models/models.dart';
import 'package:blood_pressure_tracker/providers/providers.dart';
import 'package:blood_pressure_tracker/styles/text.dart';
import 'package:blood_pressure_tracker/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Consumer(builder: (context, watch, _) {
                  return DropdownButton<Order>(
                    value: watch(orderingProvider).state,
                    items: Order.values
                        .map<DropdownMenuItem<Order>>(
                            (orderingOption) => DropdownMenuItem(
                                  value: orderingOption,
                                  child: Text(
                                    orderInStringFormat(orderingOption),
                                  ),
                                ))
                        .toList(),
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    onChanged: (Order newValue) {
                      context.read(orderingProvider).state = newValue;
                    },
                    underline: Container(),
                    style: dropdownButtonTextStyle,
                  );
                }),
                Consumer(builder: (context, watch, _) {
                  return DropdownButton<TimeInterval>(
                    value: watch(timeIntervalProvider).state,
                    items: TimeInterval.values
                        .map<DropdownMenuItem<TimeInterval>>(
                            (timePeriod) => DropdownMenuItem(
                                  value: timePeriod,
                                  child: Text(
                                    timeIntervalInStringFormat(timePeriod),
                                  ),
                                ))
                        .toList(),
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    onChanged: (TimeInterval newValue) {
                      context.read(timeIntervalProvider).state = newValue;
                    },
                    underline: Container(),
                    style: dropdownButtonTextStyle,
                  );
                }),
              ],
            ),
            Expanded(
              child: Consumer(
                builder: (context, watch, _) {
                  var list = watch(listOfEntriesProvider);

                  return list.when(
                    loading: () => const Center(
                      child: const CircularProgressIndicator(),
                    ),
                    error: (error, stackTrace) => Center(
                      child: Text('Error: $error'),
                    ),
                    data: (List<Entry> value) {
                      if (value.isEmpty) {
                        return Center(
                          child: NoEntriesMessage(),
                        );
                      }
                      return ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10.0),
                        itemCount: value.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return SizedBox(height: 10.0);
                          }

                          final entry = value[index - 1];
                          return Card(
                            clipBehavior: Clip.antiAlias,
                            child: Dismissible(
                              key: Key(entry.id.toString()),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                alignment: Alignment.centerRight,
                                color: Colors.red,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                        size: 32.0,
                                      ),
                                      Text(
                                        'DELETE',
                                        style: entryCardTextStyle.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onDismissed: (direction) async {
                                await context
                                    .read(databaseProvider)
                                    .deleteEntry(entry);
                                await context
                                    .read(boxProvider)
                                    .put('has_changes', true);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(height: 6.0),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ParameterNameValuePair(
                                          name: 'Systolic',
                                          value: entry.systolic.toString(),
                                          axis: Axis.vertical,
                                        ),
                                      ),
                                      Expanded(
                                        child: ParameterNameValuePair(
                                          name: 'Diastolic',
                                          value: entry.diastolic.toString(),
                                          axis: Axis.vertical,
                                        ),
                                      ),
                                      Expanded(
                                        child: ParameterNameValuePair(
                                          name: 'Pulse',
                                          value: entry.pulse.toString(),
                                          axis: Axis.vertical,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: Text(
                                      DateFormat('dd.MM.yyyy - HH:mm')
                                          .format(entry.timestamp),
                                      style: entryCardTextStyle,
                                    ),
                                  ),
                                  SizedBox(height: 6.0),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
