using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text.RegularExpressions;
using System.Web.Security;
using System.IO;

public partial class UserProfile_Settings : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (User.Identity.IsAuthenticated) {

           hiddenUsername.Value = User.Identity.Name;
            DataView dv = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
            DataRow row = dv.Table.Rows[0];
            int isAdmin = (int)row["Administrator"];
            if (isAdmin == 1) {



                HyperLink mpLink = (HyperLink)Master.FindControl("adminHyperlink");
                if (mpLink != null) {
                    mpLink.Visible = true;
                }

            }

            string firstName = (string)row["FirstName"];
            HyperLink mpHomelink = (HyperLink)Master.FindControl("homeHyperlink");
            if (mpHomelink != null) {
                mpHomelink.Text = firstName;
            }


        } else {

            Response.Redirect("~/Login.aspx");
        }
    }
    protected void Button1_Click(object sender, EventArgs e) {
        if (!Page.IsValid) {
            Label1.Text = "Form Error";
            return;
        }
        DataView dv = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
        DataRow row = dv.Table.Rows[0];
        string pass = (string)row["Password"];
        if (pass == pw0.Text) { // authentication success
            //Session["New"] = userName.Text;
            Label1.Text = "Password Updated";
            SqlDataSource1.Update();

        } else {
            Label1.Text = "Current Password incorrect!";
        }
    }
    protected void Button2_Click(object sender, EventArgs e) {
        if (!Page.IsValid) {
            Label1.Text = "Form Error";
            return;
        }
        DataView dv = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
        DataRow row = dv.Table.Rows[0];
        string pass = (string)row["Password"];
        if (pass == pw1.Text) { // authentication success
            Label2.Text = "Goodbye";
            SqlDataSource2.Update();
            FormsAuthentication.SignOut();
            Response.Redirect("~/Login.aspx");

        } else {
            Label2.Text = "Current Password incorrect!";
        }
    }
}






