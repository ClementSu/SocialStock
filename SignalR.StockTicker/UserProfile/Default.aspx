<%@ Page Language="C#" AutoEventWireup="true" Inherits="UserProfile" MasterPageFile="~/MasterPage.master" Codebehind="Default.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
        <asp:Panel ID="Panel2" runat="server">
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
        </asp:Panel>
        <br />
        <br />
    
    </div>
        </asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="head">
    </asp:Content>
