import {LightningElement, wire, api, track } from 'lwc';
import getOrderProductList from '@salesforce/apex/OrderProductController.getOrderProductList';
import {refreshApex} from '@salesforce/apex';  
const columns = [
    { label: 'Name', fieldName:'Name'},
    { label: 'Unit price', fieldName:'UnitPrice', type: 'currency',typeAttributes : {currencyCode:'USD',step: '0.001'}},
    { label: 'Quantity', fieldName:'Quantity', type:'number'},
    { label: 'Total Price', fieldName:'TotalPrice',  type: 'currency',typeAttributes : {currencyCode:'USD',step: '0.001'}}
];
export default class OrderItems extends LightningElement {
    @api refresh;
    columns = columns;
    wiredOrderItems;
    orderItem;
    @api recordId;
    @wire(getOrderProductList, {orderId: '$recordId'}) wiredOrderItems(value){
    this.refresh = value;

    if(value.data){
        let tempRecords = JSON.parse(JSON.stringify(value.data));
        tempRecords = tempRecords.map(row => {
            return { UnitPrice : row.UnitPrice, 
                        Name : row.Product2.Name,
                        TotalPrice : row.TotalPrice,
                        Quantity : row.Quantity
                    };
        });
        this.orderItem = tempRecords;
    }
    else if ( value.error ) {
        this.error = error;
        this.orderItem = undefined;
    }
}

redrM(){
    refreshApex(this.refresh);
}

}