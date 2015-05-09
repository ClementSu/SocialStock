<%@ Page Language="C#" AutoEventWireup="true" Inherits="Admin" MasterPageFile="~/MasterPage.master" Codebehind="Default.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 style="text-align: center">Admin Page</h1>
    <h3 style="text-align: center">You can change user priviliges here</h3>
    
    <asp:HiddenField ID="hiddenUsername" runat="server" />
    
    <div>
    
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:RegistrationConnectionString %>" SelectCommand="SELECT * FROM [UserInfo]" UpdateCommand="UPDATE [UserInfo] SET [Active] = @Active, [Administrator] = @Administrator WHERE [Id] = @Id">

            <UpdateParameters>
                <asp:Parameter Name="Active" Type="Int32" />
                <asp:Parameter Name="Administrator" Type="Int32" />
                <asp:Parameter Name="Id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Id" DataSourceID="SqlDataSource1" ForeColor="#333333" HorizontalAlign="Center" Width="952px" AllowPaging="True" AllowSorting="True" >
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:CommandField ShowEditButton="True" ButtonType="Button" />
                <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                <asp:BoundField DataField="Username" HeaderText="Username" ReadOnly="True" SortExpression="Username" />
                <asp:BoundField DataField="Password" HeaderText="Password" ReadOnly="True" SortExpression="Password" ApplyFormatInEditMode="True" />
                <asp:BoundField DataField="FirstName" HeaderText="FirstName" ReadOnly="True" SortExpression="FirstName" />
                <asp:BoundField DataField="LastName" HeaderText="LastName" ReadOnly="True" SortExpression="LastName" />
                <asp:TemplateField HeaderText="Active" SortExpression="Active">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Active") %>' CausesValidation="True"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox1" EnableClientScript="False" ErrorMessage="Only values of 0 or 1 are accepted" ForeColor="Red" ValidationExpression="[01]{1}$"></asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Active") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Administrator" SortExpression="Administrator">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Administrator") %>' CausesValidation="True"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TextBox2" EnableClientScript="False" ErrorMessage="Only values of 0 or 1 are accepted" ForeColor="Red" ValidationExpression="[01]{1}$"></asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Administrator") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
    
    </div>

</asp:Content>
