<%@ Page Title="" Language="C#" MasterPageFile="~/MOBILE/Master/Master.Master" AutoEventWireup="true"
    CodeBehind="userinfo.aspx.cs" Inherits="MVC_Kutun.MOBILE.vi_vn.userinfo" %>

<%@ Register Src="../../Calendar/pickerAndCalendar.ascx" TagName="pickerAndCalendar"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <asp:Literal ID="ltrFavicon" runat="server" EnableViewState="false"></asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../../Calendar/calendarStyle.css" rel="stylesheet" type="text/css" />
    <div class="path">
        <a href="/">Trang chủ</a> » <a href="#">Thông tin cá nhân</a></div>
    <!--Login Page-->
    <div class="box" id="account">
        <div class="box_Tab">
            Thông tin cá nhân</div>
        <!--Form Login-->
        <div class="box_ct login_form form_web">
            <div class="row_account">
                <span class="left">Email:</span>
                <asp:Label ID="Lbemail" runat="server" Text="Label"></asp:Label>
            </div>
            <div class="row_account">
                <span class="left">Họ Tên: <span class="required">*</span></span>
                <asp:TextBox ID="Txtname" runat="server" class="inputbox"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvHoVaTen" runat="server" ErrorMessage="Chưa nhập họ tên"
                    ControlToValidate="Txtname" Display="Dynamic" ForeColor="Red" ValidationGroup="G5">*</asp:RequiredFieldValidator>
            </div>
            <div class="row_account">
                <span class="left">Số điện thoại: <span class="required">*</span></span>
                <asp:TextBox ID="Txtphone" runat="server" class="inputbox"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Chưa nhập số điện thoại"
                    ControlToValidate="Txtphone" Display="Dynamic" ForeColor="Red" ValidationGroup="G5">*</asp:RequiredFieldValidator>
            </div>
            <div class="row_account">
                <span class="left">Ngày sinh: <span class="required">*</span></span>
                <uc1:pickerAndCalendar ID="pickbirth" runat="server" CssClass="inputbox" />
            </div>
            <div class="row_account">
                <span class="left">Giới tính: <span class="required">*</span></span>
                <asp:RadioButtonList ID="Rdsex" runat="server" CssClass="inputbox" RepeatColumns="2">
                    <asp:ListItem Value="0" Text="Nam" Selected="True"></asp:ListItem>
                    <asp:ListItem Value="1" Text="Nữ"></asp:ListItem>
                </asp:RadioButtonList>
            </div>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" ShowMessageBox="True"
                ShowSummary="False" ValidationGroup="G5" />
            <div class="row_account">
                <asp:LinkButton ID="Lblogins" runat="server" ValidationGroup="G5" CssClass="btn_web btn_action"
                    OnClick="Lblogins_Click"><b>Lưu</b></asp:LinkButton>
            </div>
        </div>
        <!--End Form Login-->
    </div>
    <!--End Login Page-->
</asp:Content>
