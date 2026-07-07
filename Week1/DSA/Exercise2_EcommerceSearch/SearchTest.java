package com.dsa.search;

public class SearchTest {
    public static void main(String[] args) {
        Product[] products = {
                new Product(5, "Laptop", "Electronics"),
                new Product(2, "Shoes", "Footwear"),
                new Product(8, "Watch", "Accessories"),
                new Product(1, "Phone", "Electronics"),
                new Product(4, "Bag", "Fashion")
        };
        Product[] sortedProducts = {
                new Product(1, "Phone", "Electronics"),
                new Product(2, "Shoes", "Footwear"),
                new Product(4, "Bag", "Fashion"),
                new Product(5, "Laptop", "Electronics"),
                new Product(8, "Watch", "Accessories")
        };
        int searchId = 4;
        int linearResult = SearchAlgorithms.linearSearch(products, searchId);
        if (linearResult != -1) {
            System.out.println("Linear Search: Found '" + products[linearResult].productName + "' at index " + linearResult);
        } else {
            System.out.println("Linear Search: Product not found");
        }
        int binaryResult = SearchAlgorithms.binarySearch(sortedProducts, searchId);
        if (binaryResult != -1) {
            System.out.println("Binary Search: Found '" + sortedProducts[binaryResult].productName + "' at index " + binaryResult);
        } else {
            System.out.println("Binary Search: Product not found");
        }
        System.out.println("\nAnalysis");
        System.out.println("Linear Search: O(n) - checks every item, works on unsorted data");
        System.out.println("Binary Search: O(log n) - much faster, but requires sorted data");
        System.out.println("For large e-commerce platforms: Binary Search is preferred");
    }
}