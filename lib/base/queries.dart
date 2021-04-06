class Queries {
  static String getProductsQuery(int limit) => """
{
  products(first: $limit) {
    edges {
      node {
        id
        handle
        title
        images(first: 1) {
          edges {
            node {
              id
              originalSrc
              width
              height
            }
          }
        }
        priceRange {
          minVariantPrice {
            amount
            currencyCode
          }
          maxVariantPrice {
            amount
            currencyCode
          }
        }
      }
    }
  }
}
""";

  static String getProductQuery(String handle) => """
  query {
  productByHandle(handle: \"$handle\") {
    title
    description
    images(first: 10) {
      edges {
        node {
          id
          originalSrc
          width
          height
        }
      }
    }
    priceRange {
      minVariantPrice {
        amount
        currencyCode
      }
      maxVariantPrice {
        amount
        currencyCode
      }
    }
    variants(first: 10) {
      edges {
        node {
          id
          title
          priceV2 {
            amount
            currencyCode
          }
        }
      }
    }
  }
}
""";
}