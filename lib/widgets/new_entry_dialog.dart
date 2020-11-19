import 'package:blood_pressure_tracker/database/database.dart';
import 'package:blood_pressure_tracker/providers/providers.dart';
import 'package:blood_pressure_tracker/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:moor/moor.dart' hide Column;
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Function which is used for calling NewEntryDialog
Future<bool> showNewEntryDialog(BuildContext context) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return NewEntryDialog();
    },
  );
}

class NewEntryDialog extends StatefulWidget {
  @override
  _NewEntryDialogState createState() => _NewEntryDialogState();
}

class _NewEntryDialogState extends State<NewEntryDialog> {
  bool _customDateTime = false;
  DateTime _dateTime = currentDateTime();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _systolicController = TextEditingController();
  final TextEditingController _diastolicController = TextEditingController();
  final TextEditingController _pulseController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _systolicController.dispose();
    _diastolicController.dispose();
    _pulseController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      clipBehavior: Clip.antiAlias,
      content: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16.0),
            Text(
              'Enter values: ',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 16.0),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Padding(
                // Ovo smanjiti da se uglavi dugme za editovanje - bilo 24.0
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _systolicController,
                      cursorWidth: 3.0,
                      cursorColor: Theme.of(context).accentColor,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.streetAddress,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(3),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Systolic',
                        labelStyle: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal,
                          //color: Colors.black45,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        isDense: true,
                      ),
                      autovalidateMode: AutovalidateMode.disabled,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Value is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 12.0),
                    TextFormField(
                      controller: _diastolicController,
                      cursorWidth: 3.0,
                      cursorColor: Theme.of(context).accentColor,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.streetAddress,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(3),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Diastolic',
                        labelStyle: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal,
                          //color: Colors.black45,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        isDense: true,
                      ),
                      autovalidateMode: AutovalidateMode.disabled,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Value is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 12.0),
                    TextFormField(
                      controller: _pulseController,
                      cursorWidth: 3.0,
                      cursorColor: Theme.of(context).accentColor,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.streetAddress,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(3),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Pulse',
                        labelStyle: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal,
                          //color: Colors.black45,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        isDense: true,
                      ),
                      autovalidateMode: AutovalidateMode.disabled,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Value is required';
                        }
                        return null;
                      },
                    ),
                    !_customDateTime
                        ? SizedBox(height: 12.0)
                        : SizedBox(height: 4.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _customDateTime
                            ? SizedBox(width: 4.0)
                            : SizedBox.shrink(),
                        Text(
                          DateFormat('dd.MM.yy HH:mm').format(_dateTime),
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                        _customDateTime
                            ? SizedBox(width: 4.0)
                            : SizedBox.shrink(),
                        _customDateTime
                            ? IconButton(
                                color: Colors.black45,
                                icon: Icon(
                                  Icons.edit,
                                ),
                                onPressed: () async {
                                  var _pickedDate =
                                      await selectDate(context, _dateTime);
                                  if (_pickedDate == null) return;
                                  var _pickedTime = await selectTime(context,
                                      TimeOfDay.fromDateTime(_dateTime));
                                  if (_pickedTime == null) return;
                                  var _newDateTime =
                                      makeNewDateTime(_pickedDate, _pickedTime);
                                  var _now = currentDateTime();
                                  if (_newDateTime.compareTo(_now) <= 0) {
                                    setState(() {
                                      _dateTime = _newDateTime;
                                    });
                                  }
                                })
                            : SizedBox.shrink(),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    FlatButton(
                      color: Theme.of(context).accentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.all(0.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 12.0),
                        child: Text(
                          !_customDateTime ? 'Custom time' : 'Current time',
                          style: TextStyle(
                            fontSize: 22.0,
                            //fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        if (!_customDateTime) {
                          var _pickedDate =
                              await selectDate(context, _dateTime);
                          if (_pickedDate == null) return;
                          var _pickedTime = await selectTime(
                              context, TimeOfDay.fromDateTime(_dateTime));
                          if (_pickedTime == null) return;
                          var _newDateTime =
                              makeNewDateTime(_pickedDate, _pickedTime);
                          var _now = currentDateTime();
                          if (_newDateTime.compareTo(_now) <= 0) {
                            setState(() {
                              _dateTime = _newDateTime;
                              _customDateTime = !_customDateTime;
                            });
                          }
                        } else {
                          setState(() {
                            _dateTime = currentDateTime();
                            _customDateTime = !_customDateTime;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 12.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        FlatButton(
          child: Text(
            'CANCEL',
            style: TextStyle(
              fontSize: 20.0, // bilo je 18.0
              fontWeight: FontWeight.w500, // bilo je w600
              color: Theme.of(context).accentColor,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        FlatButton(
          child: Text(
            'DONE',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          textColor: Theme.of(context).accentColor,
          disabledTextColor: Colors.black54,
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              var _systolicPressure = int.parse(_systolicController.text);
              var _diastolicPressure = int.parse(_diastolicController.text);
              var _pulse = int.parse(_pulseController.text);

              var entriesCompanion = EntriesCompanion(
                systolic: Value(_systolicPressure),
                diastolic: Value(_diastolicPressure),
                pulse: Value(_pulse),
                timestamp: Value(_dateTime),
              );

              await context.read(databaseProvider).addEntry(entriesCompanion);
              await context.read(boxProvider).put('has_changes', true);

              _formKey.currentState.reset();

              Navigator.of(context).pop(true);
            }
          },
        ),
      ],
    );
  }
}
