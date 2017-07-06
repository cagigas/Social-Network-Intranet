<%@ Control Language="C#" %>
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="wtv.sa.admin" %>

<script runat="server">

    XmlDocument xmlContent;
    string xmlFileName = "akamai.xml";
    string xmlFileCache = "SAakamaiXml";
    string entryName = "encoder";
    string currentGroupName = "real";
    string[] elements = new string[] { "name", "url1", "url2", "url3", "url4" };

    void Page_Init(object sender, EventArgs e)
    {
        xmlContent = XmlContent;
        if (Session["currentGroup"] == null)
            Session["currentGroup"] = "nothing";
        buildTable();
    }

    void buildTable()
    {
        HtmlTable table = new HtmlTable();
        HtmlTableRow row = new HtmlTableRow();
        HtmlTableCell cell = new HtmlTableCell();
        XmlNodeList allNodes = xmlContent.SelectNodes("root/" + Session["currentGroup"].ToString() + "/" + entryName);
        int akamaiCounter = 1;
        string rowColor = "#A7CBEB";
        foreach (XmlNode node in allNodes)
        {
            row = new HtmlTableRow();
            cell = new HtmlTableCell();
            cell.ColSpan = 4;
            cell.InnerHtml = "<hr/>";
            row.Cells.Add(cell);
            table.Rows.Add(row);
            string nodeid = node.SelectSingleNode("@id").InnerText;
            row = new HtmlTableRow();
            for (int a = 0; a < elements.Length; a++)
            {
                if (elements[a].IndexOf("url2") == -1 && elements[a].IndexOf("url3") == -1 && elements[a].IndexOf("url4") == -1)
                {
                    cell = new HtmlTableCell();
                    cell.VAlign = "top";
                }
                if (elements[a].IndexOf("url1") != -1 || elements[a].IndexOf("url2") != -1 || elements[a].IndexOf("url3") != -1 || elements[a].IndexOf("url4") != -1)
                {
                    if (rowColor == "#A7CBEB")
                        rowColor = "#fff";
                    else
                        rowColor = "#A7CBEB";
                    cell.InnerHtml += "<div onmouseover='this.style.backgroundColor=\"yellow\"' onmouseout='this.style.backgroundColor=\"" + rowColor + "\"' style='background-color:" + rowColor + ";cursor:pointer' onclick='copyToClipboard(" + akamaiCounter.ToString() + ");' id='span_" + akamaiCounter.ToString() + "'><b>" + akamaiCounter.ToString("000") + "</b>&nbsp;&nbsp;" + node.SelectSingleNode(elements[a]).InnerText + "</div>";
                    akamaiCounter++;
                }
                else if (node.SelectSingleNode(elements[a]) != null)
                    cell.InnerHtml += node.SelectSingleNode(elements[a]).InnerText;
                row.Cells.Add(cell);
            }
            cell = new HtmlTableCell();
            cell.VAlign = "top";
            cell.Width = "1";
            ImageButton imgbtn = new ImageButton();
            imgbtn.ID = "edit_" + nodeid;
            imgbtn.Command += new CommandEventHandler(showEditNode);
            imgbtn.CommandArgument = nodeid;
            imgbtn.Attributes.Add("title", "Edit node");
            imgbtn.ImageUrl = "../picts/edit.gif";
            cell.Controls.Add(imgbtn);
            row.Controls.Add(cell);
            cell = new HtmlTableCell();
            cell.VAlign = "top";
            cell.Width = "1";
            LinkButton lnkbtn = new LinkButton();
            lnkbtn.ID = "delete_" + nodeid;
            lnkbtn.Command += new CommandEventHandler(deleteNode);
            lnkbtn.CommandArgument = nodeid;
            lnkbtn.Text = "<img src='picts/empty.gif' style='display:none' border='0'/>";
            cell.Controls.Add(new LiteralControl("<img src='picts/delete.gif' title='Delete node' border='0' style='cursor:pointer;' onclick='DeleteNode(\"ctl00$Main$ctl00$delete_" + nodeid + "\");'/>"));
            cell.Controls.Add(lnkbtn);
            row.Controls.Add(cell);
            table.Rows.Add(row);
        }

        HtmlTable table2 = new HtmlTable();
        row = new HtmlTableRow();
        cell = new HtmlTableCell();
        cell.Controls.Add(new LiteralControl("<br/><hr/><a href='javascript:showcreate();'>Create new node</a><br/><br/><table cellpadding='2' style='display:none;width:auto' cellspacing='0' border='0' id='createTable'>"));
        for (int a = 0; a < elements.Length; a++)
        {
            cell.Controls.Add(new LiteralControl("<tr><td>" + elements[a] + ":</td><td>"));
            TextBox textbox = new TextBox();
            textbox.ID = "create_" + elements[a];
            textbox.Style.Add("width", "800px");
            textbox.CssClass = "input";
            cell.Controls.Add(textbox);
            cell.Controls.Add(new LiteralControl("</td></tr>"));
        }
        cell.Controls.Add(new LiteralControl("<tr><td colspan='2' align='center'><br/>"));
        Button button = new Button();
        button.ID = "createNodeBtn";
        button.Click += new EventHandler(createNode);
        button.CssClass = "button";
        button.Text = "Save";
        cell.Controls.Add(button);
        cell.Controls.Add(new LiteralControl("</td></tr>"));
        cell.Controls.Add(new LiteralControl("</table>"));
        row.Cells.Add(cell);
        table2.Rows.Add(row);

        
        HtmlTable table3 = new HtmlTable();
        table3.ID = "editNodeTable";
        table3.Visible = false;
        row = new HtmlTableRow();
        cell = new HtmlTableCell();
        cell.Controls.Add(new LiteralControl("<div style='background-color:#eee;border:1px solid #000;position:absolute;left:100px;top:250px;'><br/><b>&nbsp;&nbsp;Edit entry:</b><br/><br/><table cellpadding='5' style='width:auto' cellspacing='0' border='0'>"));
        for (int a = 0; a < elements.Length; a++)
        {
            cell.Controls.Add(new LiteralControl("<tr><td>" + elements[a] + ":</td><td>"));
            TextBox textbox = new TextBox();
            textbox.ID = "edit_" + elements[a];
            textbox.Style.Add("width", "800px");
            textbox.CssClass = "input";
            cell.Controls.Add(textbox);
            cell.Controls.Add(new LiteralControl("</td></tr>"));
        }
        cell.Controls.Add(new LiteralControl("<tr><td colspan='2' align='center'><br/>"));
        HiddenField hiddenField = new HiddenField();
        hiddenField.ID = "edit_id";
        cell.Controls.Add(hiddenField);
        button = new Button();
        button.ID = "editNodeBtn";
        button.Click += new EventHandler(editNode);
        button.CssClass = "button";
        button.Text = "Save";
        cell.Controls.Add(button);
        cell.Controls.Add(new LiteralControl("</td></tr>"));
        cell.Controls.Add(new LiteralControl("</table></div>"));
        row.Cells.Add(cell);
        table3.Rows.Add(row);
        
        for (int i = 0; i < multiView.Views.Count; i++)
        {
            if (multiView.Views[i].ID == Session["currentGroup"].ToString())
            {
                if (Session["currentGroup"].ToString() != "internalLinksView")
                {
                    multiView.Views[i].Controls.Add(table3);
                    multiView.Views[i].Controls.Add(table);
                    multiView.Views[i].Controls.Add(table2);
                }
                multiView.ActiveViewIndex = i;
                break;
            }
        }
    }
    
    void Page_Load(object sender, EventArgs e)
    {

    }

    void deleteNode(object sender, CommandEventArgs args)
    {
        if (Session["currentGroup"] != "nothing")
        {
            Cache.Remove(xmlFileCache);
            xmlContent = XmlContent;
            XmlNode targetNode = xmlContent.SelectSingleNode("//" + entryName + "[@id = '" + args.CommandArgument + "']");
            targetNode.ParentNode.RemoveChild(targetNode);
            Globals.SaveXml(xmlContent, Server.MapPath("xml/" + xmlFileName), xmlFileCache);
        }
        Response.Redirect(Request.ServerVariables["URL"] + "?" + Request.ServerVariables["QUERY_STRING"]);
    }
    
    void showEditNode(object sender, CommandEventArgs args)
    {
        ((HtmlTable)Globals.FindControlRecursive(this, "editNodeTable")).Visible = true;
        XmlNode targetNode = xmlContent.SelectSingleNode("//" + entryName + "[@id = '" + args.CommandArgument + "']");
        if (targetNode != null)
        {
            ((HiddenField)Globals.FindControlRecursive(this, "edit_id")).Value = targetNode.SelectSingleNode("@id").InnerText;
            for (int a = 0; a < elements.Length; a++)
            {
                ((TextBox)Globals.FindControlRecursive(this, "edit_" + elements[a])).Text = targetNode.SelectSingleNode(elements[a]).InnerText;
            }
        }
    }

    void createNode(object sender, EventArgs e)
    {
        if (Session["currentGroup"] != "nothing")
        {
            Cache.Remove(xmlFileCache);
            xmlContent = XmlContent;
            XmlNode rootElement = xmlContent.SelectSingleNode("root/" + Session["currentGroup"].ToString());
            if (rootElement == null)
            {
                XmlElement rootEle = xmlContent.CreateElement(Session["currentGroup"].ToString());
                xmlContent.DocumentElement.AppendChild(rootEle);
                rootElement = xmlContent.SelectSingleNode("root/" + Session["currentGroup"].ToString());
            }
            XmlElement element = xmlContent.CreateElement(entryName);
            int id = int.Parse(xmlContent.SelectSingleNode("root/@nextid").InnerText);
            element.SetAttribute("id", id.ToString());
            for (int a = 0; a < elements.Length; a++)
            {
                XmlElement subEle = xmlContent.CreateElement(elements[a]);
                subEle.InnerText = ((TextBox)Globals.FindControlRecursive(this, "create_" + elements[a])).Text.Trim();
                element.AppendChild(subEle);
            }
            rootElement.AppendChild(element);
            id++;
            xmlContent.SelectSingleNode("root/@nextid").InnerText = id.ToString();
            Globals.SaveXml(xmlContent, Server.MapPath("xml/" + xmlFileName), xmlFileCache);
        }
        Response.Redirect(Request.ServerVariables["URL"] + "?" + Request.ServerVariables["QUERY_STRING"]);
    }

    void editNode(object sender, EventArgs e)
    {
        if (Session["currentGroup"] != "nothing")
        {
            Cache.Remove(xmlFileCache);
            xmlContent = XmlContent;
            XmlElement element = xmlContent.CreateElement(entryName);
            int id = int.Parse(((HiddenField)Globals.FindControlRecursive(this, "edit_id")).Value);
            element.SetAttribute("id", id.ToString());
            for (int a = 0; a < elements.Length; a++)
            {
                XmlElement subEle = xmlContent.CreateElement(elements[a]);
                subEle.InnerText = ((TextBox)Globals.FindControlRecursive(this, "edit_" + elements[a])).Text.Trim();
                element.AppendChild(subEle);
            }
            XmlNode targetNode = xmlContent.SelectSingleNode("//" + entryName + "[@id = '" + id.ToString() + "']");
            targetNode.ParentNode.ReplaceChild(element, targetNode);
            Globals.SaveXml(xmlContent, Server.MapPath("xml/" + xmlFileName), xmlFileCache);
        }
        Response.Redirect(Request.ServerVariables["URL"] + "?" + Request.ServerVariables["QUERY_STRING"]);
    }

    public XmlDocument XmlContent
    {
        get
        {
            XmlDocument xmlDoc = Globals.LoadXml(Server.MapPath("xml/" + xmlFileName), xmlFileCache);
            if (xmlDoc == null) 
            {
                xmlDoc = new XmlDocument();
                xmlDoc.LoadXml("<root nextid=\"1\"></root>");    
            }
            return xmlDoc;
        }
    }

    
    void switchView(object sender, CommandEventArgs args)
    {
        for (int i = 0; i < multiView.Views.Count; i++)
        {
            if (multiView.Views[i].ID == args.CommandArgument)
            {
                multiView.ActiveViewIndex = i;
                Session["currentGroup"] = args.CommandArgument;
                Response.Redirect(Request.ServerVariables["URL"] + "?" + Request.ServerVariables["QUERY_STRING"]);
                break;
            }
        }
    }
 
