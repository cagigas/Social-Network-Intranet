<%@ Control Language="C#" %>
<%@ Import Namespace="wtv.sa.admin" %>

<script runat="server">

    SAdevicesCollection saDevices;
    SAdevicesCollection tandbergs;
    SAdevicesCollection hybrids;
    SAdevicesCollection satellites;
	SAdevicesCollection encoders;
    ScheduleEntries scheduledEntries;
    DateTime selectedFirstDate;
    
    void Page_Load(object sender, EventArgs e)
    {
        saDevices = SqlDataProvider.GetAllSAdevices();
        tandbergs = saDevices.getDevicesByDeviceType("Tandberg");
        hybrids = saDevices.getDevicesByDeviceType("Hybrid");
        satellites = saDevices.getDevicesByDeviceType("Satellite");
        if (Request.QueryString["dt"] == null)
            selectedFirstDate = DateTime.Parse(DateTime.Now.ToString("d") + " 0:00:00");
        else
            selectedFirstDate = DateTime.Parse(Server.UrlDecode(Request.QueryString["dt"]));

        scheduledEntries = SqlDataProvider.GetScheduleEntriesByTimeFrame(selectedFirstDate, selectedFirstDate.AddDays(6));
    }

</script>

<table width="100%" cellpadding="2" cellspacing="0" border="0">
    <tr style="background-color:#fbfbfb">
        <td valign="top" width="200"><nobr>Name</nobr></td>
        <td valign="top" width="1"><nobr>Status&nbsp;&nbsp;&nbsp;&nbsp;</nobr></td>
        <td valign="top" width="1"><nobr>Dial-In</nobr></td>
        <td valign="top" width="1" style="font-weight:bold"><nobr><a href="default.aspx?p=tandbergs&dt=<%=Server.UrlEncode(selectedFirstDate.AddDays(-7).ToString()) %>">&lt;&lt;</a></nobr></td>
        <td><%=selectedFirstDate.DayOfWeek.ToString()%><br /><%=selectedFirstDate.ToString("d")%></td>
        <td><%=selectedFirstDate.AddDays(1).DayOfWeek.ToString()%><br /><%=selectedFirstDate.AddDays(1).ToString("d")%></td>
        <td><%=selectedFirstDate.AddDays(2).DayOfWeek.ToString()%><br /><%=selectedFirstDate.AddDays(2).ToString("d")%></td>
        <td><%=selectedFirstDate.AddDays(3).DayOfWeek.ToString()%><br /><%=selectedFirstDate.AddDays(3).ToString("d")%></td>
        <td><%=selectedFirstDate.AddDays(4).DayOfWeek.ToString()%><br /><%=selectedFirstDate.AddDays(4).ToString("d")%></td>
        <td><%=selectedFirstDate.AddDays(5).DayOfWeek.ToString()%><br /><%=selectedFirstDate.AddDays(5).ToString("d")%></td>
        <td><%=selectedFirstDate.AddDays(6).DayOfWeek.ToString()%><br /><%=selectedFirstDate.AddDays(6).ToString("d")%></td>
        <td valign="top" width="1" style="font-weight:bold"><nobr><a href="default.aspx?p=tandbergs&dt=<%=Server.UrlEncode(selectedFirstDate.AddDays(7).ToString()) %>">&gt;&gt;</a></nobr></td>
    </tr>
	
	<tr>
        <td colspan="12"><hr /></td>
    </tr>
    <tr>
        <td colspan="12" style="font-weight:bold">
            Encoder
        </td>
    </tr>
    <% foreach (SAdevice device in encoders)
       { %>
    <tr>
        <td style="background-color:#e2e2e2"><nobr><%if (device.IP != "") { %><a href="http://<%=device.IP %>" target="_blank"><img src="picts/urlicon.gif" border="0" /></a>&nbsp;&nbsp;&nbsp;<% } %><a href="javascript:void(0)" <% if (device.Description != "") { %>onmouseover="showWMTT('<%=device.Description.Replace("\"", "&quot;").Replace("'", "\\'") %>')" onmouseout="hideWMTT();"<% } %> onclick="window.open('createSAdevice.aspx?id=<%=device.ID.ToString() %>','SAadmin','width=400,height=400,top=50,left=50,locationbar=no,menubar=no,resizable=0',true);"><%=device.Name%></a>&nbsp;&nbsp;&nbsp;<span onclick="ajxCall('menuEnable', '<%=device.IP %>');" style="cursor:pointer;background-color:Green;border:1px solid #000" onmouseover="showWMTT('Enable Menu')" onmouseout="hideWMTT()"><img src="picts/empty.gif" width="5" height="10" /></span>&nbsp;&nbsp;<span onclick="ajxCall('menuDisable', '<%=device.IP %>');" style="cursor:pointer;background-color:Red;border:1px solid #000" onmouseover="showWMTT('Disable Menu')" onmouseout="hideWMTT()"><img src="picts/empty.gif" width="5" height="10" /></span></nobr></td>
        <td style="background-color:#e2e2e2"><%if (device.IP != "") { %><a href="http://<%=device.IP %>/status.ssi" target="_blank">Status</a><% } %></td>
        <td style="background-color:#e2e2e2" colspan="2"><nobr><%=device.Phone%></nobr></td>
        <% int counter = 0;
           for (int a = 0; a <= 6; a++)
           {
               string tempDescription = "";
               string tempBgColor = "transparent";
               ScheduleEntry tempEntry = scheduledEntries.getScheduleByDeviceIDandDate(device.ID, selectedFirstDate.AddDays(a));
               if (tempEntry != null)
               {
                   tempDescription = "showWMTT('" + tempEntry.Description.Replace("\"", "&quot;").Replace("'", "\\'") + "');";
                   tempBgColor = "#ebc9c9";
               }
            %>
        <td style="font-weight:bold;border:dotted 1px #c1c1c1;cursor:pointer;background-color:<%=tempBgColor%>" onclick="window.open('createScheduleEntry.aspx?did=<%=device.ID.ToString() %>&dt=<%=Server.UrlEncode(selectedFirstDate.AddDays(a).ToString()) %>','SAadmin','width=400,height=400,top=50,left=50,locationbar=no,menubar=no,resizable=0',true);" onmouseover="this.style.backgroundColor='#deff00';<%=tempDescription %>" onmouseout="this.style.backgroundColor='<%=tempBgColor %>';hideWMTT();">
        <% 
           if (tempEntry != null)
           {
            %>
            <%=tempEntry.Title%>
            <% }
           else
           { %>
        &nbsp;
        <% } %>
        </td>
        <% } %>
        <td></td>
    </tr>
    <tr>
        <td colspan="12"><img src="picts/empty.gif" border="0" width="10" height="1" style="display:block" /></td>
    </tr>
    <% } %>
    <tr>
        <td colspan="12"><img src="picts/empty.gif" border="0" width="10" height="10" style="display:block" /></td>
    </tr>
    
	
	
	
	
