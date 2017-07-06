<%--@elvariable id="numberOfSessions" type="int"--%>
<%--@elvariable id="timestamp" type="long"--%>
<%--@elvariable id="sessionList" type="java.util.List<javax.servlet.http.HttpSession>"--%>
<%--
  Created by IntelliJ IDEA.
  User: 4120-ddgz
  Date: 02.06.2015
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<template:main htmlTitle="Sessions"
               bodyTitle="">
    <jsp:attribute name="navigationContent">

    There are a total of ${numberOfSessions} active sessions in this
    application.<br /><br />
    <c:forEach items="${sessionList}" var="s">
        <c:out value="${s.id} - ${s.getAttribute('username')}" />
        <c:if test="${s.id == pageContext.session.id}">&nbsp;(you)</c:if>
        &nbsp;- last active
        ${wrox:timeIntervalToString(timestamp - s.lastAccessedTime)} ago<br />
    </c:forEach>

    </jsp:attribute>
</template:main>
