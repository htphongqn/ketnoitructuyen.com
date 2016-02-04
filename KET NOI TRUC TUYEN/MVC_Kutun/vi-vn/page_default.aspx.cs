using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using vpro.functions;
using System.Web.UI.HtmlControls;
using Controller;
using MVC_Kutun.Components;

namespace MVC_Kutun.vi_vn
{
    public partial class page_default : System.Web.UI.Page
    {
        #region Declare
        Get_session getsession = new Get_session();
        Config cf = new Config();
        setCookieDevice setckdv = new setCookieDevice();
        int device = 0;
        #endregion
        #region Page Event
        protected void Page_PreInit(object sender, EventArgs e)
        {
            HttpCookie cookie = setckdv.GetCookie();
            if (Request.Cookies["deviceck"] != null)
            {
                if (cookie.HasKeys)
                {
                    device = 1;
                }
                else if (Request.Browser.IsMobileDevice)
                {
                    device = 1;
                }
            }
            //else if (Request.Browser.IsMobileDevice)
            //{
            //    device = 1;
            //}
            if (device == 0) Page.MasterPageFile = "/Master/Master.Master";
            else Page.MasterPageFile = "/MOBILE/Master/Master.Master";
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                Session["home"] = 1;
                HttpContext.Current.Session["Cat_id_home"] = 0;
                Bind_icon();
                string _catSeoUrl = Utils.CStrDef(Request.QueryString["purl"]);
                string _newsSeoUrl = Utils.CStrDef(Request.QueryString["purl"]);

                UserControl list_pro = null;
                UserControl prodetails = null;
                UserControl list_news = null;
                UserControl details_news = null;
                UserControl search = null;
                UserControl list_thuonghieu = null;

                if (device == 0)
                {
                    list_pro = Page.LoadControl("../UIs/list-product.ascx") as UserControl;
                    prodetails = Page.LoadControl("../UIs/product-details.ascx") as UserControl;
                    list_news = Page.LoadControl("../UIs/listnews.ascx") as UserControl;
                    details_news = Page.LoadControl("../UIs/news-details.ascx") as UserControl;
                    search = Page.LoadControl("../UIs/search-result.ascx") as UserControl;
                    list_thuonghieu = Page.LoadControl("../UIs/List-thuonghieu.ascx") as UserControl;
                }
                else
                {
                    list_pro = Page.LoadControl("/MOBILE/UIs/list-product.ascx") as UserControl;
                    prodetails = Page.LoadControl("/MOBILE/UIs/product-detail.ascx") as UserControl;
                    list_news = Page.LoadControl("/MOBILE/UIs/list-news.ascx") as UserControl;
                    details_news = Page.LoadControl("/MOBILE/UIs/news-details.ascx") as UserControl;
                    search = Page.LoadControl("/MOBILE/UIs/search-result.ascx") as UserControl;
                }
                int _type = Utils.CIntDef(Request["type"]);
               

                switch (_type)
                {

                    case 3:
                            getsession.LoadCatInfo(_catSeoUrl);
                            Bind_meta_tags_cat();
                            if (Utils.CIntDef(Session["Cat_type"]) == 1 || Utils.CIntDef(Session["Cat_type"]) == 2 || Utils.CIntDef(Session["Cat_type"]) == 3 || _catSeoUrl.Contains("san-pham-yeu-thich"))
                            {
                                if (Utils.CIntDef(Session["Cat_type"]) == 2 && Utils.CIntDef(Session["Cat_rank"])==1)
                                    phdMain.Controls.Add(list_thuonghieu);
                                else
                                    phdMain.Controls.Add(list_pro);
                            }
                            else
                            {
                                if (Utils.CIntDef(Session["Cat_showitem"]) == 1)
                                {
                                    phdMain.Controls.Add(details_news);
                                }
                                else phdMain.Controls.Add(list_news);
                            }
                        break;
                    case 5:
                        Bind_meta_tag_index();
                        phdMain.Controls.Add(search);
                        break;
                    case 6:
                        getsession.LoadNewsInfo(_newsSeoUrl);
                        Bind_meta_tags_news();
                        phdMain.Controls.Add(prodetails);
                        break;
                    case 7:
                        getsession.LoadNewsInfo(_newsSeoUrl);
                        Bind_meta_tags_news();
                        phdMain.Controls.Add(details_news);
                        break;


                    default:
                        Response.Redirect("/");
                        break;
                }
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
            }
        }
        #endregion
        public void Bind_meta_tags_cat()
        {
            #region Bind Meta Tags
            HtmlHead header = base.Header;
            HtmlMeta headerDes = new HtmlMeta();
            HtmlMeta headerKey = new HtmlMeta();

            headerDes.Name = "Description";
            headerKey.Name = "Keywords";

            header.Title = Utils.CStrDef(Session["Cat_seo_title"]);
            headerDes.Content = Utils.CStrDef(Session["Cat_seo_desc"]);
            headerKey.Content = Utils.CStrDef(Session["Cat_seo_keyword"]);


            if (string.IsNullOrEmpty(headerDes.Content))
            {
                headerDes.Content = "";
            }
            header.Controls.Add(headerDes);

            if (string.IsNullOrEmpty(headerKey.Content))
            {
                headerKey.Content = "";
            }

            header.Controls.Add(headerKey);
            #endregion
        }
        public void Bind_meta_tags_news()
        {
            #region Bind Meta Tags
            HtmlHead header = base.Header;
            HtmlMeta headerDes = new HtmlMeta();
            HtmlMeta headerKey = new HtmlMeta();
            //Face tags
            HtmlMeta propety = new HtmlMeta();
            HtmlMeta propetyTitle = new HtmlMeta();
            HtmlMeta propetyDesc = new HtmlMeta();
            //Twitter tags
            HtmlMeta propetyTw = new HtmlMeta();
            HtmlMeta propetyTitleTw = new HtmlMeta();
            HtmlMeta propetyDescTw = new HtmlMeta();

            headerDes.Name = "Description";
            headerKey.Name = "Keywords";
            header.Title = Utils.CStrDef(Session["News_seo_title"]);
            headerDes.Content = Utils.CStrDef(Session["News_seo_desc"]);
            headerKey.Content = Utils.CStrDef(Session["News_seo_keyword"]);
            if (string.IsNullOrEmpty(headerDes.Content))
            {
                headerDes.Content = "";
            }
            header.Controls.Add(headerDes);

            if (string.IsNullOrEmpty(headerKey.Content))
            {
                headerKey.Content = "";
            }

            header.Controls.Add(headerKey);
            //Facebook meta
            propety.Attributes.Add("property", "og:image");
            propety.Content = "" + System.Configuration.ConfigurationManager.AppSettings["URLWebsite"] + "" + PathFiles.GetPathNews(Utils.CIntDef(Session["News_id"])) + Utils.CStrDef(Session["News_image3"]);
            header.Controls.Add(propety);
            //Title         
            propetyTitle.Attributes.Add("property", "og:title");
            propetyTitle.Content = Utils.CStrDef(Session["News_seo_title"]);
            header.Controls.Add(propetyTitle);
            //Desc
            propetyDesc.Attributes.Add("property", "og:description");
            propetyDesc.Content = Utils.CStrDef(Session["News_seo_desc"]);
            header.Controls.Add(propetyDesc);
            //Twitter meta
            propetyTw.Attributes.Add("property", "twitter:image");
            propetyTw.Content = "" + System.Configuration.ConfigurationManager.AppSettings["URLWebsite"] + "" + PathFiles.GetPathNews(Utils.CIntDef(Session["News_id"])) + Utils.CStrDef(Session["News_image3"]);
            header.Controls.Add(propetyTw);
            //Title         
            propetyTitleTw.Attributes.Add("property", "twitter:title");
            propetyTitleTw.Content = Utils.CStrDef(Session["News_seo_title"]);
            header.Controls.Add(propetyTitleTw);
            //Desc
            propetyDescTw.Attributes.Add("property", "twitter:description");
            propetyDescTw.Content = Utils.CStrDef(Session["News_seo_desc"]);
            header.Controls.Add(propetyDescTw);


            #endregion
        }
        private void Bind_icon()
        {
            var _configs = cf.Config_meta();

            if (_configs.ToList().Count > 0)
            {
                if (!string.IsNullOrEmpty(_configs.ToList()[0].CONFIG_FAVICON))
                    ltrFavicon.Text = "<link rel='shortcut icon' href='" + PathFiles.GetPathConfigs() + _configs.ToList()[0].CONFIG_FAVICON + "' />";
            }
        }
        public void Bind_meta_tag_index()
        {
            #region Metaindex
            HtmlHead header = base.Header;
            HtmlMeta headerDes = new HtmlMeta();
            HtmlMeta headerKey = new HtmlMeta();
            headerDes.Name = "Description";
            headerKey.Name = "Keywords";

            var _configs = cf.Config_meta();

            if (_configs.ToList().Count > 0)
            {
                if (!string.IsNullOrEmpty(_configs.ToList()[0].CONFIG_FAVICON))
                    ltrFavicon.Text = "<link rel='shortcut icon' href='" + PathFiles.GetPathConfigs() + _configs.ToList()[0].CONFIG_FAVICON + "' />";

                header.Title = _configs.ToList()[0].CONFIG_TITLE;

                headerDes.Content = _configs.ToList()[0].CONFIG_DESCRIPTION;
                header.Controls.Add(headerDes);

                headerKey.Content = _configs.ToList()[0].CONFIG_KEYWORD;
                header.Controls.Add(headerKey);
            }
            else
            {
                header.Title = "Enews Standard V1.0";

                headerDes.Content = "Enews Standard V1.0";
                header.Controls.Add(headerDes);

                headerKey.Content = "Enews Standard V1.0";
                header.Controls.Add(headerKey);
            }
            #endregion
        }
    }
}