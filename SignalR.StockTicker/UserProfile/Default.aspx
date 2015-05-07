<%@ Page Language="C#" AutoEventWireup="true" Inherits="UserProfile" MasterPageFile="~/MasterPage.master" Codebehind="Default.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script  type="text/javascript">
        /// <summary>
        /// This function will be called when user clicks the Get Quotes button.
        /// </summary>
        /// <returns>Always return false.</returns>


        /// <summary>
        /// The functyion will be called when a keyboard key is pressed in the textbox.
        /// </summary>
        /// <param name="e">Onkeypress event.</param>
        /// <returns>Return true if user presses Enter key; otherwise false.</returns>        
        function CheckEnter(e) {
            if ((e.keyCode && e.keyCode == 13) || (e.which && e.which == 13))
                // Enter is pressed in the textbox.
                return SendRequest();
            return true;
        }

        /// <summary>
        /// The function will be called when user changes the chart type to another type.
        /// </summary>
        /// <param name="type">Chart type.</param>
        /// <param name="num">Stock number.</param>
        /// <param name="symbol">Stock symobl.</param>
        function changeChart(type, num, symbol) {
            // All the DIVs are inside the main DIV and defined in the code-behind class.
            var div1d = document.getElementById("div1d_" + num);
            var div5d = document.getElementById("div5d_" + num);
            var div3m = document.getElementById("div3m_" + num);
            var div6m = document.getElementById("div6m_" + num);
            var div1y = document.getElementById("div1y_" + num);
            var div2y = document.getElementById("div2y_" + num);
            var div5y = document.getElementById("div5y_" + num);
            var divMax = document.getElementById("divMax_" + num);
            var divChart = document.getElementById("imgChart_" + num);
            // Set innerHTML property.
            div1d.innerHTML = "1d";
            div5d.innerHTML = "5d";
            div3m.innerHTML = "3m";
            div6m.innerHTML = "6m";
            div1y.innerHTML = "1y";
            div2y.innerHTML = "2y";
            div5y.innerHTML = "5y";
            divMax.innerHTML = "Max";
            // Use a random number to defeat cache.
            var rand_no = Math.random();
            rand_no = rand_no * 100000000;
            // Display the stock chart.
            switch (type) {
                case 1: // 5 days
                    div5d.innerHTML = "<b>5d</b>";
                    divChart.src = "http://ichart.finance.yahoo.com/w?s=" + symbol + "&" + rand_no;
                    break;
                case 2: // 3 months 
                    div3m.innerHTML = "<b>3m</b>";
                    divChart.src = "http://chart.finance.yahoo.com/c/3m/" + symbol + "?" + rand_no;
                    break;
                case 3: // 6 months 
                    div6m.innerHTML = "<b>6m</b>";
                    divChart.src = "http://chart.finance.yahoo.com/c/6m/" + symbol + "?" + rand_no;
                    break;
                case 4: // 1 year
                    div1y.innerHTML = "<b>1y</b>";
                    divChart.src = "http://chart.finance.yahoo.com/c/1y/" + symbol + "?" + rand_no;
                    break;
                case 5: // 2 years 
                    div2y.innerHTML = "<b>2y</b>";
                    divChart.src = "http://chart.finance.yahoo.com/c/2y/" + symbol + "?" + rand_no;
                    break;
                case 6: // 5 years
                    div5y.innerHTML = "<b>5y</b>";
                    divChart.src = "http://chart.finance.yahoo.com/c/5y/" + symbol + "?" + rand_no;
                    break;
                case 7: // Max
                    divMax.innerHTML = "<b>msx</b>";
                    divChart.src = "http://chart.finance.yahoo.com/c/my/" + symbol + "?" + rand_no;
                    break;
                case 0: // 1 day
                default:
                    div1d.innerHTML = "<b>1d</b>";
                    divChart.src = "http://ichart.finance.yahoo.com/b?s=" + symbol + "&" + rand_no;
                    break;
            }
        }
    </script>
    <div>
    
        <asp:HiddenField ID="hiddenUsername" runat="server" />
        <asp:HiddenField ID="hiddenView" runat="server" />
        <br />
        <h1 style="text-align:center"><asp:Label ID="Label1" runat="server"></asp:Label></h1>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:RegistrationConnectionString %>" SelectCommand="SELECT Id, FirstName, LastName, Password, Username, Active, Administrator, Email, Gender, Telephone, Address, Age FROM UserInfo WHERE (Username = @userName) AND (Active = 1)" UpdateCommand="UPDATE UserInfo SET ImageUrl = @imgUrl WHERE (Username = @userName) AND (Active = 1)">
            <SelectParameters>
                <asp:ControlParameter ControlID="hiddenUsername" Name="userName" PropertyName="Value" />
            </SelectParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="imgUrlHidden" Name="imgUrl" PropertyName="Value" />
                <asp:ControlParameter ControlID="hiddenView" Name="userName" PropertyName="Value" />
            </UpdateParameters>
        </asp:SqlDataSource>
    
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:RegistrationConnectionString %>" SelectCommand="SELECT Id, Username, Password, FirstName, LastName, Active, Administrator, Age, Address, Telephone, Gender, Email, DefaultImage, ImageUrl FROM UserInfo WHERE (Username = @viewName) AND (Active = 1)" UpdateCommand="UPDATE UserInfo SET DefaultImage = 0, ImageUrl = @imgUrl WHERE (Username = @username)">
            <SelectParameters>
                <asp:ControlParameter ControlID="hiddenView" Name="viewName" PropertyName="Value" />
            </SelectParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="hiddenUsername" Name="username" PropertyName="Value" />
                <asp:ControlParameter ControlID="imgUrlHidden" Name="imgUrl" PropertyName="Value" />
            </UpdateParameters>
        </asp:SqlDataSource>
    
        <br />
        <table class="auto-style1" border="0" style="border-spacing: 50px;">
            <tr>
                <td>
                    <asp:Panel ID="Panel1" runat="server" HorizontalAlign="Right">
                        <asp:Image ID="profImage" runat="server" CssClass="profpic" ImageAlign="Middle" style="max-height:300px; width: auto; align-content:center;"/>
                        <br />
                        <br />
                        <asp:FileUpload ID="FileUpload1" runat="server" Visible="False" />
                        <asp:Button ID="uploadBut" runat="server" OnClick="Upload" Text="Upload" Visible="False" />
                        <asp:RegularExpressionValidator ID="uplValidator" runat="server" ControlToValidate="FileUpload1" EnableClientScript="False" ErrorMessage="Only JPEG, PNG, and GIF images are allowed" ForeColor="Red" 
                            ValidationExpression="(.+\.([Jj][Pp][Gg])|.+\.([Pp][Nn][Gg])|.+\.([Gg][Ii][Ff]))"></asp:RegularExpressionValidator>
                    </asp:Panel>
                </td>
                <td>
                    <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource3" BackColor="#FFCCCC" BorderColor="#FF9966" BorderWidth="3px" CellPadding="5" Font-Bold="False" Font-Italic="False" Font-Names="Trebuchet MS" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="Black" GridLines="Both" CellSpacing="20" OnEditCommand="DataList1_EditCommand" Width="300px" OnCancelCommand="DataList1_CancelCommand" OnUpdateCommand="DataList1_UpdateCommand" style="margin-right: 17px">
                        <EditItemTemplate>
                            <strong>First Name:</strong> <strong>
                            <asp:TextBox ID="firstnamebox" runat="server" Text='<%# Eval("FirstName") %>'></asp:TextBox>
                            <br />
                            Last Name:
                            <asp:TextBox ID="lastnamebox" runat="server" Text='<%# Eval("LastName") %>'></asp:TextBox>
                            <br />
                            Age:
                            <asp:TextBox ID="agebox" runat="server" Text='<%# Eval("Age") %>'></asp:TextBox>
                            <br />
                            Address:
                            <asp:TextBox ID="addressbox" runat="server" Text='<%# Eval("Address") %>'></asp:TextBox>
                            <br />
                            Telephone:
                            <asp:TextBox ID="phonebox" runat="server" Text='<%# Eval("Telephone") %>'></asp:TextBox>
                            <br />
                            Gender:
                            <asp:TextBox ID="genderbox" runat="server" Text='<%# Eval("Gender") %>'></asp:TextBox>
                            <br />
                            Email:
                            <asp:TextBox ID="emailbox" runat="server" Text='<%# Eval("Email") %>'></asp:TextBox>
                            <br />
                            Bio:
                            <asp:TextBox ID="biobox" runat="server" Height="93px" Rows="10" Text='<%# Eval("Bio") %>' TextMode="MultiLine" Width="320px"></asp:TextBox>
                            <br />
                            <br />
                            <asp:ImageButton ID="cancelbut" runat="server" CommandName="cancel" ImageAlign="Right" ImageUrl="~/img/cancel.png" />
                            <asp:ImageButton ID="checkbut" runat="server" CommandName="update" ImageAlign="Right" ImageUrl="~/img/check.png" />
                            </strong>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <strong>First Name:</strong>
                            <asp:Label ID="FirstNameLabel" runat="server" Text='<%# Eval("FirstName") %>' />
                            <br />
                            <strong>Last Name:</strong>
                            <asp:Label ID="LastNameLabel" runat="server" Text='<%# Eval("LastName") %>' />
                            <br />
                            <strong>Age:</strong>
                            <asp:Label ID="AgeLabel" runat="server" Text='<%# Eval("Age") %>' />
                            <br />
                            <strong>Address:</strong>
                            <asp:Label ID="AddressLabel" runat="server" Text='<%# Eval("Address") %>' />
                            <br />
                            <strong>Telephone:</strong>
                            <asp:Label ID="TelephoneLabel" runat="server" Text='<%# Eval("Telephone") %>' />
                            <br />
                            <strong>Gender:</strong>
                            <asp:Label ID="GenderLabel" runat="server" Text='<%# Eval("Gender") %>' />
                            <br />
                            <strong>Email:</strong>
                            <asp:Label ID="EmailLabel" runat="server" Text='<%# Eval("Email") %>' />
                            <br />
                            <strong>Bio:</strong>
                            <asp:Label ID="BioLabel" runat="server" Text='<%# Eval("Bio") %>' />
                            <br />
                            <asp:ImageButton ID="editbut" visible='<%# FunctionToCheckPermissionsWhichReturnsTrueOrFalse() %>' runat="server" CommandName="edit" ImageAlign="Right" ImageUrl="~/img/edit.png" />
