<%@ Control Language="C#" %>
<%@ Import Namespace="wtv.sa.admin" %>

<script runat="server">

    void Page_Load(object sender, EventArgs e)
    {
        Page.Form.DefaultButton = LoginButton.UniqueID;
    }
    
    void clk_login(object sender, EventArgs e)
    {
        if (Globals.validateAdminUserLogin(Password.Text.Trim()))
        {
            HttpContext.Current.Response.Redirect(HttpContext.Current.Request.ServerVariables["URL"]);
        }
        else
        {
            validateLoginError.Text = "Login failed";
        }
    }
    
    
</script>

<table height="75%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td colspan="2">
            <img src="picts/empty.gif" border="0" width="20" height="100" />
        </td>
    </tr>
    <tr>
        <td>
            <img src="picts/empty.gif" border="0" width="160" height="10" />
        </td>
        <td height="22">
            <table style="width: auto">
                <tr>
                    <td class="maintitle">
                        <img src="picts/empty.gif" /></td>
                    <td class="maintitle">
                        Login
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <img src="picts/empty.gif" border="0" width="20" height="10" />
        </td>
    </tr>
    <tr>
        <td></td>
        <td>
            <table border="0" cellspacing="10" cellpadding="0">
                <tr>
                    <td>
                        Please enter the Password
                    </td>
                </tr>
            </table>
            <table border="0" cellspacing="10" style="width:auto">
                <tr>
                    <td>
                        Password:</td>
                    <td>
                        <asp:TextBox ID="Password" TextMode="password" Style="width: 200px" CssClass="inputtext"
                            runat="server" /></td>
                </tr>
                <tr align="middle">
                    <td>
                    </td>
                    <td align="left">
                        <asp:Button ID="LoginButton" CssClass="button" runat="server" Text="Login" OnClick="clk_login" />
                    </td>
                </tr>
                <tr align="middle">
                    <td colspan="2" align="left">
                        &nbsp;<br/>
                        <asp:Label ID="validateLoginError" runat="server" CssClass="input" Style="color: red" />
                        <asp:RequiredFieldValidator ControlToValidate="Password" Display="Static" ErrorMessage="A password is required"
                            ID="PasswordError" runat="server" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<script type="text/javascript" language="javascript">
    document.getElementById("<%=Password.ClientID %>").focus();
</script>

