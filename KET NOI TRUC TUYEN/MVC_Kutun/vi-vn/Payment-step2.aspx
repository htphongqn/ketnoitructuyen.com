<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Master.Master" AutoEventWireup="true"
    CodeBehind="Payment-step2.aspx.cs" Inherits="MVC_Kutun.vi_vn.Payment_step2" %>

<%@ Register Src="../UIs/cart.ascx" TagName="cart" TagPrefix="uc1" %>
<%@ Register Src="../UIs/Payment-giaohangtannoi.ascx" TagName="Payment" TagPrefix="uc2" %>
<%@ Register Src="../UIs/Payment-home.ascx" TagName="Payment" TagPrefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <asp:Literal ID="ltrFavicon" runat="server" EnableViewState="false"></asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link rel="Stylesheet" type="text/css" href="../vi-vn/Styles/process_payment.css" />
    <div class="progress-bar current-step-2">
        <ul>
            <li id="step1"><span class="number icon_step1">1</span><span class="title_step">Đăng
                nhập</span></li>
            <li class="current" id="step2"><span class="number icon_step2">2</span><span class="title_step">Thông
                tin giao hàng</span></li>
            <li id="step3"><span class="number icon_step3">3</span><span class="title_step">Cách
                thức thanh toán</span></li>
        </ul>
    </div>
    <!--Step 2-->
    <!--DatePicker Plugin-->
    <link rel="stylesheet" href="../vi-vn/Styles/BeatPicker.min.css" />
    <script src="../vi-vn/Scripts/BeatPicker.min.js"></script>
    <div class="box_payment_left process_payment fl">
        <div class="tt_payment_step">
            Thông tin giao hàng</div>
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
                    <li class="current"><a href="#tab-1" title="Giao hàng tận nơi">Giao hàng tận nơi</a></li>
                    <li><a href="#tab-2" title="Internet Banking">Nhận tại kết nối trực tuyến</a></li>
                </ul>
                <div class="tab tab_payment_ct fr">
                    <div id="tab-1" class="tab-content info_transport form_web pay-form">
                        <uc2:Payment ID="Payment1" runat="server" />
                    </div>
                    <div id="tab-2" class="tab-content info_transport form_web pay-form">
                        <uc3:Payment ID="Payment2" runat="server" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Step 2-->
    <!--Mini Cart-->
    <div id="mini_cart" class="fr">
        <div class="box_payment_ct">
            <uc1:cart ID="cart1" runat="server" />
        </div>
    </div>
    <!--end Mini Cart-->
</asp:Content>
