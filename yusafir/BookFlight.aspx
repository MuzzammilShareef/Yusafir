<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookFlight.aspx.cs" Inherits="yusafir.BookFlight" %>

<!DOCTYPE html>
<html>
<head>
    <title>Book Flight</title>
    <style>
        body { font-family: Arial; padding: 40px; background: #f4f4f4; }
        .form-container {
            background: white; padding: 30px;
            max-width: 450px; margin: auto;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 8px;
        }
        label, select, input, button {
            display: block; width: 100%;
            margin-bottom: 15px;
            font-size: 16px;
        }
        button {
            padding: 10px; background: #007bff;
            color: white; border: none; border-radius: 5px;
        }
        button:hover { background: #0056b3; }
        .status { margin-top: 10px; color: green; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="form-container">
        <h2>Confirm Your Booking</h2>

        <asp:Label ID="lblFlightDetails" runat="server" Text="" />

        <label>Adults (1-4)</label>
        <asp:TextBox ID="txtAdults" runat="server" TextMode="Number" Min="1" Max="4" />

        <label>Children (0-4)</label>
        <asp:TextBox ID="txtChildren" runat="server" TextMode="Number" Min="0" Max="4" />

        <label>Payment Method</label>
        <asp:DropDownList ID="ddlPaymentMethod" runat="server">
            <asp:ListItem Text="Select" Value="" />
            <asp:ListItem Text="Credit Card" Value="Credit Card" />
            <asp:ListItem Text="UPI" Value="UPI" />
            <asp:ListItem Text="Net Banking" Value="Net Banking" />
        </asp:DropDownList>

        <label>Amount</label>
        <asp:TextBox ID="txtAmount" runat="server" TextMode="Number" />

        <asp:Button ID="btnBook" runat="server" Text="Book & Pay" OnClick="btnBook_Click" />

        <asp:Label ID="lblStatus" runat="server" CssClass="status" />
    </div>
    </form>
</body>
</html>
