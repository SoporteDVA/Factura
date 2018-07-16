<%@ page language="C#" autoeventwireup="true" inherits="MenuD, App_Web_skve-5wn" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Menú</title>
    <link rel="stylesheet" type="text/css" href="STEstilos.css"/>
</head>
<body>
    <form id="form1" runat="server">
    <table>
    <tr>
    <td valign="top">
        <asp:TreeView ID="TreeView1" runat="server" CssClass="tituloAzulClaro" DataSourceID="Sitio"
            ShowLines="True" Target="Transaccion" ExpandDepth="0" NodeIndent="10">
        </asp:TreeView>
        &nbsp;
        <br />
        &nbsp;<br />
        </td>
        </tr>
     </table>
        <asp:SiteMapDataSource ID="Sitio" runat="server" ShowStartingNode="False" />
    </form>
</body>
</html>
