<%@  Page Language="C#" %>
<%@ Import Namespace="wtv.sa.admin" %>

<script runat="server">

    bool closeAndReload = false;
    SAdevice sadevice;

    void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["id"] != null && !IsPostBack)
        {
            sadevice = SqlDataProvider.GetSAdevice(int.Parse(Request.QueryString["id"]));
            deviceid.Value = sadevice.ID.ToString();
            name.Text = sadevice.Name;
            ip.Text = sadevice.IP;
            phone.Text = sadevice.Phone;
            group.SelectedValue = sadevice.DeviceType;
            description.Text = sadevice.Description.Replace("<br/>","\r\n");
            deleteButton1.Visible = true;
        }
    }

    void SaveDown(object sender, EventArgs e)
    {
        SAdevice savedevice;
        savedevice = new SAdevice();
        savedevice.ID = int.Parse(deviceid.Value);
        savedevice.Name = name.Text.Trim();
        savedevice.IP = ip.Text.Trim();
        savedevice.Phone = phone.Text.Trim();
        savedevice.Description = description.Text.Trim().Replace("\r\n","<br/>");
        savedevice.DeviceType = group.SelectedValue;
        SqlDataProvider.SaveSAdevice(savedevice);
        closeAndReload = true;
    }

    void confirmDeletion(object sender, EventArgs e)
    {
        deleteButton1.Visible = false;
        deleteButton2.Visible = true;
        deletionWarning.Text = "DELETING THE DEVICE WILL REMOVE ALL SCHEDULED ENTRIES FOR THIS DEVICE AS WELL!";
    }

    void deleteDevice(object sender, EventArgs e)
    {
        sadevice = SqlDataProvider.GetSAdevice(int.Parse(Request.QueryString["id"]));
        if (sadevice != null)
            SqlDataProvider.DeleteSAdevice(sadevice);
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
                Create/Edit SA device
                <br />
                <hr />
            </td>
        </tr>
        <tr>
            <td valign="top">
                <table width="100%" cellpadding="5" cellspacing="0" border="0">
                    <tr>
                        <td>
                            Group
                        </td>
                        <td>
                            <asp:DropDownList CssClass="inputtext" ID="group" runat="server">
                                <asp:ListItem Selected="True" Value="Tandberg">Tandberg</asp:ListItem>
                                <asp:ListItem Value="Hybrid">Hybrid</asp:ListItem>
                                <asp:ListItem Value="Satellite">Satellite</asp:ListItem>
								<asp:ListItem Value="Encoder">Encoder</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Name
                        </td>
                        <td>
                            <asp:TextBox CssClass="inputtext" ID="name" runat="server" />
                            <asp:RequiredFieldValidator ID="checkName" ControlToValidate="name" runat="server" Text="<br/>You have to enter a device name" Display="Dynamic" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            IP Address
                        </td>
                        <td>
                            <asp:TextBox CssClass="inputtext" ID="ip" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Phone
                        </td>
                        <td>
                            <asp:TextBox CssClass="inputtext" ID="phone" runat="server" />
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
                            <asp:HiddenField Value="-1" ID="deviceid" runat="server" />
                            <br /><br />
                            <table width="auto" cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td>
                                        <asp:Button ID="btn_Save" OnClick="SaveDown" Text="Save" CssClass="button" runat="server"/>
                                    </td>
                                    <td align="right">
                                        <asp:Button ID="deleteButton1" runat="server" CssClass="button" OnClick="confirmDeletion" Visible="false" Text="Delete Device" />
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
