/**
  * Created by Eugene Pavlovskiy
  */

public with sharing class OrderProductController {
    @AuraEnabled(cacheable=true)
    public static List<OrderItem> getOrderProductList() {
        return [SELECT Id FROM OrderItem LIMIT 10];
    }
}