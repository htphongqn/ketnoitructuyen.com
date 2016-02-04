<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="product-details.ascx.cs"
    Inherits="MVC_Kutun.UIs.product_details" %>
<%@ Register Src="path.ascx" TagName="path" TagPrefix="uc1" %>
<%@ Register Src="Listprososanh.ascx" TagName="Listprososanh" TagPrefix="uc2" %>
<%@ Register Src="hotline-detail.ascx" TagName="hotlinefix" TagPrefix="uc3" %>
<div class="path">
    <a href="/">Trang chủ</a>
    <uc1:path ID="path1" runat="server" />
</div>
<!--Detail Products-->
<asp:HiddenField ID="Hdscore" runat="server" ClientIDMode="Static" Value="0" />
<uc2:Listprososanh ID="Listprososanh1" runat="server" />
<!--Fancybox-->
<link href="../vi-vn/Styles/comment.css" rel="stylesheet" type="text/css" />
<script src="../vi-vn/Ajax/Ajaxsosanh.js" type="text/javascript"></script>
<script src="../vi-vn/Ajax/Ajaxlike.js" type="text/javascript"></script>
<link rel="stylesheet" href="../vi-vn/Styles/detail_product.css" type="text/css" />
<link href="../vi-vn/Styles/jquery.fancybox.css" media="all" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../vi-vn/Scripts/jquery.fancybox.js"></script>
<script type='text/javascript'>//<![CDATA[
    $(document).ready(function () {
        $(".fancybox").fancybox({
            openEffect: 'elastic',
            closeEffect: 'elastic',
            autoPlay: 'true',
            playSpeed: '4000'
        });
    });	
