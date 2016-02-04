<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="search-result.ascx.cs"
    Inherits="MVC_Kutun.MOBILE.UIs.search_result" %>
<div class="path">
    <a href="/">Trang chủ</a> » Tìm kiếm
</div>
<!--List Products-->
<div class="box">
    <h1 class="box_Tab">
        Tìm kiếm
    </h1>
    <div id="list_products">
        <ul>
            <asp:Repeater ID="Rpproduct" runat="server">
                <ItemTemplate>
                    <!--#item_P-->
                    <div class="item_P">
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
                            <%#Getgiam(Eval("News_Price1"), Eval("News_Price2"))%>
                        </div>
                        <!--product-->
                    </div>
                    <!--/item_P-->
                </ItemTemplate>
            </asp:Repeater>
        </ul>
    </div>
    <!--list_products-->
    <div class="navigation_news">
        <asp:Literal ID="ltrPage" runat="server"></asp:Literal>
    </div>
    <!--/box-->
</div>
