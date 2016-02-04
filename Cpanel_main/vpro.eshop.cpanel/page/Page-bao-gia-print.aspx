<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Page-bao-gia-print.aspx.cs"
    Inherits="vpro.eshop.cpanel.page.Page_bao_gia_print" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Báo giá</title>
    <style type="text/css">
        body
        {
            padding: 0;
            margin: 0;
            font: normal 11px/1.4 "Calibri" , sans-serif;
        }
        a
        {
            text-decoration: none;
        }
        h1
        {
            color: #00b050;
            font: italic 15px "Times New Roman" , Times, serif;
            margin: 0;
        }
        h2
        {
            float: left;
            white-space: nowrap;
            color: #FF0000;
            font: 500 14px Georgia, "Times New Roman" , Times, serif;
            margin-bottom: 5px;
            margin-top:0;
        }
        .page_print
        {
            margin: 0 auto;
        }
        .info_head
        {
            clear: both;
            font-size: 12px;
        }
        p.MsoTitle
        {
            margin-bottom: .0001pt;
            text-align: center;
            font-size: 12.0pt;
            font-family: "Arial Rounded MT Bold" , "sans-serif";
            margin-left: 0pt;
            margin-right: 0pt;
            margin-top: 0pt;
        }
        p.MsoNormal
        {
            margin-bottom: .0001pt;
            font-size: 10.0pt;
            font-family: "Times New Roman" , "serif";
            margin-left: 0pt;
            margin-right: 0pt;
            margin-top: 0pt;
        }
        p.MsoBodyText3
        {
            margin-bottom: .0001pt;
            text-align: justify;
            font-size: 10.0pt;
            font-family: "CG Omega" , "sans-serif";
            margin-left: 0pt;
            margin-right: 0pt;
            margin-top: 0pt;
        }
        p.MsoBodyText
        {
            margin-bottom: .0001pt;
            font-size: 11.0pt;
            font-family: "Arial" , "sans-serif";
            margin-left: 0pt;
            margin-right: 0pt;
            margin-top: 0pt;
        }
        .style1
        {
            font-family: Arial, Helvetica, sans-serif;
        }
        .style2
        {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 5.1261e+025;
        }
        .style3
        {
            font-size: 5.1261e+025;
        }
        .style4
        {
            font-size: 12px;
        }
        .cf
        {
            clear: both;
        }
        .content_banggia
        {
            font-size: 12px;
        }
        .MsoNormalTable td
        {
            padding: 5px !important;
        }
    </style>
