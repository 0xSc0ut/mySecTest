<%@ page import="org.owasp.encoder.Encode" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<html>
<head>
	<title>Java XXE Tests</title>
	<style> .redText { color:red; } </style>
</head>
<body>

<h1><center>Developer Security Fix Training</center></h1>
<%-- <a href="index.jsp">XML External Entity Injection</a> --%>
<%-- | <a href="LFIView.jsp">Local File Inclusion</a> --%>
<%
    //Anti-Caching Controls
    response.setHeader("Cache-Control","no-store, no-cache, must-revalidate"); //HTTP 1.1 controls
    response.setHeader("Pragma","no-cache"); //HTTP 1.0 controls
    response.setDateHeader ("Expires", 0); //Prevents caching on proxy servers

    //Anti-Clickjacking Controls
    response.setHeader("X-Frame-Options", "DENY");
%>

<h3>
    <%
        /* final int javaVersionMajor = Integer.parseInt(Runtime.class.getPackage().getImplementationVersion().substring(2, 3));
        int javaVersionUpdate;
        if (Runtime.class.getPackage().getImplementationVersion().length() > 5) {
            javaVersionUpdate = Integer.parseInt(Runtime.class.getPackage().getImplementationVersion().substring(6));
        }
        else {
            javaVersionUpdate = 0;
        }

        out.println("Java Version: " + Runtime.class.getPackage().getImplementationVersion() + "<br>");
        if (javaVersionMajor >= 8) {
            out.println("Unsafe Tests: 29 <br> Safe Tests: 22");
        }
        else if (javaVersionMajor == 7 && javaVersionUpdate >= 51) {
            out.println("Unsafe Tests: 30 <br> Safe Tests: 21");
        }
        else if ((javaVersionMajor == 7 && javaVersionUpdate <= 45)) {
            out.println("Unsafe Tests: 31 <br> Safe Tests: 20");
        }
        else {
            out.println("These test cases have not been tested for the current Java version");
        } */
    %>
</h3>

<% int testCount = 1;   // for numbering all tests
StringBuilder contentBuilder = new StringBuilder();
		try{
			BufferedReader in;
			in = new BufferedReader(new InputStreamReader(getClass().getResourceAsStream("/xxetest1web.xml")));
			String str;
	        while ((str = in.readLine()) != null) {
	            contentBuilder.append(str);
	            contentBuilder.append("\n");
	        }
	        in.close();
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
%>

<p>XXE Using DoumentBuilder parser</p>
<ul>
	<li><a href="https://docs.oracle.com/javase/7/docs/api/javax/xml/parsers/DocumentBuilder.html">javax.xml.parsers.<b>DocumentBuilder</b> (link to Javadoc)</a>
        <ol>
					<li><a href="documentbuildersafedoctype?payload=<%= Encode.forUriComponent(contentBuilder.toString()) %>">Safe when Disallowing DOCTYPE Declarations Example</a></li>
        	<%-- <li><a href="documentbuilderunsafedefault?payload=<%= Encode.forUriComponent(contentBuilder.toString()) %>">Unsafe by Default Example</a></li>
        	<li><a href="documentbuildersafeexpand?payload=<%= Encode.forUriComponent(contentBuilder.toString()) %>">Safe" when Disabling Entity Expansion Example <span class="redText">(FAILURE)</span></a></li> --%>
        	<%-- <li><a href="documentbuildersafedoctype?payload=<%= Encode.forUriComponent(contentBuilder.toString()) %>">Safe when Disallowing DOCTYPE Declarations Example</a></li> --%>
        	<%-- <li><a href="documentbuildersafeexternal?payload=<%= Encode.forUriComponent(contentBuilder.toString()) %>">Safe when Disabling External General Entities Example</a></li>
        	<li><a href="documentbuilderunsafeexternal?payload=<%= Encode.forUriComponent(contentBuilder.toString()) %>">Unsafe when Enabling External General Entities Example</a></li>
        	<li><a href="documentbuilderunsafevalidationoff?payload=<%= Encode.forUriComponent(contentBuilder.toString()) %>">Unsafe when Disabling Validation Example</a></li>
        --%>
       <%-- <li><a href="documentbuilderunsafevalidationon?payload=<%= Encode.forUriComponent(contentBuilder.toString()) %>">Unsafe when Enabling Validation Example</a></li> --%>

            </ol>
        <br />
	</li>
</ul>

</body>
</html>
