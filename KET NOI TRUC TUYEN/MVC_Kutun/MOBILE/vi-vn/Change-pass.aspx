<%@ Page Title="" Language="C#" MasterPageFile="~/MOBILE/Master/Master.Master" AutoEventWireup="true"
    CodeBehind="Change-pass.aspx.cs" Inherits="MVC_Kutun.MOBILE.vi_vn.Change_pass" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <asp:Literal ID="ltrFavicon" runat="server" EnableViewState="false"></asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="path">
        <a href="/">Trang chủ</a> » <a href="#">Đổi mật khẩu</a></div>
    <!--Login Page-->
    <div class="box" id="account">
        <div class="box_Tab">
            Đổi mật khẩu</div>
        <!--Form Login-->
        <div class="box_ct login_form form_web">
            <div class="row_account">
                <span class="left">Mật khẩu cũ : <span class="required">*</span></span>
                <asp:TextBox ID="txtpassOld" runat="server" CssClass="inputbox"  TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Chưa nhập mật khẩu củ"
                    ControlToValidate="txtpassOld" Display="Dynamic" ForeColor="Red" ValidationGroup="G5">*</asp:RequiredFieldValidator>
            </div>
            <div class="row_account">
                <span class="left">Mật khẩu mới : <span class="required">*</span></span>
                <asp:TextBox ID="txtpassNew" runat="server" CssClass="inputbox"  TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Chưa nhập mật khẩu mới"
                    ControlToValidate="txtpassNew" Display="Dynamic" ForeColor="Red" ValidationGroup="G5">*</asp:RequiredFieldValidator>
            </div>
            <div class="row_account">
                <span class="left">Nhập lại mật khẩu : <span class="required">*</span></span>
                <asp:TextBox ID="txtrepass" runat="server" CssClass="inputbox"  TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Chưa nhập lại mật khẩu "
                    ControlToValidate="txtrepass" Display="Dynamic" ForeColor="Red" ValidationGroup="G5">*</asp:RequiredFieldValidator>
            </div>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" ShowMessageBox="True"
                ShowSummary="False" ValidationGroup="G5" />
            <div class="row_account">
                <asp:LinkButton ID="Lblogins" runat="server" ValidationGroup="G5" CssClass="btn_web btn_action"
                    OnClick="Lblogins_Click"><b>Lưu</b></asp:LinkButton>
                <asp:CompareValidator ID="comparePasswords" runat="server" ControlToCompare="txtpassNew"
                    ControlToValidate="txtrepass" ErrorMessage="2 mật khẩu không giống nhau!" Display="Dynamic"
                    ForeColor="Red" />
            </div>
        </div>
        <!--End Form Login-->
    </div>
    <!--End Login Page-->
</asp:Content>
