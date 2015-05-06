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

public partial class UserProfile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e) {

        // Gets a reference to a Label control that not in 
        // a ContentPlaceHolder


        if (User.Identity.IsAuthenticated) {

            
            hiddenView.Value = Request.QueryString["username"];
            hiddenUsername.Value = User.Identity.Name;
            DataView dv = (DataView)SqlDataSource2.Select(DataSourceSelectArguments.Empty);
            
            
            DataRow row = dv.Table.Rows[0];
            string title = (string)row["FirstName"] + "'s" + " " + "Page";
            Label1.Text = title;

            int isDefaultImage = (int)row["DefaultImage"];
            
            if (isDefaultImage == 1) {
                if (File.Exists(Server.MapPath("~/Pictures/default.jpg"))) {
                    profImage.ImageUrl = "~/Pictures/default.jpg";
                    
                }
            } else {

                try {
                    string profpicPath = (string)row["ImageUrl"];
                    if (File.Exists(Server.MapPath(profpicPath))) {
                        profImage.ImageUrl = profpicPath;
                    } else {
                        profImage.ImageUrl = "~/Pictures/default.jpg";
                    }
                } catch {
                    profImage.ImageUrl = "~/Pictures/default.jpg";
                }
                
            }
            //Label1.Text = Request.QueryString["username"];

            dv = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
            row = dv.Table.Rows[0];
            int isAdmin = (int)row["Administrator"];
            if ( isAdmin == 1) {
                
                
                
                HyperLink mpLink = (HyperLink)Master.FindControl("adminHyperlink");
                if (mpLink != null) {
                    mpLink.Visible = true;
                }

                LinkButton mpBut = (LinkButton)Master.FindControl("logoutLink");
                if (mpBut != null) {
                    mpBut.Visible = true;
                }

            }

            string firstName = (string)row["FirstName"];
            HyperLink mpHomelink = (HyperLink)Master.FindControl("homeHyperlink");
            if (mpHomelink != null) {
                mpHomelink.Text = firstName;
            }

            
            if (Request.QueryString["username"] == hiddenUsername.Value) {
                FileUpload1.Visible = true;
                uploadBut.Visible = true;
                
            }

        } else {

            Response.Redirect("~/Login.aspx");
        }

    }
    protected void logoutbut_Click(object sender, EventArgs e) {
       // User.Identity.
        FormsAuthentication.SignOut();
        Response.Redirect("~/Login.aspx");
    }
    protected void searchButton_Click(object sender, EventArgs e) {
        string url = string.Format("View.aspx?username={0}", User.Identity.Name);
        Response.Redirect(url);
    }

    protected void Upload(object sender, EventArgs e) {
        if (Page.IsValid) {
            if (FileUpload1.HasFile) {
                string fileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
                string extension = System.IO.Path.GetExtension(fileName);
                string imagePath = "~/Pictures/" + User.Identity.Name + extension;
                FileUpload1.PostedFile.SaveAs(Server.MapPath(imagePath));
                //string url = string.Format("~/UserProfile?username={0}", User.Identity.Name);
                imgUrlHidden.Value = imagePath;
                SqlDataSource2.Update();
                Response.Redirect(Request.RawUrl);
            }
        }
    }
    protected void DataList1_EditCommand(object source, DataListCommandEventArgs e) {
        DataList1.EditItemIndex = e.Item.ItemIndex;
        DataList1.DataBind();
    }
    protected void DataList1_CancelCommand(object source, DataListCommandEventArgs e) {
        DataList1.EditItemIndex = -1;
        DataList1.DataBind();
    }
    protected void DataList1_UpdateCommand(object source, DataListCommandEventArgs e) {
        String firstname =
         ((TextBox)e.Item.FindControl("firstnamebox")).Text;
        String lastname =
             ((TextBox)e.Item.FindControl("lastnamebox")).Text;
        String age =
         ((TextBox)e.Item.FindControl("agebox")).Text;
        String address =
             ((TextBox)e.Item.FindControl("addressbox")).Text;
        String phone =
             ((TextBox)e.Item.FindControl("phonebox")).Text;
        String gender =
         ((TextBox)e.Item.FindControl("genderbox")).Text;
        String email =
             ((TextBox)e.Item.FindControl("emailbox")).Text;
        String bio =
             ((TextBox)e.Item.FindControl("biobox")).Text;


        SqlDataSource3.UpdateParameters["FirstName"].DefaultValue
        = firstname;
        SqlDataSource3.UpdateParameters["LastName"].DefaultValue
            = lastname;
        SqlDataSource3.UpdateParameters["Age"].DefaultValue
            = age;
        SqlDataSource3.UpdateParameters["Address"].DefaultValue
        = address;
        SqlDataSource3.UpdateParameters["Telephone"].DefaultValue
            = phone;
        SqlDataSource3.UpdateParameters["Gender"].DefaultValue
            = gender;
        SqlDataSource3.UpdateParameters["Email"].DefaultValue
        = email;
        SqlDataSource3.UpdateParameters["LastName"].DefaultValue
            = lastname;
        SqlDataSource3.UpdateParameters["Bio"].DefaultValue
            = bio;


        SqlDataSource3.Update();

        DataList1.EditItemIndex = -1;
        DataList1.DataBind();
    }

    protected bool FunctionToCheckPermissionsWhichReturnsTrueOrFalse() {
        if (Request.QueryString["username"] == hiddenUsername.Value) {
            return true;
        } else {
            return false;
        }
    }

    protected void DataList2_CancelCommand(object source, DataListCommandEventArgs e) {
        DataList2.EditItemIndex = -1;
        DataList2.DataBind();
    }

    protected void DataList2_UpdateCommand(object source, DataListCommandEventArgs e) {
        String memo =
         ((TextBox)e.Item.FindControl("memobox")).Text;
        SqlDataSource4.UpdateParameters["Memo"].DefaultValue
        = memo;
        SqlDataSource4.Update();

        DataList2.EditItemIndex = -1;
        DataList2.DataBind();
    }
    protected void DataList2_EditCommand(object source, DataListCommandEventArgs e) {
        DataList2.EditItemIndex = e.Item.ItemIndex;
        DataList2.DataBind();
    }

}



