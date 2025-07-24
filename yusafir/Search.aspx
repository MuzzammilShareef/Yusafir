<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="yusafir.Search" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Search Flights</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet" />
    <style>
        /* Base styling for html and body */
        html, body {
            height: 100%;
            margin: 0; 
            padding: 0;
            background: linear-gradient(135deg, #80c2ff 0%, #e0aaff 100%);
            font-family: 'Inter', sans-serif;
        }

        /* Center container for content */
        .container-center {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;  /* Vertically center */
            align-items: center;      /* Horizontally center */
            padding: 15px;
            gap: 20px;
        }

        /* Glassmorphic card */
        .glass-card {
            background: rgba(70, 32, 142, 0.18);
            backdrop-filter: blur(12px);
            border-radius: 18px;
            border: 1.6px solid rgba(255,255,255,0.22);
            box-shadow: 0 6px 40px rgba(60,60,60,.14);
            padding: 40px 40px 30px 40px;
            max-width: 600px;
            width: 100%;
            color: white;
            box-sizing: border-box;
        }

        /* Heading */
        h2 {
            text-align: center;
            margin-bottom: 30px;
            font-weight: 700;
            font-size: 2rem;
            text-shadow: 0 1px 10px rgba(0, 0, 0, 0.3);
        }

        /* Form row container */
        .form-row {
            margin-bottom: 20px;
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            align-items: center;
        }

        /* Form labels */
        .form-row label {
            flex: 1 0 120px;
            font-weight: 600;
        }

        /* Inputs and selects styling */
        .form-row select, 
        .form-row input[type="text"], 
        .form-row input[type="date"] {
            flex: 2 0 180px;
            padding: 10px 12px;
            font-size: 1rem;
            border-radius: 12px;
            border: none;
            background: rgba(255, 255, 255, 0.12);
            color: #fff;
            box-shadow: inset 0 2px 4px rgb(19 12 138 / 0.6);
            outline: none;
            transition: box-shadow 0.2s ease;
            box-sizing: border-box;
        }

        /* Focus styles for inputs and selects */
        .form-row select:focus,
        .form-row input[type="text"]:focus,
        .form-row input[type="date"]:focus {
            box-shadow: 0 0 5px 2px #9d4edd;
            background: rgba(255, 255, 255, 0.25);
            color: #fff;
        }

        /* Dropdown option text color */
        option {
            color: #000;
        }

        /* Time selectors container with from-to dash */
        .time-select-row {
            align-items: center;
        }

        .time-pair {
            display: flex;
            align-items: center;
            gap: 8px;
            flex: 2 0 180px; /* Keep consistent width */
        }

        /* Time dropdowns styling */
        .time-select {
            min-width: 64px;
            padding: 10px 12px;
            font-size: 1rem;
            border-radius: 12px;
            border: none;
            background: rgba(255, 255, 255, 0.12);
            color: #fff;
            box-shadow: inset 0 2px 4px rgb(19 12 138 / 0.6);
            outline: none;
            transition: box-shadow 0.2s, background 0.18s, color 0.18s;
            box-sizing: border-box;
        }

        /* Focus styles for time dropdown */
        .time-select:focus {
            background: rgba(255, 255, 255, 0.25);
            box-shadow: 0 0 5px 2px #9d4edd;
            color: #fff;
        }

        /* Dash separator between time selectors */
        .time-separator {
            color: #fff;
            font-size: 1.25em;
            font-weight: bold;
            padding: 0 4px;
            user-select: none;
        }

        /* Form action buttons container */
        .form-actions {
            text-align: center;
            margin-top: 30px;
        }

        /* Search button style */
        .form-actions input[type="submit"], .btnSearch {
            background: linear-gradient(90deg, #19d3fa, #e600ff);
            color: white;
            font-weight: 700;
            padding: 14px 36px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-size: 1.1rem;
            transition: background 0.3s ease;
        }

        /* Hover effect for search button */
        .form-actions input[type="submit"]:hover, .btnSearch:hover {
            background: linear-gradient(90deg, #564cff, #16eaff);
        }

        /* Container around the GridView with glassmorphic style */
        .results-table-container {
            max-width: 90%;
            width: 100%;
            margin: 30px auto 50px;
            background: rgba(70, 32, 142, 0.13);
            border-radius: 18px;
            box-shadow: 0 4px 30px rgba(55, 19, 105, 0.12);
            backdrop-filter: blur(12px);
            border: 1.2px solid rgba(255,255,255,0.18);
            overflow-x: visible;  /* No horizontal scrollbar */
            padding: 22px 0 18px 0;
            box-sizing: border-box;
            word-wrap: break-word; /* Wrap text if needed */
        }

        /* GridView styling */
        .styled-table {
            width: 96%;
            border-collapse: collapse;
            margin: 0 auto;
            box-shadow: 0 0 22px rgba(80, 40, 190, 0.10);
            background: rgba(255,255,255,0.17);
            color: #23223f;
            font-size: 15px;
            border-radius: 13px;
            overflow: hidden;
            table-layout: fixed; /* Prevent overflow */
        }

        /* Table header and cell styles */
        .styled-table th, .styled-table td {
            padding: 14px 20px;
            border-bottom: 1px solid #dedaf7;
            text-align: left;
            white-space: normal;    /* Allow content wrap */
            word-break: break-word; /* Wrap long words */
            font-weight: 500;
        }

        /* Table header styling */
        .styled-table thead th {
            background: linear-gradient(90deg, #c3aafd 0%, #7649d9 100%);
            color: #fff;
            font-weight: 800;
            border-bottom: 2px solid #bda1fd;
        }

        /* Row hover highlight */
        .styled-table tr:hover {
            background: rgba(130, 170, 255, 0.14);
        }

        /* Last row - no border bottom */
        .styled-table tr:last-child td {
            border-bottom: none;
        }

        /* Book button inside GridView */
        .book-btn {
            background-color: #16a34a;
            color: white;
            padding: 7px 16px;
            border: none;
            border-radius: 8px;
            font-size: 13px;
            cursor: pointer;
            font-weight: 600;
            transition: background 0.22s ease;
        }

        /* Book button hover */
        .book-btn:hover {
            background-color: #15803d;
        }

        /* Responsive: shrink font size for small screens */
        @media (max-width: 500px) {
            .styled-table th, .styled-table td {
                font-size: 12px;
                padding: 8px 8px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-center">
            <div class="glass-card">
                <h2>Search Flights</h2>

                <asp:Label ID="lblMessage" runat="server" ForeColor="Red" />

                <div class="form-row">
                    <label for="txtCustomerId">Customer ID:</label>
                    <asp:TextBox ID="txtCustomerId" runat="server" placeholder="Enter User ID" />
                </div>

                <div class="form-row">
                    <label for="ddlSource">Source:</label>
                    <asp:DropDownList ID="ddlSource" runat="server" />
                </div>

                <div class="form-row">
                    <label for="ddlDestination">Destination:</label>
                    <asp:DropDownList ID="ddlDestination" runat="server" />
                </div>

                <!-- Fixed Time From - To block -->
                <div class="form-row time-select-row">
                    <label for="ddlTimeFrom">Time (From – To):</label>
                    <div class="time-pair">
                        <asp:DropDownList ID="ddlTimeFrom" runat="server" CssClass="time-select" />
                        <span class="time-separator">–</span>
                        <asp:DropDownList ID="ddlTimeTo" runat="server" CssClass="time-select" />
                    </div>
                </div>

                <div class="form-row">
                    <label for="txtDate">Departure Date:</label>
                    <asp:TextBox ID="txtDate" runat="server" TextMode="Date" />
                </div>

                <div class="form-actions">
                    <asp:Button CssClass="btnSearch" ID="btnSearch" runat="server" Text="Search For Flights" OnClick="btnSearch_Click" />
                </div>
            </div> <!-- end glass-card -->

            <div class="results-table-container">
                <asp:GridView ID="gvFlights" runat="server" AutoGenerateColumns="False"
                    CssClass="styled-table" OnRowCommand="gvFlights_RowCommand" Visible="false">
                    <Columns>
                        <asp:BoundField DataField="FlightId" HeaderText="Flight ID" />
                        <asp:BoundField DataField="FlightType" HeaderText="Flight Type" />
                        <asp:BoundField DataField="Source" HeaderText="Source" />
                        <asp:BoundField DataField="Destination" HeaderText="Destination" />
                        <asp:BoundField DataField="DepartureDate" HeaderText="Departure Date" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" />
                        <asp:BoundField DataField="TotalSeats" HeaderText="Total Seats" />
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:Button ID="btnBook" CssClass="book-btn" runat="server" Text="Book" CommandName="BookFlight" CommandArgument='<%# Eval("FlightId") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div> <!-- end results-table-container -->
        </div>
    </form>
</body>
</html>
