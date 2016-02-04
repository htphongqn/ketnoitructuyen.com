<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="list-product.ascx.cs"
    Inherits="MVC_Kutun.UIs.list_product" %>
<%@ Register Src="path.ascx" TagName="path" TagPrefix="uc1" %>
<%@ Register Src="left-menu.ascx" TagName="left" TagPrefix="uc2" %>
<%@ Register Src="Seo-cate.ascx" TagName="Seo" TagPrefix="uc3" %>
<div class="path">
    <a href="/trang-chu.html">Trang chủ</a>
    <uc1:path ID="path1" runat="server" />
</div>
<div id="div_left" runat="server">
    <!--Left Col-->
    <div id="left_col" class="fl">
        <uc2:left ID="left1" runat="server" />
    </div>
    <!--end Left Col-->
</div>
<!--Right Col-->
<div id="right_col" class="fr" <%=setStyle() %>>
    <div class="box">
        <div class="box_Tab_main">
            <h1>
                <asp:Label ID="Lbtitle" runat="server" Text=""></asp:Label></h1>
            <div class="sort_area">
                Hiển thị
                    <asp:DropDownList ID="Drlimit" runat="server" Style="width: auto" onchange="changesort();">
                        <asp:ListItem Value="20">20</asp:ListItem>
                        <asp:ListItem Value="30">30</asp:ListItem>
                        <asp:ListItem Value="40">40</asp:ListItem>
                    </asp:DropDownList>
                    <asp:HiddenField ID="Hdurl" runat="server" />
                    <asp:HiddenField ID="Hdpage" runat="server" />
                    <asp:HiddenField ID="Hdparam" runat="server" />
                    <asp:HiddenField ID="Hdprice" runat="server" />
                &nbsp;&nbsp;
                Sắp xếp
                    <asp:DropDownList ID="Drsort" runat="server" Style="width: auto" onchange="changesort();">
                        <%--<asp:ListItem Value="0">Sắp xếp theo</asp:ListItem>--%>
                        <asp:ListItem Value="1">Tên: A-Z</asp:ListItem>
                        <asp:ListItem Value="2">Tên: Z-A</asp:ListItem>
                        <asp:ListItem Value="3">Giá: Cao đến thấp</asp:ListItem>
                        <asp:ListItem Value="4">Giá: Thấp đến cao</asp:ListItem>
                        <asp:ListItem Value="5">Mức giảm giá: Cao đến thấp</asp:ListItem>
                        <asp:ListItem Value="6">Mức giảm giá: Thấp đến cao</asp:ListItem>
                    </asp:DropDownList>
                </div>
        </div>
        <div class="list_products">
            <ul>
                <asp:Repeater ID="Rplistpro" runat="server">
                    <ItemTemplate>
                        <li class="item_P">
                            <!--Start Product-->
                            <div class="product">
                                <div class="boxgrid">
                                    <a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>"></a><a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>"
                                        class="img_product">
                                        <img alt=" <%#Eval("NEWS_TITLE") %>" src="<%# GetImageT(Eval("NEWS_ID"),Eval("NEWS_IMAGE3")) %>" /></a>
                                    <%-- <!--Box Caption-->
                                    <div class="boxcaption trans">
                                        <div class="nolist cf">
                                            <%#Eval("NEWS_DESC") %>
                                        </div>
                                    </div>
                                    <!--End Box Caption-->--%>
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
        </div>
        <div class="pagination">
            <asp:Literal ID="ltrPage" runat="server"></asp:Literal></div>
    </div>
    <!--Info SEO-->
    <div class="box">
        <div class="info_SEO_cate">
            <uc3:Seo ID="Seo1" runat="server" />
        </div>
    </div>
    <!--end Info SEO-->
</div>
<!--end Right Col-->
<script>
    function changesort() {
        var vl = document.getElementById("<%=Drsort.ClientID %>").value;
        var url = document.getElementById("<%=Hdurl.ClientID %>").value;
        var page = document.getElementById("<%=Hdpage.ClientID %>").value;
        var param = document.getElementById("<%=Hdparam.ClientID %>").value;
        var price = document.getElementById("<%=Hdprice.ClientID %>").value;
        var limit = document.getElementById("<%=Drlimit.ClientID %>").value;
        document.location = url + ".html?page=" + page + "&sort=" + vl + "&" + price + "&limit=" + limit;
    }
</script>
