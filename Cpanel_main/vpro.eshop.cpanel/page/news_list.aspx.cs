using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using vpro.functions;

using System.Data;
using System.Web.UI.HtmlControls;
using vpro.eshop.cpanel.ucControls;
using vpro.eshop.cpanel.Components;
using System.IO;
using System.Net.Mail;
using System.Data.Linq.SqlClient;
using System.Data.OleDb;
using DocumentFormat.OpenXml.Spreadsheet;
using DocumentFormat.OpenXml.Packaging;

namespace vpro.eshop.cpanel.page
{
    public partial class news_list : System.Web.UI.Page
    {

        #region Declare

        int _count = 0;
        int _type = 0;
        int _gtype, _gid;
        eshopdbDataContext DB = new eshopdbDataContext();

        #endregion

        #region properties

        public SortDirection sortProperty
        {
            get
            {
                if (ViewState["SortingState"] == null)
                {
                    ViewState["SortingState"] = SortDirection.Ascending;
                }
                return (SortDirection)ViewState["SortingState"];
            }
            set
            {
                ViewState["SortingState"] = value;
            }
        }

        #endregion

        #region Page Events

        protected void Page_Load(object sender, EventArgs e)
        {
            _gid = Utils.CIntDef(Session["GROUP_ID"]);
            _gtype = Utils.CIntDef(Session["GROUP_TYPE"]);
            _type = Utils.CIntDef(Request["type"]);
            Hyperaddnew.NavigateUrl = "news.aspx?type=" + _type;
            Hyperexport.NavigateUrl = "news_list_export.aspx?type=" + _type;
            if (!IsPostBack)
            {
                ucHeader.HeaderLevel1 = "Sản phẩm";
                ucHeader.HeaderLevel1_Url = "../page/news_list.aspx?type=" + _type;
                ucHeader.HeaderLevel2 = "Danh sách";
                ucHeader.HeaderLevel2_Url = "../page/news_list.aspx?type=" + _type;
                if (_gtype == 1)
                {
                    Loadchuyenmuc();
                    loadThuonghieu();
                }
                SearchResult();

                txtKeyword.Attributes.Add("onKeyPress", Common.getSubmitScript(lbtSearch.ClientID));
            }

        }

        #endregion

        #region My Functions

        public string getOrder()
        {
            _count = _count + 1;
            return _count.ToString();
        }

