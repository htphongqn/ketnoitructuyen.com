<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Master.Master" AutoEventWireup="true"
    CodeBehind="Check-order.aspx.cs" Inherits="MVC_Kutun.vi_vn.Check_order" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <asp:Literal ID="ltrFavicon" runat="server" EnableViewState="false"></asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../vi-vn/Styles/process_payment.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .formcode
        {
            background: none repeat scroll 0 0 #FAF9F9;
            margin: 20px auto 10px;
            overflow: hidden;
            width: 920px;
        }
        .formcode .formtitle
        {
            background: none repeat scroll 0 0 #1575BF;
            color: #FFFFFF;
            display: block;
            float: left;
            font-size: 16px;
            height: 40px;
            padding: 15px 5px 0 15px;
            width: 155px;
        }
        .formcode .forminput
        {
            float: left;
            padding: 3px 0 0 5px;
        }
        .formcode .input
        {
            border: 1px solid #CED3DC;
            float: left;
            height: 34px;
            margin: 1px 0 0 10px;
            outline: medium none;
            padding: 3px;
            width: 213px;
        }
        .item_cart .cell
        {
            border: none;
        }
    </style>
    <div class="box">
        <div class="box_Tab">
            Kiểm tra đơn hàng</div>
        <div class="formcode">
            <div style="text-align: center; color: Red">
                <asp:Label ID="Lberror" runat="server" Text=""></asp:Label>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" ShowMessageBox="True"
                    ShowSummary="False" ValidationGroup="G60" />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtemail"
                    ErrorMessage="Email Định Dạng Chưa Đúng" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                    ForeColor="Red" ValidationGroup="G60"></asp:RegularExpressionValidator>
            </div>
            <label class="formtitle">
                <strong>Nhập mã đơn hàng</strong></label>
            <div class="forminput">
                <input type="text" id="txtcode" class="input" placeholder="Thí dụ: 20150211_202" runat="server">
                <span class="verify-code-label" style="float: left; font-weight: bold; padding: 10px;">
                    Emai của bạn:</span><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                        ErrorMessage="Chưa nhập email" ControlToValidate="txtemail" Display="Dynamic"
                        ForeColor="Red" ValidationGroup="G60">*</asp:RequiredFieldValidator>
                <input type="text" id="txtemail" class="input verify_field" runat="server" validationgroup="G60">
                <asp:Button ID="Button1" runat="server" Text="Xem ngay" class="button1" Style="margin: 2px 0 5px 10px;
                    width: 160px" OnClick="Button1_Click" ValidationGroup="G60" />
            </div>
        </div>
        <div id="div_order" runat="server">
            <div id="cart_page">
                <div class="row_th_cart">
                    <h3 class="th_table_cart fl" style="width: 15%">
                        Mã
                    </h3>
                    <h3 class="th_table_cart fl" style="width: 10%">
                        Khách hàng
                    </h3>
                    <h3 class="th_table_cart fl" style="width: 10%">
                        Điện thoại
                    </h3>
                    <h3 class="th_table_cart fl" style="width: 15%">
                        Địa chỉ
                    </h3>
                    <h3 class="th_table_cart fl" style="width: 15%">
                        Ngày đặt
                    </h3>
                    <h3 class="th_table_cart fl" style="width: 15%">
                        Tổng tiền
                    </h3>
                    <h3 class="th_table_cart fl" style="width: 15%">
                        Trạng thái
                    </h3>
                </div>
                <asp:Repeater ID="Rporder" runat="server">
                    <ItemTemplate>
                        <!--Item Cart-->
                        <div class="item_cart fl" style="color: blue; text-align: center; font-weight: bold;">
                            <div class="cell" style="width: 15%">
                                <%#Eval("ORDER_CODE") %>
                            </div>
                            <div class="cell" style="width: 10%">
                                <div>
                                    <span>
                                        <%# Eval("ORDER_NAME")%></span></div>
                            </div>
                            <div class="cell" style="width: 10%">
                                <span>
                                    <%#Eval("ORDER_PHONE")%>
                                </span>
                            </div>
                            <div class="cell" style="width: 15%">
                                <span>
                                    <%#Eval("ORDER_ADDRESS")%>
                            </div>
                            <div class="cell" style="width: 15%">
                                <span>
                                    <%#getDate(Eval("ORDER_PUBLISHDATE"))%>
                            </div>
                            <div class="cell" style="width: 15%">
                                <span>
                                    <%#getMoney(Eval("ORDER_TOTAL_ALL"))%>
                            </div>
                            <div class="cell" style="width: 15%">
                                <span>
                                    <%# getOrderStatus(Eval("ORDER_STATUS"))%>
                            </div>
                        </div>
                        <!--end Item Cart-->
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</asp:Content>
