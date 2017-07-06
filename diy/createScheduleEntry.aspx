<%@  Page Language="C#" %>
<%@ Import Namespace="wtv.sa.admin" %>

<script runat="server">

    ScheduleEntries scheduledEntries;
    SAdevice sadevice;
    bool closeAndReload = false;
    DateTime targetDate;
    int targetDevice;

    void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["did"] != null && Request.QueryString["dt"] != null && !IsPostBack)
        {
            targetDate = DateTime.Parse(Server.UrlDecode(Request.QueryString["dt"]));
            targetDevice = int.Parse(Request.QueryString["did"]);
            sadevice = SqlDataProvider.GetSAdevice(targetDevice);
            deviceid.Value = targetDevice.ToString();
            entrydate.Value = targetDate.ToString();
            scheduledEntries = SqlDataProvider.GetScheduleEntriesByTimeFrame(targetDate, targetDate);
            if (scheduledEntries.getScheduleByDeviceIDandDate(targetDevice, targetDate) != null)
            {
                ScheduleEntry existingEntry = scheduledEntries.getScheduleByDeviceIDandDate(targetDevice, targetDate);
                entryid.Value = existingEntry.ID.ToString();
                title.Text = existingEntry.Title;
                description.Text = existingEntry.Description.Replace("<br/>", "\r\n");
                deleteButton1.Visible = true;
            }
        }
    }

    void SaveDown(object sender, EventArgs e)
    {
        ScheduleEntry saveEntry = new ScheduleEntry();
        saveEntry.ID = Convert.ToInt64(entryid.Value);
        saveEntry.EventDate = DateTime.Parse(entrydate.Value);
        saveEntry.Title = title.Text;
        saveEntry.Description = description.Text.Trim().Replace("\r\n", "<br/>");
        saveEntry.DeviceID = int.Parse(deviceid.Value);
        SqlDataProvider.SaveScheduleEntry(saveEntry);
        closeAndReload = true;
    }

    void confirmDeletion(object sender, EventArgs e)
    {
        targetDate = DateTime.Parse(Server.UrlDecode(Request.QueryString["dt"]));
        targetDevice = int.Parse(Request.QueryString["did"]);
        sadevice = SqlDataProvider.GetSAdevice(targetDevice);
        deleteButton1.Visible = false;
        deleteButton2.Visible = true;
    }

    void deleteDevice(object sender, EventArgs e)
    {
        targetDate = DateTime.Parse(Server.UrlDecode(Request.QueryString["dt"]));
        targetDevice = int.Parse(Request.QueryString["did"]);
        scheduledEntries = SqlDataProvider.GetScheduleEntriesByTimeFrame(targetDate, targetDate);
        ScheduleEntry existingEntry = scheduledEntries.getScheduleByDeviceIDandDate(targetDevice, targetDate);
        SqlDataProvider.DeleteScheduleEntry(existingEntry);
        closeAndReload = true;
    }
    
</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>WTV - Signal Acquisition</title>
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel="stylesheet" type="text/css" href="css/system.css" />
</head>
<body style="margin: 20px 20px;">
    <% if (closeAndReload)
       { %>
    <script type="text/javascript" language="javascript">
        window.opener.document.location = window.opener.document.location;
        window.close();
    </script>
    <% } %>
    <form id="form1" runat="server">
    <table cellpadding="0" cellspacing="0" align="center">
        <tr>
            <td style="font-weight: bold">
                Create/Edit SA schedule <%=targetDate.ToString("d") %>
                <br />
                <hr />
            </td>
        </tr>
        <tr>
            <td valign="top">
                <table width="100%" cellpadding="5" cellspacing="0" border="0">
                    <tr>
                        <td>
                            Device
                        </td>
                        <td>
                            <% try { Response.Write(sadevice.Name); }
                               catch { }%>
                            <asp:HiddenField Value="-1" ID="deviceid" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Date
                        </td>
                        <td>
                            <%=targetDate.ToString("d") %>
                            <asp:HiddenField Value="-1" ID="entrydate" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Title
                        </td>
                        <td>
                            <asp:TextBox CssClass="inputtext" ID="title" runat="server" />
                            <asp:RequiredFieldValidator ID="checkTitle" ControlToValidate="title" runat="server" Text="<br/>You have to enter a title" Display="Dynamic" />
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            Description
                        </td>
                        <td>
                            <asp:TextBox CssClass="inputtext" TextMode="MultiLine" Rows="10" ID="description" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:HiddenField Value="-1" ID="entryid" runat="server" />
                            <br /><br />
                            <table width="auto" cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td>
                                        <asp:Button ID="btn_Save" OnClick="SaveDown" Text="Save" CssClass="button" runat="server"/>
                                    </td>
                                    <td align="right">
                                        <asp:Button ID="deleteButton1" runat="server" CssClass="button" OnClick="confirmDeletion" Visible="false" Text="Delete Reservation" />
                                        <asp:Button ID="deleteButton2" runat="server" CssClass="button" OnClick="deleteDevice" Visible="false" Text="CONFIRM DELETION" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:Label ID="deletionWarning" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
