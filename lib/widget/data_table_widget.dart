import 'package:advent20_data_table_ii/data/data.dart';
import 'package:advent20_data_table_ii/model/city.dart';
import 'package:flutter/material.dart';

class DataTableWidget extends StatefulWidget {
  @override
  DataTableWidgetState createState() => DataTableWidgetState();
}

class DataTableWidgetState extends State<DataTableWidget> {
  bool ascending;
  List<City> selectedCities;

  @override
  void initState() {
    super.initState();

    ascending = false;
    selectedCities = [];
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: width * 1.4,
        child: ListView(
          children: <Widget>[
            buildDataTable(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text('Proccess with ${selectedCities.length} entries'),
                  onPressed: onPressed(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildDataTable() => DataTable(
        sortAscending: ascending,
        sortColumnIndex: 0,
        columns: cityColumns
            .map(
              (String column) => DataColumn(
                    label: Text(column),
                    onSort: (int columnIndex, bool ascending) => onSortColumn(
                        columnIndex: columnIndex, ascending: ascending),
                  ),
            )
            .toList(),
        rows: cities
            .map((City city) => DataRow(
                  selected: selectedCities.contains(city),
                  cells: [
                    DataCell(Text('${city.name}')),
                    DataCell(Text('${city.nation}')),
                    DataCell(Text('${city.population}')),
                    DataCell(Text('${city.nation}')),
                  ],
                  onSelectChanged: (bool selected) =>
                      onSelectedRowChanged(selected: selected, city: city),
                ))
            .toList(),
      );

  void onSortColumn({int columnIndex, bool ascending}) {
    if (columnIndex == 0) {
      setState(() {
        if (ascending) {
          cities.sort((a, b) => a.name.compareTo(b.name));
        } else {
          cities.sort((a, b) => b.name.compareTo(a.name));
        }
        this.ascending = ascending;
      });
    }
  }

  void onSelectedRowChanged({bool selected, City city}) {
    setState(() {
      if (selected) {
        selectedCities.add(city);
      } else {
        selectedCities.remove(city);
      }
    });
  }

  Function onPressed() {
    if (selectedCities.isEmpty) return null;

    return () {};
  }
}
