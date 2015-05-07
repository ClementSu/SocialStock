<%@ Page Language="C#" AutoEventWireup="true" Inherits="Login" MasterPageFile="~/MasterPage.master" Codebehind="Login.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/resource/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css" />
    
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style10 {
            width: 100%;
        }
        .auto-style11 {
            text-align: center;
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
    
        <br />
        <br />
        <asp:Panel ID="Panel2" runat="server" style="text-align: center">
            <table class="auto-style10">
                <tr>
                    <td class="auto-style11"><asp:Label ID="Label2" runat="server" Text="Username:"></asp:Label>
                        &nbsp;<asp:TextBox ID="userName" runat="server" Width="180px"></asp:TextBox>
                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="userName" EnableClientScript="False" ErrorMessage="Please enter a username" ForeColor="Red" ValidationGroup="loginForm"></asp:RequiredFieldValidator>
                        <br />
                        <br />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style11">
                        <asp:Label ID="Label3" runat="server" Text="Password:"></asp:Label>
&nbsp;
                        <asp:TextBox ID="pw" runat="server" TextMode="Password" Width="180px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="pw" EnableClientScript="False" ErrorMessage="Password is missing" ForeColor="Red" ValidationGroup="loginForm"></asp:RequiredFieldValidator>
                        <br />
                        <br />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style11">
                        <asp:Button ID="Button1" runat="server" CssClass="btn btn-success" OnClick="Button1_Click" Text="Login" ValidationGroup="loginForm" Width="98px" />
                        &nbsp;<asp:Button ID="registerbut" runat="server" CssClass="btn btn-success" OnClick="registerbut_Click" Text="Register" Width="97px" />
                        <br />
                        <br />
                    </td>
                </tr>
            </table>
        </asp:Panel>
    
        <br />
        <br />
    
    </div>
        </asp:Content>
