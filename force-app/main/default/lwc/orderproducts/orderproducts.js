import { LightningElement, wire } from 'lwc';
import getOrderProductList from '@salesforce/apex/OrderProductController.getOrderProductList';

const columns = [
    { label: 'First Name', fieldName: 'FirstName' },
    { label: 'Last Name', fieldName: 'LastName' },
    { label: 'Title', fieldName: 'Title' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
    { label: 'Email', fieldName: 'Email', type: 'email' }
];
export default class ApexDatatableExample extends LightningElement {

    error;
    columns = columns;

    @wire(getOrderProductList)
    OrderItem;

}