<%--@elvariable id="BridgeConnected" type="Boolean"--%>
<%--@elvariable id="VCConnected" type="Boolean"--%>
<%--
  Created by IntelliJ IDEA.
  User: 4120-ddgz
  Date: 02.07.2014
  Time: 16:29
  To change this template use File | Settings | File Templates.
--%>
<template:main htmlTitle="Bridge"
                bodyTitle="">
    <jsp:attribute name="navigationContent">
            <script>
                $(document).ready(function() {
                    $('img').click(function(){
                        $('#IPTandberg').val($(this).attr('title'));
                    })
                });
            </script>

            <div id="vmix" class="visible section">
                <h2>Bridge</h2>

                <table>
                    <thead><tr><th></th><th></th><th></th><th></th></tr></thead>
                    <tfoot><tr><td><div>&nbsp;</div></tr></tfoot>
                    <tbody>

                    <tr>
                       <td align = "center"><img src="src/images/Tandberg1.png" width = "200" title="193.109.49.71"/></td><td align = "center"><img src="src/images/Tandberg9.png" width = "200" title="193.109.49.75"/></td>
                    </tr>
                    <tr>
                        <td align = "center"><img src="src/images/Tandberg2.png" width = "200" title="193.109.49.72"/></td><td align = "center"><img src="src/images/Tandberg10.png" width = "200" title="193.109.49.125"/></td><td align = "center"><img src="src/images/Bridge.png" width = "200" /></td>
                    </tr>
                    <tr>
                        <td align = "center"><img src="src/images/Tandberg3.png" width = "200" title="193.109.49.73"/></td>
                        <td align = "center"><img src="src/images/Tandberg11.png" width = "200" title="193.109.49.126"/></td>
                        <td align = "center">
                          <c:choose>
                            <c:when test="${BridgeConnected == true}">
                              <form method="POST" action="<c:url value="/bridge?action=conbridge" />">
                                <input type="text" name="IPBridge" placeholder="Connected" readonly="readonly"/>
                              </form>
                            </c:when>
                            <c:otherwise>
                              <form method="POST" action="<c:url value="/bridge?action=conbridge" />">
                                <input type="text" name="IPBridge" placeholder="IP Bridge"/>
                                <input type="submit" name="commit" value="Dial" align="middle">
                              </form>
                            </c:otherwise>
                          </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td align = "center"><img src="src/images/Tandberg4.png" width = "200" title="193.109.49.74"/></td>
                        <td align = "center"><img src="src/images/Tandberg12.png" width = "200" title="193.109.49.79"/></td>
                        <td align = "center">
                          <form method="POST" action="<c:url value="/bridge?action=sendID" />">
                            <input type="text" name="IDBridge" placeholder="ID/User Bridge/Password"/>
                            <input type="submit" name="commit" value="Send" align="middle">
                          </form>
                        </td>
                    </tr>
                    <tr>
                        <td align = "center"><img src="src/images/Tandberg6.png" width = "200" title="193.109.49.76"/></td>
                        <td align = "center"><img src="src/images/Tandberg13.png" width = "200" title="193.109.49.80"/></td>
                        <td align = "center"></td>
                    </tr>
                    <tr>
                        <td align = "center"><img src="src/images/Tandberg7.png" width = "200" title="193.109.49.77"/></td><td align = "center"><img src="src/images/Tandberg14.png" width = "200" title="193.109.49.82"/></td></td>

                    </tr>
                    <tr>
                        <td align = "center"><img src="src/images/Tandberg8.png" width = "200" title="193.109.49.90"/></td>
                        <c:choose>
                        <c:when test="${VCConnected == true}">
                          <td align = "center">
                            <br/>
                            <form method="POST" action="<c:url value="/bridge?action=connect" />">
                              <input type="text" name="IPTandberg" id="IPTandberg" placeholder="Connected" readonly="readonly"/>
                            </form>
                          </td><td></td>
                        </c:when>
                        <c:otherwise>
                        <td align = "center">
                          <br/>
                          <form method="POST" action="<c:url value="/bridge?action=connect" />">
                            <input type="text" name="IPTandberg" id="IPTandberg" placeholder="IP VC"/>
                            <input type="submit" name="commit" value="Telnet" align="middle">
                          </form>
                        </td><td>
                        </c:otherwise>
                        </c:choose>
                    </td>
                    </tr>
                    </tbody>
                </table>

            </div>
    </jsp:attribute>
</template:main>
