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
                LoadPassengers();
            }
        }

        private void LoadCustomers()
        {
            string cs = ConfigurationManager.ConnectionStrings["mydbcon"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT UserId FROM Users", con);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                ddlCustomerId.DataSource = rdr;
                ddlCustomerId.DataValueField = "UserId";
                ddlCustomerId.DataTextField = "UserId";
                ddlCustomerId.DataBind();
            }
            ddlCustomerId.Items.Insert(0, new ListItem("--Select--", ""));
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

        private void LoadPassengers()
        {
            for (int i = 0; i <= 10; i++)
            {
                ddlAdults.Items.Add(new ListItem(i.ToString(), i.ToString()));
                ddlChildren.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }
            ddlAdults.SelectedValue = "1";
            ddlChildren.SelectedValue = "0";
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            gvFlights.Visible = false;

            bool isValid = true;
            DateTime currentDate = DateTime.Today;
            DateTime departureDate;

            if (ddlCustomerId.SelectedIndex == 0)
            {
                lblMessage.Text += "‘CustomerID’ should be selected from drop down.<br/>";
                isValid = false;
            }

            if (ddlSource.SelectedIndex == 0 || ddlDestination.SelectedIndex == 0)
            {
                lblMessage.Text += "‘Source and Destination’ should be selected from drop down.<br/>";
                isValid = false;
            }
            else if (ddlSource.SelectedValue == ddlDestination.SelectedValue)
            {
                lblMessage.Text += "‘Source and Destination’ cannot be the same.<br/>";
                isValid = false;
            }

            if (DateTime.TryParse(txtDate.Text, out departureDate))
            {
                if (departureDate < currentDate)
                {
                    lblMessage.Text += "‘Departure Date’ cannot be less than current date.<br/>";
                    isValid = false;
                }
            }
            else
            {
                lblMessage.Text += "Please select a valid ‘Departure Date’.<br/>";
                isValid = false;
            }

            int adults = int.Parse(ddlAdults.SelectedValue);
            if (adults < 1 || adults > 4)
            {
                lblMessage.Text += "Number of ‘Adults’ selected must be in between 1-4.<br/>";
                isValid = false;
            }

            int children = int.Parse(ddlChildren.SelectedValue);
            if (children < 0 || children > 4)
            {
                lblMessage.Text += "Number of ‘Children’ selected must be in between 0-4.<br/>";
                isValid = false;
            }

            if (isValid)
            {
                lblMessage.Text = "All validations passed. Searching for flights...";
                lblMessage.ForeColor = System.Drawing.Color.Green;

                string conStr = ConfigurationManager.ConnectionStrings["mydbcon"].ConnectionString;

                using (SqlConnection con = new SqlConnection(conStr))
                {
                    string query = @"SELECT * FROM Flights 
                                     WHERE Source = @Source AND Destination = @Destination AND DepartureDate = @DepartureDate";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Source", ddlSource.SelectedValue);
                    cmd.Parameters.AddWithValue("@Destination", ddlDestination.SelectedValue);
                    cmd.Parameters.AddWithValue("@DepartureDate", txtDate.Text);

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
                }
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