</script>
<div class="box">
    <div id="detail_products">
        <div class="pro_left">
            <link href="../vi-vn/Styles/cloud-zoom.css" rel="stylesheet" type="text/css" />
            <script type="text/javascript" src="../vi-vn/Scripts/cloud-zoom.1.0.2.js"></script>
            <div class="zoom-section">
                <asp:Repeater ID="Rpimg_big" runat="server">
                    <ItemTemplate>
                        <div class="zoom-small-image">
                            <a href='<%# GetImageT(Eval("NEWS_ID"),Eval("NEWS_IMG_IMAGE1")) %>' class='cloud-zoom'
                                id='zoom1' rel="position:'inside',showTitle:false,adjustX:-4,adjustY:-4" title="<%#Eval("NEWS_IMG_DESC") %>">
                                <img class="mainImage" src="<%# GetImageT(Eval("NEWS_ID"),Eval("NEWS_IMG_IMAGE1")) %>"
                                    alt='' title="<%#Eval("NEWS_IMG_DESC") %>" /></a></div>
                        <div class="zoom_area">
                            <img src="../vi-vn/Images/zoom_icon.png" style="position: absolute; top: 3px;">
                            <a class="fancybox" href="<%# GetImageT(Eval("NEWS_ID"),Eval("NEWS_IMG_IMAGE1")) %>"
                                data-fancybox-group="gallery" title="" style="margin-left: 20px;">Click to view
                                large image</a></div>
                    </ItemTemplate>
                </asp:Repeater>
                <div class="zoom-desc">
                    <ul>
                        <asp:Repeater ID="Rpimg_small" runat="server">
                            <ItemTemplate>
                                <li><a href='<%# GetImageT(Eval("NEWS_ID"),Eval("NEWS_IMG_IMAGE1")) %>' class='cloud-zoom-gallery fancybox'
                                    data-fancybox-group="gallery" title='Red' rel="useZoom: 'zoom1', smallImage: '<%# GetImageT(Eval("NEWS_ID"),Eval("NEWS_IMG_IMAGE1")) %>' ">
                                    <img class="zoom-tiny-image" src="<%# GetImageT(Eval("NEWS_ID"),Eval("NEWS_IMG_IMAGE1")) %>"
                                        alt="" /></a> </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                    <div class="cf">
                    </div>
                    <a id="prev_dtp" class="prev" href="#">&lt;</a> <a id="next_dtp" class="next" href="#">
                        &gt;</a>
                </div>
            </div>
            <!--end: #dp-thumb-->
        </div>
        <!--end: #dp-thumb-->
        <div id="dtp_info" class="fl">
            <!--Info Detail Products-->
            <div class="info_dtp_product fl">
                <div class="dtp_status brand">
                    <asp:HyperLink ID="Hyperthuonghieu" runat="server" class="img_general">
                        <asp:Image ID="Imgthuonghieu" runat="server" Width="90px" />
                    </asp:HyperLink>
                    <h1 class="h1Title">
                        <asp:Label ID="Lbnamethuonghieu" runat="server" Text="" class="title_brand"></asp:Label>
                        <br />
                        <asp:Label ID="Lbtitle_details" runat="server" Text="" class="title_pr"></asp:Label>
                    </h1>
                </div>
                <div class="dtp_status">
                    <span class="tt_status">Mã sản phẩm:</span> <b>
                        <asp:Label ID="Lbcode" runat="server" Text=""></asp:Label>
                    </b>
                </div>
                <div class="dtp_status">
                    <span class="tt_status">Bảo hành:</span> <b>
                        <asp:Label ID="Lbbaohanh" runat="server" Text=""></asp:Label>
                    </b>
                </div>
                <div class="dtp_status">
                    <span class="tt_status">Công nghệ:</span> <b>
                        <asp:Label ID="Lbcongnghe" runat="server" Text=""></asp:Label>
                    </b>
                </div>
                <div class="dtp_status">
                    <span class="tt_status">Xuất xứ:</span> <b>
                        <asp:Label ID="Lbxuatxu" runat="server" Text=""></asp:Label>
                    </b>
                </div>
                <div class="dtp_status">
                    <span class="tt_status">Trọng lượng:</span> <b>
                        <asp:Label ID="Lbweight" runat="server" Text=""></asp:Label>
                    </b>
                </div>
                <div class="dtp_status">
                    <span class="tt_status">Lượt xem:</span> <b style="color: #FF0000">
                        <asp:Label ID="Lbcount_see" runat="server" Text=""></asp:Label>
                    </b>
                </div>
                <div class="percent_reduce">
                    <asp:Label ID="Lbgiam" runat="server" Text=""></asp:Label>
                </div>
                <div class="line_dot">
                </div>
                <div class="dtp_status price_detail">
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
                <div class="line_dot">
                </div>
                <div class="dtp_status buy_function">
                    <asp:HyperLink ID="Hyperaddtocart" runat="server" class="addtocart_btn fl"><span></span></asp:HyperLink>
                    <a href="/chuyen-muc/huong-dan-mua-hang.aspx" class="product__howToBuy" target="_blank">
                        <i class="icn-howtobuy"></i>Hướng dẫn<br>
                        mua hàng</a>
                    <!--<div class="dtp_status time_transport fr"> Sẽ có tại nhà bạn trong <span>1 - 2 ngày làm việc</span><br>
            <em>(Thời gian giao hàng có thể khác nhau tùy vào địa chỉ nhận hàng)</em> </div>-->
                </div>
                <div class="dtp_status">
                    <div class="dt_support">
                        <div class="chat">
                            <asp:HyperLink ID="Hyskype" runat="server"><img src="../vi-vn/Images/skype_icon.png" alt="" /></asp:HyperLink>
                        </div>
                        <div class="order_online">
                            Đặt hàng qua điện thoại <span class="phonenumber">
                                <uc3:hotlinefix ID="hotlinefix1" runat="server" />
                            </span>
                        </div>
                    </div>
                </div>
                <div class="dtp_status">
                    <!--Rating Star-->
                    <link rel="stylesheet" href="../vi-vn/Styles/jRating.jquery.css" type="text/css" />
                    <script type="text/javascript" src="../vi-vn/Scripts/jquery.raty.js"></script>
                    <script type="text/javascript">
                        var scro = document.getElementById("Hdscore").value;
                        $(document).ready(function () {
                            $('#star').raty({
                                number: 5,
                                score: scro,
                                click: function (score, evt) {
                                    console.log(score);
                                    layso(score);
                                }
                            });
                        });
                    </script>
                    <div class="rating fl">
                        <strong>Đánh giá:</strong>
                        <div id="star">
                        </div>
                    </div>
                    <div id="fb-root" class="cf">
                    </div>
                    <script>                        (function (d, s, id) {
                            var js, fjs = d.getElementsByTagName(s)[0];
                            if (d.getElementById(id)) return;
                            js = d.createElement(s); js.id = id;
                            js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=183250451825564";
                            fjs.parentNode.insertBefore(js, fjs);
                        } (document, 'script', 'facebook-jssdk'));</script>
                    <asp:Label ID="Lbface" runat="server" Text=""></asp:Label>
                    <div class="links_more fr">
                        <asp:HyperLink ID="Hyperlike" runat="server" CssClass="addlike like_pr" Style="cursor: pointer"><span class="heart_icon"></span>Sản phẩm yêu thích</asp:HyperLink>
                        <asp:CheckBox ID="Checksosanh" runat="server" Text="So sánh" ClientIDMode="Static" />
                    </div>
                </div>
            </div>
            <!--end Info Detail Products-->
            <!--Support Detail-->
            <div class="status fr">
                <div class="status_product available fl">
                    <div>
                        <asp:Label ID="lbtinhtrang" runat="server" Text=""></asp:Label>
                    </div>
                </div>
                <div class="method_payment fr">
                    <span>THANH TOÁN KHI NHẬN HÀNG</span> <span>GIAO HÀNG MIỄN PHÍ NỘI THÀNH</span>
                </div>
                <div class="dtp_status">
                    <div class="method_payment cf" id="info_spp">
                        <asp:Literal ID="Lithotro" runat="server"></asp:Literal>
                        <i style="display: block; color: #00F; font-style: italic; padding-bottom: 10px">(Ngoài
                            giờ làm việc vui lòng đặt hàng trên website)</i>
                    </div>
                </div>
                <div class="cf">
                </div>
            </div>
            <!--End Support Detail-->
            <div class="location fr">
                <div class="box_ct">
                    <strong>Chọn địa chỉ để kiểm tra hình thức giao hàng</strong>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="dtp_status">
                                <label for="delivery_province">
                                    Tỉnh/Thành phố:</label>
                                <span class="select_item slect_location">
                                    <asp:DropDownList ID="Drarea" runat="server" AutoPostBack="True" OnSelectedIndexChanged="Drarea_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </span>
                            </div>
                            <div class="dtp_status">
                                <label for="delivery_district">
                                    Quận/Huyện:</label>
                                <span class="select_item slect_location">
                                    <asp:DropDownList ID="Drdistric" runat="server" AutoPostBack="True" OnSelectedIndexChanged="Drdistric_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </span>
                            </div>
                            <p>
                                <strong>
                                    <asp:Literal ID="Lbgiaohang" runat="server"></asp:Literal>
                                </strong>
                            </p>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
    <div class="cf">
    </div>
