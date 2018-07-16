<%@ page language="C#" autoeventwireup="true" inherits="ReporteVisor, App_Web_skve-5wn" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=10.2.3600.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Reportes</title>
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">     
    <div>
        <cr:crystalreportviewer id="VisorCrystal" runat="server" autodatabind="True"
            height="1042px" width="905px" DisplayGroupTree="False" HasToggleGroupTreeButton="False" 
            ReuseParameterValuesOnRefresh="True" HasCrystalLogo="False" HasRefreshButton="True" HasViewList="False" PrintMode="ActiveX"></cr:crystalreportviewer>
        <asp:TextBox ID="ReporteNombre" runat="server" Visible="False"></asp:TextBox><asp:TextBox ID="Archivo" runat="server" Visible="False"></asp:TextBox>
        &nbsp;
    
    </div>
    </form>
</body>
</html>
