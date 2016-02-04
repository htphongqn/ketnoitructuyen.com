<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="main.ascx.cs" Inherits="MVC_Kutun.MOBILE.UIs.main" %>
<link rel="stylesheet" href="../vi-vn/Styles/idangerous.swiper.css">
<script src="/MOBILE/vi-vn/Scripts/idangerous.swiper.min.js"></script>
<!--List Products-->
<div class="box">
    <h2 class="box_Tab">
        Sản phẩm nổi bật</h2>
    <div class="index_products owl-carousel" id="products_home">
        <asp:Repeater ID="RpproHighlight" runat="server">
            <ItemTemplate>
                <!--#item_P-->
                <div class="item_P" style="width: 100%">
                    <div class="product">
                        <div class="img_product">
                            <a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>">
                                <img src="<%# GetImageT(Eval("NEWS_ID"),Eval("NEWS_IMAGE3")) %>" alt="" />
                            </a>
                        </div>
                        <div class="info_P">
                            <h3 class="product_name">
                                <a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>">
                                    <%#Eval("NEWS_TITLE") %></a></h3>
                            <div class="txt_desc">
                                <div class="first_price">
                                    <del>
                                        <%#GetPrice2(Eval("News_Price1"), Eval("NEWS_PRICE2"))%></del></div>
                                <price><%#GetPrice1(Eval("News_Price1"), Eval("NEWS_PRICE2"))%></price>
                            </div>
                            <!--btn_P-->
                        </div>
                        <!--info_P-->
                       
                    </div>
                    <!--product-->
                </div>
                <!--/item_P-->
            </ItemTemplate>
        </asp:Repeater>
    </div>
    <!--/box_ct-->
</div>
<!--/box-->
<!--End List Products-->
