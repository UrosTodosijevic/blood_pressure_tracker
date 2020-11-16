import 'package:blood_pressure_tracker/database/database.dart';
import 'package:blood_pressure_tracker/models/models.dart';
import 'package:blood_pressure_tracker/models/ordering_option.dart';
import 'package:blood_pressure_tracker/providers/providers.dart';
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
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
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
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
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
                          child: Text(
                            'No Entries Yet',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
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
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                color: Colors.red,
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
                                        child: Column(
                                          children: [
                                            Text(
                                              entry.systolic.toString(),
                                              style: TextStyle(
                                                fontSize: 36.0,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            Text(
                                              'Systolic',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black38,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              entry.diastolic.toString(),
                                              style: TextStyle(
                                                fontSize: 36.0,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            Text(
                                              'Diastolic',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black38,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              entry.pulse.toString(),
                                              style: TextStyle(
                                                fontSize: 36.0,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            Text(
                                              'Pulse',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black38,
                                              ),
                                            ),
                                          ],
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
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black38,
                                      ),
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
