<%@ Page Title="" Language="C#" MasterPageFile="~/MOBILE/Master/Master.Master" AutoEventWireup="true"
    CodeBehind="Register-member.aspx.cs" Inherits="MVC_Kutun.MOBILE.vi_vn.Register_member" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <asp:Literal ID="ltrFavicon" runat="server" EnableViewState="false"></asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="path">
        <a href="/">Trang chủ</a> » <a href="#">Đăng ký</a></div>
    <!--Login Page-->
    <div class="box" id="account">
        <div class="box_Tab">
            Đăng ký</div>
        <span class="form_subtitle"><strong>Thông tin tài khoản</strong></span>
        <!--Form Login-->
        <div class="box_ct login_form form_web">
            <div class="row_account">
                <label for="formUsername" class="item_title">
                    Email:<span class="required">*<asp:RequiredFieldValidator ID="RequiredFieldValidator4"
                        runat="server" ErrorMessage="Chưa nhập Email" ControlToValidate="txtEmail" Display="Dynamic"
                        ForeColor="Red" ValidationGroup="G8">*</asp:RequiredFieldValidator></span></label>
                <input type="text" id="txtEmail" name="txtEmail" class="inputbox" runat="server">
            </div>
            <div class="row_account">
                <label for="formPassword" class="item_title">
                    Mật khẩu<span class="required">*<asp:RequiredFieldValidator ID="RequiredFieldValidator3"
                        runat="server" ErrorMessage="Chưa nhập mật khẩu" ControlToValidate="txtPassword1"
                        Display="Dynamic" ForeColor="Red" ValidationGroup="G8">*</asp:RequiredFieldValidator></span></label>
                <input type="text" id="txtPassword1" name="txtPassword1" class="inputbox" runat="server">
            </div>
            <div class="row_account">
                <label for="formPassword" class="item_title">
                    Xác nhận mật khẩu<span class="required">*<asp:RequiredFieldValidator ID="rfvRePassword"
                        runat="server" ErrorMessage="Chưa nhập lại mật khẩu" ControlToValidate="txtRePassword"
                        Display="Dynamic" ForeColor="Red" ValidationGroup="G8">*</asp:RequiredFieldValidator></span></label>
                <input type="text" id="txtRePassword" name="txtRePassword" class="inputbox" runat="server">
            </div>
        </div>
        <span class="form_subtitle"><strong>Thông tin thành viên</strong></span>
        <div class="box_ct login_form form_web">
            <div class="row_account">
                <label for="formName" class="item_title">
                    Họ tên:<span class="required">*
                        <asp:RequiredFieldValidator ID="rfvHoVaTen" runat="server" ErrorMessage="Chưa nhập họ tên"
                            ControlToValidate="txtName" Display="Dynamic" ForeColor="Red" ValidationGroup="G8">*</asp:RequiredFieldValidator></span></label>
                <input type="text" id="txtName" name="txtName" class="inputbox" runat="server">
            </div>
            <div class="row_account">
                <asp:RadioButtonList ID="Rdsex" runat="server" class="item_title" RepeatColumns="2">
                    <asp:ListItem Value="0" Text="Nam" Selected="True"></asp:ListItem>
                    <asp:ListItem Value="1" Text="Nữ"></asp:ListItem>
                </asp:RadioButtonList>
            </div>
            <div class="row_account">
                <label for="formAdd" class="item_title">
                    Địa chỉ:<span class="required">*
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Chưa nhập địa chỉ"
                            ControlToValidate="txtadd" Display="Dynamic" ForeColor="Red" ValidationGroup="G8">*</asp:RequiredFieldValidator></span></label>
                <input type="text" id="txtadd" name="txtadd" class="inputbox" runat="server">
            </div>
            <div class="row_account">
                <label for="formTinh" class="item_title">
                    Tỉnh/TP: <span class="required">*<asp:RequiredFieldValidator ID="RequiredFieldValidator5"
                        runat="server" ErrorMessage="Thành phố" ControlToValidate="Drcity" Display="Dynamic"
                        ForeColor="Red" ValidationGroup="G8" InitialValue="0">*</asp:RequiredFieldValidator></span></label>
                <asp:DropDownList ID="Drcity" runat="server" class="selectB" AutoPostBack="True"
                    OnSelectedIndexChanged="Drcity_SelectedIndexChanged">
                </asp:DropDownList>
            </div>
            <div class="row_account">
                <label for="formQuan" class="item_title">
                    Quận/Huyện:<span class="required">*<asp:RequiredFieldValidator ID="RequiredFieldValidator6"
                        runat="server" ErrorMessage="Quận/huyện" ControlToValidate="Drdistric" Display="Dynamic"
                        ForeColor="Red" ValidationGroup="G8" InitialValue="0">*</asp:RequiredFieldValidator></span></label>
                <asp:DropDownList ID="Drdistric" runat="server" class="selectB">
                </asp:DropDownList>
            </div>
            <div class="row_account">
                <label for="formDT" class="item_title">
                    Điện thoại:<span class="required">*
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Chưa nhập số điện thoại"
                            ControlToValidate="txtphone" Display="Dynamic" ForeColor="Red" ValidationGroup="G8">*</asp:RequiredFieldValidator></span></label>
                <input type="text" id="txtphone" name="txtphone" class="inputbox" runat="server">
            </div>
            <div class="row_account">
                <label for="formCaptcha" class="item_title">
                    Mã chuỗi:<span class="required">*</span></label>
                <input type="text" id="txtcode" name="txtcode" class="inputbox" runat="server">
                <asp:Image ID="Image1" runat="server" ImageUrl="../vi-vn/CImage.aspx" Width="170px"
                    alt="" />
            </div>
            <div class="row_account">
                <input name="" type="checkbox" value="" class="fleft" /><label for="formAg" class="item_title">Tôi
                    đã đọc và đồng ý với các điều khoản của KetNoiTrucTuyen<span class="required">*</span></label>
            </div>
            <div class="row_account text" style="text-align: center">
                <asp:LinkButton ID="Lbregis" runat="server" class="btn_web btn_action" OnClick="Lbregis_Click"
                    ValidationGroup="G8" style=" width:40%; float:left">Đăng ký</asp:LinkButton>
                <a class="btn_web btn_action" href="/" style=" width:40%; float:left; margin-left:15px;">Bỏ qua</a>
            </div>
            <div style="text-align: center">
                <asp:Label ID="Labelerrors" runat="server" Text=""></asp:Label>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" ShowMessageBox="True"
                    ShowSummary="False" ValidationGroup="G8" />
                <asp:CompareValidator ID="comparePasswords" runat="server" ControlToCompare="txtPassword1"
                    ControlToValidate="txtRePassword" ErrorMessage="2 mật khẩu không giống nhau!"
                    Display="Dynamic" ForeColor="Red" />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtphone"
                    ErrorMessage="Số điện thoại ít nhất 10 số và không khoảng trống" SetFocusOnError="True"
                    ValidationExpression="^\+?(\d[\d-. ]+)?(\([\d-. ]+\))?[\d-. ]+\d{9,40}$" ForeColor="Red"
                    ValidationGroup="G8"></asp:RegularExpressionValidator>
                <br />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtemail"
                    ErrorMessage="Email Định Dạng Chưa Đúng" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                    ForeColor="Red" ValidationGroup="G8"></asp:RegularExpressionValidator>
            </div>
        </div>
        <!--End Form Login-->
    </div>
    <!--End Login Page-->
</asp:Content>
