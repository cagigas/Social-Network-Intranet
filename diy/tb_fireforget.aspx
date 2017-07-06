<%@  Page Language="C#" %>
<%@ Import Namespace="wtv.sa.admin" %>
<%@ Import Namespace="VirtuePM" %>


<script runat="server">

    string ip = "";
    string cmd = "";
    string urlstring = "http://193.109.49.78:8080/axis2/services/TandbergService/{1}?ip={0}&password=more2stream";
    string callMessage = "You need to define an ip address and a command argument.";
    
    void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["ip"] != null && Request.QueryString["cmd"] != null)
        {
            ip = Request.QueryString["ip"];
            cmd = Request.QueryString["cmd"];
            try
            {
                httpCall.getTextFromUrl(string.Format(urlstring, ip, cmd));
                callMessage = "The call has been made successfuly.";
            }
            catch
            {
                callMessage = "The call has failed.";
            }
        }
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
    <%=callMessage %>
    <br /><br />
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td align="right">
                <span style="cursor:pointer;font-style:italic;font-family:Verdana;font-size:10px" onclick="document.getElementById('ajxStatus').style.display='none';">Close</span>
            </td>
        </tr>
    </table>
</body>
</html>
