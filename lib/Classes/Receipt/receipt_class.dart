class ReceiptJsonClass {
  ReceiptJsonClass({
    required this.address,
    required this.buyerId,
    required this.email,
    required this.id,
    required this.items,
    required this.location,
    required this.methodOfPayment,
    required this.organization,
    required this.phoneNumber,
    required this.pinNumber,
    required this.publishDate,
    required this.receiptNumber,
    required this.servedBy,
    required this.tillNumber,
  });
  late final String address;
  late final int buyerId;
  late final String email;
  late final int id;
  late final List<Items> items;
  late final String location;
  late final String methodOfPayment;
  late final String organization;
  late final int phoneNumber;
  late final String pinNumber;
  late final String publishDate;
  late final int receiptNumber;
  late final String servedBy;
  late final int tillNumber;

  ReceiptJsonClass.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    buyerId = json['buyer_id'];
    email = json['email'];
    id = json['id'];
    items = List.from(json['items']).map((e) => Items.fromJson(e)).toList();
    location = json['location'];
    methodOfPayment = json['method_of_payment'];
    organization = json['organization'];
    phoneNumber = json['phone_number'];
    pinNumber = json['pin_number'];
    publishDate = json['publish_date'];
    receiptNumber = json['receipt_number'];
    servedBy = json['served_by'];
    tillNumber = json['till_number'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['address'] = address;
    data['buyer_id'] = buyerId;
    data['email'] = email;
    data['id'] = id;
    data['items'] = items.map((e) => e.toJson()).toList();
    data['location'] = location;
    data['method_of_payment'] = methodOfPayment;
    data['organization'] = organization;
    data['phone_number'] = phoneNumber;
    data['pin_number'] = pinNumber;
    data['publish_date'] = publishDate;
    data['receipt_number'] = receiptNumber;
    data['served_by'] = servedBy;
    data['till_number'] = tillNumber;
    return data;
  }
}

class Items {
  Items({
    required this.itemDiscount,
    required this.itemName,
    required this.itemNumber,
    required this.itemPrice,
    required this.itemQuantity,
  });
  late final int itemDiscount;
  late final String itemName;
  late final int itemNumber;
  late final int itemPrice;
  late final int itemQuantity;

  Items.fromJson(Map<String, dynamic> json) {
    itemDiscount = json['item_discount'];
    itemName = json['item_name'];
    itemNumber = json['item_number'];
    itemPrice = json['item_price'];
    itemQuantity = json['item_quantity'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['item_discount'] = itemDiscount;
    data['item_name'] = itemName;
    data['item_number'] = itemNumber;
    data['item_price'] = itemPrice;
    data['item_quantity'] = itemQuantity;
    return data;
  }
}
