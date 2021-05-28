// class Mutations {
//   static String checkOutCreate() => r"""
// mutation($input: CheckoutCreateInput!) {
//   checkoutCreate(input: $input) {
//     checkout {
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
//     }
//     checkoutUserErrors {
//       field
//       message
//     }
//   }
// }

// """;

//   static String checkoutLineItemsReplace = r'''
//   mutation checkoutLineItemsReplace($lineItems: [CheckoutLineItemInput!]!, $checkoutId: ID!) {
//   checkoutLineItemsReplace(lineItems: $lineItems, checkoutId: $checkoutId) {
//     checkout {
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
//     }
//   }
// }
// ''';

// //   static String checkoutShippingAddressUpdate = r'''
// //   mutation checkoutShippingAddressUpdateV2($shippingAddress: MailingAddressInput!, $checkoutId: ID!) {
// //   checkoutShippingAddressUpdateV2(shippingAddress: $shippingAddress, checkoutId: $checkoutId) {
// //     userErrors {
// //       field
// //       message
// //     }
// //     checkout {
// //       id
// //       shippingAddress {
// //         firstName
// //         lastName
// //         address1
// //         province
// //         country
// //         zip
// //       }
// //     }
// //   }
// // }
// // ''';

// //   static String checkoutShippingLineUpdate = r'''
// // mutation checkoutShippingLineUpdate($checkoutId: ID!, $shippingRateHandle: String!) {
// //   checkoutShippingLineUpdate(checkoutId: $checkoutId, shippingRateHandle: $shippingRateHandle) {
// //     checkout {
// //       id
// //     }
// //     checkoutUserErrors {
// //       code
// //       field
// //       message
// //     }
// //   }
// // }
// // ''';
// }