<br />
                        </ItemTemplate>
                    </asp:DataList>
                </td>
            </tr>
        </table>
    
        
    
            <asp:HiddenField ID="imgUrlHidden" runat="server" />
        
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:RegistrationConnectionString %>" SelectCommand="SELECT FirstName, LastName, Age, Address, Telephone, Gender, Email, Bio FROM UserInfo WHERE (Username = @userView)" UpdateCommand="UPDATE UserInfo SET FirstName = @FirstName, LastName = @LastName, Age = @Age, Address = @Address, Telephone = @Telephone, Gender = @Gender, Email = @Email, Bio = @Bio WHERE (Username = @username) AND (Active = 1)">
            <SelectParameters>
                <asp:ControlParameter ControlID="hiddenView" Name="userView" PropertyName="Value" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="FirstName" />
                <asp:Parameter Name="LastName" />
                <asp:Parameter Name="Age" />
                <asp:Parameter Name="Address" />
                <asp:Parameter Name="Telephone" />
                <asp:Parameter Name="Gender" />
                <asp:Parameter Name="Email" />
                <asp:Parameter Name="Bio" />
                <asp:ControlParameter ControlID="hiddenUsername" Name="username" PropertyName="Value" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:RegistrationConnectionString %>" SelectCommand="SELECT Id, Username, Active, Memo FROM UserInfo WHERE (Username = @userView)" UpdateCommand="UPDATE UserInfo SET Memo = @Memo WHERE (Username = @userView) AND (Active = 1)">
            <SelectParameters>
                <asp:ControlParameter ControlID="hiddenView" Name="userView" PropertyName="Value" />
            </SelectParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="hiddenView" Name="userView" PropertyName="Value" />
                <asp:Parameter Name="Memo" />
            </UpdateParameters>
        </asp:SqlDataSource>
            <asp:DataList ID="DataList2" runat="server" BackColor="#FFCCCC" DataKeyField="Id" DataSourceID="SqlDataSource4" Font-Bold="False" Font-Italic="False" Font-Names="Trebuchet MS" Font-Overline="False" Font-Size="Medium" Font-Strikeout="False" Font-Underline="False" style="margin-top: 0px; font-weight: 700;" Width="800px" BorderColor="#FF9966" BorderWidth="3px" CellPadding="20" CellSpacing="5" OnCancelCommand="DataList2_CancelCommand" OnEditCommand="DataList2_EditCommand" OnUpdateCommand="DataList2_UpdateCommand" HorizontalAlign="Center">
                <EditItemTemplate>
                    <asp:ImageButton ID="ImageButton2" runat="server" ImageAlign="Right" ImageUrl="~/img/cancel.png" CommandName="cancel"  />
                    <asp:ImageButton ID="ImageButton3" runat="server" ImageAlign="Right" ImageUrl="~/img/check.png" CommandName="update" />
                    Edit Memo Entries:<br />
                    <br />
                    <asp:TextBox ID="memobox" runat="server" Height="355px" Text='<%# Eval("Memo") %>' TextMode="MultiLine" Width="570px"></asp:TextBox>
                    <br />
                    <br />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:ImageButton ID="ImageButton1" visible='<%# FunctionToCheckPermissionsWhichReturnsTrueOrFalse() %>' runat="server" ImageAlign="Right" ImageUrl="~/img/edit.png" CommandName="edit" />
                    Memo Pad<br />&nbsp;<br />&nbsp;<asp:Label ID="MemoLabel" runat="server" Text='<%# Eval("Memo") %>' style="font-weight: 700" />
                    <br />
                    <br />
                    <br />
                    <br />
                </ItemTemplate>
            </asp:DataList>
        <br />
        <br />
        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:RegistrationConnectionString %>" InsertCommand="INSERT INTO Portfolios(Username, Portfolio) VALUES (@username, @portfolio)" SelectCommand="SELECT COUNT(*) AS number FROM Portfolios WHERE (Username = @username) AND (Portfolio = @portfolio)">
            <InsertParameters>
                <asp:ControlParameter ControlID="hiddenUsername" Name="username" PropertyName="Value" />
                <asp:ControlParameter ControlID="newPortfolioField" Name="portfolio" PropertyName="Text" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="hiddenUsername" Name="username" PropertyName="Value" />
                <asp:ControlParameter ControlID="newPortfolioField" Name="portfolio" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:RegistrationConnectionString %>" DeleteCommand="DELETE FROM Portfolios WHERE (Username = @username) AND (Portfolio = @portfolio)" SelectCommand="SELECT Portfolio FROM Portfolios WHERE (Username = @username)">
            <DeleteParameters>
                <asp:ControlParameter ControlID="hiddenUsername" Name="username" PropertyName="Value" />
                <asp:ControlParameter ControlID="deletePortfolioDrop" Name="portfolio" PropertyName="SelectedValue" />
            </DeleteParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="hiddenUsername" Name="username" PropertyName="Value" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <asp:Panel ID="portfolioPanel" runat="server" Visible="False">
            <table class="auto-style1">
                <tr>
                    <td class="auto-style2">
                        <h4>Add New Portfolio:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Delete Portfolio:</h4>
                        <h4>
                            <asp:TextBox ID="newPortfolioField" runat="server"></asp:TextBox>
                            &nbsp;<asp:Button ID="addPortfolio" runat="server" Text="Add" OnClick="addPortfolio_Click" />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:DropDownList ID="deletePortfolioDrop" runat="server" DataSourceID="SqlDataSource6" DataTextField="Portfolio" DataValueField="Portfolio">
                            </asp:DropDownList>
                            &nbsp;<asp:Button ID="deletePortfolio" runat="server" Text="Delete" OnClick="deletePortfolio_Click" />
                        </h4>
                        <p>
                            <asp:Label ID="addLabel" runat="server" ForeColor="Red"></asp:Label>
                        </p>
                        <h4>Quote Ticker:</h4>
                        <input type="text" value="" id="txtSymbol" runat="server" onkeypress="return CheckEnter(event);" />
                        <asp:Button ID="Button2" runat="server" Text="Get Quote" OnClick="SendRequest" />
                        <asp:Label ID="quotelabel" runat="server" ForeColor="Red"></asp:Label>
                        <br />
                        <span style="font-family: Arial, Helvetica, sans-serif; font-size: 11px;	color: #666;">e.g. "YHOO or YHOO GOOG" </span>
                        <h4>Buy/Sell:</h4>
                        &nbsp;<asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:RegistrationConnectionString %>" SelectCommand="SELECT Quantity FROM BalanceSheet WHERE (Username = @username) AND (Portfolio = @portfolio) AND (Ticker = @ticker)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="hiddenUsername" Name="username" PropertyName="Value" />
                                <asp:ControlParameter ControlID="portfolioSelection" Name="portfolio" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="tradeTicker" Name="ticker" PropertyName="Text" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="transactionDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:RegistrationConnectionString %>" InsertCommand="INSERT INTO Transactions(Username, BuySell, Quantity, Epoch, Price, Ticker, Portfolio) VALUES (@username, @buysell, @quantity, @epoch, @price, @ticker, @portfolio)" SelectCommand="SELECT * FROM [Transactions]">
                            <InsertParameters>
                                <asp:ControlParameter ControlID="hiddenUsername" Name="username" PropertyName="Value" />
                                <asp:ControlParameter ControlID="buyOrSell" Name="buysell" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="quantityField" Name="quantity" PropertyName="Text" Type="Int32" />
                                <asp:Parameter Name="epoch" />
                                <asp:Parameter Name="price" />
                                <asp:ControlParameter ControlID="tradeTicker" Name="ticker" PropertyName="Text" />
                                <asp:ControlParameter ControlID="portfolioSelection" Name="portfolio" PropertyName="SelectedValue" />
                            </InsertParameters>
                        </asp:SqlDataSource>
                        <asp:HiddenField ID="hiddenEpoch" runat="server" />
                        <br />
                        <asp:HiddenField ID="hiddenPrice" runat="server" />
                        <br />
                        <br /> &nbsp;Portfolio:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ticker:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Quantity:<br /> &nbsp;<asp:DropDownList ID="portfolioSelection" runat="server" DataSourceID="SqlDataSource6" DataTextField="Portfolio" DataValueField="Portfolio">
                        </asp:DropDownList>
                        &nbsp;&nbsp;&nbsp;
                        <asp:DropDownList ID="buyOrSell" runat="server">
                            <asp:ListItem>Buy</asp:ListItem>
                            <asp:ListItem>Sell</asp:ListItem>
                        </asp:DropDownList>
                        &nbsp;&nbsp;&nbsp;
                        <asp:TextBox ID="tradeTicker" runat="server" MaxLength="5"></asp:TextBox>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:TextBox ID="quantityField" runat="server"></asp:TextBox>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="tradeButton" runat="server" OnClick="confirmTransaction_Click" Text="Trade" />
                        <br />
                        <asp:Label ID="amountlabel" runat="server" ForeColor="Red"></asp:Label>
                        <br />
                        <br />
                    </td>
                    <td><%if (m_symbol != "") {%>
                        <div id="divService" runat="server">
                            <!-- Main DIV: this DIV contains contains text and DIVs that displays stock quotes and chart. -->
                        </div>
                        <%}%></td>
                </tr>
                <tr>
                    <td class="auto-style2">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </asp:Panel>
        <br />
        <br />
        <asp:Panel ID="Panel2" runat="server">
        </asp:Panel>
        <br />
        <br />
    
    </div>

    
    
        </asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="head">
    <style type="text/css">
        .auto-style2 {
            width: 593px;
        }
    </style>
    </asp:Content>