        public string getLink(object obj_id)
        {
            return "news.aspx?type=" + _type + "&news_id=" + Utils.CStrDef(obj_id);
        }
        public string getLink_comment(object obj_id)
        {
            return "news_comment.aspx?news_id=" + Utils.CStrDef(obj_id);
        }
        public int Getcount_comment(object NewsID)
        {
            try
            {
                int _iNewsID = Utils.CIntDef(NewsID);
                var _vComment = DB.GetTable<ESHOP_NEWS_COMMENT>().Where(a => a.NEWS_ID == _iNewsID);
                return _vComment.ToList().Count;
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
                return 0;
            }
        }
        public string getTypeNew(object obj_id)
        {
            return (Utils.CIntDef(obj_id) == 0) ? "Tin tức" : ((Utils.CIntDef(obj_id) == 1) ? "Sản phẩm" : "Khác");
        }
        public void Loadchuyenmuc()
        {
            try
            {
                var CatList = (
                                from t2 in DB.ESHOP_CATEGORies
                                where t2.CAT_RANK > 0 && (_type == 0 ? (t2.CAT_TYPE == 0 || t2.CAT_TYPE == 3) : t2.CAT_TYPE == 1)
                                select new
                                {
                                    CAT_ID = t2.CAT_NAME == "------- Root -------" ? 0 : t2.CAT_ID,
                                    CAT_NAME = (string.IsNullOrEmpty(t2.CAT_CODE) ? t2.CAT_NAME : t2.CAT_NAME + "(" + t2.CAT_CODE + ")"),
                                    CAT_NAME_EN = (string.IsNullOrEmpty(t2.CAT_CODE_EN) ? t2.CAT_NAME_EN : t2.CAT_NAME_EN + "(" + t2.CAT_CODE_EN + ")"),
                                    CAT_PARENT_ID = t2.CAT_PARENT_ID,
                                    CAT_RANK = t2.CAT_RANK
                                }
                            );

                if (CatList.ToList().Count > 0)
                {
                    DataRelation relCat;
                    DataTable tbl = DataUtil.LINQToDataTable(CatList);
                    DataSet ds = new DataSet();
                    ds.Tables.Add(tbl);

                    tbl.PrimaryKey = new DataColumn[] { tbl.Columns["CAT_ID"] };
                    relCat = new DataRelation("Category_parent", ds.Tables[0].Columns["CAT_ID"], ds.Tables[0].Columns["CAT_PARENT_ID"], false);

                    ds.Relations.Add(relCat);
                    DataSet dsCat = ds.Clone();
                    DataTable CatTable = ds.Tables[0];

                    DataUtil.TransformTableWithSpace(ref CatTable, dsCat.Tables[0], relCat, null);

                    ddlCategory.DataSource = dsCat.Tables[0];
                    ddlCategory.DataTextField = "CAT_NAME";
                    ddlCategory.DataValueField = "CAT_ID";
                    ddlCategory.DataBind();

                }
                ListItem l = new ListItem("------ Chọn chuyên mục ------", "0", true);
                l.Selected = true;
                ddlCategory.Items.Insert(0, l);

            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
            }
        }
        private void loadThuonghieu()
        {
            var list = DB.ESHOP_CATEGORies.Where(n => n.CAT_TYPE == 2 && n.CAT_RANK == 2);
            Drthuonghieu.DataValueField = "CAT_ID";
            Drthuonghieu.DataTextField = "CAT_NAME";
            Drthuonghieu.DataSource = list;
            Drthuonghieu.DataBind();
            ListItem l = new ListItem("--- Chọn thương hiệu ---", "0");
            l.Selected = true;
            Drthuonghieu.Items.Insert(0, l);
        }
        private List<string> getCatid()
        {
            List<string> l = new List<string>();
            var list = DB.ESHOP_GROUP_CATs.Where(n => n.GROUP_ID == _gid).ToList();
            foreach (var i in list)
            {
                l.Add(Utils.CStrDef(i.CAT_ID));
            }
            return l;
        }
        private void SearchResult()
        {
            try
            {
                string keyword = CpanelUtils.ClearUnicode(txtKeyword.Value);
                int _catid = Utils.CIntDef(ddlCategory.SelectedValue);
                int _idhangsx = Utils.CIntDef(Drthuonghieu.SelectedValue);
                var AllList = (from g in DB.ESHOP_NEWs
                               join a in DB.ESHOP_NEWS_CATs on g.NEWS_ID equals a.NEWS_ID into t2_join
                               from d in t2_join.DefaultIfEmpty()
                               where ("" == keyword || SqlMethods.Like(g.NEWS_KEYWORD_ASCII, "%" + keyword + "%"))
                               && (_gtype != 1 ? (getCatid().Contains(d.ESHOP_CATEGORy.CAT_ID.ToString()) || getCatid().Contains(d.ESHOP_CATEGORy.CAT_PARENT_ID.ToString())) : true)
                               && (_type == 1 ? g.NEWS_TYPE == 1 : g.NEWS_TYPE == 0)
                               &&(g.UNIT_ID2==_idhangsx||0==_idhangsx)
                               &&(d.ESHOP_CATEGORy.CAT_PARENT_ID==_catid||d.ESHOP_CATEGORy.CAT_PARENT_PATH.Contains(_catid.ToString())||0==_catid)
                               orderby g.NEWS_ID descending
                               select g).OrderByDescending(n => n.NEWS_ID).ToList();


                if (AllList.Count > 0)
                    Session["NewsList"] = DataUtil.LINQToDataTable(AllList);
                GridItemList.CurrentPageIndex = 0;
                GridItemList.DataSource = AllList;
                if (AllList.Count > GridItemList.PageSize)
                    GridItemList.AllowPaging = true;
                else
                    GridItemList.AllowPaging = false;
                GridItemList.DataBind();


            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
            }
        }

        public string GetNewsStatus(object NewsID, object NewsTitle)
        {
            try
            {
                int _iNewsID = Utils.CIntDef(NewsID);
                var _vComment = DB.GetTable<ESHOP_NEWS_COMMENT>().Where(a => a.NEWS_ID == _iNewsID && a.COMMENT_CHECK == 0);
                if (_vComment.ToList().Count > 0)
                {
                    return Utils.CStrDef(NewsTitle) + " - <font color='#FF0000'>Có phản hồi mới</font>";
                }
                else
                {
                    return Utils.CStrDef(NewsTitle);
                }
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
                return null;
            }
        }

        private void EventDelete(DataGridCommandEventArgs e)
        {
            try
            {
                int NewsId = Utils.CIntDef(GridItemList.DataKeys[e.Item.ItemIndex]);

                var g_delete = DB.GetTable<ESHOP_NEW>().Where(g => g.NEWS_ID == NewsId);

                DB.ESHOP_NEWs.DeleteAllOnSubmit(g_delete);
                DB.SubmitChanges();

                //delete folder
                string fullpath = Server.MapPath(PathFiles.GetPathNews(NewsId));
                if (Directory.Exists(fullpath))
                {
                    DeleteAllFilesInFolder(fullpath);
                    Directory.Delete(fullpath);
                }

            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
            }
            finally
            {
                Response.Redirect("news_list.aspx?type=" + _type);
            }
        }

        public string getStatus(object obj_status)
        {
            return Utils.CIntDef(obj_status) == 0 ? "Ẩn" : "Hiển thị";
        }

        public string getLanguage(object News_Language)
        {
            return Utils.CIntDef(News_Language) == 1 ? "Việt Nam" : "All";
        }

        public string getDate(object News_PublishDate)
        {
            return string.Format("{0:dd/MM/yyyy HH:mm:ss}", News_PublishDate);
        }

