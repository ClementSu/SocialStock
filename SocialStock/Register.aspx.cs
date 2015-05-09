using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Text.RegularExpressions;

public partial class Register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack) {

        }

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
    protected void Button1_Click(object sender, EventArgs e) {
        //Check that the user is not in the database/*
        if (!Page.IsValid) {
            Label1.Text = "Form Error";
            return;
        } 

        DataView dv = (DataView)RegistrationSource.Select(DataSourceSelectArguments.Empty);
        DataRow row = dv.Table.Rows[0];
        int count = (int)row["number"];
        if (count > 0) {
            Label1.Text = "Error: User already exists";
        } else {

            RegistrationSource.Insert();
            TransactionSource.Insert();

            Label1.Text = "Registration successful";

        }
    }
}