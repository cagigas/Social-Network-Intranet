<%@ Control Language="C#" %>
<%@ Import Namespace="wtv.sa.admin" %>


<% if (Globals.adminUserLoggedIn()) { %>
<ul id="pmenu">
        <li><a href="<%=HttpContext.Current.Request.ServerVariables["URL"] %>?p=home"><img src="picts/empty.gif" width="14" height="14" border="0"/>Home</a></li>
        <li><a href="<%=HttpContext.Current.Request.ServerVariables["URL"] %>?p=tandbergs"><img src="picts/empty.gif" width="14" height="14" border="0"/>Tandbergs</a></li>
		<li><a href="<%=HttpContext.Current.Request.ServerVariables["URL"] %>?p=encoder"><img src="picts/empty.gif" width="14" height="14" border="0"/>Encoder</a></li>
        <li><a href="<%=HttpContext.Current.Request.ServerVariables["URL"] %>?p=akamai"><img src="picts/empty.gif" width="14" height="14" border="0"/>Akamai</a></li>
        <li><a href="<%=HttpContext.Current.Request.ServerVariables["URL"] %>?p=network"><img src="picts/empty.gif" width="14" height="14" border="0"/>Network</a></li>
        <li><a href="<%=HttpContext.Current.Request.ServerVariables["URL"] %>?p=documentation"><img src="picts/empty.gif" width="14" height="14" border="0"/>Documentation</a></li>
        <li><a href="<%=HttpContext.Current.Request.ServerVariables["URL"] %>?p=codecs"><img src="picts/empty.gif" width="14" height="14" border="0"/>Codecs</a></li>
        <li><a href="<%=HttpContext.Current.Request.ServerVariables["URL"] %>?p=links"><img src="picts/empty.gif" width="14" height="14" border="0"/>Links</a></li>
</ul>
<% } %>