// class Product {
//   String id = '';
//   String title = '';
//   String bodyHtml = '';
//   String handle = '';
//   String status = ProductStatus.any;
//   List<Variant> variants = [];
  
// }

// class ProductStatus {
//   static const String any = 'any';
//   static const String active = 'active';
//   static const String archived = 'archived';
//   static const String draft = 'draft';
// }

// class Variant {
//   int id = 0;
//   int productId = 0;
//   String title = '';
//   String price = '';
//   String sku = '';
//   int position = 0;
//   bool taxable = false;
//   bool requiresShipping = false;

//   Variant.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     productId = json['product_id'];
//     title = json['title'];
//     price = json['price'];
//     sku = json['sku'];
//     position = json['position'];
//     taxable = json['taxable'];
//     requiresShipping = json['requires_shipping'];
//   }
// }
