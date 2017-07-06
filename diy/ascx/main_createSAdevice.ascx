<%@ Control Language="C#" %>
<%@ Import Namespace="wtv.sa.admin" %>

<script runat="server">

    SAdevicesCollection saDevices;
    DateTime selectedFirstDate;
    
    void Page_Load(object sender, EventArgs e)
    {
        saDevices = SqlDataProvider.GetAllSAdevices();
        selectedFirstDate = DateTime.Parse(DateTime.Now.ToString("d") + " 0:00:00");
    }

</script>

<table width="100%" cellpadding="10" cellspacing="0" border="0">
    <tr>
        <td valign="top">Name</td>
        <td valign="top">Status</td>
        <td valign="top">Dial-In</td>
        <td><%=selectedFirstDate.DayOfWeek.ToString()%><br /><%=selectedFirstDate.ToString("d")%></td>
        <td><%=selectedFirstDate.AddDays(1).DayOfWeek.ToString()%><br /><%=selectedFirstDate.AddDays(1).ToString("d")%></td>
        <td><%=selectedFirstDate.AddDays(2).DayOfWeek.ToString()%><br /><%=selectedFirstDate.AddDays(2).ToString("d")%></td>
        <td><%=selectedFirstDate.AddDays(3).DayOfWeek.ToString()%><br /><%=selectedFirstDate.AddDays(3).ToString("d")%></td>
        <td><%=selectedFirstDate.AddDays(4).DayOfWeek.ToString()%><br /><%=selectedFirstDate.AddDays(4).ToString("d")%></td>
        <td><%=selectedFirstDate.AddDays(5).DayOfWeek.ToString()%><br /><%=selectedFirstDate.AddDays(5).ToString("d")%></td>
        <td><%=selectedFirstDate.AddDays(6).DayOfWeek.ToString()%><br /><%=selectedFirstDate.AddDays(6).ToString("d")%></td>
    </tr>
</table>
<br /><br />
<a href="index.aspx?p=createSAdevice" target="_blank">Create new device</a>