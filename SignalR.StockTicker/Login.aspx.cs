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

public partial class Login : System.Web.UI.Page {

     
    protected void Page_Load(object sender, EventArgs e) {
        if (User.Identity.IsAuthenticated) {

            string url = string.Format("~/UserProfile?username={0}", User.Identity.Name);
            Response.Redirect(url);
        } else {
            HyperLink mpLink = (HyperLink)Master.FindControl("adminHyperlink");
            if (mpLink != null) {
                mpLink.Visible = false;
            }

            LinkButton mpBut = (LinkButton)Master.FindControl("logoutLink");
            if (mpBut != null) {
                mpBut.Visible = false;
            }

            mpBut = (LinkButton)Master.FindControl("settingsbut");
            if (mpBut != null) {
                mpBut.Visible = false;
            }

            mpBut = (LinkButton)Master.FindControl("searchButton");
            if (mpBut != null) {
                mpBut.Visible = false;
            }


        }

    }
    protected void Button1_Click(object sender, EventArgs e) {
        if (!Page.IsValid) {
            Label1.Text = "Form Error";
            return;
        }
        DataView dv = (DataView)userDataSource2.Select(DataSourceSelectArguments.Empty);
        DataRow row = dv.Table.Rows[0];
        int count = (int)row["number"];

        if (count > 0) {
            dv = (DataView)userDataSource.Select(DataSourceSelectArguments.Empty);
            row = dv.Table.Rows[0];
            string pass = (string)row["Password"];

            if (pass == pw.Text) { // authentication success
                //Session["New"] = userName.Text;
                Label1.Text = "Login Success";
                FormsAuthentication.RedirectFromLoginPage(userName.Text, false);
                //Response.Redirect("UserProfile.aspx");

            } else {
                Label1.Text = "Error: Login Failed";
            }
        } else {
            Label1.Text = "Error: User doesn't exist";
        }


    }
    protected void registerbut_Click(object sender, EventArgs e) {
        Response.Redirect("Register.aspx");
    }
}