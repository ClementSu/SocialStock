<%@ Page Language="C#" AutoEventWireup="true" Inherits="UserProfile_View" MasterPageFile="~/MasterPage.master" Codebehind="View.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <h1 style="text-align: center">Browse Users</h1>
    <div>
    
        <asp:HiddenField ID="hiddenUsername" runat="server" />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:RegistrationConnectionString %>" SelectCommand="SELECT Username + ' , ' + FirstName + '  ' + LastName AS Name, Username FROM UserInfo WHERE (Active = @Active)">
            <SelectParameters>
                <asp:Parameter DefaultValue="1" Name="Active" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:RegistrationConnectionString %>" SelectCommand="SELECT Id, FirstName, LastName, Password, Username, Active, Administrator, Email, Gender, Telephone, Address, Age FROM UserInfo WHERE (Username = @userName) AND (Active = 1)">
            <SelectParameters>
                <asp:ControlParameter ControlID="hiddenUsername" Name="userName" PropertyName="Value" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        Select someone from the list to view their profile:<br />
        <br />
        <asp:DropDownList ID="userDropdown" runat="server" DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="Username">
        </asp:DropDownList>
        <asp:Button ID="Button1" runat="server" Text="Go" OnClick="Button1_Click" />
    
    &nbsp;
    
    </div>
</asp:Content>
