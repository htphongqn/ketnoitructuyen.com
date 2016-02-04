using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using vpro.functions;
using vpro.eshop.cpanel.ucControls;
using System.Data;
using vpro.eshop.cpanel.Components;
using System.Data.Linq.SqlClient;
using System.IO;

namespace vpro.eshop.cpanel.page
{
    public partial class news_list_export : System.Web.UI.Page
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
                                where t2.CAT_RANK > 0 && t2.CAT_TYPE==1
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
                var AllList = from a in DB.ESHOP_NEWs
                            join b in DB.ESHOP_NEWS_CATs on a.NEWS_ID equals b.NEWS_ID
                              where a.NEWS_TYPE == 1 && ((SqlMethods.Like(a.NEWS_KEYWORD_ASCII, "%" + keyword + "%") || "" == keyword))
                               && (a.UNIT_ID2 == _idhangsx || 0 == _idhangsx)
                               && (b.ESHOP_CATEGORy.CAT_PARENT_ID == _catid || b.ESHOP_CATEGORy.CAT_PARENT_PATH.Contains(_catid.ToString()) || 0 == _catid)
                            select new
                            {
                                a.NEWS_ID,
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
                                a.NEWS_PRICEMUAVAO,
                                b.CAT_ID
                            };

                if (AllList.ToList().Count > 0)
                    Session["NewsList"] = DataUtil.LINQToDataTable(AllList);
                GridItemList.CurrentPageIndex = 0;
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

       

        
        public string getLanguage(object News_Language)
        {
            return Utils.CIntDef(News_Language) == 1 ? "Việt Nam" : "All";
        }

        public string getDate(object News_PublishDate)
        {
            return string.Format("{0:dd/MM/yyyy HH:mm:ss}", News_PublishDate);
        }
        public string getNameCate(object id)
        {
            int _id = Utils.CIntDef(id);
            var list = DB.ESHOP_CATEGORies.Where(n => n.CAT_ID == _id).ToList();
            if (list.Count > 0)
                return list[0].CAT_NAME;
            return string.Empty;
        }
        public string getStatus(object sta)
        {
            return Utils.CIntDef(sta) == 1 ? "Còn hàng" : "Hết hàng";
        }
        public string getVat(object vat)
        {
            return Utils.CIntDef(vat) == 1 ? "Đã có VAT" : "Chưa có VAT";
        }
        public string getPriod(object per)
        {
            int _per = Utils.CIntDef(per);
            switch (_per)
            {
                case 1: return "Sản phẩm nổi bật";
                case 2: return "Sản phẩm khuyến mãi";
                case 3: return "Sản phẩm giờ vàng giá sốc";
               
            }
            return "Không";
        }
        public int parsePrice(object price)
        {
            return Utils.CIntDef(price);
        }
        #endregion

        #region Button Envents

        protected void lbtSearch_Click(object sender, EventArgs e)
        {
            SearchResult();
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

        

        #endregion

        protected void GridItemList_PageIndexChanged(object source, DataGridPageChangedEventArgs e)
        {
            GridItemList.CurrentPageIndex = e.NewPageIndex;
            _count = (Utils.CIntDef(GridItemList.CurrentPageIndex, 0) * GridItemList.PageSize);
            GridItemList.DataSource = Session["NewsList"] as DataTable;
            GridItemList.DataBind();
        }

       
       
        protected void Drchuyenmuc_SelectedIndexChanged(object sender, EventArgs e)
        {

            try
            {
                int id = Utils.CIntDef(ddlCategory.SelectedValue);
                var list = (from a in DB.ESHOP_NEWs
                            join b in DB.ESHOP_NEWS_CATs on a.NEWS_ID equals b.NEWS_ID
                            where b.CAT_ID == id || b.ESHOP_CATEGORy.CAT_PARENT_PATH.Contains(id.ToString())
                            select new
                           {
                               a.NEWS_ID,
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
                           }).OrderByDescending(n => n.NEWS_ID).ToList();
                GridItemList.DataSource = list;
                GridItemList.DataBind();
                GridItemList.AllowPaging = false;
            }
            catch (Exception)
            {

                throw;
            }
        }

      
        protected void Drthuonghieu_SelectedIndexChanged(object sender, EventArgs e)
        {
            int id = Utils.CIntDef(Drthuonghieu.SelectedValue);
            var list = (from a in DB.ESHOP_NEWs
                        join b in DB.ESHOP_NEWS_CATs on a.NEWS_ID equals b.NEWS_ID
                        where a.UNIT_ID2 == id
                        select new
                           {
                               a.NEWS_ID,
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
                           }).Distinct().OrderByDescending(n => n.NEWS_ID).ToList();
            GridItemList.DataSource = list;
            GridItemList.DataBind();
            GridItemList.AllowPaging = false;
        }

        #region print
        protected void Lbexport_Click(object sender, EventArgs e)
        {
            //cusLoadexport();
            Response.ClearContent();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "Productlist.xls"));
            Response.ContentType = "application/ms-excel";
            GridItemList.Columns[0].Visible = false;
            GridItemList.Columns[1].Visible = false;
            

            StringWriter sw = new StringWriter();
            HtmlTextWriter ht = new HtmlTextWriter(sw);
            GridItemList.RenderControl(ht);
            Response.Write(sw.ToString());
            Response.End();
        }
        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
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
                               a.NEWS_ID,
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
                GridItemList.DataSource = list;
                GridItemList.DataBind();
            }
            catch (Exception ex)
            {

            }
        }
        #endregion
    }
}