using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using vpro.functions;
using MVC_Kutun.Components;
using System.IO;
using Controller;
using MVC_Kutun.Components;
using System.Data;

namespace MVC_Kutun.MOBILE.UIs
{
    public partial class product_detail : System.Web.UI.UserControl
    {
        #region Declare
        Product_Details pro_detail = new Product_Details();
        Function fun = new Function();
        Attfile att = new Attfile();
        Comment cm = new Comment();
        List_product list_pro = new List_product();
        Getcookie ck = new Getcookie();
        Checkcookie checkck = new Checkcookie();
        setCookieLike setck = new setCookieLike();
        public clsFormat fm = new clsFormat();
        string _sNewsSeoUrl = string.Empty;
        public string comment_url = "";
        int count1 = 1;
        int count2 = 1;
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            _sNewsSeoUrl = Utils.CStrDef(Request.QueryString["purl"]);
            //Hyperlike.Attributes.Add("newsurl", _sNewsSeoUrl);
            if (!IsPostBack)
            {
                Addcookie();
                Addsee();
                //Show_File_HTML_sup("contact-sup.htm");
                Load_Similar_Product(_sNewsSeoUrl);
                //Load_random_quantam(_sNewsSeoUrl);
                Loadimgalbum(0, 10, ref Rpimg);

                loadArea();
                Loaddis(-1);
            }
            Loaddetails();
        }
        #region area
        private void loadArea()
        {
            Drarea.DataValueField = "PROP_ID";
            Drarea.DataTextField = "PROP_NAME";
            Drarea.DataSource = pro_detail.loadArea();
            Drarea.DataBind();
            ListItem l = new ListItem("--- Chọn tỉnh/thành phố ---", "0");
            l.Selected = true;
            Drarea.Items.Insert(0, l);
        }
        private void Loaddis(int id)
        {
            var list = pro_detail.loadAreaDis(id);
            if (list.Count > 0)
            {
                Drdistric.DataValueField = "PROP_ID";
                Drdistric.DataTextField = "PROP_NAME";
                Drdistric.DataSource = list;
                Drdistric.DataBind();
                ListItem l = new ListItem("--- Chọn quận/huyện ---", "0");
                l.Selected = true;
                Drdistric.Items.Insert(0, l);
            }
            else
            {
                DataTable dt = new DataTable("Newtable");

                dt.Columns.Add(new DataColumn("PROP_ID"));
                dt.Columns.Add(new DataColumn("PROP_NAME"));

                DataRow row = dt.NewRow();
                row["PROP_ID"] = 0;
                row["PROP_NAME"] = "--- Chọn quận/huyện ---";
                dt.Rows.Add(row);

                Drdistric.DataTextField = "PROP_NAME";
                Drdistric.DataValueField = "PROP_ID";
                Drdistric.DataSource = dt;
                Drdistric.DataBind();

            }
        }
        protected void Drarea_SelectedIndexChanged(object sender, EventArgs e)
        {
            int id = Utils.CIntDef(Drarea.SelectedValue);
            Loaddis(id);
            Drdistric.Focus();
        }

        protected void Drdistric_SelectedIndexChanged(object sender, EventArgs e)
        {
            Lbgiaohang.Text = pro_detail.getGiaohang(Utils.CIntDef(Drdistric.SelectedValue));
            Drdistric.Focus();
        }
        #endregion
        #region Addcookie
        private void Addcookie()
        {
            if (!checkck.Listcookie_see().Contains(_sNewsSeoUrl))
                ck.Addcookie(_sNewsSeoUrl);
        }
        #endregion
        #region Addsee
        private void Addsee()
        {
            pro_detail.Addsee(_sNewsSeoUrl);
        }
        #endregion
        #region Loaddata

