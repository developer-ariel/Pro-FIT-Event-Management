import { LightningElement, api, wire, track } from 'lwc';
import getSpeakers from "@salesforce/apex/EventDetailsClassController.getSpeakers";
import getLocationDetails from "@salesforce/apex/EventDetailsClassController.getLocationDetails";
import getAttendees from "@salesforce/apex/EventDetailsClassController.getAttendees";
const columnsSpk = [
    { label: 'Speaker Name', fieldName: 'Speaker_Name', type: 'text' },
    { label: 'Email', fieldName: 'Speaker_Email', type: 'text' },
    { label: 'Phone', fieldName: 'Phone', type: 'text' },
    { label: 'Company', fieldName: 'Company_Name', type: 'text' }
];
const columnsAtt = [
    { label: 'Attendee Name', fieldName: 'Attendee_Name', type: 'text' },
    { label: 'Email', fieldName: 'Attendee_Email', type: 'text' },
    { label: 'Phone', fieldName: 'Phone', type: 'text' },
    { label: 'Company', fieldName: 'Company_Name', type: 'text' }
];

export default class EventDetails extends LightningElement {
    @api recordId;
    @track speakerList;
    @track attendeeList;
    @track eventLocation;
    @track columnsSpk = columnsSpk;
    @track columnsAtt = columnsAtt;

    @wire(getSpeakers, {eventId:'$recordId'})
    wiredSpeakers({data, error}){
        if(data){
            let speakerRow = [];
            data.forEach(spk => {
                speakerRow.push({
                    Speaker_Name : spk.Speaker__r.Name,
                    Speaker_Email : spk.Speaker__r.Email__c,
                    Phone : spk.Speaker__r.Phone__c,
                    Company_Name : spk.Speaker__r.Company__c
                });
            });
            this.speakerList = speakerRow;
        }else{
            console.log(error);
        }
    }
    @wire(getLocationDetails, {eventId:'$recordId'})
    wiredLocation({data, error}){
        if(data){
            this.eventLocation = data;
        }else{
            console.log(error);
        }
    }
    @wire(getAttendees, {eventId:'$recordId'})
    wiredAttendees({data, error}){
        if(data){
            let attendeeRow = [];
            data.forEach(att => {
                attendeeRow.push({
                    Attendee_Name : att.Attendee__r.Name,
                    Attendee_Email : att.Attendee__r.Email__c,
                    Phone : att.Attendee__r.Phone__c,
                    Company_Name : att.Attendee__r.Company_Name__c
                });
            });
            this.attendeeList = attendeeRow;
        }else{
            console.log(error);
        }
    }
}