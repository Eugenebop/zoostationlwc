@IsTest
public with sharing class ProductsControllerTest{

    @TestSetup
    static void makeData(){
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
    }

    @IsTest 
    private static void getProduct(){
        System.assertNotEquals(null, ProductsController.getProductList());
    }
    @IsTest 
    private static void orderUpdate(){

        List<Product2> prod = [
            SELECT Id FROM Product2
        ];
        Order order = [
            SELECT Id FROM Order Limit 1
        ];
        

        ProductsController.orderUpdate(prod, order.Id);
        OrderItem oi = [
            SELECT Id, OrderId,Product2Id FROM OrderItem LIMIT 1
        ];
        System.assertEquals(oi.OrderId, Order.Id);
    }


}