        public void Load_img_news(int take, int skip, ref Repeater rp)
        {
            rp.DataSource = pro_detail.Load_Product_Detail(_sNewsSeoUrl);
            rp.DataBind();
        }
        public void Loadimgalbum(int skip, int limit, ref Repeater rp)
        {
            try
            {
                int _newsID = Utils.CIntDef(Session["news_id"]);
                var list = pro_detail.Load_albumimg(_newsID, skip, limit).ToList();
                if (list.Count > 0)
                {
                    rp.DataSource = list;
                    rp.DataBind();

                }

            }
            catch (Exception)
            {

                throw;
            }
        }
        public void Loaddetails()
        {
            try
            {
                Show_File_HTML();
                var list = pro_detail.Load_Product_Detail(_sNewsSeoUrl);
                if (list.Count > 0)
                {
                    Lbtitle_details.Text = list[0].NEWS_TITLE;
                    lbcode.Text = list[0].NEWS_CODE;
                    Lbweight.Text = list[0].NEWS_FIELD4;
                    Lbvat.Text = Utils.CIntDef(list[0].UNIT_ID3) == 0 ? "có VAT" : "chưa VAT";
                    //Lbdesc_details.Text = setBr(list[0].NEWS_DESC);
                    //Lbdesc_bot.Text = setBr(list[0].NEWS_FIELD4);
                    //Lbcount_see.Text = list[0].NEWS_COUNT.ToString();
                    //Lbcount_buy.Text = list[0].UNIT_ID3.ToString();
                    Hyperaddtocart.NavigateUrl = "../vi-vn/Addtocart.aspx?id=" + list[0].NEWS_ID;
                    //HyperaddTocart2.NavigateUrl = "../vi-vn/Addtocart.aspx?id=" + list[0].NEWS_ID;
                    Lbbaohanh.Text = list[0].NEWS_FIELD2;
                    Hyperthuonghieu.NavigateUrl = pro_detail.getSeourl(Utils.CIntDef(list[0].UNIT_ID2));
                    Litthuonghieu_info.Text = list_pro.getHmtlSeo(Utils.CIntDef(list[0].UNIT_ID2));
                    Lbxuatxu.Text = pro_detail.getnamecate(list[0].UNIT_ID1);
                    if (pro_detail.checkCateImg(list[0].UNIT_ID2))
                    {
                        Hyperthuonghieu.ImageUrl = pro_detail.getimgCate(list[0].UNIT_ID2);

                    }
                    else
                    {
                        Hyperthuonghieu.Text = pro_detail.getnamecate(list[0].UNIT_ID2);
                    }

                    if (Utils.CIntDef(list[0].NEWS_FIELD3) == 0)
                    {
                        Hyperaddtocart.Text = "<span>Hết hàng</span>";
                        Hyperaddtocart.Enabled = false;
                        Hyperaddtocart.CssClass = "cart_btn";

                    }
                    else
                    {
                        Hyperaddtocart.Text = "<span>Đặt mua</span>";
                        Hyperaddtocart.Enabled = true;

                    }
                    lbtinhtrang.Text = Utils.CIntDef(list[0].NEWS_FIELD3) == 1 ? "Còn hàng" : "Hết hàng";
                    //Lbprice_goc.Text = GetPrice2(list[0].NEWS_PRICE1, list[0].NEWS_PRICE2);
                    if (Utils.CDecDef(list[0].NEWS_PRICE2) != 0 || Utils.CIntDef(list[0].NEWS_PRICE3) != 0)
                        div_tietkiem.Visible = true;
                    else
                        div_tietkiem.Visible = false;
                    if (Utils.CIntDef(list[0].NEWS_PERIOD) == 3 && list[0].NEWS_UPDATE >= DateTime.Today)
                    {
                        Lbprice_goc.Text = GetPrice2(list[0].NEWS_PRICE1, list[0].NEWS_PRICE3);
                        Lbprice_buy.Text = GetPrice1(list[0].NEWS_PRICE1, list[0].NEWS_PRICE3);
                        lbPricetietkiem.Text = getTietkiem(list[0].NEWS_PRICE1, list[0].NEWS_PRICE3);
                        Lbpricepointtietkiem.Text = getPointietkiem(list[0].NEWS_PRICE1, list[0].NEWS_PRICE3);
                        //Lbgiam.Text = getPointietkiemNotsymbol(list[0].NEWS_PRICE1, list[0].NEWS_PRICE3);
                    }
                    else
                    {
                        Lbprice_goc.Text = GetPrice2(list[0].NEWS_PRICE1, list[0].NEWS_PRICE2);
                        Lbprice_buy.Text = GetPrice1(list[0].NEWS_PRICE1, list[0].NEWS_PRICE2);
                        lbPricetietkiem.Text = getTietkiem(list[0].NEWS_PRICE1, list[0].NEWS_PRICE2);
                        Lbpricepointtietkiem.Text = getPointietkiem(list[0].NEWS_PRICE1, list[0].NEWS_PRICE2);
                        //Lbgiam.Text = getPointietkiemNotsymbol(list[0].NEWS_PRICE1, list[0].NEWS_PRICE2);
                    }
                    //lbPricetietkiem.Text = getTietkiem(list[0].NEWS_PRICE1, list[0].NEWS_PRICE2);
                    //Lbpricepointtietkiem.Text = getPointietkiem(list[0].NEWS_PRICE1, list[0].NEWS_PRICE2);
                    Lbface.Text = "<div class='fb-like' data-href='" + Request.RawUrl + "'data-layout='button_count' data-action='like' data-show-faces='true' data-share='true' style='float: left'> </div>";
                    //if (checkck.Listcookie_like().Contains(_sNewsSeoUrl))
                    //{
                    //    Hyperlike.Attributes.Add("class", "active");
                    //    Hyperlike.Text = "Đã thêm vào yêu thích";
                    //    Hyperlike.Enabled = false;
                    //}
                    //Lbtitle.Text = pro_detail.Load_Product_Detail(_sNewsSeoUrl)[0].NEWS_TITLE;
                }

            }
            catch (Exception ex)
            {

                clsVproErrorHandler.HandlerError(ex);
            }
        }
        
