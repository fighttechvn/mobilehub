class DropdownModel {
  final String title;
  final int value;

  DropdownModel({required this.title, required this.value});

  @override
  String toString() {
    return 'Title: $title |  Value: $value ';
  }

  factory DropdownModel.init() {
    return DropdownModel(title: 'title', value: 0);
  }
}
