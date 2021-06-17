/**
  * Created by Eugene Pavlovskiy
  */

public with sharing class ProductsController {
    @AuraEnabled(cacheable=true)
    public static List<Product2> getProductList() {
        return [SELECT Id, Name FROM Product2 LIMIT 10];
     
    }
}