<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Master.Master" AutoEventWireup="true"
    CodeBehind="userinfo.aspx.cs" Inherits="MVC_Kutun.vi_vn.userinfo" %>

<%@ Register Src="../Calendar/pickerAndCalendar.ascx" TagName="pickerAndCalendar"
    TagPrefix="uc2" %>
<%@ Register Src="../UIs/leftmenu-userinfo.ascx" TagName="leftmenu" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <asp:Literal ID="ltrFavicon" runat="server" EnableViewState="false"></asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../Calendar/calendarStyle.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .input-txt
        {
            background: none repeat scroll 0 0 #FFFFFF;
            border: 1px solid #ccc;
            border-radius: 4px;
            -moz-border-radius: 4px;
            -webkit-border-radius: 4px;
            float: left;
            font-size: 15px;
            padding-bottom: 9px;
            padding-left: 5px;
            padding-top: 9px;
            width: 358px;
        }
        
        .profile-row .text
        {
            color: #000;
            line-height: 40px;
        }
        .profile-row .left
        {
            float: left;
            width: 150px;
            line-height: 41px;
            color: #000;
            margin: 10px 0;
        }
        .profile-row
        {
            clear: left;
            float: left;
            width: 100%;
            padding-top: 6px;
        }
        
        .button-change
        {
            clear: left;
            float: left;
            width: 100%;
            border-top: 1px dotted #ccc;
            margin-top: 30px;
            padding: 18px 0 25px 0;
            height: 42px;
        }
        element.style
        {
        }
        .button-change .change
        {
            width: 140px;
            height: 42px;
            text-align: center;
            line-height: 42px;
            color: #fff;
            display: inline-block;
            font-size: 167%;
            font-weight: 700;
            text-transform: uppercase;
            font-weight: 700;
            background-image: url(http://statics.kay.com.vn/images/button.png?v=1.1);
            background-repeat: no-repeat;
            background-position: 0 -640px;
            margin-right: 10px;
            float: left;
            position: relative;
        }
        .change-pass
        {
            clear: left;
            float: left;
            width: 100%;
            border-top: 1px dotted #ccc;
            margin-top: 30px;
            padding-top: 16px;
        }
        /*===============TAB=====================*/
        
        ul.tabs
        {
            margin: 0;
            padding: 0;
            float: left;
            list-style: none;
            height: 40px;
            width: 100%;
        }
        ul.tabs li
        {
            float: left;
            margin: 0;
            padding: 0;
            height: 41px;
            line-height: 40px;
            background: #9f9f9f;
            overflow: hidden;
            position: relative;
            border: 1px solid #ccc;
            border-bottom: none;
            margin-left: 10px;
        }
        ul.tabs li a
        {
            text-decoration: none;
            color: #000;
            display: block;
            font-size: 15px;
            padding: 0 30px;
            border: 1px solid #fff;
            outline: none;
            text-transform: uppercase;
        }
        ul.tabs li a:hover
        {
            background: #e3e3e3;
        }
        html ul.tabs li.active, html ul.tabs li.active a:hover
        {
            background: #fff;
            border-bottom: 1px solid #fff;
        }
        .tab_container
        {
            -moz-box-shadow: 0px 0px 10px #333;
            -webkit-box-shadow: 0px 0px 10px #333;
            box-shadow: 0px 0px 10px #333;
            -moz-border-radius-bottomright: 5px;
            -moz-border-radius-bottomleft: 5px;
            -moz-border-radius-topright: 5px;
            -khtml-border-radius-bottomright: 5px;
            -khtml-border-radius-bottomleft: 5px;
            -khtml-border-radius-topright: 5px;
            -webkit-border-bottom-right-radius: 5px;
            -webkit-border-bottom-left-radius: 5px;
            -webkit-border-top-right-radius: 5px;
            border-top: none;
            clear: both;
            float: left;
            width: 100%;
            background: #fff;
            border-top: 2px solid #ccc;
            margin-top: 1px;
        }
        .tab_content
        {
            padding: 20px;
            font-size: 14px;
            line-height: 18px;
            text-align: justify;
        }
    </style>
    <div class="path">
        <a href="/trang-chu.html">Trang chủ</a> » Thông tin cá nhân
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
            <div class="box_Tab_main">
                <h1>
                    Thông tin cá nhân</h1>
            </div>
            <div class="list_products">
                <div class="profile-row">
                    <span class="left">Email:</span>
                    <p class="text input">
                        <asp:Label ID="Lbemail" runat="server" Text="Label"></asp:Label></p>
                </div>
                <div class="profile-row">
                    <span class="left">Họ Tên: <span class="required">*</span></span>
                    <p class="text input">
                        <asp:TextBox ID="Txtname" runat="server" CssClass="input-txt" Width="250"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvHoVaTen" runat="server" ErrorMessage="Chưa nhập họ tên"
                            ControlToValidate="Txtname" Display="Dynamic" ForeColor="Red" ValidationGroup="G5">*</asp:RequiredFieldValidator>
                    </p>
                </div>
                <div class="profile-row">
                    <span class="left">Số điện thoại: <span class="required">*</span></span>
                    <p class="text input">
                        <asp:TextBox ID="Txtphone" runat="server" CssClass="input-txt" Width="250"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Chưa nhập số điện thoại"
                            ControlToValidate="Txtphone" Display="Dynamic" ForeColor="Red" ValidationGroup="G5">*</asp:RequiredFieldValidator>
                    </p>
                </div>
                <div class="profile-row">
                    <span class="left">Ngày sinh: <span class="required">*</span></span>
                    <p class="text input">
                        <uc2:pickerAndCalendar ID="pickbirth" runat="server" />
                    </p>
                </div>
                <div class="profile-row">
                    <span class="left">Giới tính: <span class="required">*</span></span>
                    <p class="text input">
                        <asp:RadioButtonList ID="Rdsex" runat="server" CssClass="input-txt" RepeatColumns="2">
                            <asp:ListItem Value="0" Text="Nam" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="1" Text="Nữ"></asp:ListItem>
                        </asp:RadioButtonList>
                    </p>
                </div>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" ShowMessageBox="True"
                    ShowSummary="False" ValidationGroup="G5" />
                <div class="profile-row button-change">
                    <asp:LinkButton ID="Lblogins" runat="server" ValidationGroup="G5" CssClass="change"
                        OnClick="Lblogins_Click" Style="background: #0278a6; -webkit-border-radius: 5px;
                        -moz-border-radius: 5px; border-radius: 5px;"><b>Lưu</b></asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
