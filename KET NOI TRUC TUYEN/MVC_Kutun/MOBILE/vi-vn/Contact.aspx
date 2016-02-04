<%@ Page Title="" Language="C#" MasterPageFile="~/MOBILE/Master/Master.Master" AutoEventWireup="true"
    CodeBehind="Contact.aspx.cs" Inherits="MVC_Kutun.MOBILE.vi_vn.Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <asp:Literal ID="ltrFavicon" runat="server" EnableViewState="false"></asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="path">
        <a href="/">Trang chủ</a> » <a href="#">Liên hệ</a></div>
    <!--Login Page-->
    <div class="box" id="account">
        <div class="box_Tab">
            Liên hệ</div>
        <!--Form Login-->
        <div class="box_ct login_form form_web">
            <div class="row_contact">
                <label class="left_row">
                    Họ tên:<span class="required">*</span></label>
                <div class="right_row">
                    <input type="text" class="inputbox" id="Txtname" runat="server">
                    <br>
                    <asp:RequiredFieldValidator ID="rfvHoVaTen" runat="server" ErrorMessage="Chưa nhập họ tên"
                        ControlToValidate="Txtname" Display="Dynamic" ForeColor="Red" ValidationGroup="G40">*</asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row_contact">
                <label class="left_row">
                    Địa chỉ:</label>
                <div class="right_row">
                    <input type="text" class="inputbox" id="Txtaddress" runat="server">
                </div>
            </div>
            <div class="row_contact">
                <label class="left_row">
                    Điện thoại:<span class="required">*</span></label>
                <div class="right_row">
                    <input type="text" class="inputbox" id="Txtphone" runat="server">
                    <br>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Chưa nhập số điện thoại"
                        ControlToValidate="Txtphone" Display="Dynamic" ForeColor="Red" ValidationGroup="G40">*</asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row_contact">
                <label class="left_row">
                    Email:<span class="required">*</span></label>
                <div class="right_row">
                    <input type="text" class="inputbox" id="txtEmail" runat="server">
                    <br>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Chưa nhập email"
                        ControlToValidate="txtEmail" Display="Dynamic" ForeColor="Red" ValidationGroup="G40">*</asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row_contact">
                <label class="left_row">
                    Tiêu đề:<span class="required">*</span></label>
                <div class="right_row">
                    <input type="text" class="inputbox" id="txttitle" runat="server">
                    <br>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Chưa nhập tiêu đề"
                        ControlToValidate="txttitle" Display="Dynamic" ForeColor="Red" ValidationGroup="G40">*</asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row_contact">
                <label class="left_row">
                    Nội dung liên hệ:<span class="required">*</span></label>
                <div class="right_row">
                    <textarea cols="45" rows="10" id="txtContent" runat="server" class="inputbox"></textarea>
                    <br>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Chưa nhập nội dung"
                        ControlToValidate="txtContent" Display="Dynamic" ForeColor="Red" ValidationGroup="G40">*</asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row_contact">
                <label class="left_row">
                    Mã bảo vệ:<span class="required">*<asp:RequiredFieldValidator ID="RequiredFieldValidator7"
                        runat="server" ErrorMessage="Chưa nhập mã bảo vệ" ControlToValidate="txtCapcha"
                        Display="Dynamic" ForeColor="Red" ValidationGroup="G40">*</asp:RequiredFieldValidator></span></label>
                <div class="right_row">
                    <input type="text" class="inputbox" id="txtCapcha" runat="server">
                </div>
            </div>
            <div class="row_contact">
                <label class="left_row">
                </label>
                <div class="right_row">
                    <asp:Image ID="Image1" runat="server" ImageUrl="../vi-vn/CImage.aspx" Width="150px" />
                </div>
            </div>
            <div class="row_contact">
                <label class="left_row">
                </label>
                <div class="right_row">
                    <asp:LinkButton ID="Lbthanhtoan" runat="server" class="btn_web send_cmt" OnClick="Lbthanhtoan_Click"
                        ValidationGroup="G40">Gửi</asp:LinkButton>
                </div>
            </div>
            <div style="text-align: center">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" ShowMessageBox="True"
                    ShowSummary="False" ValidationGroup="G40" />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmail"
                    ErrorMessage="Email Định Dạng Chưa Đúng" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                    ForeColor="Red" ValidationGroup="G40"></asp:RegularExpressionValidator>
                <br />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="Txtphone"
                    ErrorMessage="Số điện thoại định dạng chưa đúng" SetFocusOnError="True" ValidationExpression="^\+?(\d[\d-. ]+)?(\([\d-. ]+\))?[\d-. ]+\d$"
                    ForeColor="Red" ValidationGroup="G40"></asp:RegularExpressionValidator>
                <asp:Label ID="lblresult" runat="server" ForeColor="Red"></asp:Label>
            </div>
        </div>
        <!--End Form Login-->
    </div>
    <!--End Login Page-->
    <script type="text/javascript">
        function reset() {
            var name = document.getElementById("<%= Txtname.ClientID %>");
            var email = document.getElementById("<%= txtEmail.ClientID %>");
            var add = document.getElementById("<%= Txtaddress.ClientID %>");
            var desc = document.getElementById("<%= txtContent.ClientID %>");
            var phone = document.getElementById("<%= Txtphone.ClientID %>");
            var title = document.getElementById("<%= txttitle.ClientID %>");
            var capcha = document.getElementById("<%= txtCapcha.ClientID %>");
            name.value = email.value = add.value = desc.value = phone.value = title.value = capcha.value = "";
        }
    </script>
</asp:Content>
