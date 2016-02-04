using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using vpro.functions;
using System.Web.UI.HtmlControls;
using System.Data;
using vpro.eshop.cpanel.Components;
using vpro.eshop.cpanel.ucControls;

namespace vpro.eshop.cpanel.page
{
    public partial class danh_sach_bao_hanh : System.Web.UI.Page
    {
        private int _count = 0;
        eshopdbDataContext db = new eshopdbDataContext();
        int type = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

            type = Utils.CIntDef(Request["type"]);
            if (!IsPostBack)
            {
                ucHeader.HeaderLevel1 = "Danh sách bảo hành";
                ucHeader.HeaderLevel1_Url = "../page/danh-sach-bao-hanh.aspx";
                ucHeader.HeaderLevel2 = "Danh sách bảo hành";
                ucHeader.HeaderLevel2_Url = "../page/danh-sach-bao-hanh.aspx";

                loadListBaohanh();
            }
        }
       
        #region getNamecate
        public string getNameCate(object id)
        {
            int cat_id = Utils.CIntDef(id);
            var list = db.ESHOP_CATEGORies.Where(n => n.CAT_ID == cat_id).ToList();
            if (list.Count > 0) return list[0].CAT_NAME;
            return "";
        }
        #endregion
        private void loadListBaohanh()
        {
            string keyword = CpanelUtils.ClearUnicode(txtKeyword.Value);
            int idsta = Utils.CIntDef(drstatus.SelectedValue);
            var list = db.BAOHANHs.Where(n => (db.fClearUnicode(n.BH_PHONE).Contains(keyword)|| db.fClearUnicode(n.BH_SOPHIEU).Contains(keyword) || "" == keyword) && (n.BH_STATUS == idsta || -1 == idsta)).ToList();
            GridItemList.DataSource = list;
            GridItemList.DataBind();
        }
        #region function
        public string getName(object id)
        {
            int userid = Utils.CIntDef(id);
            var list = db.ESHOP_USERs.Where(n => n.USER_ID == userid).ToList();
            if (list.Count > 0) return list[0].USER_NAME;
            return "";
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

                        j++;
                    }

                    i++;
                }

                //delete 
                var g_delete = db.GetTable<BAOHANH>().Where(g => items.Contains(g.ID));

                db.BAOHANHs.DeleteAllOnSubmit(g_delete);
                db.SubmitChanges();
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
            }
            finally
            {
                items = null;
                loadListBaohanh();
            }

        }
        private void EventDelete(DataGridCommandEventArgs e)
        {
            int BannerId = Utils.CIntDef(GridItemList.DataKeys[e.Item.ItemIndex]);
            DeleteInfo(BannerId);
        }

        private void DeleteInfo(int ad_id)
        {
            string strLink = "";
            try
            {

                var G_info = db.GetTable<BAOHANH>().Where(g => g.ID == ad_id);
                db.BAOHANHs.DeleteAllOnSubmit(G_info);
                db.SubmitChanges();
                strLink = "danh-sach-bao-hanh.aspx";

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

        private void DeleteAllFilesInFolder(string folderpath)
        {
            foreach (var f in System.IO.Directory.GetFiles(folderpath))
                System.IO.File.Delete(f);
        }
        #endregion
        #region function
       
        public string catngay(string ngay)
        {
            string[] listngay = ngay.Split('-');
            return listngay[2] + "/" + listngay[1] + "/" + listngay[0];
        }
        public int pareInt(object price)
        {
            return Utils.CIntDef(price);
        }
        public string getOrder()
        {
            _count = _count + 1;
            return _count.ToString();
        }
        public string getLink(object obj_id)
        {
            return "bao-hanh.aspx?id=" + obj_id;
        }
        public string getDate(object News_PublishDate)
        {
            return string.Format("{0:dd/MM/yyyy HH:mm:ss}", News_PublishDate);
        }
        public string getstatus(object sta)
        {
            int id = Utils.CIntDef(sta);
            switch (id)
            {
                case 0: return "Chưa xử lý";
                case 1: return "Đang xử lý";
                case 2: return "Đã trả";
                default: return "";
            }
        }
        #endregion
        #region Grid Events
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

            DataTable dataTable = Session["baohanhlist"] as DataTable;
            DataView sortedView = new DataView(dataTable);
            sortedView.Sort = e.SortExpression + " " + sortingDirection;
            GridItemList.DataSource = sortedView;
            GridItemList.DataBind();
        }

        protected void GridItemList_PageIndexChanged(object source, DataGridPageChangedEventArgs e)
        {
            GridItemList.CurrentPageIndex = e.NewPageIndex;
            _count = (Utils.CIntDef(GridItemList.CurrentPageIndex, 0) * GridItemList.PageSize);
            GridItemList.DataSource = Session["baohanhlist"] as DataTable;
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
                e.Item.Cells[16].Attributes.Add("onClick", "return confirm('Bạn có chắc chắn xóa?');");
            }

        }

        #endregion

        protected void lbtSearch_Click(object sender, EventArgs e)
        {
            loadListBaohanh();
        }
    }
}