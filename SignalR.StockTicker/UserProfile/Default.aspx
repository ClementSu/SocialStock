<%@ Page Language="C#" AutoEventWireup="true" Inherits="UserProfile" MasterPageFile="~/MasterPage.master" Codebehind="Default.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<link href="/resource/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css" />
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
        <h1 style="text-align:center" aria-autocomplete="inline"><asp:Label ID="Label1" runat="server"></asp:Label></h1>
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
        <table class="auto-style1" border="0" style="border-spacing: 100px; ">
            <tr>
                <td>
                    <asp:Panel ID="Panel5" runat="server" style="text-align: right">
                        <br />
                        <table class="auto-style1">
                            <tr>
                                <td>
                                    <asp:Image ID="profImage" runat="server" CssClass="profpic" ImageAlign="Middle" style="max-height:300px; width: auto; align-content:center; text-align: right;" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control-static" style="position: relative; left: 495px;" Visible="False" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="uploadBut" runat="server" CssClass="btn btn-info" OnClick="Upload" Text="Upload" Visible="False" />
                                    <asp:RegularExpressionValidator ID="uplValidator" runat="server" ControlToValidate="FileUpload1" EnableClientScript="False" ErrorMessage="Only JPEG, PNG, and GIF images are allowed" ForeColor="Red" ValidationExpression="(.+\.([Jj][Pp][Gg])|.+\.([Pp][Nn][Gg])|.+\.([Gg][Ii][Ff]))"></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
                <td>
                    <asp:DataList ID="DataList1" style="position: relative; margin-right: 17px; left: 20px" runat="server" DataSourceID="SqlDataSource3" BackColor="White" BorderColor="#337AB7" BorderWidth="3px" CellPadding="5" Font-Bold="False" Font-Italic="False" Font-Names="Trebuchet MS" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="Black" GridLines="Both" CellSpacing="20" OnEditCommand="DataList1_EditCommand" Width="300px" OnCancelCommand="DataList1_CancelCommand" OnUpdateCommand="DataList1_UpdateCommand" >
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
            <asp:DataList ID="DataList2" runat="server" BackColor="White" DataKeyField="Id" DataSourceID="SqlDataSource4" Font-Bold="False" Font-Italic="False" Font-Names="Trebuchet MS" Font-Overline="False" Font-Size="Medium" Font-Strikeout="False" Font-Underline="False" style="margin-top: 0px; font-weight: 700;" Width="800px" BorderColor="#337AB7" BorderWidth="3px" CellPadding="20" CellSpacing="5" OnCancelCommand="DataList2_CancelCommand" OnEditCommand="DataList2_EditCommand" OnUpdateCommand="DataList2_UpdateCommand" HorizontalAlign="Center">
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
        <asp:SqlDataSource ID="getUserPortfolioSource" runat="server" ConnectionString="<%$ ConnectionStrings:RegistrationConnectionString %>" SelectCommand="SELECT * FROM [Portfolios] WHERE ([Username] = @Username)">
            <SelectParameters>
                <asp:ControlParameter ControlID="hiddenView" Name="Username" PropertyName="Value" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="userTransactionSource" runat="server" ConnectionString="<%$ ConnectionStrings:RegistrationConnectionString %>" SelectCommand="SELECT BuySell, Quantity, Ticker, Price, Epoch FROM Transactions WHERE (Username = @Username) AND (Portfolio = @Portfolio)">
            <SelectParameters>
                <asp:ControlParameter ControlID="hiddenView" Name="Username" PropertyName="Value" Type="String" />
                <asp:ControlParameter ControlID="viewUserPortfolio" Name="Portfolio" PropertyName="SelectedValue" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="userBalanceSheetSource" runat="server" ConnectionString="<%$ ConnectionStrings:RegistrationConnectionString %>" SelectCommand="SELECT [Quantity], [Ticker] FROM [BalanceSheet] WHERE (([Username] = @Username) AND ([Portfolio] = @Portfolio))">
            <SelectParameters>
                <asp:ControlParameter ControlID="hiddenView" Name="Username" PropertyName="Value" Type="String" />
                <asp:ControlParameter ControlID="viewUserPortfolio" Name="Portfolio" PropertyName="SelectedValue" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <br />
        <br />
        <asp:DropDownList ID="viewUserPortfolio" runat="server" DataSourceID="getUserPortfolioSource" DataTextField="Portfolio" DataValueField="Portfolio" CssClass="form-control" Width="177px">
        </asp:DropDownList>
