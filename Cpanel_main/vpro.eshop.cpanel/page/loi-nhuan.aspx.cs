using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using vpro.functions;
using vpro.eshop.cpanel.Components;
using DevExpress.Web.ASPxGridView;
using vpro.eshop.cpanel.ucControls;

namespace vpro.eshop.cpanel.page
{
    public partial class loi_nhuan : System.Web.UI.Page
    {
        #region Declare
        eshopdbDataContext DB = new eshopdbDataContext();

        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ucHeader.HeaderLevel1 = "Tồn kho";
                ucHeader.HeaderLevel1_Url = "../page/inventory_list.aspx";
                ucHeader.HeaderLevel2 = "Tồn kho";
                ucHeader.HeaderLevel2_Url = "../page/inventory_list.aspx";

            }
            Loadinventory();

        }
        #region Load data
        private void Loadinventory()
        {
            string keyword = CpanelUtils.ClearUnicode(txtKeyword.Value);
            var list = (from a in DB.INVENTORies
                        join b in DB.ESHOP_NEWs on a.NEWS_ID equals b.NEWS_ID
                        where a.INVENT_TYPE == 0
                        && (DB.fClearUnicode(b.NEWS_TITLE).Contains(keyword) || "" == keyword)
                        select new
                        {
                            b.NEWS_ID,
                            b.NEWS_CODE,
                            b.NEWS_TITLE,
                            a.ID,
                            a.INVENT_QUANTITY,
                            a.INVENT_PRICE
                        }).OrderByDescending(n=>n.ID).ToList();
            if (list.Count > 0)
            {
                ASPxGridView_inventory.DataSource = list;
                ASPxGridView_inventory.DataBind();
                HttpContext.Current.Session["buy.listinvent"] = list;
            }
            else
            {
                HttpContext.Current.Session["buy.listinvent"] = null;
                ASPxGridView_inventory.DataSource = list;
                ASPxGridView_inventory.DataBind();
            }
        }
        public int getCountBuy(object news_id)
        {
            int id = Utils.CIntDef(news_id);
            int count = (from a in DB.ESHOP_ORDER_ITEMs
                         join b in DB.ESHOP_NEWs on a.NEWS_ID equals b.NEWS_ID
                         join c in DB.ESHOP_ORDERs on a.ORDER_ID equals c.ORDER_ID
                         where b.NEWS_ID == id && (c.ORDER_STATUS == 2 || c.ORDER_STATUS == 3)
                         select a).ToList().Count;
            return count;
        }
        public int getSlxuat(object id)
        {
            int _id = Utils.CIntDef(id);
            var list = DB.INVENTORies.Where(n => n.INVENT_ID_NHAP_KHO == _id && n.INVENT_TYPE == 1).ToList();
            int _count =Utils.CIntDef(list.Sum(n => n.INVENT_QUANTITY));
            return _count;
        }
        private decimal getPricebuy(object id)
        {
            int _id = Utils.CIntDef(id);
            var list = DB.INVENTORies.Where(n => n.INVENT_ID_NHAP_KHO == _id && n.INVENT_TYPE == 1).ToList();
            return Utils.CDecDef(list.Sum(n=>n.INVENT_PRICE));
        }
        public string getPriceBuyFormat(object id)
        {
            return formatMoney(getPricebanduoc(id));
        }
        public string getPriceMua(object price,object quantity)
        {
            decimal _pri = Utils.CDecDef(price);
            int _quan = Utils.CIntDef(quantity);
            return formatMoney(_pri * _quan);
        }
        private decimal getPricebanduoc(object id)
        {
            int _id = Utils.CIntDef(id);
            decimal _price = 0;
            var list = DB.INVENTORies.Where(n => n.INVENT_ID_NHAP_KHO == _id && n.INVENT_TYPE == 1);
            foreach (var i in list)
            {
                _price += Utils.CIntDef(i.INVENT_QUANTITY) * Utils.CDecDef(i.INVENT_PRICE);
            }
            return _price;
        }
        public string getLoinhuan(object id, object pricenhap,object slnhap)
        {
            decimal _pricenhap = Utils.CDecDef(pricenhap);
            decimal _priceban = getPricebanduoc(id);
            int _soluongnhap = Utils.CIntDef(slnhap);
            decimal _priceloinhuan = _priceban-(_pricenhap * _soluongnhap);
            return formatMoney(_priceloinhuan);
        }
        #endregion
        #region function
        public int getSl(object news_id, int type)
        {
            int id = Utils.CIntDef(news_id);
            var list = DB.INVENTORies.Where(n => n.NEWS_ID == id && n.INVENT_TYPE == type);
            return Utils.CIntDef(list.Sum(n => n.INVENT_QUANTITY));
        }
        public int pareInt(object price)
        {
            return Utils.CIntDef(price);
        }
        public string formatMoney(object money)
        {
            string Money = String.Format("{0:0,0 VNĐ}", money);
            return Money.Replace(",", ".");
        }
        #endregion
        protected void Lbexport_Click(object sender, EventArgs e)
        {
            ASPxGridViewExporter_export.WriteXlsxToResponse();
        }

        protected void lbtSearch_Click(object sender, EventArgs e)
        {
            Loadinventory();
        }

        protected void Lbexprortpdf_Click(object sender, EventArgs e)
        {
            ASPxGridViewExporter_export.WritePdfToResponse();
        }

        protected void lbtSave_Click(object sender, EventArgs e)
        {
            Save();
            Loadinventory();
        }
        private void Save()
        {
            int count = ASPxGridView_inventory.VisibleRowCount;
            for (int i = 0; i < count; i++)
            {
                GridViewDataColumn colid = ASPxGridView_inventory.Columns[0] as GridViewDataColumn;
                //GridViewDataColumn colprice = ASPxGridView_inventory.Columns[2] as GridViewDataColumn;
                GridViewDataColumn colinventory = ASPxGridView_inventory.Columns[5] as GridViewDataColumn;
                HiddenField idhd = ASPxGridView_inventory.FindRowCellTemplateControl(i, colid, "Hdid") as HiddenField;
                //TextBox txtprice = ASPxGridView_inventory.FindRowCellTemplateControl(i, colprice, "txtPricenhap") as TextBox;
                TextBox txtinventory = ASPxGridView_inventory.FindRowCellTemplateControl(i, colinventory, "txtInventory") as TextBox;
                int id = 0;
                if (idhd != null)
                    id = Utils.CIntDef(idhd.Value);
                var list = DB.ESHOP_NEWs.Where(n => n.NEWS_ID == id).ToList();
                if (list.Count > 0)
                {

                    //list[0].NEWS_PRICE3 = Utils.CDecDef(txtprice.Text);

                    list[0].NEWS_INVENTORY = Utils.CIntDef(txtinventory.Text);
                    DB.SubmitChanges();
                }

            }

        }
    }
}