<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="print-kho.aspx.cs" Inherits="vpro.eshop.cpanel.page.print_kho" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>KHO</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link type="image/x-icon" href="http://gianhangvn.com/Template/GianHang/gianhangvn.ico"
        rel="shortcut icon" />
</head>
<body onload="print();">
    <form id="form1" runat="server">
    <div style="font-family: 'Times New Roman', Times, serif; font-size: 15px; text-align: left;
        width: 800px; margin-top: -10px; margin-left: -20px;">
        <div style="margin-top: 10px; margin-left: 20px">
            <div style="width: 100%; border-bottom: 1px solid #4a4a4a; padding-bottom: 10px;">
                <table width="100%" border="0">
                    <tr>
                        <td>
                            <asp:Image ID="Image_Logo" runat="server" />
                        </td>
                        <td>
                            <table width="100%" border="0" style="margin-top: -10px;">
                                <tr>
                                    <td align="right">
                                        <span style="text-transform: uppercase; font-weight: bold;">CÔNG TY TNHH MTV TM HÀ NHƯ
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Chi nhánh : 28 Nguyễn Bá Tòng, P 11 – Q Tân Bình - Tp Hồ Chí Minh
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Điện thoại : (08) 39718011 - Fax: (08) 39712658
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Website : www.ketnoitieudung.vn / ketnoitructuyen.com
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
            <p style="font-size: 26px; text-align: center; font-weight: bold; margin: 0; padding: 15px 0 5px 0;">
                <%=getTypeinvent()%></p>
            <p style="text-align: center; font-style: italic; margin: 0; padding: 0 0 10px 0;">
                <asp:Label ID="Lbdate" runat="server" Text=""></asp:Label>
            </p>
            <table width="100%" border="0" cellpadding="1">
                <!--=======================THÔNG TIN NGƯỜI NHẬN HÀNG===============================-->
                <tr>
                    <td colspan="3">
                        <b>Kết nối tốt nhất giữa người mua và người bán</b>
                    </td>
                </tr>
                <tr>
                    <td width="20%" align="left">
                        Khách hàng
                    </td>
                    <td width="70%" align="left">
                        <asp:Label ID="Lbname" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        Địa chỉ
                    </td>
                    <td>
                        <asp:Label ID="Lbadd" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        Ghi chú
                    </td>
                    <td>
                        <asp:Label ID="Lbnote" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
            </table>
            <!--=======================DANH SÁCH SẢN PHẨM===============================-->
            <table width="100%" border="0" cellpadding="3" cellspacing="0" style="border-left: solid 1px #4a4a4a;
                border-bottom: solid 1px #4a4a4a; margin-top: 10px;">
                <tr>
                    <td style="background: #ccc; border-top: solid 1px #4a4a4a; border-right: solid 1px #4a4a4a;
                        text-align: center; font-weight: bold; width: 40px;">
                        STT
                    </td>
                    <td style="background: #ccc; border-top: solid 1px #4a4a4a; border-right: solid 1px #4a4a4a;
                        text-align: center; font-weight: bold; width: 60px;">
                        MÃ SP
                    </td>
                    <td style="background: #ccc; border-top: solid 1px #4a4a4a; border-right: solid 1px #4a4a4a;
                        text-align: center; font-weight: bold; width: 60px;">
                        ĐVT
                    </td>
                    <td style="background: #ccc; border-top: solid 1px #4a4a4a; border-right: solid 1px #4a4a4a;
                        text-align: center; font-weight: bold; height: 30px;">
                        TÊN SẢN PHẨM
                    </td>
                    <td style="background: #ccc; border-top: solid 1px #4a4a4a; border-right: solid 1px #4a4a4a;
                        text-align: center; font-weight: bold; width: 110px;">
                        Số lượng
                    </td>
                    <td style="background: #ccc; border-top: solid 1px #4a4a4a; border-right: solid 1px #4a4a4a;
                        text-align: center; font-weight: bold; width: 90px;">
                        Giá
                    </td>
                    <td style="background: #ccc; border-top: solid 1px #4a4a4a; border-right: solid 1px #4a4a4a;
                        text-align: center; font-weight: bold; width: 90px;">
                        Chiếc khấu
                    </td>
                    <td style="background: #ccc; border-top: solid 1px #4a4a4a; border-right: solid 1px #4a4a4a;
                        text-align: center; font-weight: bold; width: 90px;">
                        Thành tiền
                    </td>
                </tr>
                <asp:Repeater ID="Rpkho" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td style="border-top: solid 1px #4a4a4a; border-right: solid 1px #4a4a4a; text-align: center;">
                                <%#setOrder() %>
                            </td>
                            <td style="border-top: solid 1px #4a4a4a; border-right: solid 1px #4a4a4a; text-align: center;">
                                <%# Eval("NEWS_CODE")%>
                            </td>
                            <td style="border-top: solid 1px #4a4a4a; border-right: solid 1px #4a4a4a; text-align: left;">
                                <%# Eval("NEWS_TITLE")%>
                            </td>
                            <td style="border-top: solid 1px #4a4a4a; border-right: solid 1px #4a4a4a; text-align: center;">
                                Cái
                            </td>
                            <td style="border-top: solid 1px #4a4a4a; border-right: solid 1px #4a4a4a; text-align: right;">
                                <%# Eval("INVENT_QUANTITY")%>
                            </td>
                            <td style="border-top: solid 1px #4a4a4a; border-right: solid 1px #4a4a4a; text-align: center;">
                                <%# formatMoney(Eval("INVENT_PRICE"))%>
                            </td>
                            <td style="border-top: solid 1px #4a4a4a; border-right: solid 1px #4a4a4a; text-align: center;">
                                <%# Eval("INVENT_CHIECKHAU")%>
                            </td>
                            <td style="border-top: solid 1px #4a4a4a; border-right: solid 1px #4a4a4a; text-align: center;">
                                <%# totalMoney(Eval("INVENT_PRICE"),Eval("INVENT_CHIECKHAU"),Eval("INVENT_QUANTITY"))%>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
                <tr>
                    <td>
                    </td>
                </tr>
            </table>
            <!--=======================CHỮ KÝ===============================-->
            <table width="100%" border="0" cellpadding="4" style="margin-top: 20px;">
                <tr>
                    <td width="25%" style="text-align: center">
                        <b>Người nhận</b> <br /><i>(Ký và ghi rõ họ tên)</i>
                    </td>
                    <td width="25%" style="text-align: center">
                        <b>Người giao</b> <br /><i>(Ký và ghi rõ họ tên)</i>
                    </td>
                    <td width="25%" style="text-align: center">
                        <b>Người lập</b><br /> <i>(Ký và ghi rõ họ tên)</i>
                    </td>
                    <td width="25%" style="text-align: center">
                        <b>Kế toán</b> <br /><i>(Ký và ghi rõ họ tên)</i>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    </form>
</body>
</html>
