<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FlightSearch.aspx.cs" Inherits="FlightSearch" %>

<asp:ScriptManager ID="ScriptManager1" runat="server" />
<ajaxToolkit:CalendarExtender ... /> to be added

<!DOCTYPE html>
<html>
<head runat="server">

    <title>Flight Search - Yusafir</title>
    <link rel="stylesheet" href="style.css" />

</head>
<body>

    <form id="form1" runat="server">
        <div class="container">
            <h2>Search Flights</h2>

            <div class="form-group">
                <label for="ddlCustID">Customer ID</label>
                <asp:DropDownList ID="ddlCustID" runat="server" CssClass="dropdown"></asp:DropDownList>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="ddlSource">Source</label>
                    <asp:DropDownList ID="ddlSource" runat="server" CssClass="dropdown"></asp:DropDownList>
                </div>
                <div class="form-group">
                    <label for="ddlDestination">Destination</label>
                    <asp:DropDownList ID="ddlDestination" runat="server" CssClass="dropdown"></asp:DropDownList>
                </div>
            </div>

            <div class="form-group">

                <label for="txtDepartureDate">Departure Date</label>
                <asp:TextBox ID="txtDepartureDate" runat="server" CssClass="textbox" placeholder="YYYY-MM-DD"></asp:TextBox>
                <asp:CalendarExtender ID="CalendarExtender1" runat="server"
                    TargetControlID="txtDepartureDate" Format="yyyy-MM-dd" />
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="ddlAdults">Adults</label>
                    <asp:DropDownList ID="ddlAdults" runat="server" CssClass="dropdown"></asp:DropDownList>
                </div>
                <div class="form-group">
                    <label for="ddlChildren">Children</label>
                    <asp:DropDownList ID="ddlChildren" runat="server" CssClass="dropdown"></asp:DropDownList>
                </div>
            </div>

            <asp:Button ID="btnSearch" runat="server" Text="Search For Flights" CssClass="btn" OnClick="btnSearch_Click" />
        </div>
    </form>
</body>
</html>
