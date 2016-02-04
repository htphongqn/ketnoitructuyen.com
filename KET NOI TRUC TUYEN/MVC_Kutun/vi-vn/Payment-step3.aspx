<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Master.Master" AutoEventWireup="true"
    CodeBehind="Payment-step3.aspx.cs" Inherits="MVC_Kutun.vi_vn.Payment_step3" %>

<%@ Register Src="../UIs/cart.ascx" TagName="cart" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <asp:Literal ID="ltrFavicon" runat="server" EnableViewState="false"></asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link rel="Stylesheet" type="text/css" href="../vi-vn/Styles/process_payment.css" />
    <div class="progress-bar current-step-3">
        <ul>
            <li id="step1"><span class="number icon_step1">1</span><span class="title_step">Đăng
                nhập</span></li>
            <li id="step2"><span class="number icon_step2">2</span><span class="title_step">Thông
                tin giao hàng</span></li>
            <li class="current" id="step3"><span class="number icon_step3">3</span><span class="title_step">Cách
                thức thanh toán</span></li>
        </ul>
    </div>
    <!--Step 3-->
    <div class="box_payment_left process_payment fl">
        <div class="tt_payment_step">
            Cách thức thanh toán</div>
        <div class="box_payment_ct">
            <!--Tab Method Payment-->
            <script type='text/javascript'>//<![CDATA[
                $(window).load(function () {
                    $(document).ready(function () {
                        $(".tabs-menu a").click(function (event) {
                            event.preventDefault();
                            $(this).parent().addClass("current");
                            $(this).parent().siblings().removeClass("current");
                            var tab = $(this).attr("href");
                            $(".tab-content").not(tab).css("display", "none");
                            $(tab).fadeIn();
                        });
                    });
                    /* <![CDATA[ */
                    (function ($) {
                        $('a[href="#"]').click(function (e) {
                            e.preventDefault();
                        });
                    })(jQuery);
                    /* ]]> */
                });//]]>  

            </script>
            <div id="tabs-container">
                <ul class="tabs-menu tabs_payment fl">
                    <li class="current"><a href="#tab-1" title="Thanh toán bằng tiền mặt">Thanh toán bằng
                        tiền mặt</a></li>
                    <li><a href="#tab-2" title="Internet Banking">Chuyển khoản</a></li>
                </ul>
                <div class="tab tab_payment_ct fr">
                    <div id="tab-1" class="tab-content">
                        <div class="cod_page">
                            <div class="payment_wrap">
                                <div class="row">
                                    <span class="cod_info">Bạn sẽ thanh toán bằng tiền mặt khi nhận hàng tại nhà</span>
                                </div>
                                <div class="row cod_aditional_info">
                                </div>
                            </div>
                        </div>
                        <div class="payment_page">
                            <div class="billaddress_wrap">
                                <div class="row">
                                    <div class="payment_form_title">
                                        <label for="ThreeStepBillingAddressForm_isSameShipping" style="display: inline;">
                                            Địa chỉ thanh toán cũng là địa chỉ giao hàng</label>
                                    </div>
                                </div>
                                <div class="clear">
                                </div>
                            </div>
                             <div class="billaddress_wrap">
                                <div class="row">
                                    <div class="payment_form_title">
                                       <input type="checkbox"  onclick="xuathd(this);"/> Xuất hóa đơn
                                       <br />
                                       <textarea class="" rows="5" id="txthd" style="display:none;width:350px;border-radius:5px;" runat="server" clientidmode="Static" placeholder='Nội dung xuất hóa đơn'></textarea>
                                    </div>
                                </div>
                                <div class="clear">
                                </div>
                            </div>
                            <div id="place_order_default">
                                <div class="row">
                                    <asp:LinkButton ID="LbPayment" runat="server" class="btn_web btn_account" OnClick="LbPayment_Click1">Tiếp tục</asp:LinkButton>
                                </div>
                                <div class="row">
                                    <div class="cod_inform">
                                        Bạn sẽ được thông báo về tình trạng đơn hàng qua email và tin nhắn.
                                    </div>
                                </div>
                            </div>
                            <div class="newsletter">
                                <div class="row">
                                    <br>
                                    * Tôi đã đọc và đồng ý với các điều khoản sử dụng của ketnoitructuyen.com
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="tab-2" class="tab-content">
                        <!--Method Payment 2-->
                        <div class="payment_wrap">
                            <asp:Literal ID="Litbank" runat="server"></asp:Literal>
                        </div>
                        <div class="row">
                            <asp:LinkButton ID="LbPayment2" runat="server" class="btn_web btn_account" OnClick="LbPayment2_Click">Tiếp tục</asp:LinkButton>
                        </div>
                        <!--end Method Payment 2-->
                    </div>
                </div>
            </div>
            <!--End Tab Method Payment-->
        </div>
    </div>
    <!--Step 3-->
    <!--Mini Cart-->
    <div id="mini_cart" class="fr">
        <div class="box_payment_ct">
            <uc1:cart ID="cart1" runat="server" />
        </div>
    </div>
    <!--end Mini Cart-->
    <!--Dia chi giao hang-->
    <div id="info_address" class="fr">
        <div class="box_payment_ct">
            <div class="tt_payment_step">
                Giao hàng đến <a href="/thanh-toan-buoc-2.aspx" class="change_info">thay đổi</a>
            </div>
            <div class="address">
                D/c:
                <asp:Label ID="Lbaddress" runat="server" Text=""></asp:Label>
                <br />
                Số điện thoại :
                <asp:Label ID="Lbphone" runat="server" Text=""></asp:Label>
            </div>
        </div>
    </div>
    <!--end Dia chi giao hang-->
    <script>
        function xuathd(e) {
            if (e.checked) {
                $('#txthd').show();
            }
            else
                $('#txthd').hide();
        }
    </script>
</asp:Content>