        #endregion

        #region Button Envents

        protected void lbtSearch_Click(object sender, EventArgs e)
        {
            SearchResult();
        }

        protected void lbtDelete_Click(object sender, EventArgs e)
        {
            int i = 0;
            int j = 0;
            HtmlInputCheckBox check = new HtmlInputCheckBox();
            int[] items = new int[GridItemList.Items.Count];

            try
            {
                foreach (DataGridItem item in GridItemList.Items)
                {
                    check = new HtmlInputCheckBox();
                    check = (HtmlInputCheckBox)item.Cells[1].FindControl("chkSelect");

                    if (check.Checked)
                    {
                        items[j] = Utils.CIntDef(GridItemList.DataKeys[i]);
                        try
                        {
                            //delete folder
                            string fullpath = Server.MapPath(PathFiles.GetPathNews(items[j]));
                            if (Directory.Exists(fullpath))
                            {
                                DeleteAllFilesInFolder(fullpath);
                                Directory.Delete(fullpath);
                            }
                        }
                        catch (Exception)
                        { }
                        j++;
                    }

                    i++;
                }

                //delete 
                var g_delete = DB.GetTable<ESHOP_NEW>().Where(g => items.Contains(g.NEWS_ID));

                DB.ESHOP_NEWs.DeleteAllOnSubmit(g_delete);
                DB.SubmitChanges();
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
            }
            finally
            {
                items = null;
                SearchResult();
            }

        }

        private void DeleteAllFilesInFolder(string folderpath)
        {
            foreach (var f in System.IO.Directory.GetFiles(folderpath))
                System.IO.File.Delete(f);
        }

        protected void lbtSave_Click(object sender, EventArgs e)
        {
            HtmlInputCheckBox check = new HtmlInputCheckBox();
            string strLink = "";
            int i = 0;

            try
            {
                foreach (DataGridItem item in GridItemList.Items)
                {
                    check = new HtmlInputCheckBox();
                    check = (HtmlInputCheckBox)item.Cells[1].FindControl("chkSelect");

                    if (check.Checked)
                    {
                        strLink = "news.aspx?news_id=" + Utils.CStrDef(GridItemList.DataKeys[i]);
                        break;
                    }
                    i++;
                }

            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
            }
            finally
            {
                if (!string.IsNullOrEmpty(strLink))
                    Response.Redirect(strLink);
            }

        }

        #endregion

        #region Grid Events

        protected void GridItemList_SortCommand(object source, DataGridSortCommandEventArgs e)
        {
            string sortingDirection = string.Empty;
            if (sortProperty == SortDirection.Ascending)
            {
                sortProperty = SortDirection.Descending;
                sortingDirection = "Desc";
            }
            else
            {
                sortProperty = SortDirection.Ascending;
                sortingDirection = "Asc";
            }

            DataTable dataTable = Session["NewsList"] as DataTable;
            DataView sortedView = new DataView(dataTable);
            sortedView.Sort = e.SortExpression + " " + sortingDirection;
            GridItemList.DataSource = sortedView;
            GridItemList.DataBind();
        }

        //protected void GridItemList_PageIndexChanged(object source, DataGridPageChangedEventArgs e)
        //{
        //    GridItemList.CurrentPageIndex = e.NewPageIndex;
        //    _count = (Utils.CIntDef(GridItemList.CurrentPageIndex, 0) * GridItemList.PageSize);
        //    GridItemList.DataSource = Session["NewsList"] as DataTable;
        //    GridItemList.DataBind();
        //}

        protected void GridItemList_ItemCommand(object source, DataGridCommandEventArgs e)
        {
            if (((LinkButton)e.CommandSource).CommandName == "Delete")
            {
                EventDelete(e);
            }
        }

        protected void GridItemList_ItemDataBound(object sender, DataGridItemEventArgs e)
        {
            if ((((e.Item.ItemType == ListItemType.Item) | (e.Item.ItemType == ListItemType.AlternatingItem)) | (e.Item.ItemType == ListItemType.SelectedItem)))
            {
                e.Item.Cells[9].Attributes.Add("onClick", "return confirm('Bạn có chắc chắn xóa?');");
            }

        }

        #endregion

        protected void GridItemList_PageIndexChanged(object source, DataGridPageChangedEventArgs e)
        {
            GridItemList.CurrentPageIndex = e.NewPageIndex;
            _count = (Utils.CIntDef(GridItemList.CurrentPageIndex, 0) * GridItemList.PageSize);
            GridItemList.DataSource = Session["NewsList"] as DataTable;
            GridItemList.DataBind();
        }

