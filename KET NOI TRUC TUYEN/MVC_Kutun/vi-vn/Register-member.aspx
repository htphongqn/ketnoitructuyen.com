<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Master.Master" AutoEventWireup="true"
    CodeBehind="Register-member.aspx.cs" Inherits="MVC_Kutun.vi_vn.Register_member" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <asp:Literal ID="ltrFavicon" runat="server" EnableViewState="false"></asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link rel="Stylesheet" type="text/css" href="../vi-vn/Styles/process_payment.css" />
    <!--Form Register-->
    <div class="regis_form form_web">
        <div class="tt_slide_P">
            ĐĂNG KÝ THÀNH VIÊN</div>
        <!--Info Account-->
        <div class="info_account fl">
            <div class="form_header">
                Thông tin tài khoản</div>
            <div class="row_account">
                <label class="item_title" for="formEmail">
                    Email:<span class="required">*</span></label>
                <div class="right_row_account fr">
                    <input class="txtpassdangnhap" type="text" name="txtEmail" id="txtEmail" runat="server" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Chưa nhập Email"
                        ControlToValidate="txtEmail" Display="Dynamic" ForeColor="Red" ValidationGroup="G8">*</asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row_account">
                <label class="item_title" for="formPassword">
                    Mật khẩu<span class="required">*</span></label>
                <div class="right_row_account fr">
                    <input class="txtpassdangnhap" type="password" name="txtPassword1" id="txtPassword1"
                        runat="server" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Chưa nhập mật khẩu"
                        ControlToValidate="txtPassword1" Display="Dynamic" ForeColor="Red" ValidationGroup="G8">*</asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row_account">
                <label class="item_title" for="formPassword_2">
                    Xác nhận mật khẩu<span class="required">*</span></label>
                <div class="right_row_account fr">
                    <input class="txtpassdangnhap" type="password" name="txtRePassword" id="txtRePassword"
                        runat="server" />
                    <asp:RequiredFieldValidator ID="rfvRePassword" runat="server" ErrorMessage="Chưa nhập lại mật khẩu"
                        ControlToValidate="txtRePassword" Display="Dynamic" ForeColor="Red" ValidationGroup="G8">*</asp:RequiredFieldValidator>
                </div>
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
        <!--Info Member-->
        <div class="info_account fr">
            <div class="form_header font3">
                Thông tin thành viên</div>
            <div class="row_account">
                <label class="item_title" for="formFullname">
                    Họ tên:<span class="required">*</span></label>
                <div class="right_row_account fr">
                    <input class="txtpassdangnhap" type="text" name="txtName" id="txtName" runat="server" />
                    <asp:RequiredFieldValidator ID="rfvHoVaTen" runat="server" ErrorMessage="Chưa nhập họ tên"
                        ControlToValidate="txtName" Display="Dynamic" ForeColor="Red" ValidationGroup="G8">*</asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row_account">
                <label class="item_title" for="formSex">
                    Giới tính:<span class="required">*</span></label>
                <div class="right_row_account fr">
                    <asp:RadioButtonList ID="Rdsex" runat="server" class="chkbox" RepeatColumns="2">
                        <asp:ListItem Value="0" Text="Nam" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="1" Text="Nữ"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <div class="row_account">
                    <label class="item_title" for="formAddress">
                        Địa chỉ liên hệ:<span class="required">*</span></label>
                    <div class="right_row_account fr">
                        <input class="txtpassdangnhap" placeholder="Vui lòng nhập địa chỉ" type="text" name="txtadd"
                            id="txtadd" runat="server" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Chưa nhập địa chỉ"
                            ControlToValidate="txtadd" Display="Dynamic" ForeColor="Red" ValidationGroup="G8">*</asp:RequiredFieldValidator>
                    </div>
                </div>
                
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="row_account">
                            <label class="item_title" for="formCountry">
                                Tỉnh/TP:<span class="required">*</span></label>
                            <div class="right_row_account fr">
                                <asp:DropDownList ID="Drcity" runat="server" class="sl_form_web" AutoPostBack="True"
                                    OnSelectedIndexChanged="Drcity_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="row_account">
                            <label class="item_title" for="formDistrict">
                                Quận/Huyện:<span class="required">*</span></label>
                            <div class="right_row_account fr">
                                <asp:DropDownList ID="Drdistric" runat="server" class="sl_form_web">
                                </asp:DropDownList>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div class="row_account">
                    <label class="item_title" for="formPhone">
                        Điện thoại: <span class="required">*</span></label>
                    <div class="right_row_account fr">
                        <input class="txtpassdangnhap" type="text" name="txtphone" id="txtphone" runat="server" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Chưa nhập số điện thoại"
                            ControlToValidate="txtphone" Display="Dynamic" ForeColor="Red" ValidationGroup="G8">*</asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="row_account">
                    <label class="item_title" for="formCode">
                        Nhập mã chuỗi:<span class="required">*</span></label>
                    <div class="right_row_account fr">
                        <input class="txtpassdangnhap" type="text" name="txtcode" id="txtcode" style="width: 40%;
                            margin-right: 10px" runat="server" />
                        <asp:Image ID="Image1" runat="server" ImageUrl="../vi-vn/CImage.aspx" Width="170px"
                            alt="" /></div>
                </div>
                <div class="row_account">
                    <span class="floatl mvs">
                        <input type="checkbox" checked="checked" id="checkdieukhoan">
                    </span>
                    <label class="cl_red" for="RegistrationForm_newsletter">
                        Tôi đã đọc và chấp nhận điều khoản sử dụng của Kết nối trực tuyến</label>
                </div>
                <div class="row_account" style="margin-top: 20px">
                    <asp:LinkButton ID="Lbregis" runat="server" class="btn_web btn_action" OnClick="Lbregis_Click"
                        ValidationGroup="G8">Đăng ký</asp:LinkButton>
                    <a class="btn_web btn_action" href="/trang-chu.html">Bỏ qua</a>
                </div>
                <!--end Info Member-->
            </div>
        </div>
        <!--End Form Register-->
</asp:Content>
