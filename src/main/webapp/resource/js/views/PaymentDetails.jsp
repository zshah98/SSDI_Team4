<!DOCTYPE html>
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>BookAndGo</title>
      
     
      
      <!-- Bootstrap Css -->
      <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css">
      
      <style type="text/css">
  		background-color: lightblue;
      	.marginTop14 {
      		margin-top: 14px;
      	}
      </style>
    <!-- Javascript Files -->      
      <script type="text/javascript" src="resource/js/angular_v1.6.0.js"></script>	    	   
      <script type="text/javascript" src="resource/js/controller/PaymentDetails.js"></script>    
      <script type="text/javascript" src="resource/js/angular-route.js"></script>
      <script src="resource/js/controller/PaymentDetails.js"></script>   
   	 <script src="http://code.angularjs.org/1.2.6/angular.js"></script>
   	<script src= 
"https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"> 
        </script> 
  
         
   </head>
    <body>
   
    
    <body >
    
        
    <div ng-app="validationApp" ng-controller="payment_controller">
	<div class="container">
	<div class="col-sm-8 col-sm-offset-2">
    
    <div class="page-header"><h2 align="center" class="text-primary">Book And Go</h2></div> 
   
    <form name="paymentForm" ng-submit="submitForm()" novalidate>
    
   
   <div ng-controller="payment_controller">
  <label>Enter name: <input type="text" ng-model="bookid"></label><br>
  BookingID: <span ng-bind="bookid"></span>
    </div>
    
    <div ng-controller="payment_controller">
  <label>Enter name: <input type="text" ng-model="paymentid"></label><br>
  PyamentID: <span ng-bind="paymentid"></span>
    </div>
    
    <div ng-controller="payment_controller">
  <label>Enter name: <input type="number" ng-model="roomprice"></label><br>
  Room Price:$ <span ng-bind="roomprice"></span>
    </div>
    
    
    <div class="form-group">
    	<lable>Name on credit/debit card</lable>
    	<input type="text" name="name" class="form-control" ng-model="name" ng-minlength="1" ng-maxlength="100" required>
    	<p ng-show="paymentForm.name.$invalid && !paymentForm.name.$pristine" class="help-block">You name is required.</p>
    </div>
    
    <div class="form-group">
    	<lable>Credit card number</lable>
    	<input type="number" name="cardno" class="form-control" ng-model="cardno" ng-minlength="16" ng-maxlength="16" required>
    	<p ng-show="paymentForm.cardno.$invalid && !paymentForm.cardno.$pristine" class="help-block">Enter 16 digit card number.</p>
    </div>
    
    <div class="form-group">
    	<lable>Email</lable>
    	<input type="email" name="users_email" class="form-control" ng-model="users_email" required>
    	<p ng-show="paymentForm.users_email.$invalid && !paymentForm.users_email.$pristine" class="help-block">Enter correct email address.</p>
    </div>
    
    
     <div class="form-group">
    	<lable>Valid till</lable>
    	<input type="date" name="validdate" class="form-control" ng-model="validdate" required>
    	<p ng-show="paymentForm.validdate.$invalid && !paymentForm.validdate.$pristine" class="help-block">Enter correct date.</p>
    </div>
    
    
        
   <button type="submit" class="btn btn-primary" ng-disabled="paymentForm.$invalid" ng-click='postData()'>Submit</button>
    </form>
    </div>
    </div>	
    </div>
    <div> 
            <p>{{ today | date : "dd.MM.y" }}</p> 
        </div> 
   </body>



</html>



