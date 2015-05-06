<%@ Page Language="C#" AutoEventWireup="true" Inherits="Login" MasterPageFile="~/MasterPage.master" Codebehind="Login.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            text-align: right;
            width: 315px;
        }
        .auto-style3 {
            width: 315px;
        }
        .auto-style4 {
            width: 216px;
        }
        .auto-style5 {
            text-align: right;
            width: 315px;
            height: 26px;
        }
        .auto-style6 {
            width: 216px;
            height: 26px;
        }
        .auto-style7 {
            height: 26px;
        }
    </style>
    <h1 style="text-align: center">Welcome to StockView</h1>
    <h3 style="text-align: center">An easy way to manage your stock portfolio</h3>
    <div>
    
        <asp:SqlDataSource ID="userDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:RegistrationConnectionString %>" SelectCommand="SELECT Id, Password FROM UserInfo WHERE (Username = @userName) AND (Active = 1)">
            <SelectParameters>
                <asp:ControlParameter ControlID="userName" Name="userName" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="userDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:RegistrationConnectionString %>" SelectCommand="SELECT COUNT(*) AS number FROM UserInfo WHERE (Active = 1) AND (Username = @userName)">
            <SelectParameters>
                <asp:ControlParameter ControlID="userName" Name="userName" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
    
        <br />
        <asp:Label ID="Label1" runat="server" ForeColor="Red"></asp:Label>
    
    </div>
        <table class="auto-style1">
            <tr>
                <td class="auto-style2">Username:</td>
                <td class="auto-style4">
                    <asp:TextBox ID="userName" runat="server" Width="180px"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="userName" EnableClientScript="False" ErrorMessage="Please enter a username" ForeColor="Red" ValidationGroup="loginForm"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style5">Password:</td>
                <td class="auto-style6">
                    <asp:TextBox ID="pw" runat="server" TextMode="Password" Width="180px"></asp:TextBox>
                </td>
                <td class="auto-style7">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="pw" EnableClientScript="False" ErrorMessage="Password is missing" ForeColor="Red" ValidationGroup="loginForm"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">&nbsp;</td>
                <td class="auto-style4">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style3">&nbsp;</td>
                <td class="auto-style4">
                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Login" ValidationGroup="loginForm" Width="98px" />
                </td>
                <td>
                    <asp:Button ID="registerbut" runat="server" OnClick="registerbut_Click" Text="Register" Width="97px" />
                </td>
            </tr>
        </table>
</asp:Content>