        //gui mail km
        public void SendEmailSMTP(string strSubject, string toAddress, string ccAddress, string bccAddress, string body, bool isHtml, bool isSSL)
        {
            try
            {
                using (MailMessage mail = new MailMessage())
                {
                    mail.From = new MailAddress(Utils.CStrDef(System.Configuration.ConfigurationManager.AppSettings["Email"]), Utils.CStrDef(System.Configuration.ConfigurationManager.AppSettings["EmailDisplayName"]));
                    mail.To.Add(toAddress);
                    if (ccAddress != "")
                    {
                        mail.CC.Add(ccAddress);
                    }
                    if (bccAddress != "")
                    {
                        mail.Bcc.Add(bccAddress);
                    }
                    mail.Subject = strSubject;

                    string str = body;
                    mail.Body = str;
                    mail.IsBodyHtml = isHtml;
                    SmtpClient client = new SmtpClient();
                    client.EnableSsl = isSSL;
                    client.Host = Utils.CStrDef(System.Configuration.ConfigurationManager.AppSettings["EmailHost"]);
                    client.Port = Utils.CIntDef(System.Configuration.ConfigurationManager.AppSettings["EmailPort"]);
                    client.Credentials = new System.Net.NetworkCredential(Utils.CStrDef(System.Configuration.ConfigurationManager.AppSettings["Email"]), Utils.CStrDef(System.Configuration.ConfigurationManager.AppSettings["EmailPassword"]));

                    client.Send(mail);
                }
            }
            catch (SmtpException ex)
            {
                clsVproErrorHandler.HandlerError(ex);
            }
        }
        private void Send_Mail_Content(string MailContent, string Email)
        {
            try
            {
                string strEmailBody = "";

                strEmailBody += getHeader();
                strEmailBody += MailContent;
                strEmailBody += getFooter();

                SendEmailSMTP("Vui lòng ghé thăm website " + System.Configuration.ConfigurationManager.AppSettings["URLWebsite1"] + "", Email, "", "", strEmailBody, true, false);

            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
            }
        }

