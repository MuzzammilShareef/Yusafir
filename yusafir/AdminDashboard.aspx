<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="yusafir.AdminDashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard</title>
    <style>
        .styled-table {
            border-collapse: collapse;
            margin: 20px auto;
            font-size: 1em;
            min-width: 700px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.15);
        }
        .styled-table th, .styled-table td {
            padding: 12px 15px;
            border: 1px solid #ddd;
            text-align: center;
        }
        .styled-table th {
            background-color: #009879;
            color: #ffffff;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h2 style="text-align:center;">Admin Dashboard - Bookings & Payments</h2>
        <asp:GridView ID="gvAdminBookings" runat="server" CssClass="styled-table" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="BookingID" HeaderText="Booking ID" />
                <asp:BoundField DataField="FlightID" HeaderText="Flight ID" />
                <asp:BoundField DataField="PassengerName" HeaderText="Passenger Name" />
                <asp:BoundField DataField="AmountPaid" HeaderText="Amount Paid" />
                <asp:BoundField DataField="PaymentStatus" HeaderText="Payment Status" />
                <asp:BoundField DataField="BookingDate" HeaderText="Booking Date" />
            </Columns>
        </asp:GridView>
    </form>
</body>
</html>