</head>
<body onload="print();">
    <form id="form1" runat="server">
    <div>
        <div class="page_print">
            <table width="100%">
                <tr>
                    <td width="25%" align="center">
                        <img src="../Images/logo.jpg" alt="" width="200px" height="80px" />
                    </td>
                    <td width="70%">
                        <table width="100%" border="0" style="font-size: 12px; font-weight: 500">
                            <tr>
                                <td colspan="3">
                                    <span style="color: #FF0000; font-size: 16px"><b>CHI NHÁNH CÔNG TY TNHH MTV THƯƠNG MẠI
                                        HÀ NHƯ</b></span><br />
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    Địa chỉ
                                </td>
                                <td align="center">
                                    :
                                </td>
                                <td align="left">
                                    28 Nguyễn Bá Tòng – P 11 – Q Tân Bình - Tp Hồ Chí Minh
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    Điện thoại
                                </td>
                                <td align="center">
                                    :
                                </td>
                                <td align="left">
                                    (08) 3869 1122 - Fax: (08) 3971 2658
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    ĐKKD
                                </td>
                                <td align="center">
                                    :
                                </td>
                                <td align="left">
                                    0311904294-001
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    Số tài khoản
                                </td>
                                <td align="center">
                                    :
                                </td>
                                <td align="left">
                                    0421000420447 Ngân hàng Vietcombank – Chi Nhánh Phú Thọ
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Email </th>
                                    <td align="center">
                                        :
                                    </td>
                                    <td>
                                        <a href="mailto:info@ketnoitructuyen.com " style="color: #000000">info@ketnoitructuyen.com
                                        </a>
                                    </td>
                            </tr>
                            <tr>
                                <td>
                                    Website </th>
                                    <td align="center">
                                        :
                                    </td>
                                    <td>
                                        <a href="http://ketnoitructuyen.com/" style="color: #FF0000">www.ketnoitructuyen.com</a>
                                    </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <h2>
                Đơn giản là chia sẻ</h2>
            <div class="info_head" style="width: 100%; float: left;position:relative">
                <img src="../Images/hinhnen.png" style="width:100%;height:75px;position:absolute" />
                <div style="float: left; width: 48%; height: 58px; padding-top: 15px">
                    Kính gửi:
                    <asp:Label ID="Lbname" runat="server" Text=""></asp:Label><br />
                    Email:
                    <asp:Label ID="lbemail" runat="server" Text=""></asp:Label><br />
                    Mobile:
                    <asp:Label ID="lbhp" runat="server" Text=""></asp:Label>
                </div>
                <div style="float: left; width: 12%; height: 58px;">
                </div>
                <div style="float: left; width: 40%; height: 58px; padding-top: 15px">
                    Báo giá số:
                    <asp:Label ID="Lbno" runat="server" Text=""></asp:Label><br />
                    <asp:Label ID="Lbdate" runat="server" Text=""></asp:Label>
                </div>
            </div>
            <div class="content_banggia cf">
                <p>
                    CHI NHÁNH CÔNG TY TNHH MTV THƯƠNG MẠI HÀ NHƯ là nhà cung cấp, phân phối chuyên bán
                    hàng thiết bị máy công nghiệp và nông nghiệp của tất cả các hãng sản xuất nổi tiếng
                    và có thương hiệu trên toàn thế giới. Xin chân thành cảm ơn sự tin tưởng của Quý
                    Công ty đã tạo điều kiện cho chúng tôi được cung cấp vật tư thiết bị đáp ứng nhu
                    cầu sử dụng của Quý Công ty, Quý khách hang. Chúng tôi trân trọng báo giá sản phẩm
                    yêu cầu của quý khách như sau:</p>
                <table class="MsoNormalTable" border="1" cellspacing="0" cellpadding="5" width="100%"
                    style="border-style: none; border-color: inherit; border-width: medium; border-collapse: collapse;">
                    <tr style="height: 2.5pt">
                        <td width="36" style="width: 27.15pt; border: solid windowtext 1.0pt; padding: 0pt 5.4pt 0pt 5.4pt">
                            <p class="MsoNormal" align="center" style="text-align: center; font-size: 12px;">
                                <b><span class="style2">STT
                                    <o:p></o:p>
                                </span></b>
                            </p>
                        </td>
                        <td width="229" style="border-right: 1.0pt solid windowtext; border-top: 1.0pt solid windowtext;
                            border-bottom: 1.0pt solid windowtext; width: 171.55pt; border-left: none; padding: 0pt 5.4pt 0pt 5.4pt">
                            <p class="MsoNormal" align="center" style="text-align: center; font-size: 12px;">
                                <b><span class="style2">TÊN SẢN PHẨM
                                    <o:p></o:p>
                                </span></b>
                            </p>
                        </td>
                        <td width="36" style="border-right: 1.0pt solid windowtext; border-top: 1.0pt solid windowtext;
                            border-bottom: 1.0pt solid windowtext; width: 26.65pt; border-left: none; padding: 0pt 5.4pt 0pt 5.4pt">
                            <p class="MsoNormal" align="center" style="text-align: center; font-size: 12px;">
                                <b><span class="style2">SL
                                    <o:p></o:p>
                                </span></b>
                            </p>
                        </td>
                        <td width="56" style="border-right: 1.0pt solid windowtext; border-top: 1.0pt solid windowtext;
                            border-bottom: 1.0pt solid windowtext; width: 41.95pt; border-left: none; padding: 0pt 5.4pt 0pt 5.4pt">
                            <p class="MsoNormal" align="center" style="text-align: center; font-size: 12px;">
                                <b><span class="style2">ĐVT
                                    <o:p></o:p>
                                </span></b>
                            </p>
                        </td>
                        <td width="56" style="border-right: 1.0pt solid windowtext; border-top: 1.0pt solid windowtext;
                            border-bottom: 1.0pt solid windowtext; width: 41.95pt; border-left: none; padding: 0pt 5.4pt 0pt 5.4pt">
                            <p class="MsoNormal" align="center" style="text-align: center; font-size: 12px;">
                                <b><span class="style2">VAT
                                    <o:p></o:p>
                                </span></b>
                            </p>
                        </td>
                        <td width="125" style="border-right: 1.0pt solid windowtext; border-top: 1.0pt solid windowtext;
                            border-bottom: 1.0pt solid windowtext; width: 93.9pt; border-left: none; padding: 0pt 5.4pt 0pt 5.4pt">
                            <p class="MsoNormal" align="center" style="text-align: center; font-size: 12px;">
                                <b><span class="style2">Nhà SX
                                    <o:p></o:p>
                                </span></b>
                            </p>
                        </td>
                        <td width="73" style="border-right: 1.0pt solid windowtext; border-top: 1.0pt solid windowtext;
                            border-bottom: 1.0pt solid windowtext; width: 54.85pt; border-left: none; padding: 0pt 5.4pt 0pt 5.4pt">
                            <p class="MsoNormal" align="center" style="text-align: center; font-size: 12px;">
                                <b><span class="style2">ĐƠN &nbsp;GIÁ (VNĐ)
                                    <o:p></o:p>
                                </span></b>
                            </p>
                        </td>
                        <td width="73" style="border-right: 1.0pt solid windowtext; border-top: 1.0pt solid windowtext;
                            border-bottom: 1.0pt solid windowtext; width: 54.85pt; border-left: none; padding: 0pt 5.4pt 0pt 5.4pt">
                            <p class="MsoNormal" align="center" style="text-align: center; font-size: 12px;">
                                <b><span class="style2">CK(%)
                                    <o:p></o:p>
                                </span></b>
                            </p>
                        </td>
                        <td width="88" style="border-right: 1.0pt solid windowtext; border-top: 1.0pt solid windowtext;
                            border-bottom: 1.0pt solid windowtext; width: 65.9pt; border-left: none; padding: 0pt 5.4pt 0pt 5.4pt">
                            <p class="MsoNormal" align="center" style="text-align: center; font-size: 12px;">
                                <b><span class="style2">Thành Tiền (VNĐ)
                                    <o:p></o:p>
                                </span></b>
                            </p>
                        </td>
                    </tr>
                    <asp:Repeater ID="Rpprobaogia" runat="server">
                        <ItemTemplate>
                            <tr style="height: 15.6pt">
                                <td align="center">
                                    <%#getOrder() %>
                                </td>
                                <td style="width:400px">
                                    <a href='<%# getLink(Eval("NEWS_SEO_URL")) %>' target="_blank">
                                        <%#Eval("NEWS_TITLE")%>
                                    </a>
                                </td>
                                <td align="center">
                                    <%#Eval("BGD_QUANTITY")%>
                                </td>
                                <td align="center">
                                    <%#Eval("BGD_UNIT")%>
                                </td>
                                <td align="center">
                                    <%#getVat(Eval("UNIT_ID3"))%>
                                </td>
                                <td align="center">
                                    <%# getNameCate(Eval("UNIT_ID2"))%>
                                </td>
                                <td align="right">
                                    <%# FormatMoney(Eval("BGD_PRICE"))%>
                                </td>
                                <td align="center">
                                    <%# Eval("BGD_CHIECKHAU")%>
                                </td>
                                <td align="right">
                                    <%# getAmount(Eval("BGD_PRICE"), Eval("BGD_QUANTITY"), Eval("BGD_CHIECKHAU"))%>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                    <tr>
                        <td colspan="8">
                            TỔNG CỘNG
                        </td>
                        <td align="right">
                            <asp:Label ID="Lbtotal" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="8">
                            Phí vận chuyển
                        </td>
                        <td align="right">
                            <asp:Label ID="lbShip" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="8">
                            THÀNH TIỀN
                        </td>
                        <td align="right">
                            <asp:Label ID="Lbamount" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                </table>
                <p class="MsoNormal" align="right" style="margin-bottom: 6.0pt; text-align: right;
                    font-size: 12px;">
                    <b><span style="color: red" class="style2">Số tiền bằng chữ :
                        <asp:Label ID="LbamountChar" runat="server" Text=""></asp:Label>
                        <o:p></o:p>
                    </span></b>
                </p>
                <style>
                .detailinfo *
                {
                        font-size:12px !important;
                    }
                </style>
                <table width="100%" border="1" class="detailinfo">
                    <asp:Repeater ID="Rpdetail" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td style="padding-left: 20px;font-size:12px !important">
                                    <%#showHmtl(Eval("NEWS_ID"), Eval("NEWS_FILEHTML"))%>
                                </td>
                                <td>
                                    <img src="<%#getImage(Eval("NEWS_ID"), Eval("NEWS_IMAGE3"))%>" style="width: 250px;
                                        height: 250px" />
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
               
                <p class="MsoNormal" style="margin-bottom: 0; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">
                    <o:p> &nbsp;</o:p>
                </p>
                <p class="MsoNormal" style="margin-bottom: 6.0pt; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">
                    1. Chất lượng và nguồn gốc sản phẩm
                    <o:p></o:p>
                </p>
                <p class="MsoTitle" style="text-align: justify; font-family: Arial, Helvetica, sans-serif;
                    font-size: 12px;">
                    - Hàng hóa mới 100% và đầy đủ các phụ kiện hỗ trợ sử dụng theo quy định của nhà
                    sản xuất
                    <o:p></o:p>
                </p>
                <p class="MsoTitle" style="text-align: justify; font-family: Arial, Helvetica, sans-serif;
                    font-size: 12px;">
                    - Hàng chính hãng
                    <o:p></o:p>
                </p>
                <p class="MsoTitle" style="text-align: justify; font-family: Arial, Helvetica, sans-serif;
                    font-size: 12px;">
                    2. Chế độ bảo hành &nbsp;
                    <o:p></o:p>
                </p>
                <p class="MsoTitle" style="text-align: justify; font-family: Arial, Helvetica, sans-serif;
                    font-size: 12px;">
                    - Thời gian đúng theo quy định của nhà sản xuất cho từng loại sản phẩm cụ thể.
                    <o:p></o:p>
                </p>
                <p class="MsoTitle" style="text-align: justify; font-family: Arial, Helvetica, sans-serif;
                    font-size: 12px;">
                    - Các sản phẩm bảo hành xác định do lỗi của nhà sản xuất sẽ được thay đổi sản phẩm
                    khác.
                    <o:p></o:p>
                </p>
                <p class="MsoTitle" style="text-align: justify; font-family: Arial, Helvetica, sans-serif;
                    font-size: 12px;">
                    - Thời gian bảo hành tính từ ngày giao hàng hoàn tất.
                    <o:p></o:p>
                </p>
                <p class="MsoTitle" style="text-align: justify; font-family: Arial, Helvetica, sans-serif;
                    font-size: 12px;">
                    3. Thời gian giao hàng.
                    <o:p></o:p>
                </p>
                <p class="MsoTitle" style="text-align: justify; font-family: Arial, Helvetica, sans-serif;
                    font-size: 12px;">
                    - Giao ngay khi đã hoàn tất đơn hàng hoặc được thỏa thuận giữa 2 bên mua và bán.
                    <o:p></o:p>
                </p>
                <p class="MsoTitle" style="text-align: justify; font-family: Arial, Helvetica, sans-serif;
                    font-size: 12px;">
                    - Giao trong 1 đến 2 ngày nếu khách hàng ở nội thành hoặc khu vực lân cận
                    <o:p></o:p>
                </p>
                <p class="MsoTitle" style="text-align: justify; font-family: Arial, Helvetica, sans-serif;
                    font-size: 12px;">
                    - Giao trong vòng 3 đến 4 ngày nếu khách hàng ở xa khu vực lân cận
                    <o:p></o:p>
                </p>
                <p class="MsoTitle" style="text-align: justify; font-family: Arial, Helvetica, sans-serif;
                    font-size: 12px;">
                    4. Thanh toán&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :&nbsp; Chuyển khoản trước, hoặc tiền
                    mặt
                    <o:p></o:p>
                </p>
                <p class="MsoTitle" style="text-align: justify; font-family: Arial, Helvetica, sans-serif;
                    font-size: 12px;">
                    - Hiệu lực báo giá&nbsp; : Trong vòng 7 ngày kể từ ngày gởi
                    <o:p></o:p>
                </p>
                <p class="MsoTitle" style="text-align: justify; font-family: Arial, Helvetica, sans-serif;
                    font-size: 12px;">
                    <o:p> &nbsp;</o:p>
                </p>
                <p class="MsoTitle" style="text-align: justify; font-family: Arial, Helvetica, sans-serif;
                    font-size: 12px;">
                    Cảm ơn quý khách hàng. Mong sự cộng tác dài lâu!
                    <o:p></o:p>
                </p>
                <p class="MsoTitle" style="text-align: justify; font-family: Arial, Helvetica, sans-serif;
                    font-size: 12px;">
                    Vui lòng liên hệ với chúng tôi nếu có điều gì chưa hiểu trong bảng báo giá
                    <o:p></o:p>
                </p>
                <p class="MsoTitle" style="text-align: justify; font-family: Arial, Helvetica, sans-serif;
                    font-size: 12px;">
                    Chúng tôi tin tưởng rằng bảng báo giá này sẽ đáp ứng được các yêu cầu mà Quý Công
                    ty đưa ra, và chúng tôi hy vọng sẽ được phục vụ Quý Công ty trong thời gian tới.
                    <o:p></o:p>
                </p>
                <p class="MsoTitle" style="text-align: justify; font-family: Arial, Helvetica, sans-serif;
                    font-size: 12px;">
                    Nếu Quý công ty có bất cứ yêu cầu gì, xin vui lòng liên hệ với chúng tôi.
                    <o:p></o:p>
                </p>
                <p class="MsoTitle" style="text-align: justify; font-family: Arial, Helvetica, sans-serif;
                    font-size: 12px;">
                    <o:p> &nbsp;</o:p>
                </p>
                <p class="MsoTitle" style="text-align: justify; font-family: Arial, Helvetica, sans-serif;
                    font-size: 12px;">
                    Trân trọng,&nbsp;&nbsp;&nbsp;
                    <o:p></o:p>
                </p>
                
                <div style="text-align: center">
                    <div style="float: left; width: 50%">
                        <p>
                            Phòng kinh doanh</p>
                        <p>
                            <asp:Literal ID="LitinfoEmp" runat="server"></asp:Literal>
                        </p>
                    </div>
                    <div style="float: right; width: 50%">
                        <p>
                            Xác nhận đặt hàng
                        </p>
                        <p>
                            (Ký tên và đóng dấu)
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
