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
using System.Xml;
using System.Xml.Xsl;
using System.Xml.XPath;
using System.Net;
using System.Text;

public partial class UserProfile : System.Web.UI.Page
{

    // Stock symbols seperated by space or comma.
    protected string m_symbol = "";
    protected void Page_Load(object sender, EventArgs e) {

        if (!IsPostBack) {
            // The page is being loaded and accessed for the first time.
            // Retrieve user input from the form.
            if (Request.QueryString["s"] == null)
                // Set the default stock symbol to YHOO.
                m_symbol = "YHOO";
            else
                // Get the user's input.
                m_symbol = Request.QueryString["s"].ToString().ToUpper();
            // Update the textbox value.
            txtSymbol.Value = m_symbol;
            // This DIV that contains text and DIVs that displays stock quotes and chart from Yahoo.
            // Set the innerHTML property to replaces the existing content of the DIV.
            divService.InnerHtml = "<br />";
            if (m_symbol.Trim() != "") {
                try {
                    // Return the stock quote data in XML format.
                    String arg = GetQuote(m_symbol.Trim());
                    if (arg == null)
                        return;

                    // Read XML.
                    // Declare an XmlDocument object to represents an XML document.
                    XmlDocument xd = new XmlDocument();
                    // Loads the XML data from a stream.
                    xd.LoadXml(arg);

                    // Read XSLT
                    // Declare an XslCompiledTransform object to transform XML data using an XSLT style sheet.
                    XslCompiledTransform xslt = new XslCompiledTransform();
                    // Use the Load method to load the Xsl transform object.
                    xslt.Load(Server.MapPath("stock.xsl"));

                    // Transform the XML document into HTML.
                    StringWriter fs = new StringWriter();
                    xslt.Transform(xd.CreateNavigator(), null, fs);
                    string result = fs.ToString();

                    // Replace the characters "&gt;" and "&lt;" back to "<" and ">".
                    divService.InnerHtml = "<br />" + result.Replace("&lt;", "<").Replace("&gt;", ">") + "<br />";

                    // Display stock charts.
                    String[] symbols = m_symbol.Replace(",", " ").Split(' ');
                    // Loop through each stock
                    for (int i = 0; i < symbols.Length; ++i) {
                        if (symbols[i].Trim() == "")
                            continue;
                        int index = divService.InnerHtml.ToLower().IndexOf(symbols[i].Trim().ToLower() + " is invalid.");
                        // If index = -1, the stock symbol is valid.
                        if (index == -1) {
                            // Use a random number to defeat cache.
                            Random random = new Random();
                            divService.InnerHtml += "<img id='imgChart_" + i.ToString() + "' src='http://ichart.finance.yahoo.com/b?s=" + symbols[i].Trim().ToUpper() + "& " + random.Next() + "' border=0><br />";
                            // 1 days
                            divService.InnerHtml += "<a style='font-family: Arial, Helvetica, sans-serif; font-size: 14px; color: Blue;' href='javascript:changeChart(0," + i.ToString() + ", \"" + symbols[i].ToLower() + "\");'><span id='div1d_" + i.ToString() + "'><b>1d</b></span></a>&nbsp;&nbsp;";
                            // 5 days
                            divService.InnerHtml += "<a style='font-family: Arial, Helvetica, sans-serif; font-size: 14px; color: Blue;' href='javascript:changeChart(1," + i.ToString() + ", \"" + symbols[i].ToLower() + "\");'><span id='div5d_" + i.ToString() + "'>5d</span></a>&nbsp;&nbsp;";
                            // 3 months
                            divService.InnerHtml += "<a style='font-family: Arial, Helvetica, sans-serif; font-size: 14px; color: Blue;' href='javascript:changeChart(2," + i.ToString() + ", \"" + symbols[i].ToLower() + "\");'><span id='div3m_" + i.ToString() + "'>3m</span></a>&nbsp;&nbsp;";
                            // 6 months
                            divService.InnerHtml += "<a style='font-family: Arial, Helvetica, sans-serif; font-size: 14px; color: Blue;' href='javascript:changeChart(3," + i.ToString() + ", \"" + symbols[i].ToLower() + "\");'><span id='div6m_" + i.ToString() + "'>6m</span></a>&nbsp;&nbsp;";
                            // 1 yeas
                            divService.InnerHtml += "<a style='font-family: Arial, Helvetica, sans-serif; font-size: 14px; color: Blue;' href='javascript:changeChart(4," + i.ToString() + ", \"" + symbols[i].ToLower() + "\");'><span id='div1y_" + i.ToString() + "'>1y</span></a>&nbsp;&nbsp;";
                            // 2 years
                            divService.InnerHtml += "<a style='font-family: Arial, Helvetica, sans-serif; font-size: 14px; color: Blue;' href='javascript:changeChart(5," + i.ToString() + ", \"" + symbols[i].ToLower() + "\");'><span id='div2y_" + i.ToString() + "'>2y</span></a>&nbsp;&nbsp;";
                            // 5 years
                            divService.InnerHtml += "<a style='font-family: Arial, Helvetica, sans-serif; font-size: 14px; color: Blue;' href='javascript:changeChart(6," + i.ToString() + ", \"" + symbols[i].ToLower() + "\");'><span id='div5y_" + i.ToString() + "'>5y</span></a>&nbsp;&nbsp;";
                            // Max
                            divService.InnerHtml += "<a style='font-family: Arial, Helvetica, sans-serif; font-size: 14px; color: Blue;' href='javascript:changeChart(7," + i.ToString() + ", \"" + symbols[i].ToLower() + "\");'><span id='divMax_" + i.ToString() + "'>Max</span></a><br><br /><br />&nbsp;&nbsp;";
                        }
                    }
                } catch {
                    // Handle exceptions
                }
            }
        }

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
                portfolioPanel.Visible = true;
                
            }

        } else {

            Response.Redirect("~/Login.aspx");
        }

    }

    /// <summary>
    /// This function handles and parses multiple stock symbols as input parameters 
    /// and builds a valid XML return document.
    /// </summary>
    /// <param name="symbol">A bunch of stock symbols seperated by space or comma</param>
    /// <returns>Return stock quote data in XML format</returns>
    public string GetQuote(string symbol) {
        // Set the return string to null.
        string result = null;
        try {
            // Use Yahoo finance service to download stock data from Yahoo
            string yahooURL = @"http://download.finance.yahoo.com/d/quotes.csv?s=" + symbol + "&f=sl1d1t1c1hgvbap2";
            string[] symbols = symbol.Replace(",", " ").Split(' ');

            // Initialize a new WebRequest.
            HttpWebRequest webreq = (HttpWebRequest)WebRequest.Create(yahooURL);
            // Get the response from the Internet resource.
            HttpWebResponse webresp = (HttpWebResponse)webreq.GetResponse();
            // Read the body of the response from the server.
            StreamReader strm = new StreamReader(webresp.GetResponseStream(), Encoding.ASCII);

            // Construct a XML in string format.
            string tmp = "<StockQuotes>";
            string content = "";
            for (int i = 0; i < symbols.Length; i++) {
                // Loop through each line from the stream, building the return XML Document string
                if (symbols[i].Trim() == "")
                    continue;

                content = strm.ReadLine().Replace("\"", "");
                string[] contents = content.ToString().Split(',');
                // If contents[2] = "N/A". the stock symbol is invalid.
                if (contents[2] == "N/A") {
                    // Construct XML via strings.
                    tmp += "<Stock>";
                    // "<" and ">" are illegal in XML elements. Replace the characters "<" and ">" to "&gt;" and "&lt;".
                    tmp += "<Symbol>&lt;span style='color:red'&gt;" + symbols[i].ToUpper() + " is invalid.&lt;/span&gt;</Symbol>";
                    tmp += "<Last></Last>";
                    tmp += "<Date></Date>";
                    tmp += "<Time></Time>";
                    tmp += "<Change></Change>";
                    tmp += "<High></High>";
                    tmp += "<Low></Low>";
                    tmp += "<Volume></Volume>";
                    tmp += "<Bid></Bid>";
                    tmp += "<Ask></Ask>";
                    tmp += "<Ask></Ask>";
                    tmp += "</Stock>";
                } else {
                    //construct XML via strings.
                    tmp += "<Stock>";
                    tmp += "<Symbol>" + contents[0] + "</Symbol>";
                    try {
                        tmp += "<Last>" + String.Format("{0:c}", Convert.ToDouble(contents[1])) + "</Last>";
                    } catch {
                        tmp += "<Last>" + contents[1] + "</Last>";
                    }
                    tmp += "<Date>" + contents[2] + "</Date>";
                    tmp += "<Time>" + contents[3] + "</Time>";
                    // "<" and ">" are illegal in XML elements. Replace the characters "<" and ">" to "&gt;" and "&lt;".
                    if (contents[4].Trim().Substring(0, 1) == "-")
                        tmp += "<Change>&lt;span style='color:red'&gt;" + contents[4] + "(" + contents[10] + ")" + "&lt;span&gt;</Change>";
                    else if (contents[4].Trim().Substring(0, 1) == "+")
                        tmp += "<Change>&lt;span style='color:green'&gt;" + contents[4] + "(" + contents[10] + ")" + "&lt;span&gt;</Change>";
                    else
                        tmp += "<Change>" + contents[4] + "(" + contents[10] + ")" + "</Change>";
                    tmp += "<High>" + contents[5] + "</High>";
                    tmp += "<Low>" + contents[6] + "</Low>";
                    try {
                        tmp += "<Volume>" + String.Format("{0:0,0}", Convert.ToInt64(contents[7])) + "</Volume>";
                    } catch {
                        tmp += "<Volume>" + contents[7] + "</Volume>";
                    }
                    tmp += "<Bid>" + contents[8] + "</Bid>";
                    tmp += "<Ask>" + contents[9] + "</Ask>";
                    tmp += "</Stock>";
                }
                // Set the return string
                result += tmp;
                tmp = "";
            }
            // Set the return string
            result += "</StockQuotes>";
            // Close the StreamReader object.
            strm.Close();
        } catch {
            // Handle exceptions.
        }
        // Return the stock quote data in XML format.
        return result;
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

 

    protected void SendRequest(object sender, EventArgs e) {
        //string text;
        // Refresh the page.
        string url = "~/UserProfile/?username=" + User.Identity.Name + "&s=" + txtSymbol.Value;
        Response.Redirect(url);
    }

    protected void confirmTransaction_Click(object sender, EventArgs e) {
        if (portfolioSelection.SelectedIndex == -1) {
            amountlabel.Text = "No portfolio selected.";
            return;
        }

        if (tradeTicker.Text == "") {
            amountlabel.Text = "No ticker entered.";
            return;
        }

        if ((quantityField.Text == "")) {
            amountlabel.Text = "Quantity not specified.";
            return;

        }

        int quantity;
        if(!(int.TryParse(quantityField.Text, out quantity))){
            amountlabel.Text = "You must enter an integer for the quantity.";
            return;
        }

        hiddenEpoch.Value = DateTime.Now.ToString("yyyyMMddHHmmss");
        hiddenPrice.Value = get_price(tradeTicker.Text).ToString();

        DataView dv = (DataView)PortfolioHasStock.Select(DataSourceSelectArguments.Empty);
        if (buyOrSell.SelectedValue  == "Sell") {
            
            
            if (dv.Table.Rows.Count == 0) {
                amountlabel.Text = "Portfolio does not own this stock.";
                return;
            }
            DataRow row = dv.Table.Rows[0];
            int dbquantity = (int)row["Quantity"];
            if (quantity > dbquantity) {
                amountlabel.Text = "Entered quantity exceeds portfolio stock.";
                return;
            }
            //execute sell code
            amountlabel.Text = "Successfully sold " + quantityField.Text + " shares of "
                + tradeTicker.Text + " at " + hiddenPrice.Value + "$ per share.";
           
            //transactions
            transactionDataSource.Insert();

            //balance sheet
            quantityField.Text = "-" + quantityField.Text;
            balanceSheetDataSource.Update();
            return;
        }
        //execute buy code
       
        //store buy to transactions
        try {
            transactionDataSource.Insert();
            amountlabel.Text = "Successfully purchased " + quantityField.Text +" shares of "
                + tradeTicker.Text +" at " + hiddenPrice.Value +"$ per share.";
        } catch {
            amountlabel.Text = "Failed to save trade to transactions.";
        }

        //store buy to balancesheet

        if (dv.Table.Rows.Count == 0) {
            //insert new row
            balanceSheetDataSource.Insert();

        } else {
            //else add to existing quantity
            balanceSheetDataSource.Update();
        }

            //amountlabel.Text = "Failed to save trade to balancesheet.";
        
        return;
    }



    protected float get_price(string ticker) {
        float price = -2;
        string symbol = ticker;
        string content = "";
        
        try {
            // Use Yahoo finance service to download stock data from Yahoo
            string yahooURL = @"http://download.finance.yahoo.com/d/quotes.csv?s=" + symbol + "&f=l1";
            string[] symbols = symbol.Replace(",", " ").Split(' ');

            // Initialize a new WebRequest.

            HttpWebRequest webreq = (HttpWebRequest)WebRequest.Create(yahooURL);
            // Get the response from the Internet resource.
            HttpWebResponse webresp = (HttpWebResponse)webreq.GetResponse();
            // Read the body of the response from the server.
            StreamReader strm = new StreamReader(webresp.GetResponseStream(), Encoding.ASCII);

            // Construct a XML in string format.
           
           
                while (!(strm.EndOfStream)) {
                    content += strm.ReadLine();

                }
               

            
                if (content == "N/A") {
                    return -1;
            }
                float.TryParse(content, out price);
            
            // Close the StreamReader object.
            strm.Close();
        } catch {
            // Handle exceptions.
        }
        // Return the stock quote data in XML format.

        return price;
        
    }

    protected void addPortfolio_Click(object sender, EventArgs e) {
        
        if (newPortfolioField.Text == "") {
            return;
        }

        DataView dv = (DataView)SqlDataSource5.Select(DataSourceSelectArguments.Empty);
        DataRow row = dv.Table.Rows[0];
        int count = (int)row["number"];

        if (count > 0) {
            addLabel.Text = "Portfolio already exists.";
            return;
        }

        SqlDataSource5.Insert();
        deletePortfolioDrop.DataBind();
        portfolioSelection.DataBind();
        addLabel.Text = "Portfolio added successfully.";
    }

    protected void deletePortfolio_Click(object sender, EventArgs e) {
        
        try {
            SqlDataSource6.Delete();
            balanceSheetDataSource.Delete();
            transactionDataSource.Delete();
            deletePortfolioDrop.DataBind();
            portfolioSelection.DataBind();
            addLabel.Text = "Portfolio deleted successfully.";
            return;
        } catch {
            addLabel.Text = "Portfolio does not exist.";
        }
    }

    

    protected void viewPortfolioButton_Click(object sender, EventArgs e) {
        try
        {
            balanceSheetGrid.DataBind();
            transactionGrid.DataBind();
            //total current value of portfolio
            DataView dv = (DataView)userBalanceSheetSource.Select(DataSourceSelectArguments.Empty);
            float TotalValue = 0;

            foreach (DataRowView rowView in dv)
            {
                DataRow row = rowView.Row;
                TotalValue += get_price((string)row["Ticker"]) * (int)row["Quantity"];
            }
            NetValue.Text = TotalValue.ToString();
            //total gains since inception
            //Totalvalue - buys + sells
            dv = (DataView)userTransactionSource.Select(DataSourceSelectArguments.Empty);
            double TotalGain = TotalValue;
            foreach (DataRowView rowView in dv)
            {
                DataRow row = rowView.Row;
                if ((string)row["BuySell"] == "Sell")
                {
                    TotalGain += (double)row["Price"] * (int)row["Quantity"];
                }
                if ((string)row["BuySell"] == "Buy")
                {
                    TotalGain -= (double)row["Price"] * (int)row["Quantity"];
                }
            }
            int intGrowth = Convert.ToInt32(TotalGain);
            Growth.Text = intGrowth.ToString();
        }
        catch
        {

        }
    }


    
}



