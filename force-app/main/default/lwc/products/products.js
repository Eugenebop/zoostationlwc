import { LightningElement, wire } from 'lwc';
import getProductList from '@salesforce/apex/ProductsController.getProductList';

const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'ListPrice', fieldName: 'ListPrice' },

];
export default class ApexDatatableExample extends LightningElement {

    error;
    columns = columns;

    @wire(getProductList) productList;

}