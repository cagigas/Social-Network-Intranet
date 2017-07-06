<%--@elvariable id="loginFailed" type="java.lang.Boolean"--%>

<%--
  Created by IntelliJ IDEA.
  User: 4120-ddgz
  Date: 02.06.2015
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<template:main htmlTitle="Main"
                bodyTitle="">
    <jsp:attribute name="navigationContent">

        <form method="POST" action="<c:url value="/login" />">
            <input type="radio" name="username" value="David">David&nbsp;&nbsp;<input type="radio" name="username" value="Mario">Mario&nbsp;&nbsp;<input type="radio" name="username" value="Pedro">Pedro&nbsp;&nbsp;<input type="password" name="password" placeholder="Password"></p>
            <p class="submit"><input type="submit" name="commit" value="Login"></p>
        </form>
        <c:if test="${loginFailed}">
            <b>The username or password you entered are not correct. Please try
                again.</b><br /><br />
        </c:if>


    </jsp:attribute>
</template:main>
