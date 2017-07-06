<%@ tag body-content="scriptless" trimDirectiveWhitespaces="true" %>
<%@ attribute name="htmlTitle" type="java.lang.String" rtexprvalue="true"
              required="true" %>
<%@ attribute name="bodyTitle" type="java.lang.String" rtexprvalue="true"
              required="true" %>
<%@ attribute name="navigationContent" fragment="true" required="true" %>
<%@ tag body-content="scriptless" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/jsp/base.jspf" %>
<%--@elvariable id="username" type="java.lang.String"--%>
<!DOCTYPE html>
<html>
<head>

    <title>SA WTV :: <c:out value="${fn:trim(htmlTitle)}" /></title>
    <meta name="description" content="website description" />
    <meta name="keywords" content="website keywords, website keywords" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <link rel="stylesheet" type="text/css" href="src/css/fonts.css"  />
    <link rel="stylesheet" type="text/css" href="src/css/style.css"  />
    <link rel="shortcut icon" href="https://pbs.twimg.com/profile_images/2672449394/2d242436b92b0382875ccef8566874b7_400x400.jpeg">
    <script src="src/js/jquery.js"></script>
    <script src="src/js/general.js"></script>
</head>
<body><div id="main">&nbsp;
    <div id="wrapper">
        <p align="right"><a href="<c:url value="/login?logout"></c:url>">${username}</a></p>
        <ul class="menu2">
            <li><a href="<c:url value="/main"><c:param name="action" value="vmix" /></c:url>">vMix</a></li>
            <li><a href="<c:url value="/main"><c:param name="action" value="bridge" /></c:url>">Bridge</a></li>
            <div class="cb"></div>
        </ul>

        <div class="cb"></div>
        <div class="container-top">
            <div class="container-middle">

                <jsp:invoke fragment="navigationContent" />


            </div>
        </div>
        <div class="shadow"></div>
        <!--		<div class="copyright">
                    Copyright 2012 John Doe Personal Vcard - <a href="http://www.themesline.com/" title="Free website templates">Free website templates</a> by ThemesLine.<br /><a href="http://www.cemuzica.ro/" title="Muzica Noua" style="color:#ededed;">Muzica Noua</a>
                </div>
                -->
    </div>
</div></body>


</html>