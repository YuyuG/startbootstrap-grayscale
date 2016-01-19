
		
		if(request.getAttribute("user") != null){
			username = (String)request.getAttribute("user");
			
			System.out.println("GET IT TO WORK");
	        // This will reference one line at a time
	        String line = null;

	        try {
	            // FileReader reads text files in the default encoding.
	            FileReader fileReader = 
	                new FileReader(fullpath);

	            // Always wrap FileReader in BufferedReader.
	            BufferedReader bufferedReader = 
	                new BufferedReader(fileReader);
	            int count = 0;
	            while((line = bufferedReader.readLine()) != null) {
	               pwdFile[count] = line;
	               count += 1;
	               System.out.println("Has next line ");
	            }   

	            // Always close files.
	            bufferedReader.close();         
	        }
	        catch(FileNotFoundException ex) {
	            System.out.println(
	                "Unable to open file '" + 
	                		fullpath + "'");                
	        }
	        catch(IOException ex) {
	            System.out.println(
	                "Error reading file '" 
	                + fullpath + "'");                  
	            // Or we could just do this: 
	            // ex.printStackTrace();
	        }
	    }
			
			
			
		Map<String, String> pwdMap = new TreeMap<String, String>();
		
		for(int i = 0; i < pwdFile.length; i ++){
			
			String[] split = pwdFile[i].split(" ");
			pwdMap.put(split[0], split[1]);
		}
		
		String userInput = (String) request.getAttribute("pwd");
		String hash = "";
		try{
		 hash = javax.xml.bind.DatatypeConverter.printHexBinary(MessageDigest.getInstance("SHA1").digest((userInput).getBytes()));
		
		}catch(Exception e){
			e.printStackTrace();
		}
		boolean check = false;
		for(Map.Entry<String, String> entry : pwdMap.entrySet()){
			
			if(entry.getKey().contentEquals(username) && entry.getValue().contentEquals(hash)){
				check = true;
				break;
				
			}else{
				check = false;
			}
		}
		if(check){
		request.getSession().setAttribute("loggedIn", username);
		}
		if(!check){
			
			if(request.getSession().getAttribute("loggedIn") != null){
				request.getSession().removeAttribute("loggedIn");
				request.setAttribute("errorMsg", "Invalid Credentials!");
			}
		}
		
		if(request.getSession().getAttribute("loggedIn") != null){
			request.setAttribute("target", "MaxP.jspx");
		}else{
			request.setAttribute("target", "Login.jspx");
		}
		
		
		}