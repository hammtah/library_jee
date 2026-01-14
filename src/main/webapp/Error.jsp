<%--
  Created by IntelliJ IDEA.
  User: taha
  Date: 1/14/26
  Time: 10:26 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isErrorPage="true"%>
<html>
<head>
    <title>Error</title>
</head>
<body>
<h1 style="color: red">Error </h1>
<p><%=exception.getMessage()%></p>
</body>
</html>
