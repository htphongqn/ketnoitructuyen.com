<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="product-detail.ascx.cs"
    Inherits="MVC_Kutun.MOBILE.UIs.product_detail" %>
<%@ Register Src="path.ascx" TagName="path" TagPrefix="uc1" %>
<div class="path">
    <a href="/">Trang chủ</a><uc1:path ID="path1" runat="server" />
</div>
<!--Slider banner-->
<div class="callbacks_container" id="slide_dt_P">
    <ul class="rslides" id="slider4">
        <asp:Repeater ID="Rpimg" runat="server">
            <ItemTemplate>
                <li>
                    <img src="<%# GetImageT(Eval("NEWS_ID"),Eval("NEWS_IMG_IMAGE1")) %>"></li>
            </ItemTemplate>
        </asp:Repeater>
    </ul>
</div>
<!-- End Slider banner -->
<!--Detail Products-->
<div class="box">
    <div id="dtp_info">
        <h1 class="h1Title">
            <asp:Label ID="Lbtitle_details" runat="server" Text=""></asp:Label></h1>
        <div class="fl" id="info_dtp_product">
            <!--end: .dtp_status-->
            <div class="dtp_status">
                <span class="title_status">Mã sản phẩm:</span> <b>
                    <asp:Label ID="lbcode" runat="server" Text=""></asp:Label></b></div>
            <!--end: .dtp_status-->
            <div class="dtp_status">
                <span class="title_status">Bảo hành:</span> <b>
                    <asp:Label ID="Lbbaohanh" runat="server" Text=""></asp:Label></b></div>
            <!--end: .dtp_status-->
            <div class="dtp_status">
                <span class="title_status">Xuất xứ:</span> <b>
                    <asp:Label ID="Lbxuatxu" runat="server" Text=""></asp:Label></b></div>
            <div class="dtp_status">
                <span class="title_status">Trọng lượng:</span> <b>
                    <asp:Label ID="Lbweight" runat="server" Text=""></asp:Label></b></div>
            <div class="dtp_status">
                <span class="title_status">Thương hiệu:</span> <b>
                    <asp:HyperLink ID="Hyperthuonghieu" runat="server"></asp:HyperLink></b></div>
            <div class="dtp_status price_detail" style="border-top: 1px dotted #555555; border-bottom: 1px dotted #555555;">
                <div class="origin">
                </div>
                <div class="col_detail fl">
                    <p>
                        Giá bán (
                        <asp:Label ID="Lbvat" runat="server" Text=""></asp:Label>
                        )</p>
                    <p class="cost">
                        <asp:Label ID="Lbprice_buy" runat="server" Text=""></asp:Label>
                    </p>
                </div>
                <div class="col_detail fl">
                    <p>
                        <span class="f_price"><del>
                            <asp:Label ID="Lbprice_goc" runat="server" Text=""></asp:Label>
                        </del></span>
                    </p>
                    <p id="div_tietkiem" runat="server">
                        Tiết kiệm<br />
                        <strong>
                            <asp:Label ID="lbPricetietkiem" runat="server" Text=""></asp:Label>
                            =
                            <asp:Label ID="Lbpricepointtietkiem" runat="server" Text=""></asp:Label>
                        </strong>
                    </p>
                </div>
            </div>
            <!--end: .dtp_status-->
            <div class="btn_addtocart">
                <asp:HyperLink ID="Hyperaddtocart" runat="server" class="cart_btn"></asp:HyperLink>
            </div>
            <div class="dtp_status">
                <div id="fb-root">
                </div>
                <script>                    (function (d, s, id) {
                        var js, fjs = d.getElementsByTagName(s)[0];
                        if (d.getElementById(id)) return;
                        js = d.createElement(s); js.id = id;
                        js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=183250451825564";
                        fjs.parentNode.insertBefore(js, fjs);
                    } (document, 'script', 'facebook-jssdk'));</script>
                <asp:Label ID="Lbface" runat="server" Text=""></asp:Label></div>
        </div>
        <div class="status">
            <div class="status_product available">
                <asp:Label ID="lbtinhtrang" runat="server" Text=""></asp:Label>
            </div>
            <div class="method_payment fr">
                <span>THANH TOÁN KHI NHẬN HÀNG</span> <span>GIAO HÀNG MIỄN PHÍ NỘI THÀNH</span>
            </div>
            <div class="cf">
            </div>
        </div>
        <div class="box_ct ship_info">
            <p>
                Chọn địa chỉ của bạn để kiểm tra thời gian giao hàng dự kiến
            </p>
            <div class="row">
                <asp:DropDownList ID="Drarea" runat="server" CssClass="ddlthanhphoh input-text" AutoPostBack="True"
                    OnSelectedIndexChanged="Drarea_SelectedIndexChanged">
                </asp:DropDownList>
            </div>
            <div class="row">
                <asp:DropDownList ID="Drdistric" runat="server" AutoPostBack="True" OnSelectedIndexChanged="Drdistric_SelectedIndexChanged">
                </asp:DropDownList>
            </div>
            <div class="row">
                <asp:Literal ID="Lbgiaohang" runat="server"></asp:Literal>
            </div>
        </div>
    </div>
</div>
<!--End Detail Products-->
<!--Thong_tin_chi_tiet-->
<script type="text/javascript">
    $(document).ready(function () {
        $(".tab_content").hide();
        $(".tab_content:first").show();

        $("ul.tabs_info_pro li").click(function () {
            $("ul.tabs_info_pro li").removeClass("active");
            $(this).addClass("active");
            $(".tab_content").hide();
            var activeTab = $(this).attr("rel");
            $("#" + activeTab).fadeIn();
        });
    }); 
</script>
<div class="box">
    <ul class="tabs_info_pro">
        <li class="active" rel="tab1">Chi tiết sản phẩm</li>
        <li rel="tab2">Thông tin nhãn hiệu</li>
    </ul>
    <div class="tab_container info_pro">
        <div id="tab1" class="tab_content ">
            <div class="box_ct" id="info_g">
                <asp:Literal ID="liHtml_info" runat="server"></asp:Literal>
            </div>
            <!--box_ct-->
        </div>
        <!-- #tab1 -->
        <div id="tab2" class="tab_content">
            <asp:Literal ID="Litthuonghieu_info" runat="server"></asp:Literal>
        </div>
        <!-- #tab2 -->
    </div>
    <!-- #tab2 -->
</div>
<!-- .tab_container -->
<div class="box">
    <h2 class="box_Tab">
        Sản phẩm tương tự</h2>
    <div class="index_products owl-carousel" id="products_similar">
        <asp:Repeater ID="rp_sanphamcungloai" runat="server">
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
                        <%--<%#Getgiam(Eval("News_Price1"), Eval("News_Price2"))%>--%>
                    </div>
                    <!--product-->
                </div>
                <!--/item_P-->
            </ItemTemplate>
        </asp:Repeater>
    </div>
    <!--/box_ct-->
</div>
