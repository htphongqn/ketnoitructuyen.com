<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Master.Master" AutoEventWireup="true"
    CodeBehind="Payment-finish.aspx.cs" Inherits="MVC_Kutun.vi_vn.Payment_finish" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <asp:Literal ID="ltrFavicon" runat="server" EnableViewState="false"></asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link rel="Stylesheet" type="text/css" href="../vi-vn/Styles/process_payment.css" />
    <!--Order Success-->
    <div id="orderInfo" class="box_payment_ct">
        <div style="padding: 20px">
            <h1 class="chkSucP-orderInfo-hdl" style="margin-bottom: 10px">
                <i class="icn_social icn_social-checked_26x26"></i>
                <img width="70" height="70" src="../vi-vn/Images/succe.jpg" style="float: left; margin-right: 5px"><span
                    class="large">Chúc mừng bạn đã đặt hàng thành công.</span><br />
                Chúng tôi sẽ xử lý đơn hàng của bạn trong vòng 24h!
            </h1>
            <div class="row">
                <span class="fl">Mã đơn hàng: 
                    <asp:Label ID="Lbcode" runat="server" Text=""></asp:Label></span>
            </div>
            <div class="row">
                <div class="orderInfo_hidden fl" style="width: 20%; font-size: 1.2em" href="#">
                    <asp:Label ID="Lbcount_pro" runat="server" Text=""></asp:Label>
                    sản phẩm
                    <div class="box_hover hidden">
                        <asp:Repeater ID="Rporder" runat="server">
                            <ItemTemplate>
                                <img src="<%# GetImageT(Eval("NEWS_ID"),Eval("NEWS_IMAGE3")) %>" alt="" class="img_general"
                                    style="width: 100px" />
                                <a href="<%# GetLink(Eval("NEWS_URL"),Eval("NEWS_SEO_URL"),1) %>">
                                    <%#Eval("NEWS_TITLE") %>
                                </a><span class="overlay-price">
                                    <%#GetPrice1(Eval("News_Price1"), Eval("News_Price2"))%>
                                </span>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
                <div class="fr" style="width: 78%">
                    <span>Địa chỉ : <b>
                        <asp:Label ID="Lbaddress" runat="server" Text=""></asp:Label></b></span>
                </div>
            </div>
            <div class="row">
                <p>
                    Chúng tôi đã gởi cho bạn một email xác nhận với đầy đủ thông tin chi tiết (Vui lòng
                    kiểm tra hộp thư đến hoặc spam)</p>
            </div>
            <div class="row" style="text-align: center">
                <a href="/" class="btn_web btn_account" id="ContentPlaceHolder1_Payment_HCM">
                    Trở về trang chủ >></a>
            </div>
        </div>
    </div>
    <!--end Order Success-->
</asp:Content>
