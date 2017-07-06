<%@ Control Language="C#" %>
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.Xml.XPath" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="wtv.sa.admin" %>

<script runat="server">

    XmlDocument xmlContent;
    string xmlFileName = "codecs.xml";
    string xmlFileCache = "SAcodecsXml";
    string xmlSortBy = "Customer";
    string entryName = "entry";
    string[] elements = new string[] { "Customer", "CodecUsing", "CodecAccepted", "Migrated" };

    void Page_Init(object sender, EventArgs e)
    {
        xmlContent = XmlContent;
        buildTable();
    }

    void buildTable()
    {
        HtmlTable table = new HtmlTable();
        table.Style.Add("width", "500px");
        table.Style.Add("border", "1px dotted #e4e4e4");
        table.CellPadding = 2;
        table.CellSpacing = 1;
        HtmlTableRow row = new HtmlTableRow();
        HtmlTableCell cell = new HtmlTableCell();

        XPathNavigator nav = xmlContent.CreateNavigator();
        XPathExpression expr = nav.Compile("root/" + entryName);
        expr.AddSort(xmlSortBy, XmlSortOrder.Ascending, XmlCaseOrder.None, "", XmlDataType.Text);
        
        int akamaiCounter = 1;
        string rowColor = "#A7CBEB";
        for (int i = 0; i < elements.Length; i++)
        {
            cell = new HtmlTableCell();
            cell.InnerHtml = "<b>" + elements[i] + "</b>";
            row.Cells.Add(cell);
        }
        cell = new HtmlTableCell();
        cell.ColSpan = 2;
        row.Cells.Add(cell);
        table.Rows.Add(row);
        row = new HtmlTableRow();
        cell = new HtmlTableCell();
        cell.ColSpan = elements.Length + 2;
        cell.InnerHtml = "<hr/>";
        row.Cells.Add(cell);
        table.Rows.Add(row);
        XPathNodeIterator iterator = nav.Select(expr);
        while (iterator.MoveNext())
        {
            XmlNode node = ((IHasXmlNode)iterator.Current).GetNode();
            string nodeid = node.SelectSingleNode("@id").InnerText;
            if (rowColor == "#A7CBEB")
                rowColor = "#fff";
            else
                rowColor = "#A7CBEB";
            row = new HtmlTableRow();
            row.Style.Add("background-color", rowColor);
            row.Attributes.Add("onmouseover", "this.style.backgroundColor='yellow'");
            row.Attributes.Add("onmouseout", "this.style.backgroundColor='" + rowColor + "'");
            for (int a = 0; a < elements.Length; a++)
            {
                if (elements[a].IndexOf("url2") == -1 && elements[a].IndexOf("url3") == -1 && elements[a].IndexOf("url4") == -1)
                {
                    cell = new HtmlTableCell();
                    cell.VAlign = "top";
                }
                else
                {
                    cell.InnerHtml += "<br/>";
                }
                if (elements[a].IndexOf("url1") != -1 || elements[a].IndexOf("url2") != -1 || elements[a].IndexOf("url3") != -1 || elements[a].IndexOf("url4") != -1)
                {
                    cell.InnerHtml += "<b>W" + akamaiCounter.ToString("000") + "</b>&nbsp;&nbsp;";
                    akamaiCounter++;
                }
                if (node.SelectSingleNode(elements[a]) != null)
                    cell.InnerHtml += node.SelectSingleNode(elements[a]).InnerText;
                row.Cells.Add(cell);
            }
            cell = new HtmlTableCell();
            cell.Width = "1";
            ImageButton imgbtn = new ImageButton();
            imgbtn.ID = "edit_" + nodeid;
            imgbtn.Command += new CommandEventHandler(showEditNode);
            imgbtn.CommandArgument = nodeid;
            imgbtn.ImageUrl = "../picts/edit.gif";
            cell.Controls.Add(imgbtn);
            row.Controls.Add(cell);
            cell = new HtmlTableCell();
            cell.Width = "1";
            LinkButton lnkbtn = new LinkButton();
            lnkbtn.ID = "delete_" + nodeid;
            lnkbtn.Command += new CommandEventHandler(deleteNode);
            lnkbtn.CommandArgument = nodeid;
            lnkbtn.Text = "<img src='picts/empty.gif' style='display:none' border='0'/>";
            cell.Controls.Add(new LiteralControl("<img src='picts/delete.gif' border='0' style='cursor:pointer;' onclick='DeleteNode(\"ctl00$Main$ctl00$delete_" + nodeid + "\");'/>"));
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

        placeHolder.Controls.Add(table3);
        placeHolder.Controls.Add(table);
        placeHolder.Controls.Add(table2);

    }

    void Page_Load(object sender, EventArgs e)
    {

    }

    void deleteNode(object sender, CommandEventArgs args)
    {
        Cache.Remove(xmlFileCache);
        xmlContent = XmlContent;
        XmlNode targetNode = xmlContent.SelectSingleNode("//" + entryName + "[@id = '" + args.CommandArgument + "']");
        targetNode.ParentNode.RemoveChild(targetNode);
        Globals.SaveXml(xmlContent, Server.MapPath("xml/" + xmlFileName), xmlFileCache);
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
        Cache.Remove(xmlFileCache);
        xmlContent = XmlContent;
        XmlNode rootElement = xmlContent.SelectSingleNode("root");
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
        Response.Redirect(Request.ServerVariables["URL"] + "?" + Request.ServerVariables["QUERY_STRING"]);
    }

    void editNode(object sender, EventArgs e)
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


 
</script>

<table width="100%" cellpadding="0" cellspacing="10">
    <tr>
        <td valign="top">
            <asp:PlaceHolder ID="placeHolder" runat="server" />
        </td>
    </tr>
</table>

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
</script>

