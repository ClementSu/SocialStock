<%@ Page Language="C#" AutoEventWireup="true" Inherits="UserProfile_Settings" MasterPageFile="~/MasterPage.master" Codebehind="Settings.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 style="text-align: center">Settings</h1>
 
        
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:RegistrationConnectionString %>" SelectCommand="SELECT Id, FirstName, LastName, Password, Username, Active, Administrator, Email, Gender, Telephone, Address, Age FROM UserInfo WHERE (Username = @userName) AND (Active = 1)" UpdateCommand="UPDATE UserInfo SET Password = @newPassword WHERE (Username = @username) AND (Active = 1)">
            <SelectParameters>
                <asp:ControlParameter ControlID="hiddenUsername" Name="userName" PropertyName="Value" />
            </SelectParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="pw" Name="newPassword" PropertyName="Text" />
                <asp:ControlParameter ControlID="hiddenUsername" Name="username" PropertyName="Value" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="hiddenUsername" runat="server" />
&nbsp;<br />
    <asp:Label ID="Label1" runat="server" ForeColor="Red"></asp:Label>
    <br />
    <h3>Password Settings</h3>
    
        <table class="auto-style1">
            <tr>
                <td class="auto-style5">Current Password:</td>
                <td class="auto-style6">
                    <asp:TextBox ID="pw0" runat="server" Width="180px" TextMode="Password"></asp:TextBox>
                </td>
                <td class="auto-style7">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Missing Password" ControlToValidate="pw0" EnableClientScript="False" ForeColor="Red" Display="Dynamic" ValidationGroup="RegForm"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style8">New Password:</td>
                <td class="auto-style9">
                    <asp:TextBox ID="pw" runat="server" Width="180px" TextMode="Password"></asp:TextBox>
                </td>
                <td class="auto-style10">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Missing Password" ControlToValidate="pw" EnableClientScript="False" ForeColor="Red" Display="Dynamic" ValidationGroup="RegForm"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="pw" EnableClientScript="False" ErrorMessage="Password must be 8-15 characters" ForeColor="Red" ValidationExpression="^.{8,15}$" ValidationGroup="RegForm"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">Confirm New Password:</td>
                <td class="auto-style4">
                    <asp:TextBox ID="confirmpw" runat="server" Width="180px" TextMode="Password"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Missing Password Confirmation" ControlToValidate="confirmpw" EnableClientScript="False" ForeColor="Red" Display="Dynamic" ValidationGroup="RegForm"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="pw" ControlToValidate="confirmpw" EnableClientScript="False" ErrorMessage="Passwords do not match" ForeColor="Red" Display="Dynamic" ValidationGroup="RegForm"></asp:CompareValidator>
                </td>
            </tr>

            <tr>
                <td class="auto-style3">&nbsp;</td>
                <td class="auto-style4">
                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" ValidationGroup="RegForm" />
                </td>
                <td>&nbsp;</td>
            </tr>
        </table>
 
    

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:RegistrationConnectionString %>" SelectCommand="SELECT * FROM [UserInfo]" UpdateCommand="UPDATE UserInfo SET Active = 0 WHERE (Username = @username) AND (Active = 1)">
        <UpdateParameters>
            <asp:ControlParameter ControlID="hiddenUsername" Name="username" PropertyName="Value" />
        </UpdateParameters>
    </asp:SqlDataSource>
 
    

    <br />
    
    <h3>Delete Account</h3>
    <p>
        <asp:Label ID="Label2" runat="server" ForeColor="Red"></asp:Label>
    </p>

        <table class="auto-style1">
            <tr>
                <td class="auto-style5">Current Password:</td>
                <td class="auto-style6">
                    <asp:TextBox ID="pw1" runat="server" Width="180px" TextMode="Password"></asp:TextBox>
                </td>
                <td class="auto-style7">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Missing Password" ControlToValidate="pw1" EnableClientScript="False" ForeColor="Red" Display="Dynamic" ValidationGroup="deleteform"></asp:RequiredFieldValidator>
                </td>
            </tr>

            <tr>
                <td class="auto-style3">&nbsp;</td>
                <td class="auto-style4">
                    <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Delete" ValidationGroup="deleteform" />
                </td>
                <td>&nbsp;</td>
            </tr>
        </table>
 
    

    <br />

</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="head">
    <style type="text/css">
        .auto-style2 {
            text-align: right;
            width: 259px;
        }
        .auto-style4 {
            width: 200px;
        }
        .auto-style3 {
            width: 259px;
        }
        .auto-style5 {
            text-align: right;
            width: 259px;
            height: 23px;
        }
        .auto-style6 {
            width: 200px;
            height: 23px;
        }
        .auto-style7 {
            height: 23px;
        }
        .auto-style8 {
            text-align: right;
            width: 259px;
            height: 26px;
        }
        .auto-style9 {
            width: 200px;
            height: 26px;
        }
        .auto-style10 {
            height: 26px;
        }
    </style>
</asp:Content>

