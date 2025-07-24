using System;
using System.Data.SqlClient;
using System.Web;

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
                // Check if user is not logged in, but cookie exists => auto-login
                if (Session["UserId"] == null && Request.Cookies["YusafirAuth"] != null)
                {
                    var cookie = Request.Cookies["YusafirAuth"];
                    Session["UserId"] = cookie.Values["UserId"];
                    Session["UserName"] = cookie.Values["UserName"];
                    Session["Role"] = cookie.Values["Role"];

                    // Redirect immediately based on role
                    Response.Redirect(Session["Role"].ToString() == "Admin" ? "AdminDashboard.aspx" : "Home.aspx");
                }

                IsAdminMode = false; // Default is user login on first load
                Page.DataBind(); // Bind UI based on mode
            }
        }

        // Handles login as Admin or as User
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";  // Clear previous messages

            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();
            string role = IsAdminMode ? "Admin" : "Customer";

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Please enter both username and password.";
                return;
            }

            string conStr = "Data Source=MUZZAMMIL;Initial Catalog=yusafir;Integrated Security=True";
            string query = "SELECT UserId, Name FROM users WHERE Email = @Email AND password = @Password AND Role = @Role";

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
                            // Set session variables
                            Session["UserId"] = dr["UserId"];
                            Session["UserName"] = dr["Name"];
                            Session["Role"] = role;

                            // Handle "Remember Me" checkbox - set persistent cookie if checked
                            if (chkRemember.Checked)
                            {
                                HttpCookie authCookie = new HttpCookie("YusafirAuth");
                                authCookie.Values["UserId"] = dr["UserId"].ToString();
                                authCookie.Values["UserName"] = dr["Name"].ToString();
                                authCookie.Values["Role"] = role;
                                authCookie.Expires = DateTime.Now.AddHours(12); // Cookie valid for 12 hours
                                Response.Cookies.Add(authCookie);
                            }
                            else
                            {
                                // Remove cookie if exists and checkbox not checked
                                if (Request.Cookies["YusafirAuth"] != null)
                                {
                                    var expiredCookie = new HttpCookie("YusafirAuth");
                                    expiredCookie.Expires = DateTime.Now.AddDays(-1);
                                    Response.Cookies.Add(expiredCookie);
                                }
                            }

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
            Page.DataBind(); // Refresh UI texts accordingly
            lblMessage.Text = "";
            txtPassword.Text = "";
        }
    }
}
