<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html ng-app="app">
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>Billing Information</title>
      
     
      
      <!-- Bootstrap Css -->
      <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css">
      <!-- <link href="src/css/angular-datepicker.css" rel="stylesheet" type="text/css" /> -->
      
      <style type="text/css">
  		background-color: lightblue;
      	.marginTop14 {
      		margin-top: 14px;
      		padding-top:20px;
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
         <script src="src/js/angular-datepicker.js"></script> 
  
         
   </head>
    <body>
   
    
    <body ng-controller="billing_controller" >
    <div >
	<div class="container">
	<div class="col-sm-8 col-sm-offset-2">
    
    
   
    <form name="billingForm" method="post" ng-submit="submitForm()" novalidate>
    <label sytle>Billing Details:</label>  
    
        <div class="form-group">
    	<label>Name:</label>
    	<input type="text" name="name" class="form-control"  ng-minlength="1" ng-maxlength="100" required placeholder="Enter your name">
    	
    </div>
    
        <div class="form-group">
    	<lable>Email:</lable>
    	<input type="email" name="email" class="form-control"  ng-minlength="1" ng-maxlength="100" required placeholder="Enter your email">
    	<p ng-show="billingForm.add_line1.$invalid && !billingForm.add_line1.$pristine" class="help-block">Address Line 1 is required.</p>
    </div>
    
    
    <div class="form-group">
    	<lable>Address Line 1:</lable>
    	<input type="text" name="add1" class="form-control" ng-model="billingData.add_line1" ng-minlength="1" ng-maxlength="100" required placeholder="Street or Apartment Name">
    	<p ng-show="billingForm.add_line1.$invalid && !billingForm.add_line1.$pristine" class="help-block">Address Line 1 is required.</p>
    </div>
    
    <div class="form-group">
    	<lable>Address Line 2:</lable>
    	<input type="text" name="add2" class="form-control" ng-model="billingData.add_line2" ng-minlength="1" ng-maxlength="100" required placeholder="Apt No.">
    	<p ng-show="billingForm.add_line2.$invalid && !billingForm.add_line2.$pristine" class="help-block">Address Line 2 is required.</p>
    </div>
    
     <div class="form-group">
    	<lable>City:</lable>
    	<input type="text" name="city" class="form-control" ng-model="billingData.city" ng-minlength="1" ng-maxlength="100" required placeholder="City">
    	<p ng-show="billingForm.city.$invalid && !billingForm.city.$pristine" class="help-block">City is required.</p>
    </div>
    
    <div class="form-group">
    	<lable>Pincode:</lable>
    	<input type="text" name="pincode" class="form-control" ng-model="billingData.pincode" ng-minlength="5" ng-maxlength="5" required placeholder="Pincode">
    	<p ng-show="billingForm.pincode.$invalid && !billingForm.pincode.$pristine" class="help-block">Pincode is required.</p>
    </div>
    
    <div class="form-group">
    	<lable>State:</lable>
    	<input type="text" name="state" class="form-control" ng-model="billingData.state" ng-minlength="1" ng-maxlength="100" required placeholder="State">
    	<p ng-show="billingForm.state.$invalid && !billingForm.state.$pristine" class="help-block">State is required.</p>
    </div>
     <button type="submit" class="btn btn-primary" ng-disabled="billingForm.$invalid" ng-click='postData()'>Submit</button>
    </form>
    </div>
    </div>	
    </div>
    
   </body>



</html>