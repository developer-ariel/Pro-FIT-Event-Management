import { LightningElement, api, wire, track } from "lwc";
import getUpcomingEvents from "@salesforce/apex/AttendeeEventsService.getUpcomingEvents";
import getPastEvents from "@salesforce/apex/AttendeeEventsService.getPastEvents";
const columnsFtrEvts = [
    { label: 'Event', fieldName: 'Event_Name', type: 'text' },
    { label: 'Organizer', fieldName: 'Event_Organizer', type: 'text' },
    { label: 'Event Date', fieldName: 'Start_Date', type: 'date-local'},
    { label: 'Event Type', fieldName: 'Event_Type', type: 'text' }
];
const columnsPstEvts = [
    { label: 'Event', fieldName: 'Past_Event_Name', type: 'text' },
    { label: 'Organizer', fieldName: 'Past_Event_Organizer', type: 'text' },
    { label: 'Event Date', fieldName: 'Past_Event_Start_Date', type: 'date-local'},
    { label: 'Event Type', fieldName: 'Past_Event_Type', type: 'text' }
];
export default class AttendeeEvents extends LightningElement {
    @api recordId;
    @track futureEventList;
    @track pastEventList;
    @track columnsFtrEvts = columnsFtrEvts;
    @track columnsPstEvts = columnsPstEvts;

    @wire(getUpcomingEvents, {attendeeId:'$recordId'})
    wiredUpcomingEvents({data}){
        if(data){
            let eventRow = [];
            data.forEach(evt => {
                eventRow.push({
                    Event_Name : evt.Event_for_Pro_FIT__r.Name__c,
                    Event_Organizer : evt.Event_for_Pro_FIT__r.Organizer__r.Name,
                    Start_Date : evt.Event_for_Pro_FIT__r.Start__c,
                    Event_Type : evt.Event_for_Pro_FIT__r.Event_Type__c
                });
            });
            this.futureEventList = eventRow;
        }
    }
    @wire(getPastEvents, {attendeeId:'$recordId'})
    wiredPastEvents({data}){
        if(data){
            let pastEventRow = [];
            data.forEach(pstEvt => {
                pastEventRow.push({
                    Past_Event_Name : pstEvt.Event_for_Pro_FIT__r.Name__c,
                    Past_Event_Organizer : pstEvt.Event_for_Pro_FIT__r.Organizer__r.Name,
                    Past_Event_Start_Date : pstEvt.Event_for_Pro_FIT__r.Start__c,
                    Past_Event_Type : pstEvt.Event_for_Pro_FIT__r.Event_Type__c
                });
            });
            this.pastEventList = pastEventRow;
        }
    }
}
