using System;
using System.Web.UI;

namespace Yusafir
{
    public partial class home : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // You can show user name here if logged in
            // lblWelcome.Text = "Welcome, " + Session["UserName"];
        }

        protected void btnFlights_Click(object sender, EventArgs e)
        {
            Response.Redirect("Flights.aspx");
        }

        protected void btnHotels_Click(object sender, EventArgs e)
        {
            Response.Redirect("Hotels.aspx");
        }

        protected void btnPackages_Click(object sender, EventArgs e)
        {
            Response.Redirect("Packages.aspx");
        }

        protected void btnVehicles_Click(object sender, EventArgs e)
        {
            Response.Redirect("Vehicles.aspx");
        }
    }
}
