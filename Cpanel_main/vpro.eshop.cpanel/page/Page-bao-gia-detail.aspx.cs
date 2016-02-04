using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using vpro.functions;
using System.Data;
using vpro.eshop.cpanel.Components;
using System.Web.UI.HtmlControls;
using vpro.eshop.cpanel.ucControls;
using System.Data.Linq.SqlClient;

namespace vpro.eshop.cpanel.page
{
    public partial class Page_bao_gia_detail : System.Web.UI.Page
    {
        #region Declare
        int _count = 0,_count1=0,_idbaogia;
        eshopdbDataContext DB = new eshopdbDataContext();
        getCookiebaogia getcki = new getCookiebaogia();
        setCookieCheck setck = new setCookieCheck();
        List<string> lcheck = new List<string>();
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
        protected void Page_Load(object sender, EventArgs e)
        {
            ucHeader.HeaderLevel1 = "Báo giá";
            ucHeader.HeaderLevel1_Url = "../page/Page-bao-gia.aspx";
            ucHeader.HeaderLevel2 = "Báo giá";
            ucHeader.HeaderLevel2_Url = "../page/Page-bao-gia.aspx";
            _idbaogia = Utils.CIntDef(Request["id"]);
            Hyperback.NavigateUrl = "Page-bao-gia.aspx?id="+_idbaogia;
            if (Session["lnewsid"]!=null)
                lcheck = (List<string>)Session["lnewsid"];
            editCheck();
            if (!IsPostBack)
            {
                
                Loadchuyenmuc();
                loadPro();

            }
        }
        #region loadPro
        private void loadPro()
        { 
            string keyword =CpanelUtils.ClearUnicode(txtKeyword.Value);
            int _catid=Utils.CIntDef(ddlCategory.SelectedValue);
            var list = (from a in DB.ESHOP_NEWs
                        join b in DB.ESHOP_NEWS_CATs on a.NEWS_ID equals b.NEWS_ID
                        join c in DB.ESHOP_CATEGORies on b.CAT_ID equals c.CAT_ID
                        where ("" == keyword || SqlMethods.Like(a.NEWS_KEYWORD_ASCII, "%" + keyword + "%"))
                        && (_catid != 0 ? c.CAT_ID == _catid || c.CAT_PARENT_PATH.Contains(_catid.ToString()) : true)
                        &&a.NEWS_TYPE==1
                        select new
                        {
                            a.NEWS_ID,
                            a.NEWS_TITLE,
                            a.UNIT_ID2,
                            a.UNIT_ID1,
                            a.NEWS_PRICE1
                        }).Distinct().OrderByDescending(n=>n.NEWS_ID).ToList();
            if (list.Count > 0)
                Session["NewsListbg"] = DataUtil.LINQToDataTable(list);

            GridItemList.DataSource = list;
            if (list.Count > GridItemList.PageSize)
                GridItemList.AllowPaging = true;
            else
                GridItemList.AllowPaging = false;
            GridItemList.DataBind();
        }
        public void Loadchuyenmuc()
        {
            try
            {
                var CatList = (
                                from t2 in DB.ESHOP_CATEGORies
                                where t2.CAT_RANK > 0 &&t2.CAT_TYPE==1
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
        public string getNameCate(object id)
        {
            int _idcat = Utils.CIntDef(id);
            var list = DB.ESHOP_CATEGORies.Where(n => n.CAT_ID == _idcat).ToList();
            if (list.Count > 0)
                return list[0].CAT_NAME;
            return "";
        }
        private void editCheck()
        {
            var list = DB.BAO_GIADETAILs.Where(n => n.ID_BAOGIA == _idbaogia);
            foreach (var i in list)
            {
                if (!lcheck.Contains(i.NEWS_ID.ToString()))
                    lcheck.Add(i.NEWS_ID.ToString());
            }
        }
        #endregion
        #region Save
        protected void lbtSave_Click(object sender, EventArgs e)
        {
            //deleteBaogia();
            Savebaogia();
        }
        private void Savebaogia()
        {
           
            HtmlInputCheckBox check = new HtmlInputCheckBox();
            string _sMailContent = string.Empty;
            try
            {
                for (int i = 0; i < GridItemList.Items.Count; i++)
                {
                    check = new HtmlInputCheckBox();
                    check = (HtmlInputCheckBox)GridItemList.Items[i].FindControl("chkSelect");
                    HiddenField hdid = new HiddenField();
                    hdid = GridItemList.Items[i].FindControl("Hdnewsid") as HiddenField;
                    int _newid = Utils.CIntDef(hdid.Value);
                    if (check.Checked)
                    {
                        if(!lcheck.Contains(_newid.ToString()))
                            lcheck.Add(_newid.ToString());
                        
                    }
                }
                for (int j = 0; j < lcheck.Count; j++)
                {
                    int _newsid=Utils.CIntDef(lcheck[j]);
                    var list = DB.BAO_GIADETAILs.Where(n => n.ID_BAOGIA == _idbaogia&&n.NEWS_ID==_newsid).ToList();
                    if (list.Count == 0)
                    {
                        BAO_GIADETAIL bgdetail = new BAO_GIADETAIL();
                        bgdetail.ID_BAOGIA = _idbaogia;
                        bgdetail.NEWS_ID = _newsid;
                        DB.BAO_GIADETAILs.InsertOnSubmit(bgdetail);
                        DB.SubmitChanges();
                    }
                   
                }
                
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
            }
            finally
            {
                UpdateTotalAmount();
                Session["lnewsid"] = null;
                Response.Redirect("Page-bao-gia.aspx?id="+_idbaogia);
            }
        }
        private void deleteBaogia()
        {
            var list = DB.BAO_GIADETAILs.Where(n => n.ID_BAOGIA == _idbaogia);
            DB.BAO_GIADETAILs.DeleteAllOnSubmit(list);
            DB.SubmitChanges();
        }
        private void UpdateTotalAmount()
        {
            var list = from a in DB.BAO_GIADETAILs
                       join b in DB.ESHOP_NEWs on a.NEWS_ID equals b.NEWS_ID
                       where a.ID_BAOGIA == _idbaogia
                       select new
                       {
                           b.NEWS_PRICE1
                       };
            decimal price = Utils.CDecDef(list.Sum(n => n.NEWS_PRICE1));
            var updatebaogia = DB.BAO_GIAs.Where(n => n.ID_BAOGIA == _idbaogia).ToList();
            if (updatebaogia.Count > 0)
            {
                updatebaogia[0].BG_AMOUNT = price;
                DB.SubmitChanges();
            }
        }
        #endregion
        #region My Functions
        public bool checkPro(object news_id)
        {
            
            int _id = Utils.CIntDef(news_id);
            var list = DB.BAO_GIADETAILs.Where(n => n.ID_BAOGIA == _idbaogia && n.NEWS_ID == _id).ToList();
            if (list.Count > 0||lcheck.Contains(_id.ToString()))
                return true;
            return false;
        }
        public string FormatMoney(object Expression)
        {
            try
            {
                string Money = String.Format("{0:0,0 VNĐ}", Expression);
                return Money.Replace(",", ".");
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
                return null;
            }
        }
        public string getOrder()
        {
            _count = _count + 1;
            return _count.ToString();
        }
        public int setCount()
        {
            return _count1++;
        }
        public string getLink(object obj_id)
        {
            return "news.aspx?type=1&news_id=" + Utils.CStrDef(obj_id);
        }
       
        public string getDate(object News_PublishDate)
        {
            return string.Format("{0:dd/MM/yyyy HH:mm:ss}", News_PublishDate);
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

            DataTable dataTable = Session["NewsListbg"] as DataTable;
            DataView sortedView = new DataView(dataTable);
            sortedView.Sort = e.SortExpression + " " + sortingDirection;
            GridItemList.DataSource = sortedView;
            GridItemList.DataBind();
        }

        //protected void GridItemList_PageIndexChanged(object source, DataGridPageChangedEventArgs e)
        //{
        //    GridItemList.CurrentPageIndex = e.NewPageIndex;
        //    _count = (Utils.CIntDef(GridItemList.CurrentPageIndex, 0) * GridItemList.PageSize);
        //    GridItemList.DataSource = Session["NewsListbg"] as DataTable;
        //    GridItemList.DataBind();
        //}

        #endregion

        protected void GridItemList_PageIndexChanged(object source, DataGridPageChangedEventArgs e)
        {
            GridItemList.CurrentPageIndex = e.NewPageIndex;
            _count = (Utils.CIntDef(GridItemList.CurrentPageIndex, 0) * GridItemList.PageSize);
            GridItemList.DataSource = Session["NewsListbg"] as DataTable;
            GridItemList.DataBind();
        }

        protected void lbtSearch_Click(object sender, EventArgs e)
        {
            loadPro();
        }

        protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
        {
            int i = 0;
            CheckBox check = new CheckBox();
            string _sMailContent = string.Empty;

            try
            {
                foreach (DataGridItem item in GridItemList.Items)
                {
                    HiddenField hdid = new HiddenField();
                    check = new CheckBox();
                    check = (CheckBox)item.Cells[1].FindControl("CheckBox1");
                    hdid = item.Cells[1].FindControl("Hdnewsid") as HiddenField;
                    int _newsid = Utils.CIntDef(hdid.Value);
                    if (check.Checked)
                    {
                        setck.Addcookie(_newsid.ToString());
                    }

                    i++;
                }
                //Gửi mail

            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
            }
            finally
            {
                GridItemList.DataSource = Session["NewsListbg"] as DataTable;
                GridItemList.DataBind();
            }
        }
    }
}