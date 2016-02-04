<%@ Page Title="" Language="C#" MasterPageFile="~/MOBILE/Master/Master.Master" AutoEventWireup="true"
    CodeBehind="User-manager.aspx.cs" Inherits="MVC_Kutun.MOBILE.vi_vn.User_manager" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <asp:Literal ID="ltrFavicon" runat="server" EnableViewState="false"></asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="box">
        <div class="box_Tab tab_home">
            Chào
            <asp:Label ID="Lbname" runat="server" Text=""></asp:Label></div>
        <div class="box_ct" id="all_categories">
            <ul>
                <li><a target="_parent" href="/m-doi-mat-khau.aspx">Đổi mật khẩu</a> </li>
                <li><a target="_parent" href="/m-thong-tin-ca-nhan.aspx">Thông tin cá nhân</a> </li>
                <li><a target="_parent" href="/m-dia-chi-giao-hang.aspx">Địa chỉ giao hàng</a> </li>
                 <li>
                     <asp:LinkButton ID="Lblogout" runat="server" onclick="Lblogout_Click">Đăng xuất</asp:LinkButton>
                 </li>
            </ul>
        </div>
    </div>
</asp:Content>
