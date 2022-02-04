/**
 * @description       : Account SObject Trigger
 * @author            : Rakesh Ramaswamy
 * @group             : Google & Salesforce
 * @last modified on  : 02-02-2022
 * @last modified by  : Rakesh Ramaswamy
**/
trigger AccountTrigger on Account (before insert, before update) {
    if(trigger.isInsert){
        // code for before insert operations to be performed...
    }
    else if(trigger.isUpdate) {
        // code for before update operations to be performed...
    }
}