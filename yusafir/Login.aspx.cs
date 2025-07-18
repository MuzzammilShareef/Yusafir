using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace yusafir
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string conStr = "Data Source=MUZZAMMIL;Initial Catalog = yusafir; Integrated Security=True";
            SqlConnection con = new SqlConnection(conStr);

            string query = "Select * from users where email=@email and password = @password";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("Email",txtEmail.Text);
            cmd.Parameters.AddWithValue("Password", txtPassword.Text);

            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    Session["UserId"] = dr["UserId"];
                    Session["Role"] = dr["Role"];
                    Session["UserName"] = dr["Name"];
                    Response.Redirect("Home.aspx");
                }
                else
                {
                    lblMessage.Text = "Invalid email or password.";
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
            }
            finally
            {
                con.Close();
            }

        }
    }
}