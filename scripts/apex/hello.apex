// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

List<Product2> prod = [SELECT id FROM Product2 WHERE Id != '01t5g000002M49KAAS'];
List<PriceBook2> priceBook = [SELECT id, isStandard FROM PriceBook2 WHERE isStandard = true];
List<PriceBookEntry> priceBookEntryList = new List<PriceBookEntry>();
for(Integer i = 0; i < prod.size(); i++){
    priceBookEntryList.add(
        new PriceBookEntry(
            Pricebook2Id = priceBook[0].Id,
            Product2Id =  prod[i].Id,
            UnitPrice = 10.0
        )
    );
}
insert priceBookEntryList;
