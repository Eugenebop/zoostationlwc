/**
  * Created by Eugene Pavlovskiy
  */

public with sharing class ProductsController {
    @AuraEnabled(cacheable=true)
    public static List<Product2> getProductList() {
        return [SELECT Id, Name,CreatedDate  FROM Product2 Order BY CreatedDate ASC LIMIT 200];
    }


    @AuraEnabled()
    public static void orderUpdate(List<Product2> prodList, Id dorderId){
      Map<Id, OrderItem> keyProdIdOrderItemVal = new Map<Id, OrderItem>();
      List<OrderItem> usedOrderItem = [
                      SELECT Id,
                             OrderId,
                             Product2Id,
                             Quantity
                      FROM   OrderItem
                      WHERE  OrderId =: dorderId
      ];

      for(OrderItem orderItem : usedOrderItem){
          keyProdIdOrderItemVal.put(orderItem.Product2Id, orderItem);
      }
      
      Map<Id, PricebookEntry> product2KeyPricebookEntryValue = new Map<Id, PricebookEntry>();
      List<PricebookEntry> priceBookEntryList = [
          SELECT  Id,
                  Product2Id,
                  Pricebook2Id,
                  UnitPrice
          FROM    PricebookEntry
          WHERE   Product2Id IN: prodList
         
      ];

      for(PricebookEntry priceBookEntry : priceBookEntryList){
          product2KeyPricebookEntryValue.put(priceBookEntry.Product2Id, priceBookEntry);
      }

      Order order = [SELECT Id FROM Order WHERE Id =: dorderId];
      List<OrderItem> orderItList = new List<OrderItem>();

      for(Product2 prod : prodList){
        if(keyProdIdOrderItemVal.containsKey(prod.Id)){
              OrderItem oi = keyProdIdOrderItemVal.get(prod.Id);
              oi.Quantity += 1;
              orderItList.add(oi);
        } else {orderItList.add(new OrderItem(OrderId = dorderId,
              Product2Id = prod.Id,
              UnitPrice = product2KeyPricebookEntryValue.get(prod.Id).UnitPrice,
              PricebookEntryId = product2KeyPricebookEntryValue.get(prod.Id).Id,
              Quantity = 1));
          }
      }
      upsert orderItList;
    }
}