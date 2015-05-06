using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected void logoutLinnk_Click(object sender, EventArgs e) {
        FormsAuthentication.SignOut();
        Response.Redirect("~/Login.aspx");
    }
    protected void searchButton_Click(object sender, EventArgs e) {
        Response.Redirect("~/UserProfile/View.aspx");
    }
    protected void settingsbut_Click(object sender, EventArgs e) {
        Response.Redirect("~/UserProfile/Settings.aspx");
    }
}
