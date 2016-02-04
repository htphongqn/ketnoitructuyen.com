<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="cate-bottom.ascx.cs"
    Inherits="MVC_Kutun.MOBILE.UIs.cate_bottom" %>
<!--List All Categories-->
<div class="box">
    <h2 class="box_Tab" style="text-align: left">
        Danh mục sản phẩm</h2>
    <div id="ic_menucate">
        <div class="ic_cate fa fa-fw fa-list">
        </div>
    </div>
    <div id="mnu_bot">
        <ul>
            <asp:Repeater ID="Rpcatepro" runat="server">
                <ItemTemplate>
                    <li class="cat-header">
                        <div class="cate_icon">
                            <span>
                                <img src="<%#getImagecat(Eval("CAT_ID"),Eval("CAT_IMAGE1")) %>" alt=""></span></div>
                        <a href="<%#GetLink(Eval("cat_url"),Eval("cat_seo_url"))%>">
                            <%#Eval("cat_name")%></a>
                        <asp:Repeater ID="Repeater1" runat="server" DataSource='<%# Load_Menu2(Eval("Cat_ID")) %>'>
                            <HeaderTemplate>
                                <ul>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <li><a href="<%#GetLink(Eval("cat_url"),Eval("cat_seo_url"))%>">
                                    <%#Eval("cat_name")%></a></li></ItemTemplate>
                            <FooterTemplate>
                                </ul></FooterTemplate>
                        </asp:Repeater>
                    </li>
                </ItemTemplate>
            </asp:Repeater>
        </ul>
    </div>
</div>
<!--end List All Categories-->
<script>
    $('#ic_menucate').click(function () {

        $('#mnu_bot').slideToggle();
    });
</script>
