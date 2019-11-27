import static org.junit.Assert.assertEquals;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.ws.rs.core.Application;
import javax.ws.rs.core.Response;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.glassfish.jersey.server.ResourceConfig;
import org.glassfish.jersey.test.JerseyTest;
import org.junit.Before;
import org.junit.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import com.jcg.java.config.MyDb;
import com.jcg.java.model.User;
import com.jcg.java.restServices.MainController;
import com.mysql.jdbc.Connection;

public class MainControllerTest extends JerseyTest{

	@Override
    protected Application configure() {
       return new ResourceConfig(MainControllerTest.class);
    }
	//Here MainController depends on MyDb class
	@InjectMocks private MyDb mydb;
	@Mock private Connection con;
	 @Mock	private Statement st;
	 @Mock	private ResultSet rs;
	MainController mcontroller=new MainController();
	@Before
	  public void setUp() {
	    MockitoAnnotations.initMocks(this);
	    
	  }
	
	@Test
	public void testLoginService() {
		Response res=mcontroller.getLoginResponse("ssmith@gmail.com","1234");
		assertEquals(res.getStatus(),200);
	}
	@Test
	public void testSearchService() {
		Response res=mcontroller.getSearchResponse("Hilton");
		assertEquals(res.getStatus(),200);
	}
	@Test
	public void testRegisterService() throws JsonParseException, JsonMappingException, IOException {
		Response res=mcontroller.postRegisterDetails("{\"users_id\":\"\",\"users_nameFirst\":\"arikasai\",\"users_nameLast\":\"zarna\",\"users_password\":\"123\",\"users_email\":\"harikapaluri@gmail.com\"}");
		assertEquals(res.getStatus(),200); //Checking for insertion.
		//Trying to delete what we inserted
				String responseDeleted=" Not Deleted";
				 con=(Connection) MyDb.connectDb();
			       
				try{String sql="Delete from users where users_nameFirst='aarikasai'";
				st=con.createStatement();
				
				if(st.executeUpdate(sql)==0) {
					responseDeleted="Deleted";
				}
				}
				
				catch(SQLException sqlExObj) {
					sqlExObj.printStackTrace();
				}
				assertEquals("Deleted",responseDeleted);
		
	}
	//Billing details Test
	@Test
	public void testSaveBillingDetails() throws JsonParseException, JsonMappingException, IOException {
		Response res=mcontroller.postBillingDetails("{\"add_line1\":\"sssssssss\",\"add_line2\":\"ssssssss\",\"city\":\"Charlotte\",\"pincode\":\"28262\",\"state\":\"North Carolina\"}");
		assertEquals(res.getStatus(),200);
	}
	//Payment details Test
	@Test
	public void testSavePaymentDetails() throws JsonParseException, JsonMappingException, IOException {
		Response res=mcontroller.postPaymentDetails("{\"user_name\":\"harika\",\"card_no\":\"123213231322222\",\"ccv\":\"123\",\"month\":\"8\",\"year\":\"2021\"}");
		assertEquals(res.getStatus(),200);
	}
	//roomDetails
	@Test
	public void testgetRoomDetails() {
		Response res=mcontroller.getRoomDetailsResponse("Wynn","Kings Bed","28662 Concord Mall");
		//Get room data only of room is available.
		assertEquals(res.getStatus(),200);
	}
	//BookingDetails
	@Test
	public void testBookingDetails() {
		Response res=mcontroller.getBookingDetailsResponse("1","W110");
		//Getting details of a booked room
		assertEquals(res.getStatus(),200);
	}
}
