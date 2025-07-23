<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="yusafir.Search" %>

<!DOCTYPE html>
<html>
<head>
    <title>Search Flights</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet" />
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f5f7fa;
            margin: 0;
            padding: 40px;
        }

        .container {
            background: #ffffff;
            padding: 30px 40px;
            max-width: 600px;
            margin: auto;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #333;
        }

        .form-row {
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            gap: 15px;
        }

        .form-row label {
            flex: 1;
            font-weight: 600;
            margin-bottom: 5px;
            color: #444;
        }

        .form-row select,
        .form-row input[type="text"],
        .form-row input[type="date"] {
            flex: 2;
            padding: 8px 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }

        .form-actions {
            text-align: center;
            margin-top: 30px;
        }

        .form-actions input[type="submit"] {
            background-color: #007bff;
            color: white;
            padding: 12px 28px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
        }

        .form-actions input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .table-bordered {
            z-index: 1;
            left: 426px;
            top: 622px;
            position: absolute;
            height: 158px;
            width: 770px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Search Flights</h2>

            <asp:Label ID="lblMessage" runat="server" ForeColor="Red" />

            <div class="form-row">
                <label for="ddlCustomerId">Customer ID:</label>
                <asp:DropDownList ID="ddlCustomerId" runat="server" />
            </div>

            <div class="form-row">
                <label for="ddlSource">Source:</label>
                <asp:DropDownList ID="ddlSource" runat="server" />
            </div>

            <div class="form-row">
                <label for="ddlDestination">Destination:</label>
                <asp:DropDownList ID="ddlDestination" runat="server" />
            </div>

            <div class="form-row">
                <label for="ddlTimeFrom">Time From:</label>
                <asp:DropDownList ID="ddlTimeFrom" runat="server" />
                <label for="ddlTimeTo">To:</label>
                <asp:DropDownList ID="ddlTimeTo" runat="server" />
            </div>

            <div class="form-row">
                <label for="txtDate">Departure Date:</label>
                <asp:TextBox ID="txtDate" runat="server" TextMode="Date" />
            </div>

            <div class="form-row">
                <label for="ddlAdults">Adults:</label>
                <asp:DropDownList ID="ddlAdults" runat="server" />
                <label for="ddlChildren">Children:</label>
                <asp:DropDownList ID="ddlChildren" runat="server" />
            </div>

            <div class="form-actions">
                <asp:Button ID="btnSearch" runat="server" Text="Search For Flights" OnClick="btnSearch_Click" />
            </div>

            <asp:GridView ID="gvFlights" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered" class="form-row" Visible="false">
                <Columns>
                    <asp:BoundField DataField="FlightId" HeaderText="Flight ID" />
                    <asp:BoundField DataField="FlightType" HeaderText="Flight Type" />
                    <asp:BoundField DataField="Source" HeaderText="Source" />
                    <asp:BoundField DataField="Destination" HeaderText="Destination" />
                    <asp:BoundField DataField="DepartureDate" HeaderText="Departure Date" />
                    <asp:BoundField DataField="Price" HeaderText="Price" />
                    <asp:BoundField DataField="TotalSeats" HeaderText="Total Seats" />
                </Columns>
            </asp:GridView>

        </div>
    </form>
</body>

</html>
