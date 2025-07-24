using System;
using System.Data.SqlClient;

namespace yusafir
{
    public partial class Login : System.Web.UI.Page
    {
        protected bool IsAdminMode
        {
            get { return (ViewState["IsAdminMode"] as bool?) ?? false; }
            set { ViewState["IsAdminMode"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                IsAdminMode = false; // Default is user login on first load
            }
            Page.DataBind(); // Always bind mode-dependent controls
        }

        // Handles login as Admin or as User
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();
            string role = IsAdminMode ? "Admin" : "User";

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Please enter both username and password.";
                return;
            }

            string conStr = "Data Source=MUZZAMMIL;Initial Catalog=yusafir;Integrated Security=True";
            string query = "SELECT UserId, Name FROM users WHERE email = @Email AND password = @Password AND Role = @Role";

            try
            {
                using (SqlConnection con = new SqlConnection(conStr))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", password);
                    cmd.Parameters.AddWithValue("@Role", role);

                    con.Open();
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            Session["UserId"] = dr["UserId"];
                            Session["UserName"] = dr["Name"];
                            Session["Role"] = role;
                            // Redirect based on login mode
                            if (IsAdminMode)
                                Response.Redirect("AdminDashboard.aspx");
                            else
                                Response.Redirect("Home.aspx");
                        }
                        else
                        {
                            lblMessage.Text = "Invalid credentials.";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Server error: " + ex.Message;
            }
        }

        // Toggle Admin/User mode and update UI
        protected void btnSwitchMode_Click(object sender, EventArgs e)
        {
            IsAdminMode = !IsAdminMode;
            Page.DataBind(); // Refresh texts
            lblMessage.Text = "";
            txtPassword.Text = "";
        }
    }
}
