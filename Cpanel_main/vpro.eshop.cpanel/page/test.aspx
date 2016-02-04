<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="test.aspx.cs" Inherits="vpro.eshop.cpanel.page.test" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <!-- Load jQuery build -->
    <script src="../tinymce/js/tinymce/tinymce.min.js"></script>
    <script type="text/javascript">
        tinymce.init({
            selector: "textarea",
            plugins: [
        "advlist autolink lists link image charmap print preview hr anchor pagebreak",
        "searchreplace wordcount visualblocks visualchars code fullscreen",
        "insertdatetime media nonbreaking save table contextmenu directionality",
        "emoticons template paste textcolor colorpicker textpattern media"
            ],

            file_browser_callback: function (field_name, url, type, win) {
                alert(field_name);
                fileBrowserURL = "/Cpanel/FileManager/Default.aspx?sessionid=<%= Session.SessionID.ToString() %>";


                tinyMCE.activeEditor.windowManager.open({
                    title: "Ajax File Manager",
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
            toolbar: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image"
        });

    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <textarea cols="5" rows="20"></textarea>
</asp:Content>
