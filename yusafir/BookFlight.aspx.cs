using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace yusafir
{
    public partial class BookFlight : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Request.QueryString["flightId"] != null)
            {
                int flightId = int.Parse(Request.QueryString["flightId"]);
                ShowFlightDetails(flightId);
            }
            else if (!IsPostBack)
            {
                lblFlightDetails.Text = "No flight selected.";
                btnBook.Enabled = false;
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
                }
            }
        }

        protected void btnBook_Click(object sender, EventArgs e)
        {
            try
            {
                // Grab inputs
                int flightId = int.Parse(Request.QueryString["flightId"]);
                int userId = Convert.ToInt32(Session["UserID"]);
                int adults = int.Parse(txtAdults.Text);
                int children = int.Parse(txtChildren.Text);
                string paymentMethod = ddlPaymentMethod.SelectedValue;
                decimal amount = decimal.Parse(txtAmount.Text);
                DateTime bookingDate = DateTime.Now;

                if (adults < 1 || adults > 4 || children < 0 || children > 4)
                {
                    lblStatus.Text = "Please enter valid number of passengers.";
                    return;
                }

                if (string.IsNullOrWhiteSpace(paymentMethod))
                {
                    lblStatus.Text = "Please select a payment method.";
                    return;
                }

                string cs = ConfigurationManager.ConnectionStrings["mydbcon"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(cs))
                {
                    conn.Open();

                    // Insert into Bookings table
                    string insertBooking = @"INSERT INTO Bookings (FlightID, CustomerID, Adults, Children, BookingDate)
                                             OUTPUT INSERTED.BookingID
                                             VALUES (@FlightID, @CustomerID, @Adults, @Children, @BookingDate)";
                    SqlCommand bookingCmd = new SqlCommand(insertBooking, conn);
                    bookingCmd.Parameters.AddWithValue("@FlightID", flightId);
                    bookingCmd.Parameters.AddWithValue("@CustomerID", userId);
                    bookingCmd.Parameters.AddWithValue("@Adults", adults);
                    bookingCmd.Parameters.AddWithValue("@Children", children);
                    bookingCmd.Parameters.AddWithValue("@BookingDate", bookingDate);

                    int bookingId = (int)bookingCmd.ExecuteScalar();

                    // Insert payment details
                    string insertPayment = @"INSERT INTO Payments (BookingID, PaymentMethod, PaymentDate, Amount)
                                             VALUES (@BookingID, @PaymentMethod, @PaymentDate, @Amount)";
                    SqlCommand paymentCmd = new SqlCommand(insertPayment, conn);
                    paymentCmd.Parameters.AddWithValue("@BookingID", bookingId);
                    paymentCmd.Parameters.AddWithValue("@PaymentMethod", paymentMethod);
                    paymentCmd.Parameters.AddWithValue("@PaymentDate", bookingDate);
                    paymentCmd.Parameters.AddWithValue("@Amount", amount);

                    paymentCmd.ExecuteNonQuery();
                }

                lblStatus.Text = "Booking and payment successful!";
            }
            catch (Exception ex)
            {
                lblStatus.Text = "Error: " + ex.Message;
            }
        }
    }
}
