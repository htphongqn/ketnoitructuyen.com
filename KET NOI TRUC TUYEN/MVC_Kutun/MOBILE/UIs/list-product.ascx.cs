using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using vpro.functions;
using MVC_Kutun.Components;
using Controller;

namespace MVC_Kutun.MOBILE.UIs
{
    public partial class list_product : System.Web.UI.UserControl
    {
        #region Declare
        List_product list_pro = new List_product();
        Function fun = new Function();
        clsFormat fm = new clsFormat();
        Pageindex_chage change = new Pageindex_chage();
        Home index = new Home();
        Checkcookie cki = new Checkcookie();
        int _Catid = 0, _idhangsx = 0;
        string _cat_seo_url = string.Empty;
        int _page = 0;
        string _price;
        int _pricetype;
        public static int _coutrow = 0;
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            _Catid = Utils.CIntDef(Session["Cat_id"]);
            _cat_seo_url = Request.QueryString["purl"];
            _page = Utils.CIntDef(Request.QueryString["page"]);
            _idhangsx = Utils.CIntDef(Request.QueryString["idhangsx"]);
            _pricetype = Utils.CIntDef(Request.QueryString["typepri"]);
            _price = Utils.CStrDef(Request.QueryString["price"]);
            if (!IsPostBack)
            {

                Loadtitle();
                Loadlist();
            }
        }


        public void Loadtitle()
        {
            try
            {
                Lbtitle.Text = list_pro.Loadtitle(_cat_seo_url);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public void Loadlist()
        {
            try
            {

                int sotin = list_pro.Getsotin(_Catid);
                if (list_pro.checkHangsx(_Catid))
                {
                    var listhsx = list_pro.loadProhangsx(_Catid, _pricetype, _price, 0);
                    _coutrow = listhsx.Count;
                    if (listhsx.Count > 0)
                    {
                        Rplistpro.DataSource = listhsx.Take(15);
                        Rplistpro.DataBind();
                    }
                    return;
                }
                var list = list_pro.Load_listpro(_Catid, _idhangsx, _pricetype, _price, 0);
                _coutrow = list.Count;
                if (list.Count > 0)
                {
                    Rplistpro.DataSource = list.Take(15);
                    Rplistpro.DataBind();

                }
                Hdcount.Value = _coutrow.ToString();
            }
            catch (Exception)
            {

                throw;
            }
        }

        #region function
        public int getCount()
        {
            return _coutrow;
        }
        public int getCatid()
        {
            return _Catid;
        }
        public string getBuy(object news_id, object sta)
        {
            return fun.getBuy(news_id, sta);
        }
        public string Getprice(object News_Price1)
        {
            return fun.Getprice(News_Price1);
        }
        public decimal Getprice_addtocart(object News_Price1)
        {
            return fun.Getprice_addtocart(News_Price1);
        }
        public string GetPrice1(object News_Price1, object News_Price2)
        {
            try
            {
                return fun.Getprice1(News_Price1, News_Price2);
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
                return null;
            }
        }
        public string GetPrice2(object News_Price1, object News_Price2)
        {
            try
            {
                return fun.Getprice2(News_Price1, News_Price2);
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
                return null;
            }
        }
        public string Getgiam(object News_Price1, object News_Price2)
        {
            return fun.Getgiamgia(News_Price1, News_Price2);
        }
        public string GetLink(object News_Url, object News_Seo_Url, object cat_seo)
        {
            try
            {
                return fun.Getlink_News(News_Url, News_Seo_Url, cat_seo);
            }
            catch (Exception ex)
            {
                vpro.functions.clsVproErrorHandler.HandlerError(ex);
                return null;
            }
        }
        public string GetImageT(object News_Id, object News_Image1)
        {

            try
            {
                return fun.GetImageT_News(News_Id, News_Image1);
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
                return null;
            }
        }
        public string getdate(object date)
        {
            return fun.getDate(date);
        }
        #endregion
    }
}