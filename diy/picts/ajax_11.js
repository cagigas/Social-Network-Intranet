	var xmlhttp;
	var xmlhttpObj;
	
	function ajaxRequest(ajaxurl, objid) 
	{
	    if (requestInProgress) {
	        setTimeout("ajaxRequest('"+ajaxurl+"','"+objid+"')",500);
	    }
	    else {
	        requestInProgress = true;
	        xmlhttpObj = objid;
		    document.getElementById(xmlhttpObj).innerHTML = "<img src='picts/loading.gif' border='0'/>";
		    if(window.XMLHttpRequest) {
			    xmlhttp = new XMLHttpRequest();
		    } else if(window.ActiveXObject) {
			    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		    } else {
			    return false;
		    }
		    xmlhttp.onreadystatechange=stateChange;
		    xmlhttp.open("GET", ajaxurl, true); 
		    xmlhttp.send(null); 
		}
	}
	
	function ajaxRequestScript(ajaxurl) 
	{
	    if (requestInProgress) {
	        setTimeout("ajaxRequestScript('"+ajaxurl+"')",500);
	    }
	    else {
	        requestInProgress = true;
		    if(window.XMLHttpRequest) {
			    xmlhttp = new XMLHttpRequest(); 
		    } else if(window.ActiveXObject) {
			    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); // Internet Explorer
		    } else {
			    return false;
		    }
		    xmlhttp.onreadystatechange=stateChangeScript;
		    xmlhttp.open("GET", ajaxurl, true); 
		    xmlhttp.send(null);
		} 
	}
	
	function stateChangeScript() {
		if (xmlhttp.readyState == 4) { 
			if (xmlhttp.status==200) 
			{ 
			    if (xmlhttp.responseText.indexOf("<title>Login</title>") == -1) 
			    {
				    eval(xmlhttp.responseText);
				}
				else 
				{
                    document.getElementById("ajxStatus").style.display = "inline";
                    document.getElementById("ajxStatus").innerHTML = requestFailedMessage;
				}
			} 
			else 
			{ 
                document.getElementById("ajxStatus").style.display = "inline";
                document.getElementById("ajxStatus").innerHTML = requestFailedMessage;
			}
			requestInProgress = false;
		}
	}
	
	function stateChange() {
		if (xmlhttp.readyState == 4) { 
			if (xmlhttp.status==200) 
			{ 
			    if (xmlhttp.responseText.indexOf("<title>Login</title>") == -1) 
			    {
				    document.getElementById(xmlhttpObj).innerHTML = xmlhttp.responseText;
				}
				else 
				{
                    document.getElementById("ajxStatus").style.display = "inline";
                    document.getElementById("ajxStatus").innerHTML = requestFailedMessage;
                    document.getElementById(xmlhttpObj).innerHTML = "";
				}
			} 
			else 
			{ 
                document.getElementById("ajxStatus").style.display = "inline";
                document.getElementById("ajxStatus").innerHTML = requestFailedMessage;
                document.getElementById(xmlhttpObj).innerHTML = "";
			}
			requestInProgress = false;
		}
	}