        protected void lbtnSendMail_Click(object sender, EventArgs e)
        {
            int i = 0;
            int j = 0;
            HtmlInputCheckBox check = new HtmlInputCheckBox();
            int[] items = new int[GridItemList.Items.Count];

            string _sMailContent = string.Empty;

            try
            {
                foreach (DataGridItem item in GridItemList.Items)
                {
                    check = new HtmlInputCheckBox();
                    check = (HtmlInputCheckBox)item.Cells[1].FindControl("chkSelect");

                    if (check.Checked)
                    {
                        items[j] = Utils.CIntDef(GridItemList.DataKeys[i]);
                        j++;
                    }

                    i++;
                }
                var setMailcontent = DB.ESHOP_NEWs.Where(n => items.Contains(n.NEWS_ID));
                foreach (var s in setMailcontent)
                {
                    _sMailContent += setHtmlSendmail(s.NEWS_TITLE, subDesc(s.NEWS_DESC), GetImageT_News(s.NEWS_ID, s.NEWS_IMAGE3), Getprice(s.NEWS_PRICE1), Getlink_News(s.NEWS_URL, s.NEWS_SEO_URL, s.NEWS_TYPE));
                }
                //Gửi mail
                var _vEmailReceive = DB.GetTable<ESHOP_MAIL_RECIVE>().Where(a => a.MAIL_ACTIVE == 1);
                foreach (var item in _vEmailReceive)
                {
                    Send_Mail_Content(_sMailContent, item.MAIL_NAME);
                }
                Response.Write("<script LANGUAGE='JavaScript' >alert('Thông báo: Tin đã được gửi thành công!');document.location='" + ResolveClientUrl("/cpanel/page/news_list.aspx?type=" + _type) + "';</script>");
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
            }
            finally
            {
                items = null;
                SearchResult();
            }
        }
        private string getHeader()
        {
            string pathFile;
            string strHTMLContent = string.Empty;

            pathFile = Server.MapPath(PathFiles.GetPathConfigs() + "/headersendmail.htm");

            if ((File.Exists(pathFile)))
            {
                StreamReader objNewsReader;
                //objNewsReader = New StreamReader(pathFile, System.Text.Encoding.Default)
                objNewsReader = new StreamReader(pathFile);
                strHTMLContent = objNewsReader.ReadToEnd();
                objNewsReader.Close();

            }
            return strHTMLContent;
        }
        private string getFooter()
        {
            string pathFile;
            string strHTMLContent = string.Empty;

            pathFile = Server.MapPath(PathFiles.GetPathConfigs() + "/footersendmail.htm");

            if ((File.Exists(pathFile)))
            {
                StreamReader objNewsReader;
                //objNewsReader = New StreamReader(pathFile, System.Text.Encoding.Default)
                objNewsReader = new StreamReader(pathFile);
                strHTMLContent = objNewsReader.ReadToEnd();
                objNewsReader.Close();

            }
            return strHTMLContent;
        }
        private string setHtmlSendmail(string title, string desc, string img, string price, string link)
        {
            string _result = string.Empty;
            _result += "<table class='MsoNormalTable' border='0' cellpadding='0'>";
            _result += "  <tr>";
            _result += "<td rowspan='2' style='padding: .75pt .75pt .75pt .75pt' colspan='2'";
            _result += " <p class='MsoNormal' style='margin-top: 10pt'>";
            _result += "   <b><span style='font-family: Arial,sans-serif;'><a target='_blank' href='" + link + "'>";
            _result += " <span style='color: #0792BD; text-decoration: none;'>";
            _result += " <img border='0' width='210' height='140' src='" + img + "'";
            _result += "   alt='" + title + "' title='" + title + "' /></span></a><o:p>";
            _result += "</o:p></span></b></p>";
            _result += "</td>";
            _result += "<td valign='top' style='padding: .75pt .75pt .75pt 3.75pt'";
            _result += " <p class='MsoNormal' style='margin-top: 10pt; text-align: left;'>";
            _result += " <b><span style='font-size: 13.0pt; font-family: Arial,sans-serif;'>";
            _result += "<a target='_blank' href='" + link + "'>";
            _result += "<span style='color: #DD3489;";
            _result += " text-decoration: none;'>" + title + "</span></a><o:p></o:p></span></b></p>";
            _result += "<p class='MsoNormal' style='margin-top: 10pt; font-size: x-small; text-align: left;'>";
            _result += " <b><span style='font-family: Arial,sans-serif; color: #666666'>";
            _result += desc + "</span></b></p>";
            _result += " </td>";
            _result += "</tr>";
            _result += "<tr>";
            _result += " <td valign='bottom' style='padding: .75pt .75pt .75pt 3.75pt'>";
            _result += " <table class='MsoNormalTable' border='0' cellspacing='0' cellpadding='0' width='100%'";
            _result += "style='width: 100.0%; background: #FF6600;'>";
            _result += "<tr>";
            _result += " <td valign='bottom' style='padding: .75pt .75pt .75pt 3.75pt'>";
            _result += " <table class='MsoNormalTable' border='0' cellspacing='0' cellpadding='0' width='100%'";
            _result += "style='width: 100.0%; background: #FF6600;'>";
            _result += "<tr>";
            _result += "<td style='background: white; padding: 0in 0in 0in 0in'>";
            _result += "<p class='MsoNormal' align='center' style='text-align: center'>";
            _result += "<span style='color: #666666'>Giá<o:p></o:p></span></p>";
            _result += "</td>";
            _result += "<td style='background: white; padding: 0in 0in 0in 0in'>";
            _result += "  <p class='MsoNormal' align='center' style='text-align: center'>";
            _result += "  </p>";
            _result += " </td>";
            _result += " <td style='background: white; padding: 0in 0in 0in 0in'>";
            _result += "<p class='MsoNormal' align='center' style='text-align: center'>";
            _result += " <span style='color: #666666'><o:p></o:p></span></p>";
            _result += "</td>";
            _result += "<td style='background: white; padding: 0in 0in 0in 0in'>";
            _result += "<p class='MsoNormal' align='center' style='text-align: center'>";
            _result += " <span style='color: white'>&nbsp;<o:p></o:p></span></p>";
            _result += " </td>";
            _result += "</tr>";
            _result += "<tr>";
            _result += "<td style='background: #E77500; padding: 0in 0in 0in 0in'>";
            _result += "  <p class='MsoNormal' align='center' style='text-align: center'>";
            _result += "   <b><span style='color: white'>" + price + "<o:p></o:p></span></b></p>";
            _result += " </td>";
            _result += " <td style='background: #E77500; padding: 0in 0in 0in 0in'>";
            _result += "   <p class='MsoNormal' align='center' style='text-align: center'>";
            _result += "         <b><span style='color: white'><o:p></o:p></span></b></p>";
            _result += "</td>";
            _result += " <td style='background: #E77500; padding: 0in 0in 0in 0in'>";
            _result += "  <p class='MsoNormal' align='center' style='text-align: center'>";
            _result += "  <b><span style='color: white'>";
            _result += "      <o:p></o:p>";
            _result += " </span></b>";
            _result += "</p>";
            _result += "</td>";
            _result += "<td style='background: #468107; padding: 3.75pt 3.75pt 3.75pt 3.75pt'>";
            _result += " <p class='MsoNormal' align='center' style='text-align: center'>";
            _result += " <span style='color: white'><a target='_blank' href='" + link + "'>";
            _result += "<b><span style='font-size: 12.0pt; font-family: Arial,sans-serif; color: white; text-decoration: none;'>";
            _result += " MUA NGAY</span></b></a><o:p></o:p></span></p>";
            _result += " </td>";
            _result += " </tr>";
            _result += "  </table>";
            _result += " </td>";
            _result += "</tr>";

            _result += "  </table>";
            _result += " </td>";
            _result += " </tr>";
            _result += "</table>";
            return _result;
        }
        public string Getlink_News(object News_url, object Seo_url, object type)
        {
            int _sType = Utils.CIntDef(type);
            string _url = _sType == 1 ? "san-pham" : "tin-tuc";
            return string.IsNullOrEmpty(Utils.CStrDef(News_url)) ? System.Configuration.ConfigurationManager.AppSettings["URLWebsite1"] + "/" + _url + "/" + Utils.CStrDef(Seo_url) + ".aspx" : Utils.CStrDef(News_url);
        }
        public string Getprice(object Price1)
        {
            decimal _dPrice1 = Utils.CDecDef(Price1);
            if (_dPrice1 != 0)
            {
                return String.Format("{0:0,0 VNĐ}", _dPrice1);
            }
            return "Liên hệ";
        }
        public string GetImageT_News(object News_Id, object News_Image1)
        {

            try
            {
                if (Utils.CIntDef(News_Id) > 0 && !string.IsNullOrEmpty(Utils.CStrDef(News_Image1)))
                {
                    return System.Configuration.ConfigurationManager.AppSettings["URLWebsite1"] + "/" + PathFiles.GetPathNews(Utils.CIntDef(News_Id)) + Utils.CStrDef(News_Image1);
                }
                else
                {
                    return "";
                }
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
                return null;
            }
        }
        private string subDesc(string desc)
        {
            if (desc.Length > 100)
                return desc.Substring(0, 99) + "...";
            return desc;
        }
        protected void Drchuyenmuc_SelectedIndexChanged(object sender, EventArgs e)
        {

            try
            {
                int id = Utils.CIntDef(ddlCategory.SelectedValue);
                var list = (from a in DB.ESHOP_NEWs
                            join b in DB.ESHOP_NEWS_CATs on a.NEWS_ID equals b.NEWS_ID
                            where b.CAT_ID == id || b.ESHOP_CATEGORy.CAT_PARENT_PATH.Contains(id.ToString())
                            select a).OrderByDescending(n => n.NEWS_PUBLISHDATE).ToList();
                GridItemList.DataSource = list;
                GridItemList.DataBind();
                Session["NewsList"] = DataUtil.LINQToDataTable(list);
            }
            catch (Exception)
            {

                throw;
            }
        }

