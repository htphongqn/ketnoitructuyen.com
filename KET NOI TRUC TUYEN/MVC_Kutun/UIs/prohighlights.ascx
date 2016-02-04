<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="proHighlights.ascx.cs"
    Inherits="MVC_Kutun.UIs.proHighlights" %>
<div id="tabs-container">
    <ul class="tabs_menu tab_home">
        <li class="active" rel="tab-1" onclick="loadproSlider(this,1);">Sản phẩm nổi bật</li>
        <li rel="tab-2" onclick="loadproSlider(this,2);">Mới được xem</li>
        <li rel="tab-3" onclick="loadproSlider(this,3);">Mới được thích</li>
        <li rel="tab-4" onclick="loadproSlider(this,4);">Mới được mua</li>
        <li rel="tab-5" onclick="loadproSlider(this,5);">Mới cập nhật</li>
        <li rel="tab-6" onclick="loadproSlider(this,6);">Sản phẩm khuyến mãi</li>
    </ul>
    <div class="tab_container">
        <div id="tab-1" class="tab_content">
            <!--Slide Products-->
            <div id="popular_products" class="sl_products">
                <ul>
                    <asp:Repeater ID="Rpprohighlight" runat="server">
                        <ItemTemplate>
                            <li>
                                <!--Start Product-->
                                <div class="product">
                                    <div class="boxgrid">
                                        <a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>"></a><a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>"
                                            class="img_product">
                                            <img alt="<%#Eval("NEWS_TITLE") %>" src="<%# GetImageT(Eval("NEWS_ID"),Eval("NEWS_IMAGE3")) %>" /></a>
                                        <!--Box Caption-->
                                        <%-- <div class="boxcaption trans">
                                            <div class="nolist cf">
                                                <%#Eval("NEWS_DESC") %>
                                            </div>
                                        </div>--%>
                                        <!--End Box Caption-->
                                    </div>
                                    <h3 class="product_name">
                                        <a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>">
                                            <%#Eval("NEWS_TITLE") %></a></h3>
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
                <div class="cf">
                </div>
                <a id="prev_popularP" class="prev" href="#">&lt;</a> <a id="next_popularP" class="next"
                    href="#">&gt;</a>
            </div>
            <!--end Slide Products-->
        </div>
        <div id="tab-2" class="tab_content">
            <!--Slide Products-->
            <div id="recently_viewed_products" class="sl_products">
                <ul>
                    <asp:Repeater ID="Rpprosee" runat="server">
                        <ItemTemplate>
                            <li>
                                <!--Start Product-->
                                <div class="product">
                                    <div class="boxgrid">
                                        <a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>"></a><a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>"
                                            class="img_product">
                                            <img alt="<%#Eval("NEWS_TITLE") %>" src="<%# GetImageT(Eval("NEWS_ID"),Eval("NEWS_IMAGE3")) %>" /></a>
                                        <!--Box Caption-->
                                        <%-- <div class="boxcaption trans">
                                            <div class="nolist cf">
                                                <%#Eval("NEWS_DESC") %>
                                            </div>
                                        </div>--%>
                                        <!--End Box Caption-->
                                    </div>
                                    <h3 class="product_name">
                                        <a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>">
                                            <%#Eval("NEWS_TITLE") %></a></h3>
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
                <div class="cf">
                </div>
                <a id="prev_recently_view" class="prev" href="#">&lt;</a> <a id="next_recently_view"
                    class="next" href="#">&gt;</a>
            </div>
            <!--end Slide Products-->
        </div>
        <div id="tab-3" class="tab_content">
            <!--Slide Products-->
            <div id="recently_liked_products" class="sl_products">
                <ul>
                    <asp:Repeater ID="Rpprolike" runat="server">
                        <ItemTemplate>
                            <li>
                                <!--Start Product-->
                                <div class="product">
                                    <div class="boxgrid">
                                        <a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>"></a><a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>"
                                            class="img_product">
                                            <img alt="<%#Eval("NEWS_TITLE") %>" src="<%# GetImageT(Eval("NEWS_ID"),Eval("NEWS_IMAGE3")) %>" /></a>
                                        <!--Box Caption-->
                                        <%--  <div class="boxcaption trans">
                                            <div class="nolist cf">
                                                <%#Eval("NEWS_DESC") %>
                                            </div>
                                        </div>--%>
                                        <!--End Box Caption-->
                                    </div>
                                    <h3 class="product_name">
                                        <a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>">
                                            <%#Eval("NEWS_TITLE") %></a></h3>
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
                <div class="cf">
                </div>
                <a id="prev_recently_like" class="prev" href="#">&lt;</a> <a id="next_recently_like"
                    class="next" href="#">&gt;</a>
            </div>
            <!--end Slide Products-->
        </div>
        <div id="tab-4" class="tab_content">
            <!--Slide Products-->
            <div id="buyed_products" class="sl_products">
                <ul>
                    <asp:Repeater ID="Rpprobuy" runat="server">
                        <ItemTemplate>
                            <li>
                                <!--Start Product-->
                                <div class="product">
                                    <div class="boxgrid">
                                        <a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>"></a><a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>"
                                            class="img_product">
                                            <img alt="<%#Eval("NEWS_TITLE") %>" src="<%# GetImageT(Eval("NEWS_ID"),Eval("NEWS_IMAGE3")) %>" /></a>
                                        <!--Box Caption-->
                                        <%--                                        <div class="boxcaption trans">
                                            <div class="nolist cf">
                                                <%#Eval("NEWS_DESC") %>
                                            </div>
                                        </div>--%>
                                        <!--End Box Caption-->
                                    </div>
                                    <h3 class="product_name">
                                        <a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>">
                                            <%#Eval("NEWS_TITLE") %></a></h3>
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
                <div class="cf">
                </div>
                <a id="prev_buyedP" class="prev" href="#">&lt;</a> <a id="next_buyedP" class="next"
                    href="#">&gt;</a>
            </div>
            <!--end Slide Products-->
        </div>
        <div id="tab-5" class="tab_content">
            <!--Slide Products-->
            <div id="updated_products" class="sl_products">
                <ul>
                    <asp:Repeater ID="Rppronew" runat="server">
                        <ItemTemplate>
                            <li>
                                <!--Start Product-->
                                <div class="product">
                                    <div class="boxgrid">
                                        <a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>"></a><a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>"
                                            class="img_product">
                                            <img alt="<%#Eval("NEWS_TITLE") %>" src="<%# GetImageT(Eval("NEWS_ID"),Eval("NEWS_IMAGE3")) %>" /></a>
                                        <!--Box Caption-->
                                        <%-- <div class="boxcaption trans">
                                            <div class="nolist cf">
                                                <%#Eval("NEWS_DESC") %>
                                            </div>
                                        </div>--%>
                                        <!--End Box Caption-->
                                    </div>
                                    <h3 class="product_name">
                                        <a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>">
                                            <%#Eval("NEWS_TITLE") %></a></h3>
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
                <div class="cf">
                </div>
                <a id="prev_updatedP" class="prev" href="#">&lt;</a> <a id="next_updatedP" class="next"
                    href="#">&gt;</a>
            </div>
            <!--end Slide Products-->
        </div>
        <div id="tab-6" class="tab_content">
            <!--Slide Products-->
            <div id="saleoff_products" class="sl_products">
                <ul>
                    <asp:Repeater ID="Rppropromostion" runat="server">
                        <ItemTemplate>
                            <li>
                                <!--Start Product-->
                                <div class="product">
                                    <div class="boxgrid">
                                        <a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>"></a><a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>"
                                            class="img_product">
                                            <img alt="<%#Eval("NEWS_TITLE") %>" src="<%# GetImageT(Eval("NEWS_ID"),Eval("NEWS_IMAGE3")) %>" /></a>
                                        <!--Box Caption-->
                                        <%--<div class="boxcaption trans">
                                            <div class="nolist cf">
                                                <%#Eval("NEWS_DESC") %>
                                            </div>
                                        </div>--%>
                                        <!--End Box Caption-->
                                    </div>
                                    <h3 class="product_name">
                                        <a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>">
                                            <%#Eval("NEWS_TITLE") %></a></h3>
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
                <div class="cf">
                </div>
                <a id="prev_saleoffP" class="prev" href="#">&lt;</a> <a id="next_saleoffP" class="next"
                    href="#">&gt;</a>
            </div>
            <!--end Slide Products-->
        </div>
    </div>
</div>
<%--<script src="../vi-vn/Ajax/Ajax-prohighlight.js" type="text/javascript"></script>--%>

