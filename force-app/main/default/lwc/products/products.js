import { LightningElement, wire, api } from 'lwc';
import getProductList from '@salesforce/apex/ProductsController.getProductList';
import orderUpdate from '@salesforce/apex/ProductsController.orderUpdate';
import getOrderProductList from '@salesforce/apex/OrderProductController.getOrderProductList';

const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'ListPrice', fieldName: 'ListPrice' },
];

export default class ApexDatatableExample extends LightningElement {
    @api getId;
    error;
    columns = columns;
    @wire (getOrderProductList) getOrderProductList;
    @wire(getProductList) productList;

    updateOrder(){
      var selectedRows = this.template.querySelector("lightning-datatable").getSelectedRows();  
      orderUpdate({'prodList' : selectedRows, 'dorderId' :  this.getId})
      .then(result=>{  
          this.dispatchEvent(new CustomEvent('add'));
        })  
        .catch(error=>{  
          console.log('Cloud not delete'+JSON.stringify(error));  
        }) 

    }
    
}