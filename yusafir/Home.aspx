<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="Yusafir.home" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Welcome to Yusafir</title>
    <style>
        body {
            font-family: Arial;
            background-color: #f4f4f4;
            text-align: center;
            padding: 50px;
        }

        .module-button {
            width: 200px;
            height: 60px;
            margin: 20px;
            font-size: 18px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 10px;
            cursor: pointer;
        }

        .module-button:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h1>Welcome to Yusafir Travel Portal</h1>
        <p>Choose a module to continue:</p>
        
        <asp:Button ID="btnFlights" runat="server" CssClass="module-button" Text="✈️ Flights" OnClick="btnFlights_Click" />
        <asp:Button ID="btnHotels" runat="server" CssClass="module-button" Text="🏨 Hotels" OnClick="btnHotels_Click" />
        <asp:Button ID="btnPackages" runat="server" CssClass="module-button" Text="🗺️ Packages" OnClick="btnPackages_Click" />
        <asp:Button ID="btnVehicles" runat="server" CssClass="module-button" Text="🚗 Vehicles" OnClick="btnVehicles_Click" />
    </form>
</body>
</html>