        protected void lbSendnoti_Click(object sender, EventArgs e)
        {
            Response.Redirect("send-notify-email.aspx?type=" + _type);
        }

        protected void Drthuonghieu_SelectedIndexChanged(object sender, EventArgs e)
        {
            int id = Utils.CIntDef(Drthuonghieu.SelectedValue);
            var list = (from a in DB.ESHOP_NEWs
                        join b in DB.ESHOP_NEWS_CATs on a.NEWS_ID equals b.NEWS_ID
                        where a.UNIT_ID2 == id
                        select a).OrderByDescending(n => n.NEWS_PUBLISHDATE).ToList();
            GridItemList.DataSource = list;
            GridItemList.DataBind();
            Session["NewsList"] = DataUtil.LINQToDataTable(list);
        }
        private DataTable getDataexcel(string SourceFilePath)
        {

            DataTable dtExcel = new DataTable();
            // Connection String to Excel Workbook
            string excelConnectionString = string.Format("Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties=Excel 8.0", SourceFilePath);
            OleDbConnection connection = new OleDbConnection();
            connection.ConnectionString = excelConnectionString;
            connection.Open();
            OleDbCommand command = new OleDbCommand("select * from [Sheet1$]", connection);
            OleDbDataAdapter data = new OleDbDataAdapter(command);
            data.Fill(dtExcel);
            return dtExcel;

        }
        private List<NewsEntity> LoadListnews(Worksheet worksheet, SharedStringTable sharedString)
        {
            //Initialize the customer list.
            List<NewsEntity> result = new List<NewsEntity>();

            //LINQ query to skip first row with column names.
            IEnumerable<Row> dataRows = (from row in worksheet.Descendants<Row>()
                                         where row.RowIndex > 1
                                         select row);

            foreach (Row row in dataRows)
            {
                //LINQ query to return the row's cell values.
                //Where clause filters out any cells that do not contain a value.
                //Select returns the value of a cell unless the cell contains
                //  a Shared String.
                //If the cell contains a Shared String, its value will be a 
                //  reference id which will be used to look up the value in the 
                //  Shared String table.
                IEnumerable<String> textValues = from cell in row.Descendants<Cell>()
                                                 select
                                                   (cell.DataType != null
                                                    && cell.DataType.HasValue
                                                     && cell.DataType == CellValues.SharedString
                                                   ? sharedString.ChildElements[Utils.CIntDef(cell.CellValue.InnerText)].InnerText : cell.CellValue.InnerText);

                //Check to verify the row contained data.
                if (textValues.Count() > 0)
                {
                    //Create a customer and add it to the list.
                    var textArray = textValues.ToArray();
                    string _title = Utils.CStrDef(textArray[0]);
                    string _masp = Utils.CStrDef(textArray[1]).Trim();
                    string _congnghe = Utils.CStrDef(textArray[2]);
                    string _weight = Utils.CStrDef(textArray[3]);
                    int _idhsx = getIdCate(Utils.CStrDef(textArray[4]));
                    int _idxuatxu = getIdCate(Utils.CStrDef(textArray[5]));
                    string _bhhanh = Utils.CStrDef(textArray[6]);
                    int _status = getIdStatus(Utils.CStrDef(textArray[7]));
                    int _vat = getIdVat(Utils.CStrDef(textArray[8]));
                    int _period = getIDperiod(Utils.CStrDef(textArray[10]));
                    decimal _price = Utils.CDecDef(Utils.CStrDef(textArray[12]));
                    decimal _pricePromos = Utils.CDecDef(Utils.CStrDef(textArray[13]));
                    decimal _pricegiovang = Utils.CDecDef(Utils.CStrDef(textArray[14]));
                    decimal _priceMuavao = Utils.CDecDef(Utils.CStrDef(textArray[15]));
                    int _idcat = getIdCate(Utils.CStrDef(textArray[16]));
                    NewsEntity newsenti = new NewsEntity();
                    newsenti._news_tile = _title;
                    newsenti._news_code = _masp;
                    newsenti._news_congnghe = _congnghe;
                    newsenti._news_weight = _weight;
                    newsenti._news_hangsx = _idhsx;
                    newsenti._news_xuatxu = _idxuatxu;
                    newsenti._news_baohanh = _bhhanh;
                    newsenti._news_status = _status;
                    newsenti._news_vat = _vat;
                    newsenti._news_period = _period;
                    newsenti._news_price = _price;
                    newsenti._news_priceMos = _pricePromos;
                    newsenti._news_priceGiovang = _pricegiovang;
                    newsenti._news_priceMuavao = _priceMuavao;
                    newsenti._catid = _idcat;
                    result.Add(newsenti);
                }
                else
                {
                    //If no cells, then you have reached the end of the table.
                    break;
                }
            }

            //Return populated list of customers.
            return result;
        }
        private class NewsEntity
        {
            public string _news_tile { get; set; }
            public string _news_code { get; set; }
            public string _news_congnghe { get; set; }
            public string _news_weight { get; set; }
            public int _news_hangsx { get; set; }
            public int _news_xuatxu { get; set; }
            public string _news_baohanh { get; set; }
            public int _news_status { get; set; }
            public int _news_vat { get; set; }
            public int _news_period { get; set; }
            public decimal _news_price { get; set; }
            public decimal _news_priceMos { get; set; }
            public decimal _news_priceGiovang { get; set; }
            public decimal _news_priceMuavao { get; set; }
            public int _catid { get; set; }
        }
        private void UpdateProduct(string path)
        {
            try
            {
                Workbook workBook;
                SharedStringTable sharedStrings;
                IEnumerable<Sheet> workSheets;
                WorksheetPart custSheet;
                //WorksheetPart orderSheet;
                //Declare helper variables.
                string custID;
                //string orderID;
                List<NewsEntity> listnews;
                //List<Order> orders;

                //Open the Excel workbook.            
                using (SpreadsheetDocument document = SpreadsheetDocument.Open(@""+path+"", true))
                {
                    //References to the workbook and Shared String Table.
                    workBook = document.WorkbookPart.Workbook;
                    workSheets = workBook.Descendants<Sheet>();
                    sharedStrings = document.WorkbookPart.SharedStringTablePart.SharedStringTable;
                    //Reference to Excel Worksheet with Customer data.
                    custID = workSheets.First(s => s.Name == @"Sheet1").Id;
                    custSheet = (WorksheetPart)document.WorkbookPart.GetPartById(custID);

                    //Load customer data to business object.
                    listnews = LoadListnews(custSheet.Worksheet, sharedStrings);
                    foreach (var i in listnews)
                    {
                        var list = DB.ESHOP_NEWs.Where(n => n.NEWS_CODE == i._news_code && !String.IsNullOrEmpty(i._news_code)).ToList();
                        if (list.Count > 0)
                        {
                            list[0].NEWS_TITLE = i._news_tile;
                            list[0].NEWS_CODE = i._news_code;
                            list[0].NEWS_FIELD5 = i._news_congnghe;
                            list[0].NEWS_FIELD4 = i._news_weight;
                            list[0].UNIT_ID2 = i._news_hangsx;
                            list[0].UNIT_ID1 = i._news_xuatxu;
                            list[0].NEWS_FIELD2 = i._news_baohanh;
                            list[0].NEWS_FIELD3 = i._news_status.ToString();
                            list[0].UNIT_ID3 = i._news_vat;
                            list[0].NEWS_PERIOD = i._news_period;
                            list[0].NEWS_PRICE1 = i._news_price;
                            list[0].NEWS_PRICE2 = i._news_priceMos;
                            list[0].NEWS_PRICE3 = i._news_priceGiovang;
                            list[0].NEWS_PRICEMUAVAO = i._news_priceMuavao;
                            list[0].NEWS_SEO_URL = CpanelUtils.ClearUnicodeSeo(i._news_tile);
                            list[0].NEWS_SEO_TITLE = i._news_tile;
                            list[0].NEWS_KEYWORD_ASCII = CpanelUtils.ClearUnicode(i._news_tile);
                            DB.SubmitChanges();
                        }
                        else
                        {
                            ESHOP_NEW news = new ESHOP_NEW();
                            news.NEWS_TITLE = i._news_tile;
                            news.NEWS_CODE = i._news_code;
                            news.NEWS_FIELD5 = i._news_congnghe;
                            news.NEWS_FIELD4 = i._news_weight;
                            news.UNIT_ID2 = i._news_hangsx;
                            news.UNIT_ID1 = i._news_xuatxu;
                            news.NEWS_FIELD2 = i._news_baohanh;
                            news.NEWS_FIELD3 = i._news_status.ToString();
                            news.UNIT_ID3 = i._news_vat;
                            news.NEWS_PERIOD = i._news_period;
                            news.NEWS_PRICE1 = i._news_price;
                            news.NEWS_PRICE2 = i._news_priceMos;
                            news.NEWS_PRICE3 = i._news_priceGiovang;
                            news.NEWS_PRICEMUAVAO = i._news_priceMuavao;
                            news.NEWS_TYPE = 1;
                            news.NEWS_SHOWTYPE = 1;
                            news.NEWS_PUBLISHDATE = DateTime.Now;
                            news.NEWS_COUNT = 1;
                            news.NEWS_ORDER = 1;
                            news.NEWS_SEO_URL = CpanelUtils.ClearUnicodeSeo(i._news_tile);
                            news.NEWS_SEO_TITLE = i._news_tile;
                            news.NEWS_SEO_KEYWORD = i._news_tile;
                            news.USER_ID = 1;
                            news.NEWS_KEYWORD_ASCII = CpanelUtils.ClearUnicode(i._news_tile);
                            DB.ESHOP_NEWs.InsertOnSubmit(news);
                            DB.SubmitChanges();
                            //update cat news
                            var _new = DB.GetTable<ESHOP_NEW>().OrderByDescending(g => g.NEWS_ID).Take(1);
                            SaveNewsCategory(_new.Single().NEWS_ID, i._catid);
                        }
                    }
                }

            }
            catch (Exception ex)
            {

                clsVproErrorHandler.HandlerError(ex);
            }
        }
        private void SaveNewsCategory(int NewsId, int _catid)
        {
            try
            {
                ESHOP_NEWS_CAT nc = new ESHOP_NEWS_CAT();
                nc.CAT_ID = _catid;
                nc.NEWS_ID = NewsId;

                DB.ESHOP_NEWS_CATs.InsertOnSubmit(nc);
                DB.SubmitChanges();
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
            }
        }
        protected void Lbimport_Click(object sender, EventArgs e)
        {
            if (Fileimport.HasFile)
            {
                string namefile = Fileimport.PostedFile.FileName;
                string path = Server.MapPath(PathFiles.GetPathConfigs());
                string fullpath = path + namefile;
                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }
                Fileimport.PostedFile.SaveAs(fullpath);
                UpdateProduct(fullpath);
                SearchResult();
            }
        }
        private int getIDperiod(string name)
        {
            switch (name)
            {
                case "Sản phẩm nổi bật": return 1;
                case "Sản phẩm khuyến mãi": return 2;
                case "Sản phẩm giờ vàng giá sốc": return 3;

            }
            return 20;
        }
        private int getIdVat(string name)
        {
            if (name.ToLower().Contains("chưa có vat"))
                return 1;
            return 0;
        }
        private int getIdStatus(string name)
        {
            if (name.Contains("Còn hàng"))
                return 1;
            return 0;
        }
        private int getIdCate(string name)
        {
            var list = DB.ESHOP_CATEGORies.Where(n => n.CAT_NAME.ToLower() == name.ToLower()).ToList();
            if (list.Count > 0)
                return list[0].CAT_ID;
            return 0;
        }

