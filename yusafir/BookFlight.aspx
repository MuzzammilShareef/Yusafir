<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookFlight.aspx.cs" Inherits="yusafir.BookFlight" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Book Flight - Yusafir</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
/* Base HTML/Body */
html, body {
    height: 100%;
    margin: 0; padding: 0;
    background: linear-gradient(135deg, #80c2ff 0%, #e0aaff 100%);
    font-family: 'Inter', sans-serif; /* you can switch to 'Segoe UI' if you prefer */
}

/* Center container */
.container-center {
    min-height: 100vh;
    display: flex;
    flex-direction: column;           /* vertical stacking */
    justify-content: center;          /* vertical center */
    align-items: center;              /* horizontal center */
    padding: 15px;
    gap: 20px;
}

/* Glassmorphic card style */
.glass-card {
    background: rgba(70, 32, 142, 0.18);
    backdrop-filter: blur(12px);
    border-radius: 18px;
    border: 1.6px solid rgba(255,255,255,0.22);
    box-shadow: 0 6px 40px rgba(60,60,60,.14);
    padding: 40px 40px 30px 40px;
    max-width: 400px; /* or 600px max-width as in Search */
    width: 100%;
    color: white;
    box-sizing: border-box;
}

/* Heading style */
h2 {
    text-align: center;
    margin-bottom: 30px;
    font-weight: 700;
    font-size: 2rem;
    text-shadow: 0 1px 10px rgba(0, 0, 0, 0.3);
}

/* Labels */
label {
    display: block;
    margin-bottom: 6px;
    font-weight: 600;
    font-size: 1rem;
    color: #e2e6f3;
}

/* Inputs and selects main styling */
input[type="number"],
select,
input[readonly],
input[type="text"],
input[type="date"] {
    width: 100%;
    padding: 10px 12px;
    margin-bottom: 22px;
    border: none;
    border-radius: 12px;
    background: rgba(255, 255, 255, 0.12);
    color: #fff;
    font-size: 1rem;
    box-shadow: inset 0 2px 4px rgb(19 12 138 / 0.6);
    outline: none;
    transition: box-shadow 0.2s ease;
    box-sizing: border-box;
}

/* Focus styles */
input[type="number"]:focus,
select:focus,
input[readonly]:focus,
input[type="text"]:focus,
input[type="date"]:focus {
    box-shadow: 0 0 5px 2px #9d4edd;
    background: rgba(255, 255, 255, 0.25);
    color: #fff;
}

/* Option text color */
option {
    color: #000;
}

/* Button styling to match */
.btn-book {
    width: 100%;
    padding: 14px;
    background: linear-gradient(90deg, #19d3fa, #e600ff);
    border: none;
    border-radius: 25px;
    font-size: 1.15rem;
    font-weight: 700;
    color: white;
    cursor: pointer;
    box-shadow: 0 4px 15px rgba(86, 76, 255, 0.5);
    transition: background 0.3s ease, box-shadow 0.3s ease;
}
.btn-book:hover:not(:disabled) {
    background: linear-gradient(90deg, #564cff, #16eaff);
    box-shadow: 0 6px 20px rgba(86, 76, 255, 0.8);
}
.btn-book:disabled,
.btn-book[disabled] {
    background: rgba(128, 128, 128, 0.4);
    cursor: not-allowed;
    box-shadow: none;
}

/* Status message */
.status {
    margin-top: 15px;
    font-size: 1rem;
    text-align: center;
    font-weight: 600;
    min-height: 22px;
    color: #adebad; /* green for success */
    text-shadow: 0 1px 3px rgba(0,0,0,0.3);
}
.status.error {
    color: #ff6b6b; /* red error */
}

/* Remove default arrows on number inputs */
input[type=number]::-webkit-inner-spin-button, 
input[type=number]::-webkit-outer-spin-button { 
    -webkit-appearance: none; 
    margin: 0; 
}
input[type=number] {
    -moz-appearance: textfield;
}

/* Select specific styling for dropdown arrows */
select, .aspNet-InputDropDown {
    appearance: none;
    -webkit-appearance: none;
    -moz-appearance: none;
    background-image: url('data:image/svg+xml;utf8,<svg fill="white" height="14" viewBox="0 0 24 24" width="14" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/></svg>');
    background-repeat: no-repeat;
    background-position: right 12px center;
    background-size: 14px 14px;
    padding-right: 36px;
    color: #fff;
    background-color: rgba(255,255,255,0.14);
    border: none;
    border-radius: 12px;
    box-shadow: inset 0 2px 4px rgb(19 12 138 / 0.6);
    font-size: 1rem;
    outline: none;
    transition: background 0.25s, box-shadow 0.25s;
}
select:focus, .aspNet-InputDropDown:focus {
    background-color: rgba(255,255,255,0.25);
    box-shadow: 0 0 5px 2px #9d4edd;
}

/* Responsive adjustments if needed */
@media (max-width: 460px) {
    .glass-card {
        padding: 30px 25px;
        max-width: 95vw;
    }
}

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-center">
            <div class="glass-card">
                <h2>Confirm Your Booking</h2>

                <asp:Label ID="lblFlightDetails" runat="server" Text="" Font-Bold="true" Font-Size="Large" />

                <label for="txtAdults">Adults</label>
                <asp:DropDownList ID="txtAdults" runat="server">
                    <asp:ListItem Text="1" Value="1" />
                    <asp:ListItem Text="2" Value="2" />
                    <asp:ListItem Text="3" Value="3" />
                    <asp:ListItem Text="4" Value="4" />
                </asp:DropDownList>

                <label for="txtChildren">Children</label>
                <asp:DropDownList ID="txtChildren" runat="server">
                    <asp:ListItem Text="0" Value="0" />
                    <asp:ListItem Text="1" Value="1" />
                    <asp:ListItem Text="2" Value="2" />
                    <asp:ListItem Text="3" Value="3" />
                    <asp:ListItem Text="4" Value="4" />
                </asp:DropDownList> 

                <label for="ddlPaymentMethod">Payment Method</label>
                <asp:DropDownList ID="ddlPaymentMethod" runat="server">
                    <asp:ListItem Text="Select" Value="" />
                    <asp:ListItem Text="Credit Card" Value="Credit Card" />
                    <asp:ListItem Text="UPI" Value="UPI" />
                    <asp:ListItem Text="Net Banking" Value="Net Banking" />
                </asp:DropDownList>

                <label for="txtAmount">Amount (auto-filled)</label>
                <asp:TextBox ID="txtAmount" runat="server" ReadOnly="true" />

                <asp:Button ID="btnBook" runat="server" CssClass="btn-book" Text="Book & Pay" OnClick="btnBook_Click" />

                <asp:Label ID="lblStatus" runat="server" CssClass="status" />
            </div>
        </div>
    </form>
</body>
</html>
