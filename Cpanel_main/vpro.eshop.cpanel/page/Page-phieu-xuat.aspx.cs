using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using vpro.functions;
using System.Data;
using System.Data.Linq.SqlClient;
using vpro.eshop.cpanel.Components;
using vpro.eshop.cpanel.ucControls;

namespace vpro.eshop.cpanel.page
{
    public partial class Page_phieu_xuat : System.Web.UI.Page
    {
        eshopdbDataContext db = new eshopdbDataContext();
        int idbaogia = 0, _count = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            idbaogia = Utils.CIntDef(Request["id"]);
            Hyperprint.NavigateUrl = "Page-phieu-xuat-print.aspx?id=" + idbaogia;
            if (!IsPostBack)
            {
                ucHeader.HeaderLevel1 = "Báo giá";
                ucHeader.HeaderLevel1_Url = "../page/Page-phieu-xuat.aspx";
                ucHeader.HeaderLevel2 = "Báo giá";
                ucHeader.HeaderLevel2_Url = "../page/Page-phieu-xuat.aspx";
                if (idbaogia != 0)
                {
                    //Hyedit.Visible = true;
                    //Hyedit.NavigateUrl = "Page-bao-gia-detail.aspx?id=" + idbaogia;
                    div_probaogia.Visible = true;
                    div_search.Visible = true;
                    Loadchuyenmuc();
                    getInfo();
                    loadPro();
                }
                else
                {
                    div_probaogia.Visible = false;
                    div_search.Visible = false;
                    //Hyedit.Visible = false;
                }
            }
        }
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
        public void Loadchuyenmuc()
        {
            try
            {
                var CatList = (
                                from t2 in db.ESHOP_CATEGORies
                                where t2.CAT_RANK > 0 && t2.CAT_TYPE == 1
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
        private void getInfo()
        {
            var list = db.BAO_GIAs.Where(n => n.ID_BAOGIA == idbaogia).ToList();
            if (list.Count > 0)
            {
                txtname.Text = list[0].BG_NAME;
                txtemail.Text = list[0].BG_EMAIL;
                txthp.Text = list[0].BG_HP;
                txtShip.Value = Utils.CLngDef(list[0].BG_SHIP).ToString();
                txtNameEmploy.Text = list[0].BG_NAME_EMPLOY;
                txtEmailEmploy.Text = list[0].BG_EMAIL_EMPLOY;
                txtHpEmploy.Text = list[0].BG_HP_EMPLOY;
            }
        }
        protected void lbtSave_Click(object sender, EventArgs e)
        {
            Save();
        }

        private void SavechangeBGDetail()
        {
            int i = 0;

            string _sMailContent = string.Empty;

            try
            {
                foreach (DataGridItem item in GridItemList.Items)
                {
                    TextBox txtquantity = item.Cells[2].FindControl("txtquantity") as TextBox;
                    TextBox txtUnit = item.Cells[3].FindControl("txtUnit") as TextBox;
                    TextBox txtprice = item.Cells[5].FindControl("txtprice") as TextBox;
                    TextBox txtChieckhau = item.Cells[6].FindControl("txtChieckhau") as TextBox;
                    CheckBox checkactive = item.Cells[7].FindControl("Checkactive") as CheckBox;
                    int _newsid = Utils.CIntDef(GridItemList.DataKeys[i]);
                    var list = db.BAO_GIADETAILs.Where(n => n.NEWS_ID == _newsid && n.ID_BAOGIA == idbaogia).ToList();
                    if (list.Count > 0)
                    {
                        list[0].BGD_QUANTITY = Utils.CIntDef(txtquantity.Text);
                        list[0].BGD_UNIT = Utils.CStrDef(txtUnit.Text);
                        list[0].BGD_CHIECKHAU = Utils.CIntDef(txtChieckhau.Text);
                        list[0].BGD_PRICE = Utils.CDecDef(txtprice.Text);
                        if (checkactive.Checked)
                            list[0].BGD_STATUS_DESC = 1;
                        else
                            list[0].BGD_STATUS_DESC = 0;
                        db.SubmitChanges();
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

                loadPro();
            }
        }
        private void Save(string link = "")
        {

            if (idbaogia != 0)
            {
                var list = db.BAO_GIAs.Where(n => n.ID_BAOGIA == idbaogia).ToList();
                if (list.Count > 0)
                {
                    list[0].BG_NAME = txtname.Text;
                    list[0].BG_EMAIL = txtemail.Text;
                    list[0].BG_HP = txthp.Text;
                    list[0].BG_NO = idbaogia.ToString();
                    list[0].BG_SHIP = Utils.CDecDef(txtShip.Value);
                    list[0].BG_NAME_EMPLOY = txtNameEmploy.Text;
                    list[0].BG_EMAIL_EMPLOY = txtEmailEmploy.Text;
                    list[0].BG_HP_EMPLOY = txtHpEmploy.Text;
                    db.SubmitChanges();
                }

            }
            else
            {
                BAO_GIA bg = new BAO_GIA();
                bg.BG_NAME = txtname.Text;
                bg.BG_EMAIL = txtemail.Text;
                bg.BG_HP = txthp.Text;
                bg.BG_NO = idbaogia.ToString();
                bg.BG_SHIP = Utils.CDecDef(txtShip.Value);
                bg.BG_NAME_EMPLOY = txtNameEmploy.Text;
                bg.BG_EMAIL_EMPLOY = txtEmailEmploy.Text;
                bg.BG_HP_EMPLOY = txtHpEmploy.Text;
                bg.BG_DATE = DateTime.Now;
                db.BAO_GIAs.InsertOnSubmit(bg);
                db.SubmitChanges();
                var list = db.BAO_GIAs.OrderByDescending(n => n.ID_BAOGIA).ToList();
                if (list.Count > 0)
                    idbaogia = list[0].ID_BAOGIA;
            }
            SavechangeBGDetail();
            if (String.IsNullOrEmpty(link)) link = "Page-bao-gia.aspx?id=" + idbaogia;
            if (!String.IsNullOrEmpty(link))
                Response.Redirect(link);
        }



        protected void lbtSaveNew_Click(object sender, EventArgs e)
        {
            Save("Page-bao-gia.aspx");
        }


        protected void Lbprint_Click(object sender, EventArgs e)
        {
            Response.Redirect("Page-bao-gia-print.aspx?id=" + idbaogia);
        }
        #region loadPro
        private void loadPro()
        {

            var list = (from a in db.ESHOP_NEWs
                        join b in db.BAO_GIADETAILs on a.NEWS_ID equals b.NEWS_ID
                        where b.ID_BAOGIA == idbaogia
                        select new
                        {
                            a.NEWS_ID,
                            a.NEWS_TITLE,
                            a.UNIT_ID2,
                            a.UNIT_ID1,
                            a.NEWS_PRICE1,
                            a.NEWS_PRICE2,
                            b.BGD_CHIECKHAU,
                            b.BGD_QUANTITY,
                            b.BGD_STATUS_DESC,
                            b.BGD_UNIT,
                            b.BGD_VAT,
                            b.BGD_PRICE
                        }).Distinct().OrderByDescending(n => n.NEWS_ID).ToList();
            if (list.Count > 0)
                Session["NewsListbg"] = DataUtil.LINQToDataTable(list);

            GridItemList.DataSource = list;
            if (list.Count > GridItemList.PageSize)
                GridItemList.AllowPaging = true;
            else
                GridItemList.AllowPaging = false;
            GridItemList.DataBind();
        }
        public string getNameCate(object id)
        {
            int _idcat = Utils.CIntDef(id);
            var list = db.ESHOP_CATEGORies.Where(n => n.CAT_ID == _idcat).ToList();
            if (list.Count > 0)
                return list[0].CAT_NAME;
            return "";
        }
        private void EventDelete(DataGridCommandEventArgs e)
        {
            try
            {
                int NewsId = Utils.CIntDef(GridItemList.DataKeys[e.Item.ItemIndex]);
                var list = db.BAO_GIADETAILs.Where(n => n.ID_BAOGIA == idbaogia && n.NEWS_ID == NewsId);
                db.BAO_GIADETAILs.DeleteAllOnSubmit(list);
                db.SubmitChanges();
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
            }
            finally
            {
                UpdateTotalAmount();
                Response.Redirect("Page-bao-gia.aspx?id=" + idbaogia);
            }
        }
        private void UpdateTotalAmount()
        {
            var list = from a in db.BAO_GIADETAILs
                       join b in db.ESHOP_NEWs on a.NEWS_ID equals b.NEWS_ID
                       where a.ID_BAOGIA == idbaogia
                       select new
                       {
                           b.NEWS_PRICE1
                       };
            decimal price = Utils.CDecDef(list.Sum(n => n.NEWS_PRICE1));
            var updatebaogia = db.BAO_GIAs.Where(n => n.ID_BAOGIA == idbaogia).ToList();
            if (updatebaogia.Count > 0)
            {
                updatebaogia[0].BG_AMOUNT = price;
                db.SubmitChanges();
            }
        }
        #endregion
        #region My Functions
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

        public string getLink(object obj_id)
        {
            return "news.aspx?type=1&news_id=" + Utils.CStrDef(obj_id);
        }

        public string getDate(object News_PublishDate)
        {
            return string.Format("{0:dd/MM/yyyy HH:mm:ss}", News_PublishDate);
        }
        public bool setCheckAcive(object active)
        {
            return Utils.CIntDef(active) == 1 ? true : false;
        }
        public long parelongMoney(object money)
        {
            return Utils.CLngDef(money);
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
                e.Item.Cells[8].Attributes.Add("onClick", "return confirm('Bạn có chắc chắn xóa?');");
            }

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
            string keyword = CpanelUtils.ClearUnicode(txtKeyword.Value);
            int _catid = Utils.CIntDef(ddlCategory.SelectedValue);
            ProductEntity pro = new ProductEntity();
            if (!String.IsNullOrEmpty(keyword))
                pro = getNewsid(keyword, _catid);
            var list = db.BAO_GIADETAILs.Where(n => n.ID_BAOGIA == idbaogia && n.NEWS_ID == pro.NEWS_ID).ToList();
            if (list.Count == 0)
            {
                BAO_GIADETAIL bgdetail = new BAO_GIADETAIL();
                bgdetail.ID_BAOGIA = idbaogia;
                bgdetail.NEWS_ID = pro.NEWS_ID;
                bgdetail.BGD_PRICE = pro.PRICE;
                bgdetail.BGD_QUANTITY = 1;
                db.BAO_GIADETAILs.InsertOnSubmit(bgdetail);
                db.SubmitChanges();
            }
            txtKeyword.Value = "";
            loadPro();
        }
        #region search
        private ProductEntity getNewsid(string keyword, int _catid)
        {

            ProductEntity pro = new ProductEntity();
            var list = (from a in db.ESHOP_NEWs
                        join b in db.ESHOP_NEWS_CATs on a.NEWS_ID equals b.NEWS_ID
                        where (SqlMethods.Like(a.NEWS_KEYWORD_ASCII, "%" + keyword + "%"))
                           && (_catid != 0 ? b.CAT_ID == _catid : true)
                        select new { a.NEWS_ID, a.NEWS_PRICE2 }).ToList();
            if (list.Count > 0)
            {
                pro.NEWS_ID = list[0].NEWS_ID;
                pro.PRICE = list[0].NEWS_PRICE2;
            }
            return pro;
        }
        private class ProductEntity
        {
            public int NEWS_ID { get; set; }
            public decimal? PRICE { get; set; }
        }
        #endregion
    }
}