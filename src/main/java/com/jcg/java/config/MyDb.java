package com.jcg.java.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.jcg.java.model.BillingDetails;
import com.jcg.java.model.Hotel;
import com.jcg.java.model.PaymentDetails;
import com.jcg.java.model.Room;
import com.jcg.java.model.User;
import com.mysql.jdbc.PreparedStatement;

public class MyDb {

	public static ResultSet rsObj = null;
	public static Statement stmtObj = null;
	public static Connection connObj = null;
    public static DbDetails dbDetails=new DbDetails(); 
	/***** Method #1 :: This Method Is Used To Create A Connection With The Database *****/
	public static  Connection connectDb() {
		
		
	      String userName =dbDetails.getUserName();
	      String password =dbDetails.getPassword();
	      String jdbcUrl =dbDetails.getJdbcUrl();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			connObj = DriverManager.getConnection(jdbcUrl,userName,password);			
 	} catch (Exception exObj) {
			exObj.printStackTrace();
		}
		return connObj;
	}

	

	/***** Method #3 :: This Method Is Used To Close The Connection With The Database *****/
	public  void disconnectDb() {
		try {
			rsObj.close();
			stmtObj.close();
			connObj.close();
		} catch (SQLException sqlExObj) {
			sqlExObj.printStackTrace();
		}		
	}
		//Method to get username and password searched by user
		public String getLoginDetailsFromDb(User user){
			String response="No user Exists";
			String correctpwd="";
			try {
		   	String sql ="select *  from USERS WHERE users_email = '" + user.users_email + "' AND users_password = " + user.users_password ;
	           	stmtObj = connectDb().prepareStatement(sql);
				rsObj = stmtObj.executeQuery(sql);
				
		        if(rsObj.next()){
		        correctpwd=rsObj.getString("users_password");
					
				}
		        
		        if(correctpwd.equalsIgnoreCase(user.users_password)) {
		        	response="Logged in";
		        	
		        }else {
		        
		        }
				
			} catch (SQLException sqlExObj) {
				sqlExObj.printStackTrace();
			} finally {
			//disconnectDb();
			return response;
			}
			
			
		}

		  
	  //Method to get search Results from DB
	public List<Hotel> getSearchDetails(String searchString) {
		Hotel hotel = null;
		List<Hotel> eList = new ArrayList<Hotel>();
 	String sql ="SELECT * FROM (SELECT * FROM hotel) t1 LEFT OUTER JOIN (SELECT * FROM event) t2 ON t1.event_id = t2.event_id WHERE t1.hotel_name='"+searchString + "'OR t2.event_name='"+searchString+"'OR t1.hotel_address='"+searchString+"'" ;
       	try{
       		
       		stmtObj = connectDb().prepareStatement(sql);
		rsObj = stmtObj.executeQuery(sql);
		//Getting the hotel details from search 
while(rsObj.next()) {
	hotel = new Hotel(rsObj.getInt("hotel_id"), rsObj.getString("hotel_name"), rsObj.getString("hotel_address"),rsObj.getString("Room_id"),rsObj.getString("Room_type"));
	      if(rsObj.getString("event_id")!=null)
	      { hotel.setEvent_name(rsObj.getString("event_name"));
	        hotel.setEvent_id(rsObj.getString("event_id"));
	        hotel.setEvent_times(rsObj.getString("event_times"));}
	eList.add(hotel);	
       	}
       	
       	
       	}
       	
       	
       	
       	catch(SQLException sqlExObj) {
       		sqlExObj.printStackTrace();
       	}
       	finally {
       		return eList;
       	}
		
	}



	public String saveUsersDetails(User user) {
		String response="Db error"; try {
			 
			  String sql ="INSERT INTO users ("+"users_id,"+"users_nameFirst,"+"users_nameLast"+",users_email"+",users_type"+",users_password) VALUES (?,?,?, ?,null,?)";
		 java.sql.PreparedStatement ps = connectDb().prepareStatement(sql);
			 int userid=randomNumberGen();
			  ps.setInt(1,userid); 
			  ps.setString(2,user.users_nameFirst); 
			  ps.setString(3,user.users_nameLast);
			  ps.setString(4,user.users_email); 
			  //ps.setString(5,user.users_type);
			  ps.setString(5,user.users_password); 
			  if(ps.executeUpdate()!=0) {
				  response="Added"; 
			  }
		}
		catch (SQLException sqlExObj) { sqlExObj.printStackTrace(); } finally {
			   return response; }
	
	}
	//To delete a particular user from the database
	public String deleteUsers(String userId) {
		String response=" Not Deleted";
		try{String sql="Delete from users where users_id="+userId;
		stmtObj = connectDb().prepareStatement(sql);
		if(stmtObj.executeUpdate(sql)==0) {
			response="Deleted";
		}
		}
		
		catch(SQLException sqlExObj) {
			sqlExObj.printStackTrace();
		}
		return response;
	}
	
	 public int randomNumberGen() {
		 int userid=(int) ((Math.random() * ((10000 - 23) + 1)) + 23);
		 return userid;
	 }
	 public String savePaymentDetails(PaymentDetails dumbpay) {
			String response="Db error"; try {
				 String sql ="INSERT INTO Payment_details(user_id,user_name,card_no,ccv) VALUES (null,?, ?, ?)";
				 java.sql.PreparedStatement ps = connectDb().prepareStatement(sql);
				 int user_id=randomNumberGen();
				  ps.setString(1,dumbpay.getUser_name()); 
				  ps.setDouble(2, dumbpay.getCard_no());
				  ps.setInt(3, dumbpay.getCcv());
				  if(ps.executeUpdate()!=0) {
					  response="Added"; 
				  }
			}
			catch (SQLException sqlExObj) { sqlExObj.printStackTrace(); } finally {
				   return response; }
		}



		public String saveBillingDetails(BillingDetails dumbbill) {
			String response="Db error"; try {
				 
				  String sql ="INSERT INTO Billing_details VALUES (?,?, ?, ?, ?, ?)";
				 java.sql.PreparedStatement ps = connectDb().prepareStatement(sql);
				 int user_id=randomNumberGen();
				  ps.setInt(1,user_id); 
				  ps.setString(2,dumbbill.getAdd_line1()); 
				  ps.setString(3, dumbbill.getAdd_line2());
				  ps.setString(4, dumbbill.getCity());
				  ps.setInt(5, dumbbill.getPincode());
				  ps.setString(6, dumbbill.getState());
				  if(ps.executeUpdate()!=0) {
					  response="Added"; 
				  }
			}
			catch (SQLException sqlExObj) { sqlExObj.printStackTrace(); } finally {
				   return response; }
		}
		//Service for getting details from room_details
		public List<Room> getRoomDetails(String hotel_name,String room_type,String hotel_address){
			Room room = null;
			List<Room> eList = new ArrayList<Room>();
			String sql="SELECT t2.hotel_id,t2.room_id,t2.room_type,t2.roomAvailableFlag,t2.roomPrice,t2.no_of_beds,t2.room_floor FROM (SELECT * FROM hotel) t1 RIGHT OUTER JOIN (SELECT * FROM room) t2 ON t1.hotel_id = t2.hotel_id WHERE t2.room_type="+"'"+room_type+"'"+" AND t2.roomAvailableFLag='Yes' AND t1.hotel_name="+"'"+hotel_name+"'"+"AND t1.hotel_address="+"'"+hotel_address+"'";
			
		       	try{
		       		
		       		stmtObj = connectDb().prepareStatement(sql);
				rsObj = stmtObj.executeQuery(sql);
				//Getting the hotel details from search 
		while(rsObj.next()) {
			room = new Room(rsObj.getString("room_id"),rsObj.getInt("hotel_id"),rsObj.getString("room_type"),rsObj.getInt("room_floor"),rsObj.getString("roomAvailableFlag"),rsObj.getInt("no_of_beds"),rsObj.getString("roomPrice"));
		   
			eList.add(room);	
		       	}
		       	
		       	
		       	}
		       	
		       	
		       	
		       	catch(SQLException sqlExObj) {
		       		sqlExObj.printStackTrace();
		       	}
		       	finally {
		       		return eList;
		       	}
			
			
			
			
			
		}
}
