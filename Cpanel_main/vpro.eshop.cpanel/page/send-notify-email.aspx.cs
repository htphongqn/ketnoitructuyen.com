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
namespace vpro.eshop.cpanel.page
{
    public partial class send_notify_email : System.Web.UI.Page
    {
        #region Declare

        int _count = 0;
        eshopdbDataContext DB = new eshopdbDataContext();
        private int m_mail_id = 0,_type=0;
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
            _type = Utils.CIntDef(Request["type"]);
            Hyperback.NavigateUrl = "news_list.aspx?type=" + _type;
            if (!IsPostBack)
            {
                
                ucHeader.HeaderLevel1 = "Email";
                ucHeader.HeaderLevel1_Url = "../page/page-email-send.aspx";
                ucHeader.HeaderLevel2 = "Danh sách";
                ucHeader.HeaderLevel2_Url = "../page/page-email-send.aspx";

                SearchResult();

                
            }

        }

        #endregion
        private void SearchResult()
        {
            try
            {
                

                var AllList = (from g in DB.ESHOP_MAIL_RECIVEs
                               orderby g.MAIL_ID descending
                               select g);


                if (AllList.ToList().Count > 0)
                    Session["email_send"] = DataUtil.LINQToDataTable(AllList);

                GridItemList.DataSource = AllList;
                if (AllList.ToList().Count > GridItemList.PageSize)
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
        public string getOrder()
        {
            _count = _count + 1;
            return _count.ToString();
        }
        public string getactive(object active)
        {
            int id = Utils.CIntDef(active);
            return id == 1 ? "Cho phép nhận tin" : "Không cho phép nhận tin";
        }
        
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

            DataTable dataTable = Session["email_send"] as DataTable;
            DataView sortedView = new DataView(dataTable);
            sortedView.Sort = e.SortExpression + " " + sortingDirection;
            GridItemList.DataSource = sortedView;
            GridItemList.DataBind();
        }

        protected void GridItemList_PageIndexChanged(object source, DataGridPageChangedEventArgs e)
        {
            GridItemList.CurrentPageIndex = e.NewPageIndex;
            _count = (Utils.CIntDef(GridItemList.CurrentPageIndex, 0) * GridItemList.PageSize);
            GridItemList.DataSource = Session["email_send"] as DataTable;
            GridItemList.DataBind();
        }

       

        #endregion

        //protected void GridItemList_PageIndexChanged(object source, DataGridPageChangedEventArgs e)
        //{
        //    GridItemList.CurrentPageIndex = e.NewPageIndex;
        //    _count = (Utils.CIntDef(GridItemList.CurrentPageIndex, 0) * GridItemList.PageSize);
        //    GridItemList.DataSource = Session["email_send"] as DataTable;
        //    GridItemList.DataBind();
        //}

        

        protected void lbtnSendMail_Click(object sender, EventArgs e)
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
                        j++;
                    }

                    i++;
                }
                var list = DB.GetTable<ESHOP_MAIL_RECIVE>().Where(g => items.Contains(g.MAIL_ID));
                string _content = mrk.Value;
                string _title=txttitle.Value;
                foreach (var s in list)
                {
                    SendEmailSMTP(_title, s.MAIL_NAME, "", "", _content, true, false);
                }
               
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
            }
            finally
            {
                items = null;
                Response.Write("<script LANGUAGE='JavaScript' >alert('Thông báo: Gửi thành công!');document.location='" + ResolveClientUrl("news_list.aspx?type=" + _type) + "';</script>");
            }
        }
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
    }
}