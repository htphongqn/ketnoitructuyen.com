using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using vpro.functions;
using vpro.eshop.cpanel.Components;
using System.IO;

namespace vpro.eshop.cpanel.page
{
    public partial class Page_bao_gia_print : System.Web.UI.Page
    {
        #region Declare
        private int _idbaogia = 0;
        eshopdbDataContext db = new eshopdbDataContext();
        formatData fm = new formatData();
        int _count = 0;
        private decimal _totalamount = 0;
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            _idbaogia = Utils.CIntDef(Request["id"]);
            if (!IsPostBack)
            {
                loadInfo();
                loadDescProduct();
            }
        }
        private void loadInfo()
        { 
             var list = (from a in db.ESHOP_NEWs
                       join b in db.BAO_GIADETAILs on a.NEWS_ID equals b.NEWS_ID
                       join c in db.BAO_GIAs on b.ID_BAOGIA equals c.ID_BAOGIA
                       where b.ID_BAOGIA==_idbaogia
                       select new
                        {
                            a.NEWS_ID,
                            a.NEWS_TITLE,
                            a.NEWS_SEO_URL,
                            a.UNIT_ID2,
                            a.UNIT_ID1,
                            a.NEWS_PRICE1,
                            a.NEWS_PRICE2,
                            a.UNIT_ID3,
                            c.BG_AMOUNT,
                            c.BG_DATE,
                            c.BG_HP,
                            c.BG_NAME,
                            c.BG_NO,
                            c.BG_VAT,
                            c.BG_SHIP,
                            c.BG_EMAIL,
                            c.BG_NAME_EMPLOY,
                            c.BG_EMAIL_EMPLOY,
                            c.BG_HP_EMPLOY,
                            b.BGD_CHIECKHAU,
                            b.BGD_QUANTITY,
                            b.BGD_STATUS_DESC,
                            b.BGD_UNIT,
                            b.BGD_PRICE
                        }).Distinct().OrderByDescending(n=>n.NEWS_ID).ToList();
             if (list.Count > 0)
             {
                 LitinfoEmp.Text = list[0].BG_NAME_EMPLOY + "<br/>" + list[0].BG_EMAIL_EMPLOY + "<br/>" + list[0].BG_HP_EMPLOY;
                 Lbname.Text = list[0].BG_NAME;
                 lbemail.Text = list[0].BG_EMAIL;
                 Lbno.Text = list[0].BG_NO;
                 lbhp.Text = list[0].BG_HP;
                 Lbdate.Text ="Ngày "+ getDate(DateTime.Now);
                 lbShip.Text = FormatMoney(list[0].BG_SHIP);
                 Rpprobaogia.DataSource = list;
                 Rpprobaogia.DataBind();
                 Lbtotal.Text = FormatMoney(_totalamount);
                 decimal _priceamount = _totalamount + Utils.CDecDef(list[0].BG_SHIP);
                 Lbamount.Text = FormatMoney(_priceamount);
                 LbamountChar.Text = fm.DocTienBangChu((_priceamount.ToString()), " đồng").Replace(","," ");
             }
        }
        private void loadDescProduct()
        {
            var list = (from a in db.ESHOP_NEWs
                        join b in db.BAO_GIADETAILs on a.NEWS_ID equals b.NEWS_ID
                        join c in db.BAO_GIAs on b.ID_BAOGIA equals c.ID_BAOGIA
                        where b.ID_BAOGIA == _idbaogia
                        && b.BGD_STATUS_DESC == 1
                        select new
                        {
                            a.NEWS_ID,
                            a.NEWS_FILEHTML,
                            a.NEWS_IMAGE3
                        }).ToList();
            Rpdetail.DataSource = list;
            Rpdetail.DataBind();
        }
        public string getNameCate(object id)
        {
            int _idcat = Utils.CIntDef(id);
            var list = db.ESHOP_CATEGORies.Where(n => n.CAT_ID == _idcat).ToList();
            if (list.Count > 0)
                return list[0].CAT_NAME;
            return "";
        }
        #region My Functions
        public string FormatMoney(object Expression)
        {
            try
            {
                string Money = String.Format("{0:0,0}", Expression);
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
       
        public string getLink(object news_seo_url)
        {
            return "/san-pham/" + news_seo_url + ".aspx";
        }
        public string getImage(object news_id, object img)
        {
            string _img = Utils.CStrDef(img);
            if (!String.IsNullOrEmpty(_img))
                return PathFiles.GetPathNews(Utils.CIntDef(news_id)) + "/" + _img;
            return string.Empty;
        }
        public string showHmtl(object news_id, object filehml)
        {
            int _id = Utils.CIntDef(news_id);
            string _htmlfile = Utils.CStrDef(filehml);
            string pathFile;
            string strHTMLContent = string.Empty ;
            pathFile = Server.MapPath(PathFiles.GetPathNews(_id) + "/" + _htmlfile);
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
        public string getDate(object News_PublishDate)
        {
            return string.Format("{0:dd/MM/yyyy}", News_PublishDate);
        }
        public string getVat(object vat)
        {
            return Utils.CIntDef(vat) == 0 ? "Có VAT" : "Chưa VAT";
        }
        public string getAmount(object price, object quantity,object chieckhau)
        {
            decimal _price = Utils.CDecDef(price);
            int _quantity = Utils.CIntDef(quantity);
            int _chieckhau = Utils.CIntDef(chieckhau);
            decimal _total = _price * _quantity;
            decimal _pricechieckhau = _total * _chieckhau / 100;
            decimal _amount=_total - _pricechieckhau;
            _totalamount += _amount;
            return FormatMoney(_amount);
        }
        #endregion
    }
}