import 'package:birthday_tracker/extensions/datetime_extensions.dart';
import 'package:birthday_tracker/models/birthday.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class BirthdayListWidget extends StatelessWidget {
  final ObservableList<Birthday> items;
  final Function onEditPressed;
  final Function onDeletedPressed;

  BirthdayListWidget({
    Key key,
    @required this.items,
    @required this.onEditPressed,
    @required this.onDeletedPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 0,
      ),
      child: this.items == null || this.items.isEmpty
          ? Center(
              child: Text(
                this.items == null ? "" : "No Birthday saved!",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, int index) {
                return Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => this.onEditPressed(items[index]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              child: Observer(
                                builder: (context) {
                                  return this.getListTile(index, context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget getListTile(index, context) {
    return Container(
      alignment: Alignment.center,
      height: 80,
      child: ListTile(
        title: Text(
          this.items[index].birthday.dateToString(),
          style: TextStyle(fontSize: 14),
        ),
        trailing: IconButton(
          iconSize: 32,
          icon: Icon(Icons.delete),
          onPressed: () => this.onDeletedPressed(this.items[index]),
        ),
      ),
    );
  }
}