        private void Show_File_HTML()
        {
            try
            {
                int _newsID = Utils.CIntDef(Session["news_id"]);
                liHtml_info.Text = pro_detail.Show_File_HTML(_newsID, 1);
                //Litthuonghieu_info.Text = pro_detail.Show_File_HTML(_newsID, 2);
                //Literal_bailienquan.Text = pro_detail.Show_File_HTML(_newsID, 3);
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
            }
        }

        public void Load_Similar_Product(string News_Seo_Url)
        {
            try
            {
                rp_sanphamcungloai.DataSource = pro_detail.Load_Similar_Product(_sNewsSeoUrl, 10);
                rp_sanphamcungloai.DataBind();
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
            }
        }
        //private void Load_random_quantam(string News_Seo_Url)
        //{
        //    Rpproquantam.DataSource = pro_detail.loadPro_Random(News_Seo_Url, 5);
        //    Rpproquantam.DataBind();
        //}

        #endregion
        #region function
        public string getBuy(object news_id, object sta)
        {
            return fun.getBuy(news_id, sta);
        }
        public string getNewsurl()
        {
            return _sNewsSeoUrl;
        }
        public string getUrlface()
        {
            return System.Configuration.ConfigurationManager.AppSettings["URLWebsite"] + Request.RawUrl;
        }
        public string getCount1()
        {
            return "pimg" + count1++;
        }
        public string getCount2()
        {
            return "pimg" + count2++;
        }
        private string setBr(object desc)
        {
            string _des = Utils.CStrDef(desc);
            if (!String.IsNullOrEmpty(_des))
            {
                if (_des.Contains("\r\n")) _des = _des.Replace("\r\n", "<br/>");
            }
            return _des;
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
        public string getTietkiem(object News_Price1, object News_Price2)
        {
            return fun.getTietkiem(News_Price1, News_Price2);
        }
        public string getPointietkiem(object News_Price1, object News_Price2)
        {
            return fun.getPointietkiem(News_Price1, News_Price2);
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
        public string getnamecate(object newsid)
        {
            try
            {
                return pro_detail.getnamecate(newsid);
            }
            catch (Exception)
            {

                throw;
            }
        }
        #endregion

        protected void Lbaddtocart_Click(object sender, EventArgs e)
        {
            try
            {
                var list = pro_detail.Load_Product_Detail(_sNewsSeoUrl);
                if (list.Count > 0)
                {
                    if (Utils.CDecDef(list[0].NEWS_PRICE1) != 0)
                        Response.Redirect("../vi-vn/Addtocart.aspx?id=" + list[0].NEWS_ID, true);
                    else
                    {
                        string strScript = "<script>";
                        strScript += "alert(' Bạn hãy liên hệ chúng tôi để mua sản phẩm này!');";
                        strScript += "</script>";
                        Page.RegisterClientScriptBlock("strScript", strScript);
                    }
                }
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);

            }
        }

        protected void Lbaddlike_Click(object sender, EventArgs e)
        {
            string url = Request.RawUrl;
            if (!String.IsNullOrEmpty(url))
            {
                string[] a = url.Split('?');
                if (!checkck.Listcookie_like().Contains(_sNewsSeoUrl))
                {
                    setck.Addcookie(_sNewsSeoUrl);
                    string strScript = "<script>";
                    strScript += "alert('Đã thêm vào yêu thích!');";
                    strScript += "window.location='" + a[0] + "';";
                    strScript += "</script>";
                    Page.RegisterClientScriptBlock("strScript", strScript);
                }
                else
                {
                    string strScript = "<script>";
                    strScript += "alert(' Bạn đã thích sản phẩm này!');";
                    strScript += "window.location='" + a[0] + "';";
                    strScript += "</script>";
                    Page.RegisterClientScriptBlock("strScript", strScript);
                }
            }

        }
    }
}