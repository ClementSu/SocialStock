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

public partial class UserProfile_View : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Gets a reference to a Label control that not in 
        // a ContentPlaceHolder

        if (User.Identity.IsAuthenticated) {

            hiddenUsername.Value = User.Identity.Name;
            DataView dv = (DataView)SqlDataSource2.Select(DataSourceSelectArguments.Empty);
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
       string url = string.Format("~/UserProfile?username={0}", userDropdown.SelectedValue);
       Response.Redirect(url);
    }
}