</div>
<!--End Detail Products-->
<div class="box">
    <!--Left Col Detail Products-->
    <div id="box_detail_left" class="fl">
        <div id="tabs-container">
            <!--Tab Detail-->
            <div class="tab_info">
                <div id="checkdiv">
                </div>
                <div class="nav">
                    <ul id="tabs_detail" class="tabs_menu tabs_detail">
                        <li class="active"><a href="#productDetails" title="Chi tiết sản phẩm">Chi tiết sản
                            phẩm</a></li>
                        <li><a href="#productInfoTechnical" title="Thông tin thương hiệu">Thông tin thương hiệu</a></li>
                        <li><a href="#productInfoHangsx" title="Đánh giá sản phẩm">Đánh giá sản phẩm</a></li>
                        <li><a href="#productCondition" title="Video sản phẩm">Video sản phẩm</a></li>
                        <li><a href="#productReviews" title="Nhận xét về sản phẩm">Nhận xét sản phẩm</a></li>
                    </ul>
                </div>
                <div id="tabs_detail_content">
                    <section id="productDetails">
                     <div class="box_ct"> 
                    <asp:Literal ID="liHtml_info" runat="server"></asp:Literal>
                    </div>
                    <div class="clearfix">
                    </div>
                    </section>
                    <section id="productInfoTechnical">
           <div class="box_Tab_cate_home">
                <div class="main_cate">
                    <span>Thông tin thương hiệu</span></div>
            </div>
             <div class="box_ct">
 <asp:Literal ID="Litthuonghieu_info" runat="server"></asp:Literal>
 </div>
          <div class="clearfix"> </div>
        </section>
                    <section id="productInfoHangsx">
           <div class="box_Tab_cate_home">
                <div class="main_cate">
                    <span>Đánh giá sản phẩm</span></div>
            </div>
  <div class="box_ct">
                   <div class="danhgia">
                        <div class="row_danhgia">
                            <label class="l_danhgia">
                                Tiêu đề<span class="required">*<asp:RequiredFieldValidator ID="rfvHoVaTen" runat="server"
                                    ErrorMessage="Chưa nhập tiêu đề" ControlToValidate="txttitle" Display="Dynamic"
                                    ForeColor="Red" ValidationGroup="G40">*</asp:RequiredFieldValidator></span>
                            </label>
                            <div class="r_danhgia">
                                <input type="text" class="input_danhgia" placeholder="Nhập tiêu đề" id="txttitle"
                                    runat="server">
                            </div>
                        </div>
                        <div class="row_danhgia">
                            <label class="l_danhgia">
                                Nội dung<span class="required">*<asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                                    runat="server" ErrorMessage="Nhận xét về sản phẩm" ControlToValidate="txtcontent"
                                    Display="Dynamic" ForeColor="Red" ValidationGroup="G40">*</asp:RequiredFieldValidator></span>
                            </label>
                            <div class="r_danhgia">
                                <textarea class="input_danhgia" cols="20" data-val="true" data-val-required="Nhập nhận xét của bạn."
                                    onblur="if ( this.value == '' ) this.value = this.defaultValue" onfocus="if ( this.value == this.defaultValue ) this.value = ''"
                                    rows="2" id="txtcontent" required="" runat="server">Nhận xét về sản phẩm</textarea>
                            </div>
                        </div>
                        <div class="row_danhgia">
                            <label class="l_danhgia">
                                Tên<span class="required">*<asp:RequiredFieldValidator ID="RequiredFieldValidator2"
                                    runat="server" ErrorMessage="Nhập tên của bạn" ControlToValidate="txtname" Display="Dynamic"
                                    ForeColor="Red" ValidationGroup="G40">*</asp:RequiredFieldValidator></span>
                            </label>
                            <div class="r_danhgia">
                                <input type="text" class="input_danhgia" placeholder="Nhập tên của bạn" id="txtname"
                                    runat="server">
                            </div>
                        </div>
                        <div class="row_danhgia">
                            <label class="l_danhgia">
                                Email<span class="required">*<asp:RequiredFieldValidator ID="RequiredFieldValidator3"
                                    runat="server" ErrorMessage="Nhập email của bạn" ControlToValidate="txtemail"
                                    Display="Dynamic" ForeColor="Red" ValidationGroup="G40">*</asp:RequiredFieldValidator></span>
                            </label>
                            <div class="r_danhgia">
                                <input type="text" class="input_danhgia" placeholder="Nhập email của bạn" id="txtemail"
                                    runat="server">
                            </div>
                        </div>
                        <div class="row_danhgia">
                            <label class="l_danhgia">
                                Mã bảo vệ<span class="required">*<asp:RequiredFieldValidator ID="RequiredFieldValidator4"
                                    runat="server" ErrorMessage="Nhập mã bảo vệ" ControlToValidate="txtcapcha" Display="Dynamic"
                                    ForeColor="Red" ValidationGroup="G40">*</asp:RequiredFieldValidator></span>
                            </label>
                            <div class="r_danhgia">
                                <asp:Image ID="Image1" runat="server" ImageUrl="../vi-vn/CImage.aspx" Width="150px" />
                                <br />
                                <input type="text" class="input_danhgia" placeholder="Nhập mã bảo vệ" id="txtcapcha"
                                    runat="server">
                            </div>
                        </div>
                        <div class="row_danhgia">
                            <asp:Button ID="btnRate" runat="server" Text="Gửi đánh giá" class="buttoncm" OnClick="btnSendrate_Click"
                                ValidationGroup="G40" />
                        </div>
                        <div class="row_danhgia">
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" ShowMessageBox="True"
                                ShowSummary="False" ValidationGroup="G40" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtemail"
                                ErrorMessage="Email Định Dạng Chưa Đúng" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                ForeColor="Red" ValidationGroup="G40"></asp:RegularExpressionValidator>
                            <asp:Label ID="lblresult" runat="server" ForeColor="Red"></asp:Label>
                        </div>
                    </div>
                    <div class="choose_star">
                        <b>Đánh giá sản phẩm</b>
                        <ul>
                            <li>
                                <asp:RadioButton ID="Rdfiverate" runat="server" class="contact_now_to_check" Checked="true"
                                    GroupName="rate" />
                                <span class="star_icon five_star"></span></li>
                            <li>
                                <asp:RadioButton ID="Rdfourrate" runat="server" class="contact_now_to_check" GroupName="rate" />
                                <span class="star_icon four_star"></span></li>
                            <li>
                                <asp:RadioButton ID="Rdthreerate" runat="server" class="contact_now_to_check" GroupName="rate" />
                                <span class="star_icon three_star"></span></li>
                            <li>
                                <asp:RadioButton ID="Rdtworate" runat="server" class="contact_now_to_check" GroupName="rate" />
                                <span class="star_icon two_star"></span></li>
                            <li>
                                <asp:RadioButton ID="Rdonerate" runat="server" class="contact_now_to_check" GroupName="rate" />
                                <span class="star_icon one_star"></span></li>
                        </ul>
                    </div>
                    <div class="cf">
                    </div>
                    <div class="comment_review">
                        <asp:Repeater ID="Rpcomment" runat="server">
                            <ItemTemplate>
                                <div style="margin-bottom: 10px" class="reviewPro">
                                    <span style="color: Red" class="userNameRev">
                                        <%#Eval("COMMENT_NAME")%></span> <span class="dateComment"><i>(<%#getDate(Eval("COMMENT_PUBLISHDATE"))%>)</i></span>
                                    <span>đánh giá <span class="star_icon <%# getRatingComment(Eval("COMMENT_RATING"))%>">
                                    </span></span>
                                    <p class="titlecm" style="font-weight: bold;">
                                        <%#Eval("COMMENT_FIELD1")%>
                                    </p>
                                    <div class="contentcm">
                                        <%#Eval("COMMENT_CONTENT")%>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                    <div class="cf">
                    </div>
                    </div>
          <div class="clearfix"> </div>
        </section>
                    <section id="productCondition">
           <div class="box_Tab_cate_home">
                <div class="main_cate">
                    <span>Video sản phẩm</span></div>
            </div>
          <div class="box_ct">
             <asp:Literal ID="Liter_video" runat="server"></asp:Literal>
             </div>
          <div class="clearfix"> </div>
        </section>
                    <section id="productReviews">
         <div class="box_Tab_cate_home">
                <div class="main_cate">
                    <span>Nhận xét sản phẩm</span></div>
            </div>
             <div class="box_ct">
            <!--Comment-->
                    <script>                        (function (d, s, id) {
                            var js, fjs = d.getElementsByTagName(s)[0];
                            if (d.getElementById(id)) return;
                            js = d.createElement(s); js.id = id;
                            js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&appId=183250451825564&version=v2.0";
                            fjs.parentNode.insertBefore(js, fjs);
                        } (document, 'script', 'facebook-jssdk'));</script>
                    <div class="fb-comments" data-href="<%=getUrlface() %>" data-numposts="5" data-colorscheme="light"
                        data-width="850">
                    </div>
                    <!--End Comment-->
                    </div>

          </section>
                </div>
            </div>
            <script type="text/javascript">
                $(document).ready(function () {
                    //Scroll Tab
                    $(document).on("scroll", onScroll);
                    $('#tabs_detail a[href^="#"]').on('click', function (e) {
                        e.preventDefault();
                        $(document).off("scroll");

                        $('#tabs_detail a').each(function () {
                            $(this).removeClass('active');
                        })
                        $(this).addClass('active');

                        var target = this.hash,
            			menu = target;
                        $target = $(target);
                        $('html, body').stop().animate({
                            'scrollTop': $target.offset().top - 50
                        }, 600, 'swing', function () {
                            //window.location.hash = target;
                            $(document).on("scroll", onScroll);
                        });
                    });
                });
                function onScroll(event) {
                    var scrollPos = $(document).scrollTop();

                    $('#tabs_detail a').each(function () {
                        var currLink = $(this);
                        var refElement = $(currLink.attr("href"));
                        if (refElement.position().top <= scrollPos && refElement.position().top + refElement.height() > scrollPos) {
                            $('#tabs_detail a').removeClass("active");
                            currLink.addClass("active");
                        }
                        else {
                            currLink.removeClass("active");
                        }
                    });
                }
            </script>
            <!---End Tab-->
        </div>
        <!--The same Products-->
        <div class="box">
            <div class="box_Tab_cate_home">
                <div class="main_cate">
                    <span>Sản phẩm tương tự</span></div>
            </div>
            <!-- Jquery Products01 -->
            <div class="box_ct">
                <div id="thesame_products" class="sl_products">
                    <ul>
                        <asp:Repeater ID="rp_sanphamcungloai" runat="server">
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
                    <a id="prev_thesameP" class="prev" href="#">&lt;</a> <a id="next_thesameP" class="next"
                        href="#">&gt;</a>
                </div>
            </div>
        </div>
        <!--End The Same Products-->
        <div class="box">
            <div class="box_Tab_cate_home">
                <div class="main_cate">
                    <span>Sản phẩm cùng hãng</span></div>
            </div>
            <!--Slide Products-->
            <div class="box_ct">
                <div id="thesame_products_hang" class="sl_products">
                    <ul>
                        <asp:Repeater ID="Rpprocunghang" runat="server">
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
                    <a id="prev_thesameP_hang" class="prev" href="#">&lt;</a> <a id="next_thesameP_hang"
                        class="next" href="#">&gt;</a>
                </div>
            </div>
            <!--end Slide Products-->
        </div>
    </div>
    <!--End Detail Product Page-->
    <!--end Left Col Detail Products-->
    <!--Other Products-->
    <script src="../vi-vn/Scripts/jquery.sticky.js"></script>
    <script>
        $(document).ready(function () {
            $(".sticky").sticky({ topSpacing: 40 });
        });
    </script>
    <div id="other_products" class="fr">
        <div class="sticky" style="width: 300px">
            <div class="box_Tab_cate_home">
                <div class="main_cate">
                    <span>Có Thể Bạn Quan Tâm</span></div>
            </div>
            <div class="box_ct_home">
                <ul>
                    <asp:Repeater ID="Rpproquantam" runat="server">
                        <ItemTemplate>
                            <li>
                                <!--Start Product-->
                                <div class="product">
                                    <h3 class="product_name">
                                        <a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>">
                                            <%#Eval("NEWS_TITLE") %></a></h3>
                                    <div class="boxgrid">
                                        <div class="priceleft">
                                            <del>
                                                <%#GetPrice2(Eval("News_Price1"), Eval("News_Price2"))%></del>
                                            <div class="price">
                                                Giá: <b>
                                                    <%#GetPrice1(Eval("News_Price1"), Eval("News_Price2"))%></b></div>
                                        </div>
                                        <div class="imgright">
                                            <a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>" class="img_product">
                                                <img alt="<%#Eval("NEWS_TITLE") %>" src="<%# GetImageT(Eval("NEWS_ID"),Eval("NEWS_IMAGE3")) %>" /></a>
                                        </div>
                                    </div>
                                    <div class="addtocart"><a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>">Xem ngay</a></div>
                                </div>
                                <!--end Start Product-->
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
        </div>
    </div>
    <!--End Other Products-->
</div>
