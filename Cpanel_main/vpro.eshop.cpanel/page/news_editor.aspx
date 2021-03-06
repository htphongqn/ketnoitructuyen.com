﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="news_html.aspx.cs" Inherits="vpro.eshop.cpanel.page.news_html" ValidateRequest="false" %>

<%@ Register Src="../ucControls/ucNewsInfo.ascx" TagName="ucNewsInfo" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Soạn tin - Sản phẩm | Vpro.Eshop</title>
    <script src="../tinymce/js/tinymce/tinymce.min.js"></script>
    <script type="text/javascript">
        tinymce.init({
            selector: "textarea",
            plugins: [
        "advlist autolink lists link image charmap print preview hr anchor pagebreak",
        "searchreplace wordcount visualblocks visualchars code fullscreen",
        "insertdatetime media nonbreaking save table contextmenu directionality",
        "emoticons template paste textcolor colorpicker textpattern media youtube"
            ],
            image_advtab: true,
            style_formats: [
                        {
                            title: "Headers",
                            items: [
                                { title: "Header 1", format: "h1" },
                                { title: "Header 2", format: "h2" },
                                { title: "Header 3", format: "h3" },
                                { title: "Header 4", format: "h4" },
                                { title: "Header 5", format: "h5" },
                                { title: "Header 6", format: "h6" }
                            ]
                        },
                        {
                            title: "Inline", items: [{ title: "Bold", icon: "bold", format: "bold" }, { title: "Italic", icon: "italic", format: "italic" },
            { title: "_Underline", icon: "underline", format: "underline" }, { title: "Strikethrough", icon: "strikethrough", format: "strikethrough" }, { title: "Superscript", icon: "superscript", format: "superscript" }, { title: "Subscript", icon: "subscript", format: "subscript" }, { title: "Code", icon: "code", format: "code"}]
                        },
            { title: "_Blocks", items: [{ title: "Paragraph", format: "p" }, { title: "Blockquote", format: "blockquote" }, { title: "Div", format: "div" }, { title: "Pre", format: "pre"}] },
            { title: "_Alignment", items: [{ title: "Left", icon: "alignleft", format: "alignleft" }, { title: "Center", icon: "aligncenter", format: "aligncenter" }, { title: "Right", icon: "alignright", format: "alignright" }, { title: "Justify", icon: "alignjustify", format: "alignjustify"}] },
            {
                title: "Font Family",
                items: [
                    { title: 'Arial', inline: 'span', styles: { 'font-family': 'arial'} },
                    { title: 'Book Antiqua', inline: 'span', styles: { 'font-family': 'book antiqua'} },
                    { title: 'Comic Sans MS', inline: 'span', styles: { 'font-family': 'comic sans ms,sans-serif'} },
                    { title: 'Courier New', inline: 'span', styles: { 'font-family': 'courier new,courier'} },
                    { title: 'Georgia', inline: 'span', styles: { 'font-family': 'georgia,palatino'} },
                    { title: 'Helvetica', inline: 'span', styles: { 'font-family': 'helvetica'} },
                    { title: 'Impact', inline: 'span', styles: { 'font-family': 'impact,chicago'} },
                    { title: 'Open Sans', inline: 'span', styles: { 'font-family': 'Open Sans'} },
                    { title: 'Symbol', inline: 'span', styles: { 'font-family': 'symbol'} },
                    { title: 'Tahoma', inline: 'span', styles: { 'font-family': 'tahoma'} },
                    { title: 'Terminal', inline: 'span', styles: { 'font-family': 'terminal,monaco'} },
                    { title: 'Times New Roman', inline: 'span', styles: { 'font-family': 'times new roman,times'} },
                    { title: 'Verdana', inline: 'span', styles: { 'font-family': 'Verdana'} }
                ]
            },
    { title: "Font Size", items: [
                                { title: '8pt', inline: 'span', styles: { fontSize: '12px', 'font-size': '8px'} },
                                { title: '10pt', inline: 'span', styles: { fontSize: '12px', 'font-size': '10px'} },
                                { title: '12pt', inline: 'span', styles: { fontSize: '12px', 'font-size': '12px'} },
                                { title: '14pt', inline: 'span', styles: { fontSize: '12px', 'font-size': '14px'} },
                                { title: '16pt', inline: 'span', styles: { fontSize: '12px', 'font-size': '16px'} }
]
    }],
            file_browser_callback: function (field_name, url, type, win) {
                fileBrowserURL = "../Manager/Filemanager/Default.aspx?sessionid=<%= Session.SessionID.ToString() %>&field_name=" + field_name + "&url=" + url + "&win=" + win;


                tinyMCE.activeEditor.windowManager.open({
                    title: "File Manager NTT",
                    url: fileBrowserURL,
                    width: 950,
                    height: 650,
                    inline: 0,
                    maximizable: 1,
                    close_previous: 0
                }, {
                    window: win,
                    input: field_name,
                    sessionid: '<%= Session.SessionID.ToString() %>'
                }
        );
            },
            toolbar: "insertfile undo redo | styleselect | bold italic forecolor backcolor emoticons| alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image media preview | youtube"
        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="icon_function_parent">
        <%--       <div class="icon_function_Child">
                       <asp:LinkButton ID="lbtHelp" runat="server">
                <img src="../Images/ICON_Help.jpg" width="30" height="30" style="border: 0px" /><div>
                    Trợ giúp</div>
            </asp:LinkButton>
        </div>--%>
        <div class="icon_function_Child">
            <asp:LinkButton ID="lbtSave" runat="server" OnClick="lbtSave_Click"><img src="../Images/ICON_SAVE.jpg" width="30" height="30" style="border: 0px"/><div>
                    Lưu</div></asp:LinkButton>
        </div>
        <div class="icon_function_Child">
            <a href="#" onclick="javascript:document.location.reload(true);">
                <img src="../Images/ICON_UPDATE.jpg" width="30" height="30" style="border: 0px" /><div>
                    Cập nhật
                </div>
            </a>
        </div>
        <div class="icon_function_Child">
            <a href="#" id="hplBack" runat="server">
                <img src="../Images/ICON_RETURN.jpg" width="30" height="30" style="border: 0px" />
                <div>
                    Quay lại
                </div>
            </a>
        </div>
    </div>
    <!--icon_function_parent-->
    <div id="field">
        <table width="auto" border="0">
            <tr id="trNewsFunction" runat="server">
                <td colspan="3" align="left">
                    <div id="icon_function_news">
                        <div class="icon_function_items">
                            <a href="#" id="hplCatNews" runat="server">
                                <img src="../Images/ICON_UPDATE.jpg" width="15" height="15" style="border: 0px" />Chọn
                                chuyên mục </a>
                        </div>
                        <%--                        <div class="icon_function_items">
                            <a href="#" id="hplCatProducts" runat="server">
                                <img src="../Images/ICON_UPDATE.jpg" width="15" height="15" style="border: 0px" />
                                <asp:Label ID="lbCatNews" runat="server" Text="Chọn món ăn "></asp:Label></a>
                        </div>--%>
                        <div class="icon_function_items">
                            <a href="#" id="hplEditorHTMl" runat="server">
                                <img src="../Images/ICON_UPDATE.jpg" width="15" height="15" style="border: 0px" />Soạn
                                tin HTML </a>
                        </div>
                        <div class="icon_function_items">
                            <a href="#" id="hplNewsAtt" runat="server">
                                <img src="../Images/ICON_UPDATE.jpg" width="15" height="15" style="border: 0px" />File
                                đính kèm </a>
                        </div>
                        <div class="icon_function_items">
                            <a href="#" id="hplAlbum" runat="server">
                                <img src="../Images/ICON_UPDATE.jpg" width="15" height="15" style="border: 0px" />Album
                                hình </a>
                        </div>
                        <div class="icon_function_items">
                            <a href="#" id="hplComment" runat="server">
                                <img src="../Images/ICON_UPDATE.jpg" width="15" height="15" style="border: 0px" />Thông
                                tin phản hồi</a>
                        </div>
                        <%--<div class="icon_function_items">
                            <a href="#" id="bplNewsCopy" runat="server">
                                <img src="../Images/ICON_UPDATE.jpg" width="15" height="15" style="border: 0px" />Sao
                                chép</a>
                        </div>--%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <uc1:ucNewsInfo ID="ucNewsInfo1" runat="server" />
                </td>
            </tr>
            <tr>
                <td height="18" align="left" style="border-bottom: #e3e3e3 1px  solid;" class="general">
                    Nội dung chi tiết tin
                </td>
            </tr>
            <tr>
                <td>
                    <textarea id="mrk" cols="20" rows="10" class="mrk" style="height: 500px;" runat="server"></textarea>
                </td>
            </tr>
            <tr>
                <td>
                    Upload hình
                    <asp:FileUpload ID="FileUpload1" runat="server" class="multi" multiple="true" Width="300px" />
                    <asp:Button ID="Btupmulti" runat="server" Text="Upload" OnClick="Btupmulti_Click"
                        Width="100px" />
                </td>
            </tr>
            <tr>
                <td height="18" align="left" style="border-bottom: #e3e3e3 1px  solid;" class="general">
                    Video
                </td>
            </tr>
            <tr>
                <td>
                    <textarea id="mrk1" cols="20" rows="10" class="mrk1" style="height: 500px;" runat="server"></textarea>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
