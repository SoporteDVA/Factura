<%@ page language="C#" autoeventwireup="true" inherits="Login, App_Web_skve-5wn" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<HEAD>
		<title>Validación de usuario </title>
		<script language="JavaScript" type="text/javascript">
			<!--
			function setTop() {
				if(window != top) {
					top.location.href = "Login.aspx";
				}
			}
			// -->
		</script>
		<LINK href="styles/styles.css" type="text/css" rel="stylesheet">
	</HEAD>
<body>
    <form id="form1" runat="server">
    <div align=center>
        <asp:Login ID="Login1" runat="server"
            DestinationPageUrl="~/Default.aspx" FailureText="ID o contraseña incorrecta. Por favor intente de nuevo."
            LoginButtonText="Ingresar" PasswordLabelText="Contraseña:" PasswordRecoveryText="Olvidó su contraseña?"
             PasswordRequiredErrorMessage="La contraseña es requerida."
            RememberMeText="Recordar mi contraseña." TitleText="Login" UserNameLabelText="ID:"
            UserNameRequiredErrorMessage="La cédula es requerida." BackColor="#F7F6F3" BorderColor="#E6E2D8" BorderPadding="4" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#333333">
            <TitleTextStyle BackColor="#5D7B9D" Font-Bold="True" Font-Size="0.9em" ForeColor="White" />
            <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
            <TextBoxStyle Font-Size="0.8em" />
            <LoginButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px"
                Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284775" />
        </asp:Login>
    
    </div>
    </form>
</body>
</html>