        protected void Lbexport_Click(object sender, EventArgs e)
        {

        }
        private void cusLoadexport()
        { 
            int i = 0;
            int j = 0;
            HtmlInputCheckBox check = new HtmlInputCheckBox();
            int[] items = new int[GridItemList.Items.Count];

            string _sMailContent = string.Empty;

            try
            {
                foreach (DataGridItem item in GridItemList.Items)
                {
                    check = new HtmlInputCheckBox();
                    check = (HtmlInputCheckBox)item.Cells[1].FindControl("chkSelect");

                    if (check.Checked)
                    {
                        items[j] = Utils.CIntDef(GridItemList.DataKeys[i]);
                        j++;
                    }

                    i++;
                }
                var list = from a in DB.ESHOP_NEWs
                           join b in DB.ESHOP_NEWS_CATs on a.NEWS_ID equals b.NEWS_ID
                           where items.Contains(a.NEWS_ID)
                           select new
                           {
                               a.NEWS_TITLE,
                               a.NEWS_CODE,
                               a.NEWS_FIELD5,
                               a.NEWS_FIELD4,
                               a.UNIT_ID2,
                               a.UNIT_ID1,
                               a.NEWS_FIELD2,
                               a.NEWS_FIELD3,
                               a.UNIT_ID3,
                               a.NEWS_PERIOD,
                               a.NEWS_PRICE1,
                               a.NEWS_PRICE2,
                               a.NEWS_PRICE3,
                               b.CAT_ID
                           };
            }
            catch (Exception ex)
            { 
                
            }
        }

    }
}