<!-- 
    <tr>
        <td colspan="12"><hr /></td>
    </tr>
    <tr>
        <td colspan="12" style="font-weight:bold">
            Tandbergs
        </td>
    </tr>
    <% foreach (SAdevice device in tandbergs)
       { %>
    <tr>
        <td style="background-color:#e2e2e2"><nobr><%if (device.IP != "") { %><a href="http://<%=device.IP %>" target="_blank"><img src="picts/urlicon.gif" border="0" /></a>&nbsp;&nbsp;&nbsp;<% } %><a href="javascript:void(0)" <% if (device.Description != "") { %>onmouseover="showWMTT('<%=device.Description.Replace("\"", "&quot;").Replace("'", "\\'") %>')" onmouseout="hideWMTT();"<% } %> onclick="window.open('createSAdevice.aspx?id=<%=device.ID.ToString() %>','SAadmin','width=400,height=400,top=50,left=50,locationbar=no,menubar=no,resizable=0',true);"><%=device.Name%></a>&nbsp;&nbsp;&nbsp;<span onclick="ajxCall('menuEnable', '<%=device.IP %>');" style="cursor:pointer;background-color:Green;border:1px solid #000" onmouseover="showWMTT('Enable Menu')" onmouseout="hideWMTT()"><img src="picts/empty.gif" width="5" height="10" /></span>&nbsp;&nbsp;<span onclick="ajxCall('menuDisable', '<%=device.IP %>');" style="cursor:pointer;background-color:Red;border:1px solid #000" onmouseover="showWMTT('Disable Menu')" onmouseout="hideWMTT()"><img src="picts/empty.gif" width="5" height="10" /></span></nobr></td>
        <td style="background-color:#e2e2e2"><%if (device.IP != "") { %><a href="http://<%=device.IP %>/status.ssi" target="_blank">Status</a><% } %></td>
        <td style="background-color:#e2e2e2" colspan="2"><nobr><%=device.Phone%></nobr></td>
        <% int counter = 0;
           for (int a = 0; a <= 6; a++)
           {
               string tempDescription = "";
               string tempBgColor = "transparent";
               ScheduleEntry tempEntry = scheduledEntries.getScheduleByDeviceIDandDate(device.ID, selectedFirstDate.AddDays(a));
               if (tempEntry != null)
               {
                   tempDescription = "showWMTT('" + tempEntry.Description.Replace("\"", "&quot;").Replace("'", "\\'") + "');";
                   tempBgColor = "#ebc9c9";
               }
            %>
        <td style="font-weight:bold;border:dotted 1px #c1c1c1;cursor:pointer;background-color:<%=tempBgColor%>" onclick="window.open('createScheduleEntry.aspx?did=<%=device.ID.ToString() %>&dt=<%=Server.UrlEncode(selectedFirstDate.AddDays(a).ToString()) %>','SAadmin','width=400,height=400,top=50,left=50,locationbar=no,menubar=no,resizable=0',true);" onmouseover="this.style.backgroundColor='#deff00';<%=tempDescription %>" onmouseout="this.style.backgroundColor='<%=tempBgColor %>';hideWMTT();">
        <% 
           if (tempEntry != null)
           {
            %>
            <%=tempEntry.Title%>
            <% }
           else
           { %>
        &nbsp;
        <% } %>
        </td>
        <% } %>
        <td></td>
    </tr>
    <tr>
        <td colspan="12"><img src="picts/empty.gif" border="0" width="10" height="1" style="display:block" /></td>
    </tr>
    <% } %>
    <tr>
        <td colspan="12"><img src="picts/empty.gif" border="0" width="10" height="10" style="display:block" /></td>
    </tr>
    <tr>
        <td colspan="12" style="font-weight:bold">
            Hybrids
        </td>
    </tr>
    <% foreach (SAdevice device in hybrids)
       { %>
    <tr>
        <td style="background-color:#e2e2e2" colspan="2"><nobr><%if (device.IP != "") { %><a href="http://<%=device.IP %>" target="_blank"><img src="picts/urlicon.gif" border="0" /></a>&nbsp;&nbsp;&nbsp;<% } %><a href="javascript:void(0)" onmouseover="showWMTT('<%=device.Description.Replace("\"", "&quot;").Replace("'", "\\'") %>')" onmouseout="hideWMTT();" onclick="window.open('createSAdevice.aspx?id=<%=device.ID.ToString() %>','SAadmin','width=400,height=400,top=50,left=50,locationbar=no,menubar=no,resizable=0',true);"><%=device.Name%></a></nobr></td>
        <td style="background-color:#e2e2e2" colspan="2"><nobr><%=device.Phone%></nobr></td>
        <% int counter = 0;
           for (int a = 0; a <= 6; a++)
           {
               string tempDescription = "";
               string tempBgColor = "transparent";
               ScheduleEntry tempEntry = scheduledEntries.getScheduleByDeviceIDandDate(device.ID, selectedFirstDate.AddDays(a));
               if (tempEntry != null)
               {
                   tempDescription = "showWMTT('" + tempEntry.Description.Replace("\"", "&quot;").Replace("'", "\\'") + "');";
                   tempBgColor = "#ebc9c9";
               }
            %>
        <td style="font-weight:bold;border:dotted 1px #c1c1c1;cursor:pointer;background-color:<%=tempBgColor%>" onclick="window.open('createScheduleEntry.aspx?did=<%=device.ID.ToString() %>&dt=<%=Server.UrlEncode(selectedFirstDate.AddDays(a).ToString()) %>','SAadmin','width=400,height=400,top=50,left=50,locationbar=no,menubar=no,resizable=0',true);" onmouseover="this.style.backgroundColor='#deff00';<%=tempDescription %>" onmouseout="this.style.backgroundColor='<%=tempBgColor %>';hideWMTT();">
        <% 
           if (tempEntry != null)
           {
            %>
            <%=tempEntry.Title%>
            <% }
           else
           { %>
        &nbsp;
        <% } %>
        </td>
        <% } %>
        <td></td>
    </tr>
    <tr>
        <td colspan="12"><img src="picts/empty.gif" border="0" width="10" height="1" style="display:block" /></td>
    </tr>
    <% } %>
    <tr>
        <td colspan="12"><img src="picts/empty.gif" border="0" width="10" height="10" style="display:block" /></td>
    </tr>
    <tr>
        <td colspan="12" style="font-weight:bold">
            Satellites
        </td>
    </tr>
    <% foreach (SAdevice device in satellites)
       { %>
    <tr>
        <td style="background-color:#e2e2e2"><nobr><%if (device.IP != "") { %><a href="http://<%=device.IP %>" target="_blank"><img src="picts/urlicon.gif" border="0" /></a>&nbsp;&nbsp;&nbsp;<% } %><a href="javascript:void(0)" onmouseover="showWMTT('<%=device.Description.Replace("\"", "&quot;").Replace("'", "\\'") %>')" onmouseout="hideWMTT();" onclick="window.open('createSAdevice.aspx?id=<%=device.ID.ToString() %>','SAadmin','width=400,height=400,top=50,left=50,locationbar=no,menubar=no,resizable=0',true);"><%=device.Name%></a></nobr></td>
        <td style="background-color:#e2e2e2"><% if (device.IP != "") { %><a href="http://<%=device.IP %>" target="_blank">Status</a><% } %></td>
        <td style="background-color:#e2e2e2" colspan="2"><nobr><%=device.Phone%></nobr></td>
        <% int counter = 0;
           for (int a = 0; a <= 6; a++)
           {
               string tempDescription = "";
               string tempBgColor = "transparent";
               ScheduleEntry tempEntry = scheduledEntries.getScheduleByDeviceIDandDate(device.ID, selectedFirstDate.AddDays(a));
               if (tempEntry != null)
               {
                   tempDescription = "showWMTT('" + tempEntry.Description.Replace("\"", "&quot;").Replace("'", "\\'") + "');";
                   tempBgColor = "#ebc9c9";
               }
            %>
        <td style="font-weight:bold;border:dotted 1px #c1c1c1;cursor:pointer;background-color:<%=tempBgColor%>" onclick="window.open('createScheduleEntry.aspx?did=<%=device.ID.ToString() %>&dt=<%=Server.UrlEncode(selectedFirstDate.AddDays(a).ToString()) %>','SAadmin','width=400,height=400,top=50,left=50,locationbar=no,menubar=no,resizable=0',true);" onmouseover="this.style.backgroundColor='#deff00';<%=tempDescription %>" onmouseout="this.style.backgroundColor='<%=tempBgColor %>';hideWMTT();">
        <% 
           if (tempEntry != null)
           {
            %>
            <%=tempEntry.Title%>
            <% }
           else
           { %>
        &nbsp;
        <% } %>
        </td>
        <% } %>
        <td></td>
    </tr>
    <tr>
        <td colspan="12"><img src="picts/empty.gif" border="0" width="10" height="1" style="display:block" /></td>
    </tr>
    <% } %> -->
    <tr>
        <td colspan="12"><img src="picts/empty.gif" border="0" width="10" height="1" style="display:block" /></td>
    </tr>
</table>
<br /><br />
<hr />
<a href="javascript:void(0)" onclick="window.open('createSAdevice.aspx','SAadmin','width=400,height=400,top=50,left=50,locationbar=no,menubar=no,resizable=0',true);">Create new device</a>