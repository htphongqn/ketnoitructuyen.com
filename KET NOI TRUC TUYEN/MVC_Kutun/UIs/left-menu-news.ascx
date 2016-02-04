<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="left-menu-news.ascx.cs"
    Inherits="MVC_Kutun.UIs.left_menu_news" %>
<%@ Register src="facebook_box.ascx" tagname="facebook_box" tagprefix="uc1" %>
<div class="most-viewed" id="origin">
    <ul class="list_field">
        <asp:Repeater ID="Rpmenu_news" runat="server">
            <ItemTemplate>
                <li><a target="_parent" href="<%#GetLink(Eval("cat_url"),Eval("cat_seo_url"))%>">
                    <%#Eval("cat_name")%></a> </li>
            </ItemTemplate>
        </asp:Repeater>
    </ul>
</div>
<!--Stick Menu-->
<script src="../vi-vn/Scripts/jquery.sticky.js"></script>
<script>
    $(document).ready(function () {
        $(".sticky").sticky({ topSpacing: 40 });
    });
</script>
<uc1:facebook_box ID="facebook_box1" runat="server" />

