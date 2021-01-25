import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

typedef Discriminator<T> = bool Function(T field);
typedef _RowField<T>      = T    Function(List row);
typedef _RowDiscriminator = bool Function(List row);

/// PURPOSE:
///   to isolate all the Future-ness of dealing with the file access
/// DO NOT load/initialize resources until they're needed
///   only setup the computation to do so.
class CSVTableFile {
  //TODO change to `late` binding once null-safety enabled
  Future< List<List>> _fetchedCSVRows;
  Future< Map<String, int>> _colIdxForAttribute;

  // Don't try and load anything until the actual property is accessed.
  //  Dart futures are execute eargerly.
  CSVTableFile(Future<String> unparsedCSV) {
    var conv = CsvToListConverter();
    var _fetchedCSVTable = unparsedCSV.then(conv.convert);
    _colIdxForAttribute = _fetchedCSVTable.then(_mapHeaderLabelToColumnNumber);
    // Remove the header row, avoid type error
    _fetchedCSVRows = _fetchedCSVTable.then((t) {
      t.removeAt(0);
      return t;
    });
  }

  factory CSVTableFile.fromFile(String srcFilePath) {
    var contents = Future( () => File(srcFilePath).readAsString());
    return CSVTableFile(contents);
  }

  factory CSVTableFile.fromAssetBundle(String srcFilePath) {
    var srcFileData = Future( () => rootBundle.loadString(srcFilePath));
    return CSVTableFile(srcFileData);
  }

  Future<Map<String, dynamic>> labelRow(List<dynamic> row) async {
    final colIdx = await _colIdxForAttribute;
    return Map<String, dynamic>.fromIterables(colIdx.keys, row);
  }

  /// EXAMPLE: want to filter by field 'status' == 'unsent'
  /// var csv = CSVTableFile.fromFile("invoices.csv");
  /// var results = csv.rowsWhere<String>('status', (field) => field=="unsent");
  ///TODO add conjunction over a list of field/matcher pairs
  Future<List<List>> rowsWhere<T>(
      String header,
      Discriminator<T> fieldMatcher)
  async {
    var attr = _Attribute(header, await _colIdxForAttribute);
    getFieldForRecord(List row) => row[attr.column] as T;
    criteriaMatchesField(List row) => fieldMatcher(getFieldForRecord(row));
    final rows = await _fetchedCSVRows;
    return rows.where(criteriaMatchesField).toList();
  }

  /// Creates a map of attributes labels to respective column index/position
  Map<String, int> _mapHeaderLabelToColumnNumber(List<List<dynamic>> csvData) {
    final firstRow = List<String>.from(csvData[0]);
    final idxValues = Iterable<int>.generate(firstRow.length);
    return Map<String, int>.fromIterables(firstRow, idxValues);
  }
}

class _Attribute {
  final String label;
  int column;

  _Attribute(this.label, Map<String, int> headerLabels) {
    if (headerLabels.keys.contains(label)) {
      column = headerLabels[label];
    } else {
      throw ArgumentError.value(this.label, "label",
        "Attribute Does not Exist: label not found within given headerLabels");
    }
  }
}
