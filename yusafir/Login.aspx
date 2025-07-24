<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="yusafir.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Yusafir - Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }
        body {
            height: 100vh;
            width: 100vw;
            /* Subtle, modern gradient background (Hyderabad-inspired blues/purples) */
            background: linear-gradient(135deg, #80c2ff 0%, #e0aaff 100%);
            position: relative;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .bg-overlay {
            display: none; /* Overlay removed since no image */
        }
        .container-center {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 2;
            position: relative;
        }
        .glass-card {
            background: rgba(70, 32, 142, 0.18);
            border-radius: 18px;
            box-shadow: 0 6px 40px 0 rgba(60,60,60,.14);
            backdrop-filter: blur(12px);
            border: 1.6px solid rgba(255,255,255,0.18);
            box-sizing: border-box;
            padding: 44px 36px 31px 36px;
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 345px;
            max-width: 93vw;
        }
        .glass-card h2 {
            color: #fff;
            text-align: center;
            margin-bottom: 32px;
            letter-spacing: 1.4px;
            font-weight: bold;
            font-size: 2.1rem;
            text-shadow: 0 2px 14px rgba(30,0,90,0.15);
        }
        .input-group {
            width: 100%;
            margin-bottom: 20px;
            position: relative;    /* Required for absolute positioning of children */
        }

        .input-box {
            width: 100%;
            padding: 12px   0px 12px 14px;
            border: none;
            border-radius: 25px;
            font-size: 1.04rem;
            background: rgba(255,255,255,0.14);
            color: #fff;
            box-shadow: 0 2px 8px rgba(48,24,96,0.07) inset;
            outline: none;
            transition: background 0.18s, box-shadow 0.2s;
        }
        .input-box::placeholder {
            color: #e2e6f3;
            font-weight: 500;
            opacity: 1;
        }
        .input-icon {
            position: absolute;
            right: 15px;
            top: 50%;                          /* Center vertically */
            transform: translateY(-50%);        /* Adjust for height */
            color: #e2e6f3;
            font-size: 1.12rem;
            pointer-events: none;               /* Prevents icon from blocking input clicks */
        }

        .row-options {
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 19px;
        }
        .remember-label {
            color: #e2e6f3;
            font-size: 0.97rem;
            font-weight: 500;
            display: flex;
            align-items:center;
            cursor: pointer;
        }
        .remember-me {
            margin-right: 6px;
            accent-color: #fff;
        }
        .forgot-link {
            color: #ffe49e;
            font-size: 0.96rem;
            text-decoration: none;
            font-weight: 500;
        }
        .forgot-link:hover {
            color: #ffecb3;
            text-decoration: underline;
        }
        .btn-login {
            width: 100%;
            padding: 13px 0;
            background: linear-gradient(90deg, #19d3fa, #e600ff);
            border: none;
            border-radius: 23px;
            font-size: 1.11rem;
            font-weight: 700;
            color: #fff;
            cursor: pointer;
            margin-top: 6px;
            margin-bottom: 19px;
            letter-spacing: 0.5px;
            box-shadow: 0 1px 8px 0 rgba(128,40,240,0.12);
            transition: background 0.2s;
        }
        .btn-login:hover {
            background: linear-gradient(90deg, #564cff, #16eaff);
        }
        .switch-row {
            width: 100%;
            text-align: center;
            margin-top: 8px;
        }
        .switch-mode {
            color: #ffe49e;
            background: none;
            border: none;
            cursor: pointer;
            text-decoration: underline;
            font-size: 1.01rem;
            font-weight: 600;
            margin-left: 6px;
        }
        .switch-mode:hover {
            color: #fff;
        }
        .register-row {
            margin-top: 7px;
            text-align: center;
            width: 100%;
        }
        .register-row span {
            color: #e2e6f3;
            font-size: 0.98rem;
        }
        .register-row a {
            color: #fff;
            text-decoration: underline;
            font-weight: bold;
            margin-left: 7px;
        }
        .register-row a:hover {
            color: #ffe49e;
        }
        #lblMessage {
            color: #ffe49e;
            min-height: 18px;
            text-align:center;
            margin-bottom: 5px;
            font-size: .99rem;
            font-weight: 500;
        }
    </style>
</head>
<body>
    <div class="container-center">
        <form id="form1" runat="server">
            <div class="glass-card">
                <h2 id="loginTitle" runat="server"><%# IsAdminMode ? "Admin Login" : "Login" %></h2>

                <asp:Label ID="lblMessage" runat="server" />

                <div class="input-group">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="input-box" placeholder="Username" AutoCompleteType="None" />
                    <i class="fa fa-user input-icon"></i>
                </div>
                <div class="input-group">
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="input-box" TextMode="Password" placeholder="Password" AutoCompleteType="None" />
                    <i class="fa fa-lock input-icon"></i>
                </div>
                <div class="row-options">
                    <label class="remember-label">
                        <asp:CheckBox ID="chkRemember" runat="server" CssClass="remember-me" />
                        Remember me
                    </label>
                    <a href="ForgotPassword.aspx" class="forgot-link">Forgot password?</a>
                </div>
                <asp:Button ID="btnLogin" runat="server" CssClass="btn-login" Text="Login" OnClick="btnLogin_Click" />

                <div class="switch-row">
                    <span style="color:#e2e6f3;">
                        <%# IsAdminMode ? "Want to log in as User?" : "Are you an admin?" %>
                    </span>
                    <asp:Button ID="btnSwitchMode" runat="server"
                        CssClass="switch-mode"
                        CausesValidation="false"
                        Text='<%# IsAdminMode ? "User Login" : "Admin Login" %>' 
                        OnClick="btnSwitchMode_Click" />
                </div>
                <div class="register-row" runat="server" id="registerRow" visible='<%# !IsAdminMode %>'>
                    <span>Don't have an account?</span>
                    <a href="Register.aspx">Register</a>
                </div>
            </div>
        </form>
    </div>
</body>
</html>
Z