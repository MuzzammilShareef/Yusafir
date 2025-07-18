<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="yusafir.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>

<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f3f3f3;
    }

    .login-container {
        width: 350px;
        margin: 80px auto;
        padding: 30px;
        background-color: #ffffff;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
        border-radius: 10px;
    }

    h2 {
        text-align: center;
        margin-bottom: 25px;
        color: #333;
    }

    table {
        width: 100%;
    }

    td {
        padding: 10px;
    }

    input[type="text"], input[type="password"] {
        width: 100%;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    .btn-login {
        width: 100%;
        padding: 10px;
        background-color: #007BFF;
        border: none;
        color: white;
        border-radius: 5px;
        cursor: pointer;
    }

    .btn-login:hover {
        background-color: #0056b3;
    }

    #lblMessage {
        display: block;
        margin-top: 10px;
        color: red;
        text-align: center;
    }
</style>


<div class="login-container">
    <h2>User Login</h2>
    <table>
        <tr>
            <td>Email:</td>
            <td><asp:TextBox ID="txtEmail" runat="server" CssClass="input-box" /></td>
        </tr>
        <tr>
            <td>Password:</td>
            <td><asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="input-box" /></td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn-login" OnClick="btnLogin_Click" />
            </td>
        </tr>
    </table>
    <asp:Label ID="lblMessage" runat="server" />
</div>




</body>
</html>
