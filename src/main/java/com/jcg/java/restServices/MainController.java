package com.jcg.java.restServices;
//Just checking
import java.io.IOException;
import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONObject;

import com.google.gson.Gson;
import com.jcg.java.config.MyDb;
import com.jcg.java.model.Hotel;
import com.jcg.java.model.User;

@Path("/BookAndGo")
public class MainController {
    MyDb db=new MyDb();
    ObjectMapper mapper = new ObjectMapper();
	//Request for login
    @GET
	@Path("/Login/{param}/{params}")
	@Produces(MediaType.TEXT_PLAIN)
	public Response getLoginResponse(@PathParam("param") String userId,@PathParam("params") String password) {
            User user=new User();
            user.setUsers_email(userId);
            user.setUsers_password(password);
		String response=db.getLoginDetailsFromDb(user);
        if(response.equalsIgnoreCase("Logged in"))
		{return Response.status(200).entity(response).build();}else {
			
			return Response.status(404).entity(response).build();
		}
 
	}
  	 
		  @GET
			@Path("/Search/{param}")
			@Produces(MediaType.APPLICATION_JSON)
			public Response getSearchResponse(@PathParam("param") String searchString) {
		           
				List<Hotel> response=db.getSearchDetails(searchString);
				String json = new Gson().toJson(response);
		        if(response!=null)
				{return Response.status(200).entity(json).build();}else {
					
					return Response.status(404).entity(json).build();
				}	
}
		  
		  @POST
			@Path("/AddRegisterDetails")
			@Consumes(MediaType.APPLICATION_JSON)
		  @Produces(MediaType.TEXT_PLAIN)
			  	public Response postRegisterDetails(String userDetails) throws JsonParseException, JsonMappingException, IOException{
			  
			  
	  JSONObject requestedJSON = new JSONObject(userDetails);
			  User  user = mapper.readValue(requestedJSON.toString(), User.class);
					
				
				String dbresult=db.saveUsersDetails(user);
				  if(dbresult.equalsIgnoreCase("Added")) { return
				  Response.status(200).entity("Details Added").build();}else { return
				  Response.status(404).entity("Db Error").build(); }

			}
}
