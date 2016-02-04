<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Ajax-scroll-main.aspx.cs"
    Inherits="MVC_Kutun.vi_vn.Ajax_scroll_main" %>

<body>
    <form id="form1" runat="server">
    <asp:Repeater ID="Rpcateindex" runat="server">
        <ItemTemplate>
            <!--Category Home-->
            <div class="box">
                <div class="box_Tab_cate_home">
                    <a class="main_cate" title="<%#Eval("cat_name")%>" href="<%#GetLinkCat(Eval("cat_url"),Eval("cat_seo_url"))%>">
                        <h3>
                            <img src="<%#getImagecat(Eval("CAT_ID"),Eval("CAT_IMAGE1")) %>" alt="" /><%#Eval("cat_name")%></h3>
                    </a>
                    <ul class="link_tab_cate">
                        <asp:Repeater ID="Repeater1" runat="server" DataSource='<%#Load_caterank2(Eval("CAT_ID"),6) %>'>
                            <ItemTemplate>
                                <li><h4><a href="<%#GetLinkCat(Eval("cat_url"),Eval("cat_seo_url"))%>" class="link_tab_ajaxcate">
                                    <%#Eval("cat_name")%></a></h4></li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
                <div class="box_ct box_ct_home">
                    <div class="ads ads_left_cate fl">
                        <asp:Repeater ID="Rpadsleft" runat="server" DataSource='<%#Load_ads_cate(Eval("CAT_ID"),4) %>'>
                            <ItemTemplate>
                                <%# GetImageAd(Eval("AD_ITEM_ID"), Eval("AD_ITEM_FILENAME"), Eval("AD_ITEM_TARGET"), Eval("AD_ITEM_URL"))%>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                    <div class="product_row fr">
                        <ul>
                            <asp:Repeater ID="Repeater2" runat="server" DataSource='<%#Load_proindex(Eval("CAT_ID"),0,5) %>'>
                                <ItemTemplate>
                                    <li class="item_P">
                                        <!--Start Product-->
                                        <div class="product">
                                            <div class="boxgrid">
                                                <a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>"></a><a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>"
                                                    class="img_product">
                                                    <img alt=" <%#Eval("NEWS_TITLE") %>" src="<%# GetImageT(Eval("NEWS_ID"),Eval("NEWS_IMAGE3")) %>" /></a>
                                                <!--Box Caption-->
                                                <%-- <div class="boxcaption trans">
                                                <div class="nolist cf">
                                                    <%#Eval("NEWS_DESC") %>
                                                </div>
                                            </div>--%>
                                                <!--End Box Caption-->
                                            </div>
                                            <h2 class="product_name">
                                                <a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>">
                                                    <%#Eval("NEWS_TITLE") %></a></h2>
                                            <del>
                                                <%#GetPrice2(Eval("News_Price1"), Eval("News_Price2"))%></del>
                                            <div class="price">
                                                Giá: <b>
                                                    <%#GetPrice1(Eval("News_Price1"), Eval("News_Price2"))%></b></div>
                                            <%#getBuy(Eval("NEWS_ID"), Eval("NEWS_FIELD3"))%>
                                            <%#Getgiam(Eval("News_Price1"), Eval("News_Price2"))%>
                                        </div>
                                        <!--end Start Product-->
                                    </li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                    </div>
                </div>
            </div>
            <!--End Category Home-->
        </ItemTemplate>
    </asp:Repeater>
    </form>
</body>
</html>