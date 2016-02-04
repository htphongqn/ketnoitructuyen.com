<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Payment-giaohangtannoi.ascx.cs"
    Inherits="MVC_Kutun.MOBILE.UIs.Payment_giaohangtannoi" %>
<div class="row">
    <input class="input-text" type="text" name="formFullname" id="Txtname" placeholder="Tên đầy đủ của bạn"
        runat="server" />
    <asp:RequiredFieldValidator ID="rfvHoVaTen" runat="server" ErrorMessage="Chưa nhập họ tên"
        ControlToValidate="Txtname" Display="Dynamic" ForeColor="Red" ValidationGroup="G40">*</asp:RequiredFieldValidator>
</div>
<div class="row">
    <input class="input-text" type="text" name="formPhone" id="txtphone" placeholder="Số điện thoại"
        runat="server" />
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Vui lòng nhập số điện thoại"
        ControlToValidate="txtphone" Display="Dynamic" ForeColor="Red" ValidationGroup="G40">*</asp:RequiredFieldValidator>
</div>
<div class="row">
    <input class="input-text" type="text" name="formEmail" id="txtemail" placeholder="Email"
        runat="server" />
    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Vui lòng nhập số điện thoại"
        ControlToValidate="txtemail" Display="Dynamic" ForeColor="Red" ValidationGroup="G40">*</asp:RequiredFieldValidator>
</div>
<div class="row">
    <asp:DropDownList ID="Drcity" runat="server" class="ddlthanhphoh input-text" AutoPostBack="True"
        OnSelectedIndexChanged="Drcity_SelectedIndexChanged">
    </asp:DropDownList>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Vui lòng chọn tỉnh/thành phố"
        ControlToValidate="Drcity" Display="Dynamic" ForeColor="Red" ValidationGroup="G40"
        InitialValue="0">*</asp:RequiredFieldValidator>
</div>
<div class="row">
    <asp:DropDownList ID="Drdistric" runat="server" class="ddlthanhphoh input-text" AutoPostBack="True"
        OnSelectedIndexChanged="Drdistric_SelectedIndexChanged">
    </asp:DropDownList>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Vui lòng chọn quận/huyện"
        ControlToValidate="Drdistric" Display="Dynamic" ForeColor="Red" ValidationGroup="G40"
        InitialValue="0">*</asp:RequiredFieldValidator>
</div>
<div class="row">
    <input class="input-text" type="text" name="formAddress" id="txtadd" placeholder="Số nhà,đường,(tòa nhà),phường xã ..."
        runat="server" />
</div>
<div class="row">
    <textarea placeholder="Vui lòng điền thông tin màu sắc, kích thước, thời gian …… để chúng tôi phục vụ tốt hơn"
        id="txtnote" name="txtnote" class="input-text" style="height: 100px" runat="server"></textarea>
</div>
<div class="row">
    <p class="text-error" id="ctl00_content_pMess_HCM">
        Lưu ý: (*) là thông tin bắt buộc nhập
    </p>
</div>
<div class="row button_cart">
    <asp:LinkButton ID="lbnext" runat="server" class="btn_web button1" OnClick="lbnext_Click"
        ValidationGroup="G40">Tiếp tục</asp:LinkButton>
</div>
<div style="text-align: center">
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" ShowMessageBox="True"
        ShowSummary="False" ValidationGroup="G40" />
    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtphone"
        ErrorMessage="Số điện thoại ít nhất 10 số và không khoảng trống" SetFocusOnError="True"
        ValidationExpression="^\+?(\d[\d-. ]+)?(\([\d-. ]+\))?[\d-. ]+\d{9,40}$" ForeColor="Red"
        ValidationGroup="G40"></asp:RegularExpressionValidator>
    <br />
    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtemail"
        ErrorMessage="Email Định Dạng Chưa Đúng" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
        ForeColor="Red" ValidationGroup="G40"></asp:RegularExpressionValidator>
</div>