</script>
&nbsp;&nbsp;
<asp:Button ID="realMediaSelectBtn" CssClass="button" OnCommand="switchView" CommandArgument="realMediaView" Text="RealMedia Links" runat="server"/>
<asp:Button ID="windowsMediaSelectBtn" CssClass="button" OnCommand="switchView" CommandArgument="windowsMediaView" Text="WindowsMedia Links" runat="server"/>
<asp:Button ID="internalLinksSelectBtn" CssClass="button" OnCommand="switchView" CommandArgument="internalLinksView" Text="Internal Links" runat="server"/>

<asp:MultiView ID="multiView" ActiveViewIndex="0" runat="server">
    <asp:View ID="defaultView" runat="server">
    </asp:View>
    <asp:View ID="realMediaView" runat="server">     
    </asp:View>
    <asp:View ID="windowsMediaView" runat="server">
    </asp:View>
    <asp:View ID="internalLinksView" runat="server">
        <br /><br />
        <table style="width:90%" align="center"  border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="20%" bgcolor="#A7CBEB"><span class="style6">Windows Media </span></td>
      <td width="80%" bgcolor="#CCCCCC">&nbsp;</td>
    </tr>
    <tr>
      <td><span class="style12">Links </span></td>
      <td><span class="style9">mms://wm.world-television.com/encxxx_http_xxxx </span></td>
    </tr>
    <tr>
      <td colspan="2"><span class="style9">encxxx = encodername<br>
        xxxx = portnumber <span class="style10">(usually 6006 - 7007 - 8008 - 9009)</span></span></td>
    </tr>
    <tr>
        <td colspan="2"><br /></td>
    </tr>
