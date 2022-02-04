trigger ForceForcecasting on User (before insert) {

     for (User u: trigger.new){
     u.Forecastenabled=true;
     
     
     }

}