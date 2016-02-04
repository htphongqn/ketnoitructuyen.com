<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucLeftmenu.ascx.cs"
    Inherits="vpro.eshop.cpanel.ucControls.ucLeftmenu" %>
<div id="contentpr_menu">
    <ul>
        <asp:Repeater ID="Rpmenu" runat="server">
            <ItemTemplate>
                <li><a href="<%#Eval("MENU_LINK") %>">
                    <img src="../Images/User_Config.png" width="15" height="15" style="padding-right: 5px;
                        border: 0px;">
                    <%#Eval("MENU_NAME") %></a>
                    <asp:Repeater ID="Repeater2" runat="server" DataSource='<%#loadmenuRank2(Eval("ID")) %>'>
                        <HeaderTemplate>
                            <ul>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <li><a href="<%#Eval("MENU_LINK") %>">
                                <%#Eval("MENU_NAME") %></a></li></ItemTemplate>
                        <FooterTemplate>
                            </ul></FooterTemplate>
                    </asp:Repeater>
                </li>
            </ItemTemplate>
        </asp:Repeater>
    </ul>
</div>
