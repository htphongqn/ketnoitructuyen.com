<%@ Page Title="" Language="C#" MasterPageFile="~/MOBILE/Master/Master.Master" AutoEventWireup="true"
    CodeBehind="Payment-step3.aspx.cs" Inherits="MVC_Kutun.MOBILE.vi_vn.Payment_step3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <asp:Literal ID="ltrFavicon" runat="server" EnableViewState="false"></asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="name_web">
        KetNoiTrucTuyen.vn</h1>
    <div class="path">
        <a href="/">Trang chủ</a> » <a href="#">Thông tin giao hàng</a></div>
    <!--Cart Page-->
    <div class="bg_chk">
        <img src="/MOBILE/vi-vn/Images/bg_b_b2.png" /></div>
    <div class="box">
        <div class="box_Tab">
            <span>THANH TOÁN</span></div>
        <div class="box_ct payment_info">
            <script type="text/javascript">
                $(document).ready(function () {
                    $(".tab_content").hide();
                    $(".tab_content:first").show();

                    $("ul.tabs li").click(function () {
                        $("ul.tabs li").removeClass("active");
                        $(this).addClass("active");
                        $(".tab_content").hide();
                        var activeTab = $(this).attr("rel");
                        $("#" + activeTab).fadeIn();
                    });
                });
	
	 
            </script>
            <ul class="tabs">
                <li class="active" rel="tab1">Thanh toán khi nhận hàng</li>
                <li rel="tab2">Internet Banking</li>
            </ul>
            <div class="tab_container">
                <div id="tab1" class="tab_content">
                    <div class="cod_page">
                        <div class="payment_wrap">
                            <div class="row">
                                <span class="cod_info">Bạn sẽ thanh toán bằng tiền mặt khi nhận hàng tại nhà</span>
                            </div>
                            <div class="row cod_aditional_info">
                                <u>Lưu ý:</u> Giao hàng nhanh 1 - 2 ngày ( tùy khu vực ). Miễn phí giao hàng nội
                                thành HCM. Phụ phí hàng cồng kềnh có thể phát sinh, bạn vui lòng xem chi tiết bên
                                cạnh.
                            </div>
                        </div>
                    </div>
                    <div class="payment_page">
                        <div id="place_order_default">
                            <div class="row">
                                <asp:LinkButton ID="Lbpayment1" runat="server" class="btn_web btn_account" OnClick="Lbpayment_Click">Thanh toán</asp:LinkButton>
                            </div>
                            <div class="row">
                                <div class="cod_inform">
                                    Bạn sẽ được thông báo về tình trạng đơn hàng qua email và tin nhắn.
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- cod_page-->
                </div>
                <!-- #tab1 -->
                <div id="tab2" class="tab_content">
                    <div class="payment_wrap">
                    </div>
                    <div class="row">
                        <asp:LinkButton ID="Lbpayment" runat="server" class="btn_web btn_account" OnClick="Lbpayment_Click">Thanh toán</asp:LinkButton>
                    </div>
                </div>
            </div>
            <!-- #tab2 -->
        </div>
        <!-- .tab_container -->
    </div>
    <!--End Cart Page-->
</asp:Content>
