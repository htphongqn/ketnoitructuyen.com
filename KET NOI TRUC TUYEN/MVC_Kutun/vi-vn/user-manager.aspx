<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Master.Master" AutoEventWireup="true"
    CodeBehind="User-manager.aspx.cs" Inherits="MVC_Kutun.vi_vn.User_manager" %>

<%@ Register Src="../UIs/leftmenu-userinfo.ascx" TagName="leftmenu" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <asp:Literal ID="ltrFavicon" runat="server" EnableViewState="false"></asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style type="text/css">
        .input-txt
        {
            background: none repeat scroll 0 0 #FFFFFF;
            border: 1px solid #ccc;
            float: left;
            width: 358px;
            height: 30px;
            text-indent: 15px;
        }
        .profile-row .text
        {
            color: #000;
            line-height: 30px;
            width: 75%;
        }
        .profile-row .left
        {
            float: left;
            width: 25%;
            line-height: 30px;
            color: #000;
        }
        .profile-row
        {
            overflow: hidden;
        }
        .txt_in
        {
            float: left;
        }
        .inner_user_info h2
        {
            border-bottom: solid 1px #ddd;
            font-weight: bold;
            color: #333;
            padding-bottom: 5px;
            margin-bottom: 10px;
        }
        
        .change-pass
        {
            clear: left;
            float: left;
            width: 100%;
        }
        .cf
        {
            display: block;
            clear: both;
        }
        .user_2col
        {
            float: left;
            width: 50%;
        }
        .user_2col .inner_2col
        {
            border: solid 1px #ddd;
            padding: 10px;
        }
        .b_left
        {
            margin-right: 5px;
        }
        .b_right
        {
            margin-left: 5px;
        }
        .pbs
        {
            margin-left: 10px;
            font-size: 20px;
        }
        .link_user
        {
            line-height: 30px;
            white-space: nowrap;
            color: #FF6600;
        }
    </style>
    <div class="path">
        <a href="/trang-chu.html">Trang chủ</a> » Quản lý tài khoản
    </div>
    <div id="div_left" runat="server">
        <!--Left Col-->
        <div id="left_col" class="fl">
            <uc1:leftmenu ID="leftmenu1" runat="server" />
        </div>
        <!--end Left Col-->
    </div>
    <!--Right Col-->
    <div id="right_col" class="fr">
        <div class="box">
            <div class="inner_user_info">
                <p class="p">
                    <b>
                        <asp:Label ID="Lbgetting" runat="server" Text=""></asp:Label>
                    </b>
                    <br />
                    Chọn một link bên dưới để xem hay chỉnh sửa thông tin.
                </p>
                <div class="user_2col">
                    <div class="b_left inner_2col">
                        <h2>
                            <span>Thông tin cá nhân</span></h2>
                        <div>
                            <asp:Label ID="Lbname" runat="server" Text=""></asp:Label>
                            <br />
                            <asp:Label ID="Lbemail" runat="server" Text=""></asp:Label>
                            <br />
                            <a class="link_user" href="/doi-mat-khau.aspx">Thay đổi mật khẩu</a><br />
                            <a class="link_user" href="/thong-tin-ca-nhan.aspx">Chỉnh sửa</a>
                        </div>
                    </div>
                    <!--bleft end-->
                </div>
                <div class="user_2col">
                    <div class="b_right inner_2col">
                        <div class="change-pass ">
                            <h2>
                                <span>Địa chỉ giao hàng</span></h2>
                            <div>
                                <asp:Label ID="Lbadd" runat="server" Text=""></asp:Label>
                                <br />
                                <a class="link_user fr" href="/dia-chi-giao-hang.aspx">Chỉnh sửa</a>
                            </div>
                        </div>
                        <div class="cf">
                        </div>
                    </div>
                    <div class="cf">
                    </div>
                    <!--b right end-->
                </div>
            </div>
        </div>
    </div>
</asp:Content>
