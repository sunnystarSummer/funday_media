import 'dart:convert';

extension PrettyJsonString on Map<String, dynamic>  {
  String prettyJson() {
    var encoder = JsonEncoder.withIndent("     ");
    return encoder.convert(this);
  }
}