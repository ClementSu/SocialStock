<%@ Page Language="C#" AutoEventWireup="true" Inherits="Register" MasterPageFile="~/MasterPage.master" Codebehind="Register.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/resource/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css" />

    <h1 style="text-align: center">Registration</h1>
    
        <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            text-align: right;
            width: 259px;
        }
        .auto-style3 {
            width: 259px;
        }
        .auto-style4 {
            width: 200px;
        }
        </style>
    <div>
    
        <asp:SqlDataSource ID="RegistrationSource" runat="server" ConnectionString="<%$ ConnectionStrings:RegistrationConnectionString %>" InsertCommand="INSERT INTO UserInfo(Username, Password, FirstName, LastName, Active) VALUES (@userName, @pass, @firstName, @lastName, 1)" SelectCommand="SELECT COUNT(*) AS number FROM UserInfo WHERE (Active = 1) AND (Username = @userName)">
            <InsertParameters>
                <asp:ControlParameter ControlID="userName" Name="userName" PropertyName="Text" />
                <asp:ControlParameter ControlID="pw" Name="pass" PropertyName="Text" />
                <asp:ControlParameter ControlID="firstName" Name="firstName" PropertyName="Text" />
                <asp:ControlParameter ControlID="lastName" Name="lastName" PropertyName="Text" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="userName" Name="userName" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
    
        <asp:HiddenField ID="HiddenID" runat="server" />
        <asp:HiddenField ID="HiddenUsername" runat="server" />
        <asp:SqlDataSource ID="TransactionSource" runat="server" ConnectionString="<%$ ConnectionStrings:RegistrationConnectionString %>" InsertCommand="INSERT INTO Transactions(Username) VALUES (@username)" SelectCommand="SELECT * FROM [Transactions]">
            <InsertParameters>
                <asp:ControlParameter ControlID="userName" Name="username" PropertyName="Text" />
            </InsertParameters>
        </asp:SqlDataSource>
    
        <asp:Label ID="Label1" runat="server" ForeColor="Red"></asp:Label>
        <br />
    
        <table class="auto-style1">
            <tr>
                <td class="auto-style2">First Name:</td>
                <td class="auto-style4">
                    <asp:TextBox ID="firstName" runat="server" Width="180px"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Missing Name" ControlToValidate="firstName" EnableClientScript="False" ForeColor="Red" Display="Dynamic" ValidationGroup="RegForm"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">Last Name:</td>
                <td class="auto-style4">
                    <asp:TextBox ID="lastName" runat="server" Width="180px"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Missing Last Name" ControlToValidate="lastName" EnableClientScript="False" ForeColor="Red" Display="Dynamic" ValidationGroup="RegForm"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">Username:</td>
                <td class="auto-style4">
                    <asp:TextBox ID="userName" runat="server" Width="180px"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Missing Username" ControlToValidate="userName" EnableClientScript="False" ForeColor="Red" Display="Dynamic" ValidationGroup="RegForm"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="userName" Display="Dynamic" EnableClientScript="False" ErrorMessage="Username must be alphanumeric with no spaces" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9]*$" ValidationGroup="RegForm"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">Password:</td>
                <td class="auto-style4">
                    <asp:TextBox ID="pw" runat="server" Width="180px" TextMode="Password"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Missing Password" ControlToValidate="pw" EnableClientScript="False" ForeColor="Red" Display="Dynamic" ValidationGroup="RegForm"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="pw" EnableClientScript="False" ErrorMessage="Password must be 8-15 characters" ForeColor="Red" ValidationExpression="^.{8,15}$" ValidationGroup="RegForm"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">Confirm Password:</td>
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
                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Register" ValidationGroup="RegForm" CssClass="btn btn-success" />
                </td>
                <td>&nbsp;</td>
            </tr>
        </table>
    
    </div>
</asp:Content>