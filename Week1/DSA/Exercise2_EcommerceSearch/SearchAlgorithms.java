package com.dsa.search;

public class SearchAlgorithms {
    public static int linearSearch(Product[] products, int targetId) {
        for (int i = 0; i < products.length; i++) {
            if (products[i].productId == targetId) {
                return i;
            }
        }
        return -1;
    }

    public static int binarySearch(Product[] products, int targetId) {
        int left = 0;
        int right = products.length - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (products[mid].productId == targetId) {
                return mid;
            } else if (products[mid].productId < targetId) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return -1;
    }
}