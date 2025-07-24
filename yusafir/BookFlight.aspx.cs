using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace yusafir
{
    public partial class BookFlight : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Validate flightId query param presence
                if (Request.QueryString["flightId"] != null && int.TryParse(Request.QueryString["flightId"], out int flightId))
                {
                    ShowFlightDetails(flightId);
                    LoadAmount(flightId);
                    btnBook.Enabled = true;
                }
                else
                {
                    lblFlightDetails.Text = "No flight selected.";
                    btnBook.Enabled = false;
                }
                lblStatus.Text = "";
            }
        }

        private void ShowFlightDetails(int flightId)
        {
            string cs = ConfigurationManager.ConnectionStrings["mydbcon"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(cs))
            {
                string query = "SELECT FlightNo, Source, Destination FROM Flights WHERE FlightID = @FlightID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@FlightID", flightId);
                conn.Open();

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    lblFlightDetails.Text = $"Flight: {reader["FlightNo"]} | {reader["Source"]} → {reader["Destination"]}";
                }
                else
                {
                    lblFlightDetails.Text = "Flight not found.";
                    btnBook.Enabled = false;
                }
            }
        }

        private void LoadAmount(int flightId)
        {
            // Auto-fill amount to the flight's price on page load
            string cs = ConfigurationManager.ConnectionStrings["mydbcon"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(cs))
            {
                string query = "SELECT Price FROM Flights WHERE FlightID = @FlightID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@FlightID", flightId);
                conn.Open();

                object priceObj = cmd.ExecuteScalar();
                if (priceObj != null)
                {
                    if (decimal.TryParse(priceObj.ToString(), out decimal price))
                    {
                        txtAmount.Text = price.ToString("F2");
                    }
                    else
                    {
                        txtAmount.Text = "";
                    }
                }
                else
                {
                    txtAmount.Text = "";
                }
            }
        }

        protected void btnBook_Click(object sender, EventArgs e)
        {
            // Clear previous status message
            lblStatus.CssClass = "status";
            lblStatus.Text = "";

            // Validate inputs first
            if (!int.TryParse(Request.QueryString["flightId"], out int flightId))
            {
                lblStatus.CssClass = "status error";
                lblStatus.Text = "Invalid flight selection.";
                return;
            }

            if (Session["UserId"] == null || !int.TryParse(Session["UserId"].ToString(), out int userId))
            {
                lblStatus.CssClass = "status error";
                lblStatus.Text = "User not logged in. Please log in first.";
                btnBook.Enabled = false;
                return;
            }

            if (!int.TryParse(txtAdults.SelectedValue, out int adults) || adults < 1 || adults > 4)
            {
                lblStatus.CssClass = "status error";
                lblStatus.Text = "Please enter a valid number of adults (1-4).";
                return;
            }

            if (!int.TryParse(txtChildren.SelectedValue, out int children) || children < 0 || children > 4)
            {
                lblStatus.CssClass = "status error";
                lblStatus.Text = "Please enter a valid number of children (0-4).";
                return;
            }


            if (ddlPaymentMethod.SelectedIndex == 0)
            {
                lblStatus.CssClass = "status error";
                lblStatus.Text = "Please select a payment method.";
                return;
            }

            if (!decimal.TryParse(txtAmount.Text.Trim(), out decimal amount) || amount <= 0)
            {
                lblStatus.CssClass = "status error";
                lblStatus.Text = "Invalid amount.";
                return;
            }

            try
            {
                string cs = ConfigurationManager.ConnectionStrings["mydbcon"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(cs))
                {
                    conn.Open();

                    // Start transaction for consistency
                    SqlTransaction transaction = conn.BeginTransaction();

                    try
                    {
                        string insertBookingQuery = @"
                            INSERT INTO Bookings (FlightID, CustomerID, Adults, Children, DateOfBooking)
                            OUTPUT INSERTED.BookingID
                            VALUES (@FlightID, @CustomerID, @Adults, @Children, @DateOfBooking)";
                        SqlCommand bookingCmd = new SqlCommand(insertBookingQuery, conn, transaction);
                        bookingCmd.Parameters.AddWithValue("@FlightID", flightId);
                        bookingCmd.Parameters.AddWithValue("@CustomerID", userId);
                        bookingCmd.Parameters.AddWithValue("@Adults", adults);
                        bookingCmd.Parameters.AddWithValue("@Children", children);
                        bookingCmd.Parameters.AddWithValue("@DateOfBooking", DateTime.Now);

                        int bookingId = (int)bookingCmd.ExecuteScalar();

                        string insertPaymentQuery = @"
                            INSERT INTO Payments (BookingID, PaymentMethod, PaymentDate, Amount)
                            VALUES (@BookingID, @PaymentMethod, @PaymentDate, @Amount)";
                        SqlCommand paymentCmd = new SqlCommand(insertPaymentQuery, conn, transaction);
                        paymentCmd.Parameters.AddWithValue("@BookingID", bookingId);
                        paymentCmd.Parameters.AddWithValue("@PaymentMethod", ddlPaymentMethod.SelectedValue);
                        paymentCmd.Parameters.AddWithValue("@PaymentDate", DateTime.Now);
                        paymentCmd.Parameters.AddWithValue("@Amount", amount);

                        paymentCmd.ExecuteNonQuery();

                        transaction.Commit();

                        lblStatus.CssClass = "status";
                        lblStatus.Text = "Booking and payment successful!";

                        // Optionally, redirect to confirmation or booking details page
                        // Response.Redirect($"BookingConfirmation.aspx?bookingId={bookingId}");
                    }
                    catch (Exception exTrans)
                    {
                        transaction.Rollback();
                        lblStatus.CssClass = "status error";
                        lblStatus.Text = "Error during booking: " + exTrans.Message;
                    }
                }
            }
            catch (Exception ex)
            {
                lblStatus.CssClass = "status error";
                lblStatus.Text = "Database error: " + ex.Message;
            }
        }
    }
}
