@isTest
private  with sharing class OrderProductControllerTest{
    @TestSetup
    static void setup(){
        Account acc = new Account();
        acc.Name  = 'Testacc';
        insert acc;
        Product2 prod = new Product2(
            Name = 'Test Product2',
            ProductCode = 'TestCode',
            IsActive = true
        );
        insert prod;
        
        PricebookEntry pbe = new PricebookEntry();
        pbe.Product2Id = prod.Id;
        pbe.Pricebook2Id = Test.getStandardPricebookId();
        pbe.UnitPrice = 100;
        insert pbe;

        Order order = new Order();
        order.Name = 'Test order';
        order.Pricebook2Id = Test.getStandardPricebookId();
        order.AccountId = acc.Id;
        order.EffectiveDate = Date.today();
        order.Status ='Draft';
        insert order;

        OrderItem orderItem = new OrderItem();

        orderItem.OrderId = order.Id;
        orderItem.Product2Id = prod.Id;
        orderItem.UnitPrice = 200;
        orderItem.PricebookEntryId = pbe.Id;
        orderItem.Quantity = 1;    
        insert orderItem;
        

    }
    @IsTest
    static void someMeth(){
        Order order = [SELECT Id FROM Order LIMIT 1];

        Test.startTest();
        List<OrderItem> orderItem = [SELECT Id, OrderId, Product2Id FROM OrderItem WHERE orderId =:order.Id];
        System.assertEquals(orderItem[0].Id, OrderProductController.getOrderProductList(order.Id)[0].Id);
        
        Test.stopTest();
        
    }

}