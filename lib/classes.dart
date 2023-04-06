



class Room {
  int? roomId;
  String? roomName;
  List<Item>? items;

  Room({this.roomId, this.roomName, this.items});
}

List<Room> _rooms = [];

class Item {
  int? itemId;
  String? itemName;
  String? itemType;
  String? itemSubtype;
  String? itemBrand;
  String? itemModel;
  String? itemDimensions;
  String? itemNotes;
  // File? itemImage;

  Item({
    required this.itemId,
    required this.itemName,
    required this.itemType,
    this.itemSubtype,
    this.itemBrand,
    this.itemModel,
    required this.itemDimensions,
    this.itemNotes,
    // this.itemImage,
  });
}

List<Item> _items = [];