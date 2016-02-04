using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using vpro.functions;
using vpro.eshop.cpanel.Components;

namespace vpro.eshop.cpanel.page
{
    public partial class print_kho : System.Web.UI.Page
    {
        eshopdbDataContext db = new eshopdbDataContext();
        formatData fm = new formatData();
        int id = 0,_count=1;
        protected void Page_Load(object sender, EventArgs e)
        {
            id = Utils.CIntDef(Request["id"]);
            loadListInventory();
            loadLogo();
        }
        private void loadLogo()
        {
            var list = db.ESHOP_BANNERs.Where(n => n.BANNER_FIELD1 == "1").OrderByDescending(n => n.BANNER_ID).Take(1).ToList();
            if (list.Count > 0)
                Image_Logo.ImageUrl = PathFiles.GetPathBanner(list[0].BANNER_ID) + "/" + list[0].BANNER_FILE;
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
        public string getTypeinvent()
        {
            var list = db.INVENTORies.Where(n => n.ID == id).ToList();
            if (list.Count > 0)
                if (list[0].INVENT_TYPE == 0)
                    return "PHIẾU NHẬP KHO";
                else return "PHIẾU XUẤT KHO";
            return "";
        }
        private void loadListInventory()
        {
           
            var list = (from a in db.ESHOP_NEWs
                        join b in db.INVENTORies on a.NEWS_ID equals b.NEWS_ID
                        where b.ID==id
                        select new
                        {
                            a.NEWS_TITLE,
                            a.NEWS_CODE,
                            b.INVENT_TYPE,
                            b.ID,
                            b.INVENT_DATE,
                            b.INVENT_QUANTITY,
                            b.USER_ID,
                            b.INVENT_NHACC,
                            b.INVENT_KHO,
                            b.INVENT_PRICE,
                            b.INVENT_NAMEKH,
                            b.INVENT_ADDRESS,
                            b.INVENT_NO,
                            b.INVENT_CHIECKHAU,
                            b.INVENT_NOTE

                        }).OrderByDescending(n => n.ID).ToList();
            if (list.Count > 0)
            {
                Lbname.Text = list[0].INVENT_NAMEKH;
                Lbadd.Text = list[0].INVENT_ADDRESS;
                Lbnote.Text = list[0].INVENT_NOTE;
                Lbdate.Text = getDate(list[0].INVENT_DATE);
                Rpkho.DataSource = list;
                Rpkho.DataBind();
            }
        }
        #region function
        public string getName(object id)
        {
            int userid = Utils.CIntDef(id);
            var list = db.ESHOP_USERs.Where(n => n.USER_ID == userid).ToList();
            if (list.Count > 0) return list[0].USER_NAME;
            return "";
        }
        public string totalMoney(object price, object chieckhau, object soluong)
        {
            decimal _price = Utils.CDecDef(price);
            int _chieck = Utils.CIntDef(chieckhau);
            int _quantity = Utils.CIntDef(soluong);
            decimal _total = _price * _quantity;
            _total = _total + (_total * _chieck / 100);
            return fm.FormatMoney(_total);
        }
        #endregion
        #region function
        public int setOrder()
        {
            return _count++;
        }
        public string catngay(string ngay)
        {
            string[] listngay = ngay.Split('-');
            return listngay[2] + "/" + listngay[1] + "/" + listngay[0];
        }
        public int pareInt(object price)
        {
            return Utils.CIntDef(price);
        }
        public string formatMoney(object price)
        {
            return fm.FormatMoney(price);
        }
        public string getLink(object obj_id)
        {
            return "nhap-kho.aspx?id=" + obj_id;
        }
        public string getDate(object News_PublishDate)
        {
            return string.Format("{0:dd/MM/yyyy}", News_PublishDate);
        }
        #endregion
    }
}