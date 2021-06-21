/**
  * Created by Eugene Pavlovskiy
  */

public with sharing class OrderProductController {
    @AuraEnabled(cacheable=true)
    public static List<OrderItem> getOrderProductList(String orderId) {
        return [SELECT Id,UnitPrice, TotalPrice, Product2.Name,Quantity FROM OrderItem WHERE orderId =: orderId];
    }
}