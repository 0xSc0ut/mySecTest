<%@ page import="org.owasp.encoder.Encode" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<html>
<head>
	<title>Java LFI Tests</title>
</head>
<body>

<h1><center>Developer Security Fix Training</center></h1>
<a href="index.jsp">XML External Entity Injection</a> | <a href="LFIView.jsp">Local File Inclusion</a>
<%
	//Anti-Caching Controls
	response.setHeader("Cache-Control","no-store, no-cache, must-revalidate"); //HTTP 1.1 controls
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 controls
	response.setDateHeader ("Expires", 0); //Prevents caching on proxy servers

	//Anti-Clickjacking Controls
	response.setHeader("X-Frame-Options", "DENY");
%>


<% int testCount = 1;	// for numbering all tests %>

<p>LFI Implementations:</p>
<ul>
	<li><a href="https://xml.apache.org/xalan-j/apidocs/org/apache/xpath/package-summary.html">org.apache.xpath (link to <b>Apache Xalan-Java</b> Javadoc)</a>
		<ol start="<%= (testCount) %>">
			<li><a href="LFITest?payload=<%= Encode.forUriComponent("../../../../src/main/resources/xxe.txt") %>">Unsafe LFI Example</a></li>
		
		</ol>
		<br />
	</li>
</ul>
<script>
function InvokeGET(invokeTo) {
	  var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() {
	    if (this.readyState == 4 && this.status == 200) {
	      $("#AjaxContent").html(this.responseText);
	      // document.getElementById("AjaxContent").innerHTML = this.responseText;
	    }
	  };
	  xhttp.open("GET",invokeTo, true);
	  xhttp.send();
	}
</script>
</body>

</html>