/**
Copyright 2015 Acacia Team

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
 */

package org.acacia.backend;

import org.acacia.log.java.Logger_Java;
import org.acacia.util.java.Conts_Java;
import org.acacia.util.java.Utils_Java;

import java.io.IOException;
import java.net.BindException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;


/**
 * The Acacia back-end.
 */
public class AcaciaBackEnd {
	private boolean runFlag = true;
	private ServerSocket srv;
	private ArrayList<AcaciaBackEndServiceSession> sessions = new ArrayList<AcaciaBackEndServiceSession>();
	
    public void run(){
    	try{
    		Logger_Java.info("Starting the backend");
    		srv = new ServerSocket(Conts_Java.ACACIA_BACKEND_PORT);
    		Logger_Java.info("Done creating backend");

    		while(runFlag){
	                Socket socket = srv.accept();
	                AcaciaBackEndServiceSession session = new AcaciaBackEndServiceSession(socket);
	                sessions.add(session);
    				session.start();
	    	}
    		
    		// while(runFlag){
    		// 	var socket:Socket = srv.accept();
    		// 	val skt = socket;
    		// 	val session:AcaciaFrontEndServiceSession = new AcaciaFrontEndServiceSession(skt);
    		// 	sessions.add(session);
    		// 	session.start();
    		// }
    		
    	}catch(BindException e){
    		Logger_Java.error("Error : " + e.getMessage());
    	} catch (IOException e) {
    		Logger_Java.error("Error : " + e.getMessage());
    	}
    }
    
}