<!--
    <tr>
      <td bgcolor="#A7CBEB"><span class="style6">Real Media </span></td>
      <td bgcolor="#CCCCCC">&nbsp;</td>
    </tr>
    <tr>
      <td><span class="style12">Primary Links </span></td>
      <td><span class="style9">rtsp://live14-rm.unbn.unit.net/split/encxxx.unit.net/encoder/filename.rm</span></td>
    </tr>
    <tr>
      <td><span class="style12">Backup Links </span></td>
      <td><span class="style9">rtsp://live8-rm.unbn.unit.net/split/encxxx.unit.net/encoder/filename.rm</span></td>
    </tr>
    <tr>
      <td colspan="2"><span class="style9">encxxx = encodername<br> 
        filename.rm = the filename you typed in the encodersession
<span class="style10"></span></span></td>
    </tr>
-->
  </table>
  <blockquote>&nbsp;</blockquote>
    </asp:View>
</asp:MultiView>

<script type="text/javascript" language="javascript">
    function showcreate() 
    {
        if (document.getElementById("createTable"))
        {
            if (document.getElementById("createTable").style.display == "none")
                document.getElementById("createTable").style.display = "block";
            else
                document.getElementById("createTable").style.display = "none";
        }
    }
    
    function DeleteNode(btnID) 
    {
	        var agree=confirm("Are you sure?");
	        if (agree) 
	        {
		        __doPostBack(btnID,'');
	        }
    }
    
    function copyToClipboard(sid)
    {
        s = document.getElementById("span_" + sid).innerHTML;
        s = s.substring(s.indexOf("//")+2);
	    if( window.clipboardData && clipboardData.setData )
	    {
		    clipboardData.setData("Text", s);
		    alert(s);
	    }
        else 
        {
            alert("Clipboard copying is supported only with IE");
        }
    }
</script>