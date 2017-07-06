<%--@elvariable id="vmix" type="java.util.Map<Integer, production.wtv.DatavMix>"--%>

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

        <div id="vmix" class="visible section">
            <h2>VMix</h2>

            <ul class="categories3">
                <li><a href="<c:url value="/vmix"><c:param name="action" value="enc" /><c:param name="enc" value="303" /><c:param name="url" value="193.109.49.112:8088/api" /></c:url>">Encoder 303</a></li>
                <li><a href="<c:url value="/vmix"><c:param name="action" value="enc" /><c:param name="enc" value="304" /><c:param name="url" value="193.109.49.113:8088/api" /></c:url>">Encoder 304</a></li>
                <li><a href="<c:url value="/vmix"><c:param name="action" value="enc" /><c:param name="enc" value="305" /><c:param name="url" value="193.109.49.114:8088/api" /></c:url>">Encoder 305</a></li>
                <li><a href="<c:url value="/vmix"><c:param name="action" value="enc" /><c:param name="enc" value="600" /><c:param name="url" value="193.109.49.105:8088/api" /></c:url>">Encoder 600</a></li>
                <li><a href="<c:url value="/vmix"><c:param name="action" value="enc" /><c:param name="enc" value="601" /><c:param name="url" value="193.109.49.104:8088/api" /></c:url>">Encoder 601</a></li>
                <li><a href="<c:url value="/vmix"><c:param name="action" value="enc" /><c:param name="enc" value="602" /><c:param name="url" value="193.109.49.116:8088/api" /></c:url>">Encoder 602</a></li>
                <li><a href="<c:url value="/vmix"><c:param name="action" value="enc" /><c:param name="enc" value="603" /><c:param name="url" value="193.109.49.117:8088/api" /></c:url>">Encoder 603</a></li>
                <li><a href="<c:url value="/vmix"><c:param name="action" value="enc" /><c:param name="enc" value="604" /><c:param name="url" value="193.109.49.118:8088/api" /></c:url>">Encoder 604</a></li>
                <li><a href="<c:url value="/vmix"><c:param name="action" value="enc" /><c:param name="enc" value="606" /><c:param name="url" value="193.109.49.120:8088/api" /></c:url>">Encoder 606</a></li>
                <li><a href="<c:url value="/vmix"><c:param name="action" value="enc" /><c:param name="enc" value="607" /><c:param name="url" value="193.109.49.84:8088/api" /></c:url>">Encoder 607</a></li>
                <li><a href="<c:url value="/vmix"><c:param name="action" value="enc" /><c:param name="enc" value="608" /><c:param name="url" value="193.109.49.85:8088/api" /></c:url>">Encoder 608</a></li>
                <li><a href="<c:url value="/vmix"><c:param name="action" value="enc" /><c:param name="enc" value="609" /><c:param name="url" value="193.109.49.86:8088/api" /></c:url>">Encoder 609</a></li>
                <li><a href="<c:url value="/vmix"><c:param name="action" value="enc" /><c:param name="enc" value="610" /><c:param name="url" value="193.109.49.87:8088/api" /></c:url>">Encoder 610</a></li>
                <li><a href="<c:url value="/vmix"><c:param name="action" value="enc" /><c:param name="enc" value="611" /><c:param name="url" value="193.109.49.88:8088/api" /></c:url>">Encoder 611</a></li>
                <div class="cb"></div>
            </ul>

            <c:forEach items="${vmix}" var="entry">
                <div id="${entry.key}" class="visible section">

                    <a href="<c:url value="/vmix"><c:param name="action" value="fade" /><c:param name="enc" value="${entry.key}" /></c:url>">
                        <input align = "center" type="image" src="src/images/fade.png" name="fade" class="submit" id="fade" width="30" height="30"  alt="Computer Hope"/>
                    </a>

                    <a href="<c:url value="/vmix"><c:param name="action" value="enc" /><c:param name="enc" value="${entry.key}" /><c:param name="url" value="${entry.value.urlpure}" /></c:url>">
                        <input align = "center" type="image" src="src/images/refresh.png" name="refresh" class="submit" id="refresh" width="30" height="30"  alt="Computer Hope"/>
                    </a>

                    <a href="<c:url value="/vmix"><c:param name="action" value="del" /><c:param name="enc" value="${entry.key}" /><c:param name="url" value="${entry.value.urlpure}" /></c:url>">
                        <input align = "center" type="image" src="src/images/delete.png" name="delete" class="submit" id="delete" width="30" height="30"  alt="Computer Hope"/>
                    </a>

                    <table width="100%" border="2">
                        <tr>
                            <td width="25%" border="2">Encoder</td>
                            <td width="70%" border="2"><c:out value="${entry.key}" /></td>
                        </tr>
                        <tr>
                            <td width="25%" border="2">Version</td>
                            <td width="70%" border="2"><c:out value="${entry.value.version}" /></td>
                        </tr>
                        <tr>
                            <td width="25%" border="2">Number of Inputs</td>
                            <td width="70%" border="2"><c:out value="${entry.value.nin}" /></td>
                        </tr>
                        <c:forEach var="i" begin="1" end="${entry.value.nin}">
                            <tr>
                                <td width="25%" border="2">Input <c:out value="${i}"/></td>
                                <td width="70%" border="2"><c:out value="${entry.value.getInput(i)}" /></td>
                            </tr>
                        </c:forEach>

                        <tr bgcolor="green">
                            <td width="25%" border="2">Live</td>
                            <td width="70%" border="2"><c:out value="${entry.value.live}" /></td>
                        </tr>
                        <tr bgcolor="yellow">
                            <td width="25%" border="2">Preview</td>
                            <td width="70%" border="2"><c:out value="${entry.value.preview}" /></td>
                        </tr>
                        <c:choose>
                            <c:when test="${entry.value.external}">
                                <tr>
                                    <td width="25%" border="2">External</td>
                                    <td width="70%" border="2"><c:out value="${entry.value.external}" /></td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <tr bgcolor="red">
                                    <td width="25%" border="2">External</td>
                                    <td width="70%" border="2"><c:out value="${entry.value.external}" /></td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </table>
                    <br /><br />
                </div>
            </c:forEach>
        </div>
    </jsp:attribute>
</template:main>
