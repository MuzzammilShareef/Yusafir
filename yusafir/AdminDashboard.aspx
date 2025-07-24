<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="yusafir.AdminDashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard - Yusafir</title>
    <style>
        html, body {
            height: 100%;
            margin: 0; padding: 0;
            background: linear-gradient(135deg, #80c2ff 0%, #e0aaff 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .container-center {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: start;
            padding: 40px 20px;
        }
        .glass-card {
            background: rgba(70, 32, 142, 0.18);
            border-radius: 18px;
            box-shadow: 0 6px 40px rgba(60, 60, 60, 0.14);
            backdrop-filter: blur(12px);
            border: 1.6px solid rgba(255,255,255,0.22);
            box-sizing: border-box;
            padding: 30px 40px;
            width: 900px;
            max-width: 95vw;
            color: white;
        }
        h2 {
            text-align: center;
            font-weight: 700;
            font-size: 2.2rem;
            margin-bottom: 30px;
            text-shadow: 0 1px 6px rgba(0,0,0,0.3);
        }
        .styled-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 1rem;
            min-width: 700px;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 0 15px rgba(0,0,0,0.25);
            background: #ffffffdd;
            color: #222;
        }
        .styled-table th, .styled-table td {
            padding: 14px 18px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }
        .styled-table thead {
            background-color: #7c3aed;
            color: #ffffff;
            font-weight: 700;
        }
        .styled-table tbody tr:hover {
            background-color: #f1f7ff;
        }
        /* Responsive */
        @media (max-width: 960px) {
            .glass-card {
                width: 100%;
                padding: 20px;
            }
            .styled-table {
                font-size: 0.9rem;
                min-width: unset;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-center">
            <div class="glass-card">
                <h2>Admin Dashboard - Bookings & Payments</h2>
                <asp:GridView ID="gvAdminBookings" runat="server" CssClass="styled-table" AutoGenerateColumns="False" 
                    EmptyDataText="No booking data available">
                    <Columns>
                        <asp:BoundField DataField="BookingID" HeaderText="Booking ID" />
                        <asp:BoundField DataField="FlightID" HeaderText="Flight ID" />
                        <asp:BoundField DataField="PassengerName" HeaderText="Passenger Name" />
                        <asp:BoundField DataField="AmountPaid" DataFormatString="{0:C}" HeaderText="Amount Paid" />
                        <asp:BoundField DataField="PaymentStatus" HeaderText="Payment Status" />
                        <asp:BoundField DataField="BookingDate" DataFormatString="{0:yyyy-MM-dd HH:mm}" HeaderText="Booking Date" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>
