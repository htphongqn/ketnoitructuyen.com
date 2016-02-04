using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Controller;
using vpro.functions;
using System.IO;
using MVC_Kutun.Components;

namespace MVC_Kutun.vi_vn
{
    public partial class Page_bao_gia_print : System.Web.UI.Page
    {
        int _count = 0;
        Cart_result cart = new Cart_result();
        Propertity per = new Propertity();
        clsFormat fm = new clsFormat();
        protected void Page_Load(object sender, EventArgs e)
        {
            loadLogo();
            loadProduct();
        }
        #region loaddata
        private void loadProduct()
        { 
            Guid _guid = (Guid)Session["news_guid"];
            var list=cart.Load_cart(_guid);
            Rpprobaogia.DataSource = list;
            Rpprobaogia.DataBind();
            Rpdetail.DataSource=list;
            Rpdetail.DataBind();
            decimal _priceamount = cart.Total_Amount(_guid);
            Lbtotal.Text = Lbamount.Text = FormatMoney(_priceamount);
            LbamountChar.Text = fm.DocTienBangChu((_priceamount.ToString()), " đồng").Replace(",", " ");
        }
        private void loadLogo()
        {
            var list = per.Load_logo_or_sologan("1", 1);
            if (list.Count > 0)
            { 
                if(!String.IsNullOrEmpty(list[0].BANNER_FILE))
                    Imglogo.ImageUrl = PathFiles.GetPathBanner(list[0].BANNER_ID)+"/"+list[0].BANNER_FILE;
            }
        }
        #endregion
        #region My Functions
        public string getNameCate(object id)
        {
            int _idcat = Utils.CIntDef(id);
            return per.getNameCate(_idcat);
        }
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
            string strHTMLContent = string.Empty;
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
        public string getAmount(object price, object quantity, object chieckhau)
        {
            decimal _price = Utils.CDecDef(price);
            int _quantity = Utils.CIntDef(quantity);
            int _chieckhau = Utils.CIntDef(chieckhau);
            decimal _total = _price * _quantity;
            decimal _pricechieckhau = _total * _chieckhau / 100;
            decimal _amount = _total - _pricechieckhau;
            return FormatMoney(_amount);
        }
        #endregion
    }
}