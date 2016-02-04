<%@ Page Title="" Language="C#" MasterPageFile="~/MOBILE/Master/Master.Master" AutoEventWireup="true"
    CodeBehind="User-address.aspx.cs" Inherits="MVC_Kutun.MOBILE.vi_vn.User_address" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <asp:Literal ID="ltrFavicon" runat="server" EnableViewState="false"></asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="path">
        <a href="/">Trang chủ</a> » <a href="#">Địa chỉ giao hàng</a></div>
    <!--Login Page-->
    <div class="box" id="account">
        <div class="box_Tab">
            Địa chỉ giao hàng</div>
        <!--Form Login-->
        <div class="box_ct login_form form_web">
            <div class="row_account">
                <span class="left">Địa chỉ : <span class="required">*</span></span>
                <asp:TextBox ID="Txtadd" runat="server" CssClass="inputbox"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Chưa nhập địa chỉ"
                    ControlToValidate="Txtadd" Display="Dynamic" ForeColor="Red" ValidationGroup="G5">*</asp:RequiredFieldValidator>
            </div>
            <div class="row_account">
                <span class="left">Tỉnh/TP: <span class="required">*</span></span>
                <asp:DropDownList ID="Drcity" runat="server" CssClass="inputbox" AutoPostBack="True"
                    OnSelectedIndexChanged="Drcity_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Chưa chọn thành phố"
                    ControlToValidate="Drcity" Display="Dynamic" ForeColor="Red" ValidationGroup="G5"
                    InitialValue="0">*</asp:RequiredFieldValidator>
            </div>
            <div class="row_account">
                <span class="left">Quận/Huyện: <span class="required">*</span></span>
                <asp:DropDownList ID="Drdistric" runat="server" CssClass="inputbox">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Chưa chọn quận huyện"
                    ControlToValidate="Drdistric" Display="Dynamic" ForeColor="Red" ValidationGroup="G5"
                    InitialValue="0">*</asp:RequiredFieldValidator>
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
