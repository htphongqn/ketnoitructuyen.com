<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="left-menu.ascx.cs" Inherits="MVC_Kutun.UIs.left_menu" %>
<%@ Register src="facebook_box.ascx" tagname="facebook_box" tagprefix="uc1" %>
<script src="../vi-vn/Scripts/moreCate.js" type="text/javascript"></script>
<div class="most-viewed" id="cate_left">
    <asp:Repeater ID="Rpleftmenu" runat="server">
        <ItemTemplate>
            <h2>
                <%#Eval("cat_name")%>
            </h2>
            <ul class="list_field" id="<%#setOrder() %>">
                <asp:Repeater ID="Repeater2" runat="server" DataSource='<%# Load_Menu2(Eval("Cat_ID")) %>'>
                    <ItemTemplate>
                        <li><a class="cate_parent_left" href="<%#GetLink(Eval("cat_url"),Eval("cat_seo_url"))%>">
                            <%#Eval("cat_name")%></a>
                            <asp:Repeater ID="Repeater1" runat="server" DataSource='<%# Load_Menu3(Eval("Cat_ID")) %>'>
                                <HeaderTemplate>
                                    <ul style="margin: 10px 0 !important;">
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <li><a href="<%#GetLink(Eval("cat_url"),Eval("cat_seo_url"))%>">
                                        <%#Eval("cat_name")%></a></li></ItemTemplate>
                                <FooterTemplate>
                                    </ul></FooterTemplate>
                            </asp:Repeater>
                    </ItemTemplate>
                </asp:Repeater>
            </ul>
        </ItemTemplate>
    </asp:Repeater>
</div>
<div class="most-viewed" id="trademark">
    <h3>
        Thương hiệu</h3>
    <ul class="list_field">
        <asp:Repeater ID="Rphangsx" runat="server">
            <ItemTemplate>
                <li><a href="<%#GetLink(Eval("cat_url"),Eval("cat_seo_url"))%>">
                    <%#Eval("CAT_NAME") %></a></li>
            </ItemTemplate>
        </asp:Repeater>
    </ul>
</div>
<div class="most-viewed" id="origin">
    <h3>
        Xuất xứ</h3>
    <ul class="list_field">
        <asp:Repeater ID="Rpxuatxu" runat="server">
            <ItemTemplate>
                <li><a href="<%#GetLink(Eval("cat_url"),Eval("cat_seo_url"))%>">
                    <%#Eval("CAT_NAME") %></a></li>
            </ItemTemplate>
        </asp:Repeater>
    </ul>
</div>
<div class="most-viewed" id="search_price">
    <h3>
        Tìm theo giá</h3>
    <ul class="list_field">
        <li><a href="<%=getLink_price("200000",3) %>" class="active">Dưới 200.000 VNĐ</a>
        </li>
        <li><a href="<%=getLink_price("200000,500000",1) %>">200.000 - 500.000 VNĐ</a> </li>
        <li><a href="<%=getLink_price("500000,1000000",1) %>">500.000 - 1.000.000 VNĐ</a>
        </li>
        <li><a href="<%=getLink_price("1000000,2000000",1) %>">1.000.000 - 2.000.000 VNĐ</a>
        </li>
        <li><a href="<%=getLink_price("2000000",2) %>">Trên 2.000.000 VNĐ</a> </li>
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

