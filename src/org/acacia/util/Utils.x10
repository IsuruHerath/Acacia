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

package org.acacia.util;

import x10.io.FileReader;
import x10.io.File;
import x10.io.IOException;
import x10.util.ArrayList;
import x10.util.HashMap;
import x10.compiler.Native;

public class Utils {

    public static def getHostName():String{       
        val hostName = System.getenv("HOSTNAME");
        
        if(hostName != null){	            
            return hostName;
        }else{
            var hstNm:String = null;
        
            try{
                hstNm = java.net.InetAddress.getLocalHost().getHostName();
            }catch(val e:java.net.UnknownHostException){
                e.printStackTrace();
            }
            
            return hstNm;
        }
    }

    public static def isPublic(val hostName:String):Boolean{
         var result:Boolean = false;
         
         try{
	         val input = new File("" + Conts.ACACIA_SERVER_PUBLIC_HOSTS_FILE);
	         for(line in input.lines()){
	             if(line.trim().equals(hostName)){
                       result = true;
	             }
	         }
         }catch(e:IOException){
             Console.OUT.println(e.getMessage());
         }
         
         return result;
    }
    
    public static def getPublicHostList():Rail[String]{
        var result:ArrayList[String] = new ArrayList[String]();
    
	    try{
		    val input = new File("" + Conts.ACACIA_SERVER_PUBLIC_HOSTS_FILE);
		    for(line in input.lines()){
		        if(line.trim() != ""){
                  result.add(line.trim());
		        }
		    }
	    }catch(e:IOException){
	        Console.OUT.println(e.getMessage());
	    }
    
        return result.toRail();
    }
    
    public static def getPrivateHostList():Rail[String]{
	    var result:ArrayList[String] = new ArrayList[String]();
	    
	    try{
	    	val input = new File("" + Conts.ACACIA_SERVER_PRIVATE_HOSTS_FILE);
		    for(line in input.lines()){
		    	result.add(line.trim());
		    }
	    }catch(e:IOException){
	    	Console.OUT.println(e.getMessage());
	    }
	    
	    return result.toRail();
    }

	public static def getBatchUploadFileList():HashMap[String, String]{
	//public static def getBatchUploadFileList():String{
		// var reader: FileReader = new FileReader(new File("" + Conts.BATCH_UPLOAD_FILE_LIST));
		// var line:String = null;
		// 
		// while(true){
		// 	try{
		// 		line = reader.readLine();
		// 	}catch(IOException){
		// 		break;
		// 	}
		// }
		
		val result:HashMap[String, String] = new HashMap[String, String]();

		try{
			val input = new File("" + Conts.BATCH_UPLOAD_FILE_LIST);
			for(line in input.lines()){
				if(!(line.startsWith("#") || line.equals(""))){
					var arr:Rail[String] = line.split(":");
					result.put(arr(0), arr(1));
				}
			}
		}catch(e:IOException){
			Console.OUT.println(e.getMessage());
		}
		
		return result;
	}
	
	@Native("java", "org.acacia.util.java.Utils_Java.getRuntimeLocation()")
	public static native def call_getRuntimeLocation():String;
	
	@Native("java", "org.acacia.util.java.Utils_Java.getAcaciaProperty(#1)")
	public static native def call_getAcaciaProperty(String):String;
}