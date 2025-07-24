using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace yusafir
{
    public partial class Search : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCustomers();
                LoadLocations();
                LoadTimeDropdowns();
            }
        }

        private void LoadCustomers()
        {

        }

        private void LoadLocations()
        {
            string cs = ConfigurationManager.ConnectionStrings["mydbcon"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT DISTINCT Source FROM Flights", con);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                ddlSource.DataSource = rdr;
                ddlSource.DataTextField = "Source";
                ddlSource.DataValueField = "Source";
                ddlSource.DataBind();
            }
            ddlSource.Items.Insert(0, new ListItem("--Select--", ""));

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT DISTINCT Destination FROM Flights", con);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                ddlDestination.DataSource = rdr;
                ddlDestination.DataTextField = "Destination";
                ddlDestination.DataValueField = "Destination";
                ddlDestination.DataBind();
            }
            ddlDestination.Items.Insert(0, new ListItem("--Select--", ""));
        }

        private void LoadTimeDropdowns()
        {
            for (int i = 0; i <= 23; i++)
            {
                string hour = i.ToString("D2");
                ddlTimeFrom.Items.Add(new ListItem(hour, hour));
                ddlTimeTo.Items.Add(new ListItem(hour, hour));
            }
            ddlTimeFrom.SelectedValue = "06";
            ddlTimeTo.SelectedValue = "11";
        }



        protected void btnSearch_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            gvFlights.Visible = false;

            bool isValid = true;
            DateTime departureDate;
            DateTime currentDate = DateTime.Today;


            string customerId = txtCustomerId.Text?.Trim();
            if (string.IsNullOrEmpty(customerId) || !int.TryParse(customerId, out int custId))
            {
                lblMessage.Text += "Please enter a valid numeric Customer ID.<br/>";
                isValid = false;
            }
            else
            {
                // Optionally verify if this CustomerID exists in DB here
            }

            string source = ddlSource.SelectedValue?.Trim() ?? "";
            string destination = ddlDestination.SelectedValue?.Trim() ?? "";
            string dateText = txtDate.Text?.Trim() ?? "";

            if (string.IsNullOrEmpty(customerId) || !int.TryParse(customerId, out  custId))
            {
                lblMessage.Text += "Please enter a valid numeric Customer ID.<br/>";
                isValid = false;
            }

            if (string.IsNullOrEmpty(source) || string.IsNullOrEmpty(destination))
            {
                lblMessage.Text += "‘Source and Destination’ should be selected.<br/>";
                isValid = false;
            }
            else if (source == destination)
            {
                lblMessage.Text += "‘Source and Destination’ cannot be the same.<br/>";
                isValid = false;
            }

            if (!DateTime.TryParseExact(dateText, "yyyy-MM-dd", null,
                System.Globalization.DateTimeStyles.None, out departureDate))
            {
                lblMessage.Text += "Please select a valid ‘Departure Date’.<br/>";
                isValid = false;
            }
            else if (departureDate < currentDate)
            {
                lblMessage.Text += "‘Departure Date’ cannot be less than current date.<br/>";
                isValid = false;
            }



            if (!isValid)
                return;

            // Valid: proceed with query
            try
            {
                string conStr = ConfigurationManager.ConnectionStrings["mydbcon"].ConnectionString;

                using (SqlConnection con = new SqlConnection(conStr))
                {
                    string query = @"SELECT * FROM Flights 
                             WHERE Source = @Source 
                             AND Destination = @Destination 
                             AND DepartureDate = @DepartureDate";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Source", source);
                    cmd.Parameters.AddWithValue("@Destination", destination);
                    cmd.Parameters.AddWithValue("@DepartureDate", departureDate);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvFlights.DataSource = dt;
                    gvFlights.DataBind();
                    gvFlights.Visible = dt.Rows.Count > 0;

                    if (dt.Rows.Count == 0)
                    {
                        lblMessage.Text = "No flights found for the selected criteria.";
                        lblMessage.ForeColor = System.Drawing.Color.OrangeRed;
                    }
                    else
                    {
                        lblMessage.Text = $"Found {dt.Rows.Count} flight(s).";
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "An error occurred while searching for flights. Please try again later."+ex.Message;
                // Log exception details somewhere safe in production
            }
        }



        protected void gvFlights_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "BookFlight")
            {
                string flightId = e.CommandArgument.ToString();
                Response.Redirect("BookFlight.aspx?flightId=" + flightId);
            }
        }

        protected void gvFlights_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
