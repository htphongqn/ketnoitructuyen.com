<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="print-bao-hanh.aspx.cs"
    Inherits="vpro.eshop.cpanel.page.print_bao_hanh" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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
                            Số phiếu:
                            <asp:Label ID="lbsophieu" runat="server" Text=""></asp:Label>
                        </td>
                        <td>
                            <table width="100%" border="0" style="margin-top: -10px;">
                                <tr>
                                    <td align="right">
                                        <strong>CÔNG TY TNHH TMDV ĐT TIẾNG VANG PHƯƠNG ĐÔNG</strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Địa chỉ: 15/2 Đường C1, Cộng Hòa, P.13, Q.Tân Bình, TP.HCM
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Điện thoại: (08) - 62 67 19 19 - Email : info@happybuy.vn
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Website: www.happybuy.vn - www.sieumuanhanh.com
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
            <p style="font-size: 26px; text-align: center; font-weight: bold; margin: 0; padding: 15px 0 5px 0;">
                BIÊN NHẬN BẢO HÀNH</p>
            <p style="text-align: center; font-style: italic; margin: 0; padding: 0 0 10px 0;">
                <asp:Label ID="Lbdate" runat="server" Text=""></asp:Label>
            </p>
            <table width="100%" border="0" cellpadding="1">
                <!--=======================THÔNG TIN NGƯỜI NHẬN HÀNG===============================-->
                <tr>
                    <td colspan="2">
                        <b>THÔNG TIN</b>
                    </td>
                </tr>
                <tr>
                    <td width="20%">
                        - Tên khách hàng :
                    </td>
                    <td width="80%">
                        <asp:Label ID="lbnamekh" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        - Địa chỉ :
                    </td>
                    <td>
                        <asp:Label ID="lbadd" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        - Điện thoại :
                    </td>
                    <td>
                        <asp:Label ID="lbphone" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        - Tình trạng khi nhận :
                    </td>
                    <td>
                        <asp:Label ID="lbtinhtrang" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        - Ngày trả hàng :
                    </td>
                    <td>
                        ......./......./..........
                    </td>
                </tr>
            </table>
            <!--=======================DANH SÁCH SẢN PHẨM===============================-->
            <table width="100%" border="0" cellpadding="3" cellspacing="0" style="border-left: solid 1px #4a4a4a;
                border-bottom: solid 1px #4a4a4a; margin-top: 10px;">
                <tr>
                    <td style="background: #ccc; border-top: solid 1px #4a4a4a; border-right: solid 1px #4a4a4a;
                        text-align: center; font-weight: bold; width: 40px;">
                        Số phiếu
                    </td>
                    <td style="background: #ccc; border-top: solid 1px #4a4a4a; border-right: solid 1px #4a4a4a;
                        text-align: center; font-weight: bold; width: 60px;">
                        Mã sản phẩm
                    </td>
                    <td style="background: #ccc; border-top: solid 1px #4a4a4a; border-right: solid 1px #4a4a4a;
                        text-align: center; font-weight: bold; height: 30px;">
                        Tên sản phẩm
                    </td>
                    <td style="background: #ccc; border-top: solid 1px #4a4a4a; border-right: solid 1px #4a4a4a;
                        text-align: center; font-weight: bold; width: 90px;">
                        Số seri
                    </td>
                    <td style="background: #ccc; border-top: solid 1px #4a4a4a; border-right: solid 1px #4a4a4a;
                        text-align: center; font-weight: bold; width: 140px;">
                        Ghi chú
                    </td>
                </tr>
                <asp:Repeater ID="Rpbaohanh" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td style="border-top: solid 1px #4a4a4a; border-right: solid 1px #4a4a4a; text-align: center;">
                                <%# Eval("BH_SOPHIEU")%>
                            </td>
                            <td style="border-top: solid 1px #4a4a4a; border-right: solid 1px #4a4a4a; text-align: center;">
                                <%# Eval("NEWS_CODE")%>
                            </td>
                            <td style="border-top: solid 1px #4a4a4a; border-right: solid 1px #4a4a4a; text-align: left;">
                                <%# Eval("NEWS_TITLE")%>
                            </td>
                            <td style="border-top: solid 1px #4a4a4a; border-right: solid 1px #4a4a4a; text-align: right;">
                                <%# Eval("BH_SERI")%>
                            </td>
                            <td style="border-top: solid 1px #4a4a4a; border-right: solid 1px #4a4a4a; text-align: center;">
                                <%# Eval("BH_NOTE")%>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </table>
            <!--=======================CHỮ KÝ===============================-->
            <table width="100%" border="0" cellpadding="3" style="margin-top: 20px;">
                <tr>
                    <td width="40%" style="text-align: center">
                        <b>Người mua hàng</b>
                    </td>
                    <td width="20%">
                        &nbsp;
                    </td>
                    <td width="40%" style="text-align: center">
                        <b>Nhân viên</b>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="text-align: center">
                        Quý khách vui lòng giữ phiếu cẩn thận.Biên nhận này có giá trị trong vòng 30 ngày
                    </td>
                </tr>
            </table>
        </div>
    </div>
    </form>
</body>
</html>