&nbsp;
        <asp:Button ID="viewPortfolioButton" runat="server" OnClick="viewPortfolioButton_Click" Text="View Portfolio" CssClass="btn btn-info" />
        <br />
        <br />
        <br />
        <asp:Panel ID="Panel4" runat="server" Visible="False" HorizontalAlign="Center">
            <table align="center" class="auto-style4">
                <tr>
                    <td class="auto-style15">
                        <h4 class="auto-style14">Net Value of Assets</h4>
                    </td>
                    <td class="auto-style13">
                        <h4 class="auto-style14">Growth Since Inception</h4>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style16">
                        $<asp:Label ID="NetValue" runat="server"></asp:Label>
                    </td>
                    <td class="auto-style16">
                        $<asp:Label ID="Growth" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <br />
        <br />
        <asp:Panel ID="Panel3" runat="server" Visible="False">
            <table class="auto-style1" style="width: 100%; margin-left: 200px;">
                <tr>
                    <td class="auto-style3">
                        <h4>Balance Sheet:</h4>
                        <asp:GridView ID="balanceSheetGrid" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="balanceSheetDataSource" GridLines="Horizontal" Width="238px">
                            <AlternatingRowStyle BackColor="#F7F7F7" />
                            <Columns>
                                <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
                                <asp:BoundField DataField="Ticker" HeaderText="Ticker" SortExpression="Ticker" />
                            </Columns>
                            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <SortedAscendingCellStyle BackColor="#F4F4FD" />
                            <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
                            <SortedDescendingCellStyle BackColor="#D8D8F0" />
                            <SortedDescendingHeaderStyle BackColor="#3E3277" />
                        </asp:GridView>
                    </td>
                    <td>
                        <h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Transaction Log:</h4>
                        <asp:GridView ID="transactionGrid" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="transactionDataSource" GridLines="Horizontal" style="margin-left: 38px" Width="721px">
                            <AlternatingRowStyle BackColor="#F7F7F7" />
                            <Columns>
                                <asp:BoundField DataField="BuySell" HeaderText="BuySell" SortExpression="BuySell" />
                                <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
                                <asp:BoundField DataField="Ticker" HeaderText="Ticker" SortExpression="Ticker" />
                                <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
                                <asp:BoundField DataField="Epoch" HeaderText="Epoch" SortExpression="Epoch" />
                            </Columns>
                            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <SortedAscendingCellStyle BackColor="#F4F4FD" />
                            <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
                            <SortedDescendingCellStyle BackColor="#D8D8F0" />
                            <SortedDescendingHeaderStyle BackColor="#3E3277" />
                        </asp:GridView>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <br />
        <br />
        <br />
        <br />
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
        <asp:SqlDataSource ID="PortfolioHasStock" runat="server" ConnectionString="<%$ ConnectionStrings:RegistrationConnectionString %>" SelectCommand="SELECT Quantity FROM BalanceSheet WHERE (Username = @username) AND (Portfolio = @portfolio) AND (Ticker = @ticker)" InsertCommand="INSERT INTO Transactions(Username, BuySell, Quantity, Epoch, Price, Ticker, Portfolio) VALUES (@username, @buysell, @quantity, @epoch, @price, @ticker, @portfolio)">
                            <InsertParameters>
                                <asp:ControlParameter ControlID="hiddenUsername" Name="username" PropertyName="Value" />
                                <asp:ControlParameter ControlID="buyOrSell" Name="buysell" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="quantityField" Name="quantity" PropertyName="Text" />
                                <asp:ControlParameter ControlID="hiddenEpoch" Name="epoch" PropertyName="Value" />
                                <asp:ControlParameter ControlID="hiddenPrice" Name="price" PropertyName="Value" />
                                <asp:ControlParameter ControlID="tradeTicker" Name="ticker" PropertyName="Text" />
                                <asp:ControlParameter ControlID="portfolioSelection" Name="portfolio" PropertyName="SelectedValue" />
                            </InsertParameters>
                            <SelectParameters>
                                <asp:ControlParameter ControlID="hiddenUsername" Name="username" PropertyName="Value" />
                                <asp:ControlParameter ControlID="portfolioSelection" Name="portfolio" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="tradeTicker" Name="ticker" PropertyName="Text" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="transactionDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:RegistrationConnectionString %>" InsertCommand="INSERT INTO Transactions(Username, BuySell, Quantity, Epoch, Price, Ticker, Portfolio) VALUES (@username, @buysell, @quantity, @epoch, @price, @ticker, @portfolio)" SelectCommand="SELECT BuySell, Quantity, Ticker, Price, Epoch FROM Transactions WHERE (Username = @Username) AND (Portfolio = @Portfolio)" DeleteCommand="DELETE FROM Transactions WHERE (Username = @username) AND (Portfolio = @portfolio)">
                            <DeleteParameters>
                                <asp:ControlParameter ControlID="hiddenUsername" Name="username" PropertyName="Value" />
                                <asp:ControlParameter ControlID="deletePortfolioDrop" Name="portfolio" PropertyName="SelectedValue" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:ControlParameter ControlID="hiddenUsername" Name="username" PropertyName="Value" />
                                <asp:ControlParameter ControlID="buyOrSell" Name="buysell" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="quantityField" Name="quantity" PropertyName="Text" Type="Int32" />
                                <asp:ControlParameter ControlID="hiddenEpoch" Name="epoch" PropertyName="Value" />
                                <asp:ControlParameter ControlID="hiddenPrice" Name="price" PropertyName="Value" />
                                <asp:ControlParameter ControlID="tradeTicker" Name="ticker" PropertyName="Text" />
                                <asp:ControlParameter ControlID="portfolioSelection" Name="portfolio" PropertyName="SelectedValue" />
                            </InsertParameters>
                            <SelectParameters>
                                <asp:ControlParameter ControlID="hiddenView" Name="Username" PropertyName="Value" />
                                <asp:ControlParameter ControlID="viewUserPortfolio" Name="Portfolio" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="balanceSheetDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:RegistrationConnectionString %>" InsertCommand="INSERT INTO BalanceSheet(Username, Portfolio, Ticker, Quantity) VALUES (@username, @portfolio, @ticker, @quantity)" SelectCommand="SELECT Quantity, Ticker FROM BalanceSheet WHERE (Username = @Username) AND (Portfolio = @Portfolio)" UpdateCommand="UPDATE BalanceSheet SET Quantity = Quantity + @quantity WHERE (Username = @username) AND (Portfolio = @portfolio) AND (Ticker = @ticker)" DeleteCommand="DELETE FROM BalanceSheet WHERE (Username = @username) AND (Portfolio = @portfolio)">
                            <DeleteParameters>
                                <asp:ControlParameter ControlID="hiddenUsername" Name="username" PropertyName="Value" />
                                <asp:ControlParameter ControlID="deletePortfolioDrop" Name="portfolio" PropertyName="SelectedValue" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:ControlParameter ControlID="hiddenUsername" Name="username" PropertyName="Value" />
                                <asp:ControlParameter ControlID="portfolioSelection" Name="portfolio" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="tradeTicker" Name="ticker" PropertyName="Text" />
                                <asp:ControlParameter ControlID="quantityField" Name="quantity" PropertyName="Text" />
                            </InsertParameters>
                            <SelectParameters>
                                <asp:ControlParameter ControlID="hiddenView" Name="Username" PropertyName="Value" />
                                <asp:ControlParameter ControlID="viewUserPortfolio" Name="Portfolio" PropertyName="SelectedValue" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:ControlParameter ControlID="quantityField" Name="quantity" PropertyName="Text" />
                                <asp:ControlParameter ControlID="hiddenUsername" Name="username" PropertyName="Value" />
                                <asp:ControlParameter ControlID="portfolioSelection" Name="portfolio" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="tradeTicker" Name="ticker" PropertyName="Text" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                        <asp:HiddenField ID="hiddenEpoch" runat="server" />
                        <asp:HiddenField ID="hiddenPrice" runat="server" />
                        <asp:SqlDataSource ID="portfolioSelectSource" runat="server" ConnectionString="<%$ ConnectionStrings:RegistrationConnectionString %>" SelectCommand="SELECT Username, Portfolio FROM Portfolios WHERE (Username = @username)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="hiddenUsername" Name="username" PropertyName="Value" />
                            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <asp:Panel ID="portfolioPanel" runat="server" Visible="False" style="margin-left: 97px">
            <table class="auto-style1">
                <tr>
                    <td class="auto-style2">

                        <table class="auto-style1">
                            <tr>
                                <td class="auto-style10"><h4>Add New Portfolio:</h4></td>
                                <td><h4>Delete Portfolio:</h4></td>
                            </tr>
                            <tr>
                                <td class="auto-style10">
                                    <asp:TextBox ID="newPortfolioField" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:Button ID="addPortfolio" runat="server" CssClass="btn btn-info" OnClick="addPortfolio_Click" Text="Add" />
                                </td>
                                <td>
                                    <asp:DropDownList ID="deletePortfolioDrop" runat="server" CssClass="form-control" DataSourceID="SqlDataSource6" DataTextField="Portfolio" DataValueField="Portfolio" Width="120px">
                                    </asp:DropDownList>
                                    <asp:Button ID="deletePortfolio" runat="server" CssClass="btn btn-info" OnClick="deletePortfolio_Click" Text="Delete" />
                                </td>
                            </tr>
                        </table>
                        <br />

                        <br />
                        <p>
                            <asp:Label ID="addLabel" runat="server" ForeColor="Red"></asp:Label>
                        </p>
                        <h4>Quote Ticker:</h4>
                        <input type="text" value="" class="form-control" id="txtSymbol" runat="server" onkeypress="return CheckEnter(event);" width="100px" />
                        <asp:Button ID="Button2" runat="server" Text="Get Quote" OnClick="SendRequest" CssClass="btn btn-info" />
                        <br />
                        <span style="font-family: Arial, Helvetica, sans-serif; font-size: 11px;	color: #666;">e.g. &quot;YHOO or YHOO GOOG&quot; </span>
                        <br />
                        <asp:Label ID="quotelabel" runat="server" ForeColor="Red"></asp:Label>
                        <br />
                        <br />
                        <h4>Buy/Sell:</h4>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<table class="auto-style1">
                            <tr>
                                <td class="auto-style6">Portfolio:&nbsp;&nbsp;</td>
                                <td class="auto-style11">&nbsp;</td>
                                <td class="auto-style7">&nbsp;Ticker:</td>
                                <td class="auto-style12">&nbsp;Quantity:</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style6">
                                    <asp:DropDownList ID="portfolioSelection" runat="server" CssClass="form-control" DataSourceID="portfolioSelectSource" DataTextField="Portfolio" DataValueField="Portfolio">
                                    </asp:DropDownList>
                                </td>
                                <td class="auto-style11">
                                    <asp:DropDownList ID="buyOrSell" runat="server" CssClass="form-control">
                                        <asp:ListItem>Buy</asp:ListItem>
                                        <asp:ListItem>Sell</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td class="auto-style7">
                                    <asp:TextBox ID="tradeTicker" runat="server" CssClass="form-control" MaxLength="5"></asp:TextBox>
                                </td>
                                <td class="auto-style12">
                                    <asp:TextBox ID="quantityField" runat="server" CssClass="form-control" Width="50px"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Button ID="tradeButton" runat="server" CssClass="btn btn-info" OnClick="confirmTransaction_Click" Text="Trade" />
                                </td>
                            </tr>
                        </table>
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
        .auto-style4 {
            width: 100%;
            border-style: solid;
            border-width: 1px;
        }
        .auto-style3 {
            width: 105px;
        }
        .auto-style6 {
            width: 113px;
        }
        .auto-style7 {
            width: 157px;
        }
        .auto-style10 {
            width: 209px;
        }
        .auto-style11 {
            width: 97px;
        }
        .auto-style12 {
            width: 122px;
        }
        .auto-style13 {
            text-align: center;
            background-color: #333399;
        }
        .auto-style14 {
            color: #FFFFFF;
        }
        .auto-style15 {
            color: #FFFFFF;
            text-align: center;
            background-color: #333399;
        }
        .auto-style16 {
            text-align: center;
        }
        </style>
    </asp:Content>
