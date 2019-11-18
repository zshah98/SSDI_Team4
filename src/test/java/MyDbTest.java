import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import javax.inject.Inject;
import javax.ws.rs.core.Application;

import org.glassfish.jersey.server.ResourceConfig;
import org.glassfish.jersey.test.JerseyTest;
import org.junit.Before;
import org.junit.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;

import com.jcg.java.config.DbDetails;
import com.jcg.java.config.MyDb;
import com.jcg.java.model.Hotel;
import com.jcg.java.model.User;
import com.mysql.jdbc.Connection;

public class MyDbTest extends JerseyTest {

	@Override
    protected Application configure() {
        return new ResourceConfig(MyDbTest.class);
    }
	//MyDb has methods which internally use user,hotel
	@InjectMocks private User user;
	 @Mock private Connection con;
	 @Mock	private Statement st;
	 @Mock	private ResultSet rs;
     
	 MyDb mydb=new MyDb();
	 User dummyuser;
	@Before
	  public void setUp() {
	    MockitoAnnotations.initMocks(this);
	    
	  }
	
	
	
	
	@Test
 public void testLogin() {
		
		user.setUsers_password("1234");
		user.setUsers_email("ssmith@gmail.com");
		String resp=mydb.getLoginDetailsFromDb(user);
		assertEquals("Logged in",resp);
	}
	@Test
	 public void testwrongLogin() {
			
			user.setUsers_password("123s");
			user.setUsers_email("ssmith@gmail.com");
			String resp=mydb.getLoginDetailsFromDb(user);
			assertEquals("No user Exists",resp);
		}
	@Test
	 public void searchFunction() {
			List<Hotel> l=mydb.getSearchDetails("Hilton");
			String response="Nothing retrieved";
			for(Hotel h:l) {
				if(h.getHotel_name()!=null) {
					 response="Retrieved";
					break;
				}
		}
			assertEquals("Retrieved",response);
		}
	@Test
	 public void wrongsearchFunction() {
			List<Hotel> l=mydb.getSearchDetails("xyz");
			String response="Nothing retrieved";
			for(Hotel h:l) {
				if(h.getHotel_name()!=null) {
					 response="Retrieved";
					break;
				}
		}
			assertEquals("Nothing retrieved",response);
		}
	@Test
	 public void testRegister() {
			user.setUsers_email("g@gmail.com");
			int userid=randomNumberGen();
			user.setUsers_id(userid);
			user.setUsers_nameFirst("randomTestuser");
			user.setUsers_password("1234");
			String resp=mydb.saveUsersDetails(user);
			assertEquals(resp,"Added");
			String responseDeleted=" Not Deleted";
			 con=(Connection) MyDb.connectDb();
		       
			try{String sql="Delete from users where users_id="+userid;
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
	@Test
	 public void testRegisterNotWorking() {
			//Trying to insert an empty user record.
			String resp=mydb.saveUsersDetails(dummyuser);
			assertEquals(resp,"Db error");
			
			
		}
	public int randomNumberGen() {
		 int userid=(int) ((Math.random() * ((10000 - 23) + 1)) + 23);
		 return userid;
	 }
}
