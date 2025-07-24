using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace yusafir
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBookingsPayments();
            }
        }

        private void LoadBookingsPayments()
        {
            string cs = ConfigurationManager.ConnectionStrings["mydbcon"].ConnectionString;
            string query = @"
                SELECT 
                    b.BookingID,
                    b.FlightID,
                    u.Name AS PassengerName,
                    p.Amount AS AmountPaid,
                    CASE WHEN p.Amount > 0 THEN 'Paid' ELSE 'Pending' END AS PaymentStatus,
                    b.DateOfBooking
                FROM Bookings b
                INNER JOIN Payments p ON b.BookingID = p.BookingID
                INNER JOIN Users u ON b.CustomerID = u.UserId
                ORDER BY b.DateOfBooking DESC";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();
                try
                {
                    con.Open();
                    da.Fill(dt);

                    gvAdminBookings.DataSource = dt;
                    gvAdminBookings.DataBind();
                }
                catch (Exception ex)
                {
                    // For production, log error properly. Here just rethrow or display.
                    // You could add a label to show an error message in UI.
                    throw new Exception("Error loading bookings/payments: " + ex.Message);
                }
            }
        }
    }
}
