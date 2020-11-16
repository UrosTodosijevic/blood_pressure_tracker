import 'dart:io';

import 'package:blood_pressure_tracker/providers/providers.dart';
import 'package:blood_pressure_tracker/screens/screens.dart';
import 'package:blood_pressure_tracker/utils/utils.dart';
import 'package:blood_pressure_tracker/widgets/new_entry_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0)),
                elevation: 6.0,
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Consumer(
                  builder: (context, watch, _) {
                    var asyncValue = watch(lastEntryStreamProvider);

                    return asyncValue.when(
                        data: (entry) {
                          if (entry != null) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 12.0),
                                Text(
                                  'Last entry:',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54,
                                  ),
                                ),
                                Text(
                                  //'03.11.2020. at 22:59',
                                  DateFormat('dd. MMMM yyyy - HH:mm')
                                      .format(entry.timestamp),
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54,
                                  ),
                                ),
                                SizedBox(height: 12.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'SYS: ',
                                      style: TextStyle(
                                        fontSize: 32.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    Text(
                                      entry.systolic.toString(),
                                      style: TextStyle(
                                        fontSize: 36.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'DIA: ',
                                      style: TextStyle(
                                        fontSize: 32.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    Text(
                                      entry.diastolic.toString(),
                                      style: TextStyle(
                                        fontSize: 36.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'PULSE: ',
                                      style: TextStyle(
                                        fontSize: 32.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    Text(
                                      entry.pulse.toString(),
                                      style: TextStyle(
                                        fontSize: 36.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12.0),
                              ],
                            );
                          } else {
                            return Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 60.0),
                                child: Text(
                                  'No Entries Yet',
                                  style: TextStyle(
                                    fontSize: 26.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        loading: () => Center(
                              child: CircularProgressIndicator(),
                            ),
                        error: (err, stack) => Center(
                              child: Text('Error: $err'),
                            ));
                  },
                ),
              ),
              SizedBox(height: 24.0),
              Builder(
                builder: (context) => FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  textColor: Colors.white,
                  color: Theme.of(context).accentColor,
                  child: Text(
                    'New Entry',
                    style:
                        TextStyle(fontSize: 26.0, fontWeight: FontWeight.w600),
                  ),
                  onPressed: () async {
                    var successfulEntry = await showNewEntryDialog(context);
                    if (successfulEntry) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Successfully made new entry'),
                      ));
                    }
                  },
                ),
              ),
              SizedBox(height: 24.0),
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                textColor: Colors.white,
                color: Theme.of(context).accentColor,
                child: Text(
                  'History',
                  style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  print(' -----> Clicked History <----- ');
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HistoryScreen()));
                },
              ),
              SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Changes from last file share? ',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                  Consumer(
                    builder: (context, watch, _) {
                      var valueListenable = watch(listenableProvider);
                      return ValueListenableBuilder(
                        valueListenable: valueListenable,
                        builder: (BuildContext context, Box<dynamic> box, _) {
                          bool value = box.get('has_changes');
                          print('ValueListenableBuilder: $value');
                          return Text(
                            value ? 'YES' : 'NO',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 12.0),
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                textColor: Colors.white,
                color: Theme.of(context).accentColor,
                child: Text(
                  'Send as .csv',
                  style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w600),
                ),
                onPressed: () async {
                  print(' -----> Clicked Send as .csv <----- ');

                  var allEntries =
                      await context.read(databaseProvider).allEntries;
                  if (allEntries.isEmpty) {
                    return;
                  }

                  bool hasChanges =
                      context.read(boxProvider).get('has_changes');

                  File file = await getLocalFile();
                  bool exists = await file.exists();

                  if (!exists) {
                    /*file = */ await writeToFile(file, allEntries);
                  } else if (hasChanges) {
                    await file.delete();
                    /*file = */
                    await writeToFile(file, allEntries);
                  }

                  await Share.shareFiles([file.path],
                      text: DateFormat('dd. MMMM yyyy - HH:mm')
                          .format(DateTime.now()),
                      subject: 'Exporting .csv file');

                  await context.read(boxProvider).put('has_changes', false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
