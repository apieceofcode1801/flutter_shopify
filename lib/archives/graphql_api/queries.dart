// class Queries {
//   static String getProductsQuery(int limit) => """
// {
//   products(first: $limit) {
//     edges {
//       node {
//         id
//         handle
//         title
//         images(first: 1) {
//           edges {
//             node {
//               id
//               originalSrc
//               width
//               height
//             }
//           }
//         }
//         priceRange {
//           minVariantPrice {
//             amount
//             currencyCode
//           }
//           maxVariantPrice {
//             amount
//             currencyCode
//           }
//         }
//       }
//     }
//   }
// }
// """;

//   static String getProductQuery(String handle) => """
//   query {
//   productByHandle(handle: \"$handle\") {
//     title
//     description
//     images(first: 10) {
//       edges {
//         node {
//           id
//           originalSrc
//           width
//           height
//         }
//       }
//     }
//     priceRange {
//       minVariantPrice {
//         amount
//         currencyCode
//       }
//       maxVariantPrice {
//         amount
//         currencyCode
//       }
//     }
//     variants(first: 10) {
//       edges {
//         node {
//           id
//           title
//           priceV2 {
//             amount
//             currencyCode
//           }
//         }
//       }
//     }
//   }
// }
// """;

//   static String getCheckoutById(String id) => """
//   query {
//   node(id: \"$id\") {
//     id
//     ... on Checkout {
//       id
//       email
//       webUrl
//       lineItems(first: 100) {
//         edges {
//           node {
//             id
//             title
//             variant {
//               id
//               title
//               priceV2 {
//                 amount
//                 currencyCode
//               }
//             }
//             quantity
            
//           }
//         }
//       }
//       subtotalPriceV2 {
//         amount
//         currencyCode
//       }
//       totalPriceV2 {
//         amount
//         currencyCode
//       }
//       shippingAddress {
//         id
//         firstName
//         lastName
//         address1
//         address2
//         city
//         country
//         countryCodeV2
//         zip
//       }
//     }
//   }
//   }
// """;

//   static String getShippingRates({required String checkoutId}) => '''
//     query {
//   node(id: $checkoutId) {
//     ... on Checkout {
//       id
//       webUrl
//       availableShippingRates {
//         ready
//         shippingRates {
//           handle
//           priceV2 {
//             amount
//           }
//           title
//         }
//       }
//     }
//   }
// }
// ''';
// }
