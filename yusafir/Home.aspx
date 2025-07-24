<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="Yusafir.home" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Welcome to Yusafir</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #80c2ff 0%, #e0aaff 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .container-center {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 15px;
        }
        .glass-card {
            background: rgba(70, 32, 142, 0.18);
            border-radius: 18px;
            box-shadow: 0 6px 50px rgba(60, 60, 60, 0.2);
            backdrop-filter: blur(12px);
            border: 1.6px solid rgba(255, 255, 255, 0.22);
            box-sizing: border-box;
            padding: 40px 50px;
            width: 400px;
            max-width: 95vw;
            text-align: center;
            color: white;
        }
        .glass-card h1 {
            margin: 0 0 25px 0;
            font-size: 2.4rem;
            font-weight: 700;
            text-shadow: 0 0 7px rgba(0,0,0,0.25);
        }
        .glass-card p {
            font-size: 1.1rem;
            margin-bottom: 35px;
            text-shadow: 0 0 3px rgba(0,0,0,0.2);
        }
        .module-button {
            width: 100%;
            height: 55px;
            margin-bottom: 20px;
            font-size: 1.25rem;
            font-weight: 600;
            background: linear-gradient(90deg, #19d3fa, #e600ff);
            color: #fff;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            box-shadow: 0 3px 10px rgba(128, 40, 240, 0.3);
            transition: background 0.25s ease, box-shadow 0.25s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }
        .module-button i {
            font-size: 1.5rem;
        }
        .module-button:hover {
            background: linear-gradient(90deg, #564cff, #16eaff);
            box-shadow: 0 5px 20px rgba(86, 76, 255, 0.6);
        }
        /* Responsive for smaller screen */
        @media (max-width: 460px) {
            .glass-card {
                padding: 30px 25px;
                width: 95vw;
            }
            .module-button {
                font-size: 1.1rem;
                height: 50px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-center">
            <div class="glass-card">
                <h1>Welcome to Yusafir Travel Portal</h1>
                <p>Choose a module to continue:</p>

                <asp:Button ID="btnFlights" runat="server" CssClass="module-button" Text="✈️ Flights" OnClick="btnFlights_Click" />
                <asp:Button ID="btnHotels" runat="server" CssClass="module-button" Text="🏨 Hotels" OnClick="btnHotels_Click" />
                <asp:Button ID="btnPackages" runat="server" CssClass="module-button" Text="🗺️ Packages" OnClick="btnPackages_Click" />
                <asp:Button ID="btnVehicles" runat="server" CssClass="module-button" Text="🚗 Vehicles" OnClick="btnVehicles_Click" />
            </div>
        </div>
    </form>
</body>
</html>
