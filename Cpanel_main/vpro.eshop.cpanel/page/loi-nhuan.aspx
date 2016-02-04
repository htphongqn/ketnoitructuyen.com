<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="loi-nhuan.aspx.cs" Inherits="vpro.eshop.cpanel.page.loi_nhuan" %>

<%@ Register Assembly="DevExpress.Web.ASPxGridView.v12.1.Export, Version=12.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView.Export" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v12.1, Version=12.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v12.1, Version=12.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Lợi nhuận | Vpro.Eshop</title>
    <script language="javascript">
				<!--
        function ToggleAll(e, action) {
            if (e.checked) {
                CheckAll();
            }
            else {
                ClearAll();
            }
        }

        function CheckAll() {
            var ml = document.forms[0];
            var len = ml.elements.length;
            for (var i = 1; i < len; i++) {
                var e = ml.elements[i];

                if (e.name.toString().indexOf("chkSelect") > 0)
                    e.checked = true;
            }
            ml.MainContent_GridItemList_toggleSelect.checked = true;
        }

        function ClearAll() {
            var ml = document.forms[0];
            var len = ml.elements.length;
            for (var i = 1; i < len; i++) {
                var e = ml.elements[i];
                if (e.name.toString().indexOf("chkSelect") > 0)
                    e.checked = false;
            }
            ml.MainContent_GridItemList_toggleSelect.checked = false;
        }
				    
				// -->
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="icon_function_parent">
        <div class="icon_function_Child">
            <asp:LinkButton ID="Lbexport" runat="server" OnClick="Lbexport_Click"><img src="../Images/send_mail.png" width="30" height="30" style="border: 0px" />             
                <div>
                    Export excel</div>
            </asp:LinkButton>
        </div>
        <div class="icon_function_Child">
            <asp:LinkButton ID="Lbexprortpdf" runat="server" OnClick="Lbexprortpdf_Click"><img src="../Images/send_mail.png" width="30" height="30" style="border: 0px" />             
                <div>
                    Export PDF</div>
            </asp:LinkButton>
        </div>
    </div>
    <!--icon_function_parent-->
    <div id="field">
        <table width="100%" border="0">
            <tr>
                <td height="5" colspan="3" align="left">
                </td>
            </tr>
            <tr>
                <th width="50" class="left">
                    Filter
                </th>
                <td width="300px;">
                    <input name="txtKeyword" type="text" id="txtKeyword" style="width: 300px" runat="server" />
                </td>
                <td>
                    <div id="click">
                        <asp:LinkButton ID="lbtSearch" runat="server" OnClick="lbtSearch_Click">Tìm kiếm </asp:LinkButton>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="height: 10px;" colspan="3">
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <dx:ASPxGridView ID="ASPxGridView_inventory" runat="server" AutoGenerateColumns="False"
                        Width="100%" KeyFieldName="NEWS_ID" Theme="DevEx">
                        <Columns>
                            <dx:GridViewDataTextColumn VisibleIndex="1" Caption="Mã sản phẩm" FieldName="NEWS_CODE">
                                <DataItemTemplate>
                                    <asp:HiddenField ID="Hdid" runat="server" Value='<%#Eval("NEWS_ID") %>' />
                                    <%#Eval("NEWS_CODE")%>
                                </DataItemTemplate>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn VisibleIndex="1" Caption="Tên sản phẩm" FieldName="NEWS_TITLE">
                                <DataItemTemplate>
                                    <%# Eval("NEWS_TITLE")%>
                                </DataItemTemplate>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn VisibleIndex="1" Caption="SL nhập">
                                <DataItemTemplate>
                                    <%#Eval("INVENT_QUANTITY")%>
                                </DataItemTemplate>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn VisibleIndex="1" Caption="SL xuất">
                                <DataItemTemplate>
                                    <%#getSlxuat(Eval("ID"))%>
                                </DataItemTemplate>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn VisibleIndex="1" Caption="Tổng tiền mua">
                                <DataItemTemplate>
                                    <%#getPriceMua(Eval("INVENT_PRICE"), Eval("INVENT_QUANTITY"))%>
                                </DataItemTemplate>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn VisibleIndex="1" Caption="Tổng tiền bán được">
                                <DataItemTemplate>
                                    <%#getPriceBuyFormat(Eval("ID"))%>
                                </DataItemTemplate>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn VisibleIndex="1" Caption="Lợi nhuận" >
                                <DataItemTemplate>
                                    <%#getLoinhuan(Eval("ID"), Eval("INVENT_PRICE"), Eval("INVENT_QUANTITY"))%>
                                </DataItemTemplate>
                            </dx:GridViewDataTextColumn>
                        </Columns>
                        <Settings ShowFooter="true" ShowFilterRow="True" />
                        <TotalSummary>
                            <dx:ASPxSummaryItem FieldName="NEWS_INVENTORY" SummaryType="Sum" />
                        </TotalSummary>
                        <SettingsPager PageSize="30">
                        </SettingsPager>
                    </dx:ASPxGridView>
                    <dx:ASPxGridViewExporter ID="ASPxGridViewExporter_export" runat="server" GridViewID="ASPxGridView_inventory">
                    </dx:ASPxGridViewExporter>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
