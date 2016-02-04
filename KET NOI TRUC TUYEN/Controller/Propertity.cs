using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Model;
using vpro.functions;
using System.Web;
using System.Web.UI;

namespace Controller
{
    public class Propertity
    {
        #region Decclare
        dbVuonRauVietDataContext db = new dbVuonRauVietDataContext();
        #endregion
        //Menu
        public List<ESHOP_CATEGORy> Loadmenu(int position,int limit,int rank)
        {
            try
            {
                var list = db.ESHOP_CATEGORies.Where(n => n.CAT_STATUS == 1 && (n.CAT_POSITION == position||n.CAT_POSITION==3)&&n.CAT_RANK==rank).OrderBy(n=>n.CAT_ID).OrderByDescending(n=>n.CAT_ORDER).Take(limit).ToList();
                return list;
            }
            catch (Exception)
            {
                
                throw;
            }
        }
        public List<ESHOP_CATEGORy> Loadmenu_news(int position, int limit, int rank,int cat_type)
        {
            try
            {
                var list = db.ESHOP_CATEGORies.Where(n => n.CAT_STATUS == 1 && n.CAT_POSITION == position && n.CAT_TYPE == cat_type).OrderBy(n => n.CAT_ID).OrderByDescending(n => n.CAT_ORDER).Take(limit).ToList();
                return list;
            }
            catch (Exception)
            {

                throw;
            }
        }
        //Menu cap 2
        public IQueryable<ESHOP_CATEGORy> Menu2(object catid)
        {
            int id=Utils.CIntDef(catid);
            var list = db.ESHOP_CATEGORies.Where(n => n.CAT_PARENT_ID == id).OrderByDescending(n => n.CAT_ORDER);
            return list.ToList().Count>0 ? list:null;
        }
        public IQueryable<ESHOP_CATEGORy> Menu3(object catid,int _rank,int _Catid)
        {
            int id = Utils.CIntDef(catid);
            if (_rank > 3)
            {
                var list = db.ESHOP_CATEGORies.Where(n => n.CAT_ID == _Catid).ToList();
                if (list.Count > 0)
                {
                    _Catid = Utils.CIntDef(list[0].CAT_PARENT_ID);
                   
                }
            }
            if (id == _Catid)
            {
                var list = db.ESHOP_CATEGORies.Where(n => n.CAT_PARENT_ID == id).OrderByDescending(n => n.CAT_ORDER);
                return list;
            }
            
            return null;
        }
        public int getCountChild(object cat_id)
        {
            int id = Utils.CIntDef(cat_id);
            var list = db.ESHOP_CATEGORies.Where(n => n.CAT_PARENT_ID == id).ToList();
            return list.Count;
        }
        public List<ESHOP_CATEGORy> Loadmenu_footer(int pos)
        {
            var list = db.ESHOP_CATEGORies.Where(n => n.CAT_SHOWFOOTER == pos).OrderByDescending(n=>n.CAT_ORDER).ToList();
            return list;
        }
        public List<ESHOP_CATEGORy> Loadmenu_top(int pos,int limit)
        {
            var list = db.ESHOP_CATEGORies.Where(n => n.CAT_POSITION == pos).Take(limit).ToList();
            return list;
        }
        //Active menu
        #region Active menu
        public string Get_Cat_Seo_Url(string _seoUrl)
        {
            var rausach = from p in db.ESHOP_CATEGORies
                          where p.CAT_SEO_URL == _seoUrl && p.CAT_STATUS == 1
                          select p;
            int _catID = -1;

            if (rausach.ToList().Count > 0)
            {
                string cat_parent_path = rausach.ToList()[0].CAT_PARENT_PATH;

                string[] str = cat_parent_path.Split(',');

                if (str.Count() > 1)
                {
                    _catID = Utils.CIntDef(str[1]);
                }
                else
                {
                    _catID = Utils.CIntDef(rausach.ToList()[0].CAT_ID);
                }
            }

            else
            {
                var rausach1 = (from nc in db.ESHOP_NEWS_CATs
                                join c in db.ESHOP_CATEGORies on nc.CAT_ID equals c.CAT_ID
                                join n in db.ESHOP_NEWs on nc.NEWS_ID equals n.NEWS_ID
                                where n.NEWS_SEO_URL == _seoUrl && c.CAT_STATUS == 1
                                orderby c.CAT_RANK descending
                                select new
                                {
                                    c.CAT_PARENT_PATH,
                                    c.CAT_NAME,
                                    c.CAT_DESC,
                                    c.CAT_ID
                                }).Take(1);

                if (rausach1.ToList().Count > 0)
                {
                    string cat_parent_path_Max = rausach1.ToList()[0].CAT_PARENT_PATH;

                    string[] str = cat_parent_path_Max.Split(',');
                    if (str.Count() > 1)
                    {
                        _catID = Utils.CIntDef(str[1]);
                    }
                    else
                    {
                        _catID = Utils.CIntDef(rausach1.ToList()[0].CAT_ID);
                    }
                }
            }
            var _cat_Seo_Url = db.GetTable<ESHOP_CATEGORy>().Where(a => a.CAT_ID == _catID && a.CAT_STATUS == 1);
            if (_cat_Seo_Url.ToList().Count > 0)
            {
                string _catSeoUrl = _cat_Seo_Url.ToList()[0].CAT_SEO_URL;
                return _catSeoUrl;
            }
            else
            {
                return null;
            }
        }
        public string GetStyleActive(object Cat_Seo_Url, object Cat_Url)
        {
            try
            {
                if (!string.IsNullOrEmpty(Utils.CStrDef(HttpContext.Current.Request.QueryString["purl"])))
                {
                    string _curl = Utils.CStrDef(HttpContext.Current.Request.QueryString["purl"]);

                    var _cat = db.GetTable<ESHOP_CATEGORy>().Where(a => a.CAT_SEO_URL == _curl && a.CAT_STATUS == 1);
                    if (_cat.ToList().Count > 0)
                    {
                        if (_cat.ToList()[0].CAT_RANK == 1)
                        {
                            if (Utils.CStrDef(HttpContext.Current.Request.QueryString["purl"]) == Utils.CStrDef(Cat_Seo_Url))
                            {
                                return "active";
                            }
                            else
                            {
                                return null;
                            }
                        }
                        else
                        {
                            int _catID = -1;
                            string[] str = Utils.CStrDef(_cat.ToList()[0].CAT_PARENT_PATH).Split(',');

                            if (str.Count() > 1)
                            {
                                _catID = Utils.CIntDef(str[1]);

                                var _cat_Seo_Url = db.GetTable<ESHOP_CATEGORy>().Where(a => a.CAT_ID == _catID && a.CAT_STATUS == 1);
                                if (_cat_Seo_Url.ToList().Count > 0)
                                {
                                    string _catSeoUrl = _cat_Seo_Url.ToList()[0].CAT_SEO_URL;

                                    if (_catSeoUrl == Utils.CStrDef(Cat_Seo_Url))
                                    {
                                        return "active";
                                    }
                                    else
                                    {
                                        return null;
                                    }
                                }
                                else
                                {
                                    return null;
                                }
                            }
                            else
                            {
                                return null;
                            }
                        }
                    }
                    else
                    {
                        return null;
                    }
                }
                else
                {
                    //string _seoUrl = fm.CatChuoiURL(Utils.CStrDef(Request.RawUrl));
                    string _seoUrl = Utils.CStrDef(HttpContext.Current.Request.QueryString["purl"]);
                    if (!string.IsNullOrEmpty(_seoUrl))
                    {
                        string _catSeoUrl = Get_Cat_Seo_Url(_seoUrl);
                        if (_catSeoUrl == Utils.CStrDef(Cat_Seo_Url))
                        {
                            return "active";
                        }
                        else
                        {
                            return null;
                        }
                    }
                    else
                    {
                        if (Utils.CStrDef(HttpContext.Current.Request.RawUrl) == Utils.CStrDef(Cat_Url))
                        {
                            return "active";
                        }
                        else
                        {
                            return null;
                        }
                    }
                }

                //}
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
                return null;
            }
        }
        #endregion
        //Danh muc menu
        public List<ESHOP_CATEGORy> Load_danhmuc(int type, int rank)
        {
            var list = db.ESHOP_CATEGORies.Where(n => n.CAT_TYPE == type && n.CAT_RANK == rank && n.CAT_STATUS == 1).OrderByDescending(n => n.CAT_ORDER).ToList();
            return list;
        }
        public List<ESHOP_CATEGORy> Load_danhmuc_position(int type,int postion)
        {
            var list = db.ESHOP_CATEGORies.Where(n => n.CAT_STATUS == 1 && (n.CAT_POSITION==postion||n.CAT_POSITION==3)&&n.CAT_TYPE==type).OrderByDescending(n => n.CAT_ORDER).ToList();
            return list;
        }
        public List<ESHOP_CATEGORy> Load_danhmuc_search(int type)
        {
            var list = db.ESHOP_CATEGORies.Where(n => n.CAT_TYPE == type && n.CAT_STATUS == 1 && n.CAT_RANK >= 1).OrderByDescending(n => n.CAT_ORDER).ToList();
            return list;
        }
        //check hang sx
        private bool checkHangsx(string cat_seo)
        {
            var list = db.ESHOP_CATEGORies.Where(n => n.CAT_SEO_URL == cat_seo).ToList();
            if (list.Count > 0)
                if (list[0].CAT_TYPE == 2)
                    return true;
            return false;
        }
        private bool checkXuatxu(string cat_seo)
        {
            var list = db.ESHOP_CATEGORies.Where(n => n.CAT_SEO_URL == cat_seo).ToList();
            if (list.Count > 0)
                if (list[0].CAT_TYPE == 3)
                    return true;
            return false;
        }
        public List<ESHOP_CATEGORy> Load_danhmuc_left(string cat_seo,int _catid)
        {

            if (checkHangsx(cat_seo))
            {
                List<int> lcat_id = new List<int>();
                var getListid = (from a in db.ESHOP_NEWs
                                 join b in db.ESHOP_NEWS_CATs on a.NEWS_ID equals b.NEWS_ID
                                 where a.UNIT_ID2 == _catid
                                 select new { b.ESHOP_CATEGORy.CAT_ID }).Distinct();
                foreach (var i in getListid)
                {
                    lcat_id.Add(Utils.CIntDef(i.CAT_ID));
                }
                List<int> lcatid_menu=new List<int>();
                var list = db.ESHOP_CATEGORies.Where(n => lcat_id.Contains(n.CAT_ID)).ToList();
                foreach (var i in list)
                {
                    if (i.CAT_RANK > 2)
                    {
                        string[] a = i.CAT_PARENT_PATH.Split(',');
                        lcatid_menu.Add(Utils.CIntDef(a[2]));
                    }
                    else lcatid_menu.Add(i.CAT_ID);
                }
                var getdata = db.ESHOP_CATEGORies.Where(n => lcatid_menu.Contains(n.CAT_ID)&&n.CAT_TYPE==1).ToList();
                return getdata;
               
            }
            else if (checkXuatxu(cat_seo))
            {
                List<int> lcat_id = new List<int>();
                var getListid = (from a in db.ESHOP_NEWs
                                 join b in db.ESHOP_NEWS_CATs on a.NEWS_ID equals b.NEWS_ID
                                 where a.UNIT_ID1 == _catid
                                 select new { b.ESHOP_CATEGORy.CAT_ID }).Distinct();
                foreach (var i in getListid)
                {
                    lcat_id.Add(Utils.CIntDef(i.CAT_ID));
                }
                List<int> lcatid_menu = new List<int>();
                var list = db.ESHOP_CATEGORies.Where(n => lcat_id.Contains(n.CAT_ID)).ToList();
                foreach (var i in list)
                {
                    if (i.CAT_RANK > 2)
                    {
                        string[] a = i.CAT_PARENT_PATH.Split(',');
                        lcatid_menu.Add(Utils.CIntDef(a[2]));
                    }
                    else lcatid_menu.Add(i.CAT_ID);
                }
                var getdata = db.ESHOP_CATEGORies.Where(n => lcatid_menu.Contains(n.CAT_ID) && n.CAT_TYPE == 1).ToList();
                return getdata;

            }
            else
            {
                var list = db.ESHOP_CATEGORies.Where(n => n.CAT_SEO_URL == cat_seo).ToList();
                if (list.Count > 0)
                {
                    if (list[0].CAT_RANK > 2)
                    {
                        string[] a = list[0].CAT_PARENT_PATH.Split(',');
                        int id = Utils.CIntDef(a[2]);
                        var getlistcap1 = db.ESHOP_CATEGORies.Where(n => n.CAT_ID == id).ToList();
                        return getlistcap1;
                    }
                    return list;
                }
            }
            return new List<ESHOP_CATEGORy>();
        }
        public List<ESHOP_CATEGORy> Load_hangsx(string cat_seo)
        {
            if (checkHangsx(cat_seo))
            {
                var list = db.ESHOP_CATEGORies.Where(n => n.CAT_SEO_URL == cat_seo).ToList();
                if (list.Count > 0)
                {
                    List<int> listhsx = new List<int>();
                    int _catid = 0;
                    var getallHsx = (from a in db.ESHOP_NEWs
                                    join b in db.ESHOP_NEWS_CATs on a.NEWS_ID equals b.NEWS_ID
                                    where a.UNIT_ID2==list[0].CAT_ID
                                    select new{b.CAT_ID,b.ESHOP_CATEGORy.CAT_RANK,b.ESHOP_CATEGORy.CAT_PARENT_PATH}).Distinct().ToList();
                    if (getallHsx.Count > 0)
                    {
                        if (getallHsx[0].CAT_RANK > 1)
                        {
                            string[] a = getallHsx[0].CAT_PARENT_PATH.Split(',');
                            _catid = Utils.CIntDef(a[1]);
                        }
                        else _catid =Utils.CIntDef(getallHsx[0].CAT_ID);
                    }
                    var getall = (from a in db.ESHOP_NEWS_CATs
                                  join b in db.ESHOP_NEWs on a.NEWS_ID equals b.NEWS_ID
                                  join c in db.ESHOP_CATEGORies on a.CAT_ID equals c.CAT_ID
                                  where c.CAT_ID == _catid || c.CAT_PARENT_PATH.Contains(_catid.ToString())
                                  select new { b.UNIT_ID2 }).Distinct();
                    foreach (var i in getall)
                    {
                        listhsx.Add(Utils.CIntDef(i.UNIT_ID2));
                    }
                    var gethsx = db.ESHOP_CATEGORies.Where(n => listhsx.Contains(n.CAT_ID)&&n.CAT_RANK==2).ToList();
                    return gethsx;
                }
                return new List<ESHOP_CATEGORy>();
            }
            else if (checkXuatxu(cat_seo))
            {
                var list = db.ESHOP_CATEGORies.Where(n => n.CAT_SEO_URL == cat_seo).ToList();
                if (list.Count > 0)
                {
                    List<int> listhsx = new List<int>();
                    int _catid = 0;
                    var getallHsx = (from a in db.ESHOP_NEWs
                                     join b in db.ESHOP_NEWS_CATs on a.NEWS_ID equals b.NEWS_ID
                                     where a.UNIT_ID1 == list[0].CAT_ID
                                     select new { b.CAT_ID, b.ESHOP_CATEGORy.CAT_RANK, b.ESHOP_CATEGORy.CAT_PARENT_PATH }).Distinct().ToList();
                    if (getallHsx.Count > 0)
                    {
                        if (getallHsx[0].CAT_RANK > 1)
                        {
                            string[] a = getallHsx[0].CAT_PARENT_PATH.Split(',');
                            _catid = Utils.CIntDef(a[1]);
                        }
                        else _catid = Utils.CIntDef(getallHsx[0].CAT_ID);
                    }
                    var getall = (from a in db.ESHOP_NEWS_CATs
                                  join b in db.ESHOP_NEWs on a.NEWS_ID equals b.NEWS_ID
                                  join c in db.ESHOP_CATEGORies on a.CAT_ID equals c.CAT_ID
                                  where c.CAT_ID == _catid || c.CAT_PARENT_PATH.Contains(_catid.ToString())
                                  select new { b.UNIT_ID2 }).Distinct();
                    foreach (var i in getall)
                    {
                        listhsx.Add(Utils.CIntDef(i.UNIT_ID2));
                    }
                    var gethsx = db.ESHOP_CATEGORies.Where(n => listhsx.Contains(n.CAT_ID)).ToList();
                    return gethsx;
                }
                return new List<ESHOP_CATEGORy>();
            }
            else
            {
                List<int> idcat = new List<int>();
                var getcatid = db.ESHOP_CATEGORies.Where(n => n.CAT_SEO_URL == cat_seo).Select(n => new { n.CAT_ID }).ToList();
                if (getcatid.Count > 0)
                {
                    var list = (from a in db.ESHOP_NEWs
                                join b in db.ESHOP_NEWS_CATs on a.NEWS_ID equals b.NEWS_ID
                                where b.ESHOP_CATEGORy.CAT_ID == getcatid[0].CAT_ID || b.ESHOP_CATEGORy.CAT_PARENT_PATH.Contains(getcatid[0].CAT_ID.ToString())
                                select new { a.UNIT_ID2 }).Distinct();
                    foreach (var i in list)
                    {
                        idcat.Add(Utils.CIntDef(i.UNIT_ID2));
                    }
                }
                var getlisthsx = db.ESHOP_CATEGORies.Where(n => idcat.Contains(n.CAT_ID)).ToList();
                return getlisthsx;
            }
        }
        public List<ESHOP_CATEGORy> Load_xuatxu(string cat_seo)
        {
            if (checkXuatxu(cat_seo))
            {
                var list = db.ESHOP_CATEGORies.Where(n => n.CAT_SEO_URL == cat_seo).ToList();
                if (list.Count > 0)
                {
                    List<int> listhsx = new List<int>();
                    int _catid = 0;
                    var getallHsx = (from a in db.ESHOP_NEWs
                                     join b in db.ESHOP_NEWS_CATs on a.NEWS_ID equals b.NEWS_ID
                                     where a.UNIT_ID1 == list[0].CAT_ID
                                     select new { b.CAT_ID, b.ESHOP_CATEGORy.CAT_RANK, b.ESHOP_CATEGORy.CAT_PARENT_PATH }).Distinct().ToList();
                    if (getallHsx.Count > 0)
                    {
                        if (getallHsx[0].CAT_RANK > 1)
                        {
                            string[] a = getallHsx[0].CAT_PARENT_PATH.Split(',');
                            _catid = Utils.CIntDef(a[1]);
                        }
                        else _catid = Utils.CIntDef(getallHsx[0].CAT_ID);
                    }
                    var getall = (from a in db.ESHOP_NEWS_CATs
                                  join b in db.ESHOP_NEWs on a.NEWS_ID equals b.NEWS_ID
                                  join c in db.ESHOP_CATEGORies on a.CAT_ID equals c.CAT_ID
                                  where c.CAT_ID == _catid || c.CAT_PARENT_PATH.Contains(_catid.ToString())
                                  select new { b.UNIT_ID1 }).Distinct();
                    foreach (var i in getall)
                    {
                        listhsx.Add(Utils.CIntDef(i.UNIT_ID1));
                    }
                    var gethsx = db.ESHOP_CATEGORies.Where(n => listhsx.Contains(n.CAT_ID)).ToList();
                    return gethsx;
                }
                return new List<ESHOP_CATEGORy>();
            }
            else if (checkHangsx(cat_seo))
            {
                var list = db.ESHOP_CATEGORies.Where(n => n.CAT_SEO_URL == cat_seo).ToList();
                if (list.Count > 0)
                {
                    List<int> listhsx = new List<int>();
                    int _catid = 0;
                    var getallHsx = (from a in db.ESHOP_NEWs
                                     join b in db.ESHOP_NEWS_CATs on a.NEWS_ID equals b.NEWS_ID
                                     where a.UNIT_ID2 == list[0].CAT_ID
                                     select new { b.CAT_ID, b.ESHOP_CATEGORy.CAT_RANK, b.ESHOP_CATEGORy.CAT_PARENT_PATH }).Distinct().ToList();
                    if (getallHsx.Count > 0)
                    {
                        if (getallHsx[0].CAT_RANK > 1)
                        {
                            string[] a = getallHsx[0].CAT_PARENT_PATH.Split(',');
                            _catid = Utils.CIntDef(a[1]);
                        }
                        else _catid = Utils.CIntDef(getallHsx[0].CAT_ID);
                    }
                    var getall = (from a in db.ESHOP_NEWS_CATs
                                  join b in db.ESHOP_NEWs on a.NEWS_ID equals b.NEWS_ID
                                  join c in db.ESHOP_CATEGORies on a.CAT_ID equals c.CAT_ID
                                  where c.CAT_ID == _catid || c.CAT_PARENT_PATH.Contains(_catid.ToString())
                                  select new { b.UNIT_ID1 }).Distinct();
                    foreach (var i in getall)
                    {
                        listhsx.Add(Utils.CIntDef(i.UNIT_ID1));
                    }
                    var gethsx = db.ESHOP_CATEGORies.Where(n => listhsx.Contains(n.CAT_ID)).ToList();
                    return gethsx;
                }
                return new List<ESHOP_CATEGORy>();
            }
            else
            {
                List<int> idcat = new List<int>();
                var getcatid = db.ESHOP_CATEGORies.Where(n => n.CAT_SEO_URL == cat_seo).Select(n => new { n.CAT_ID }).ToList();
                if (getcatid.Count > 0)
                {
                    var list = (from a in db.ESHOP_NEWs
                                join b in db.ESHOP_NEWS_CATs on a.NEWS_ID equals b.NEWS_ID
                                where b.ESHOP_CATEGORy.CAT_ID == getcatid[0].CAT_ID || b.ESHOP_CATEGORy.CAT_PARENT_PATH.Contains(getcatid[0].CAT_ID.ToString())
                                select new { a.UNIT_ID1 }).Distinct();
                    foreach (var i in list)
                    {
                        idcat.Add(Utils.CIntDef(i.UNIT_ID1));
                    }
                }
                var getlisthsx = db.ESHOP_CATEGORies.Where(n => idcat.Contains(n.CAT_ID)).ToList();
                return getlisthsx;
            }
        }
        public List<ESHOP_CATEGORy> Load_menu_cat_news_seo(string cat_seo, string news_seo)
        {
            var list = db.ESHOP_CATEGORies.Where(n => n.CAT_ID == Getactive_menudanhmuc(cat_seo, news_seo)).ToList();
            return list;
        }
        public int Getactive_menudanhmuc(string cat_seo, string news_seo)
        {
            int cat_id = 0;
            if (!string.IsNullOrEmpty(cat_seo))
            {
                var list = db.ESHOP_CATEGORies.Where(n => n.CAT_SEO_URL == cat_seo).ToList();
                if (list.Count > 0)
                {
                    if (list[0].CAT_RANK > 2)
                    {
                        string[] a = list[0].CAT_PARENT_PATH.Split(',');
                        cat_id = Utils.CIntDef(a[2]);
                    }
                    else cat_id = list[0].CAT_ID;
                }
            }
            else
            {
                if (!string.IsNullOrEmpty(news_seo))
                {
                    var list = (from a in db.ESHOP_NEWs
                                join b in db.ESHOP_NEWS_CATs on a.NEWS_ID equals b.NEWS_ID
                                join c in db.ESHOP_CATEGORies on b.CAT_ID equals c.CAT_ID
                                where a.NEWS_SEO_URL == news_seo
                                select new { c.CAT_ID, c.CAT_RANK, c.CAT_PARENT_PATH }).ToList();
                    if (list.Count > 0)
                    {
                        if (list[0].CAT_RANK > 2)
                        {
                            string[] a = list[0].CAT_PARENT_PATH.Split(',');
                            cat_id = Utils.CIntDef(a[2]);
                        }
                        else cat_id = list[0].CAT_ID;
                    }
                }
            }
            return cat_id;
        }
        //Load city-distric
       
        //Logo-sologan
        public List<ESHOP_BANNER> Load_logo_and_sologan(int limit)
        {
            try
            {
                 var _logoSlogan = (from a in db.ESHOP_BANNERs
                               select a).Take(limit).ToList();
                 return _logoSlogan;
            }
            catch (Exception)
            {
                
                throw;
            }
        }
        //Logo or sologan
        public List<ESHOP_BANNER> Load_logo_or_sologan(string field,int limit)
        {
            try
            {
                var list = db.ESHOP_BANNERs.Where(n => n.BANNER_FIELD1 == field).Take(limit).ToList();
                return list;
            }
            catch (Exception)
            {

                throw;
            }
        }
        // Silder
        public List<ESHOP_AD_ITEM> Load_slider(int position, int limit)
        {
            try
            {
                var list = db.ESHOP_AD_ITEMs.Where(n => n.AD_ITEM_POSITION == position
                    && n.AD_ITEM_DATEFROM != null && n.AD_ITEM_DATETO != null
                    && (DateTime.Now.Date >= n.AD_ITEM_DATEFROM && DateTime.Now.Date <= n.AD_ITEM_DATETO)).Take(limit).ToList();
                return list;
            }
            catch (Exception)
            {
                
                throw;
            }
        }
        public List<ESHOP_AD_ITEM> Load_slider(object catid, int position, int limit)
        {
            try
            {
                var list = (from a in db.ESHOP_AD_ITEM_CATs
                            join b in db.ESHOP_AD_ITEMs on a.AD_ITEM_ID equals b.AD_ITEM_ID
                            where b.AD_ITEM_POSITION == position
                            && (a.CAT_ID == Utils.CIntDef(catid, 0))
                            && b.AD_ITEM_DATEFROM != null && b.AD_ITEM_DATETO != null
                            && (DateTime.Now.Date >= b.AD_ITEM_DATEFROM && DateTime.Now.Date <= b.AD_ITEM_DATETO)
                            select b).Distinct().Take(limit).ToList();
                return list;
            }
            catch (Exception)
            {
                return null;
            }
        }

        public string loadSupwithType(int type)
        {
            var list = db.ESHOP_ONLINEs.Where(n => n.ONLINE_TYPE == type).ToList();
            if (list.Count > 0)
                return list[0].ONLINE_NICKNAME;
            return "";
        }
        //Support yahoo+skype
        public List<ESHOP_ONLINE> Load_support()
        {
            try
            {
                var list = db.ESHOP_ONLINEs.Where(n => n.ONLINE_TYPE < 2).OrderByDescending(n => n.ONLINE_TYPE).ToList();
                return list;
            }
            catch (Exception)
            {

                throw;
            }
        }
        //Holine
        public List<ESHOP_ONLINE> Load_hotline()
        {
            try
            {
                var list = db.ESHOP_ONLINEs.Where(n => n.ONLINE_TYPE == 2).OrderByDescending(n => n.ONLINE_TYPE).ToList();
                return list;
            }
            catch (Exception)
            {

                throw;
            }
        }
        //Facebook support
        public List<ESHOP_ONLINE> Load_face()
        {
            try
            {
                var list = db.ESHOP_ONLINEs.Where(n => n.ONLINE_TYPE > 2).OrderByDescending(n => n.ONLINE_TYPE).ToList();
                return list;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public string LoadOnline(object online_type, object ONLINE_DESC, object nick)
        {
            int type = Utils.CIntDef(online_type);
            if (type == 3)
            {
                return " <a href='" + ONLINE_DESC + "' target='_blank' class='social_1'></a>";
            }
            if (type == 4)
            {
                return " <a href='" + ONLINE_DESC + "' target='_blank' class='social_3'></a>";
            }
            if (type == 5)
            {
                return " <a href='" + ONLINE_DESC + "' target='_blank' class='social_2'></a>";
            }
           
            if (type == 6)
            {
                return " <a href='" + ONLINE_DESC + "' target='_blank' class='social_6'></a>";
            }
            
            return "";
        }
        //Video
        public string Load_video()
        {
            string _sResult = "";
            var _vGetVideo = db.GetTable<Product>().Take(1).OrderByDescending(a => a.product_id);

            if (_vGetVideo.ToList().Count > 0)
            {
                _sResult += "<iframe style='display: block; margin-left: auto; margin-right: auto; width:100%;'";
                _sResult += " src='http://www.youtube.com/embed/" + Get_Embed(_vGetVideo.First().product_name) + "?rel=0' frameborder='0' width='100%'></iframe>";
            }
            return _sResult;
        }
        private string Get_Embed(string s)
        {
            try
            {
                return s.Substring(s.Length - 11, 11);
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
                return "";
            }
        }
        //Weblink
        public List<ESHOP_WEBLINK> Load_weblink()
        {
            var list = db.ESHOP_WEBLINKs.ToList();
            return list;
        }
        //Path
        #region Path

        /// <summary>
        /// Lấy đường dẫn và ghi chú về sản phẩm
        /// </summary>
        public string Getpath()
        {
            try
            {
                string _result = string.Empty;
                string requesturl = Utils.CStrDef(HttpContext.Current.Request.RawUrl);
                if (requesturl.Contains("san-pham-yeu-thich")) return "» Sản phẩm yêu thích";
                string cat_seo_url = CatChuoiURL(requesturl);
               
                if (cat_seo_url.Contains("aspx?p"))
                {
                    string[] a = cat_seo_url.Split('?');
                    cat_seo_url = a[0].Substring(0, a[0].Length - 5);
                }
                var rausach = from p in db.ESHOP_CATEGORies
                              where p.CAT_SEO_URL == cat_seo_url && p.CAT_STATUS == 1
                              select p;

                if (rausach.ToList().Count > 0)
                {

                    string cat_parent_path = rausach.ToList()[0].CAT_PARENT_PATH;

                    string[] str = cat_parent_path.Split(',');

                    if (str.Count() > 1)
                    {
                        _result = Convert_Name(str) + " » <a href='/chuyen-muc/" + rausach.ToList()[0].CAT_SEO_URL + ".aspx'>" + rausach.ToList()[0].CAT_NAME + "</a>";
                    }
                    else
                    {
                        if (rausach.ToList()[0].CAT_SHOWITEM > 0)
                        {
                            _result = " » <a href='/chuyen-muc/" + rausach.ToList()[0].CAT_SEO_URL + ".aspx'>" + rausach.ToList()[0].CAT_NAME + "</a> ";
                        }
                        else
                        {
                            _result = " » <a href='/chuyen-muc/" + rausach.ToList()[0].CAT_SEO_URL + ".aspx'>" + rausach.ToList()[0].CAT_NAME + "</a> ";
                        }
                    }
                }

                else
                {
                    var rausach1 = (from nc in db.ESHOP_NEWS_CATs
                                    join c in db.ESHOP_CATEGORies on nc.CAT_ID equals c.CAT_ID
                                    join n in db.ESHOP_NEWs on nc.NEWS_ID equals n.NEWS_ID
                                    where n.NEWS_SEO_URL == cat_seo_url && c.CAT_STATUS == 1
                                    orderby c.CAT_RANK descending
                                    select c).Take(1);
                    if (rausach1.ToList().Count > 0)
                    {
                        string cat_parent_path_Max = rausach1.ToList()[0].CAT_PARENT_PATH;

                        string[] str = cat_parent_path_Max.Split(',');
                        if (str.Count() > 1)
                        {
                            _result = Convert_Name(str) + " » <a href='/chuyen-muc/" + rausach1.ToList()[0].CAT_SEO_URL + ".aspx'>" + rausach1.ToList()[0].CAT_NAME + "</a>";
                        }
                        else
                        {
                            if (rausach1.ToList()[0].CAT_SHOWITEM > 0)
                            {
                                _result = " » <a href='/chuyen-muc/" + rausach1.ToList()[0].CAT_SEO_URL + ".aspx'>" + rausach1.ToList()[0].CAT_NAME + "</a> ";
                            }
                            else
                            {
                                _result = " » <a href='/chuyen-muc/" + rausach1.ToList()[0].CAT_SEO_URL + ".aspx'>" + rausach1.ToList()[0].CAT_NAME + "</a> ";
                            }
                        }

                    }
                }
                return _result;
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
                return "";
            }
        }

        /// <summary>
        /// Chuyển chuỗi kiểu số thành chuỗi kiểu chữ
        /// </summary>
        /// <param name="str">mảng chứa đường dẫn kiểu số</param>
        /// <returns>đường dẫn kiểu chữ</returns>
        public string Convert_Name(string[] str)
        {
            string s = "";

            try
            {
                int _value = 0;

                for (int i = 1; i < str.Count(); i++)
                {

                    _value = Utils.CIntDef(str[i]);

                    var rausach = (from r in db.ESHOP_CATEGORies
                                  where r.CAT_ID == _value && r.CAT_STATUS == 1
                                  select r).ToList();
                    //s += rausach.ToList()[0] + " > ";
                    if(rausach.Count>0)
                    s += " » <a href='/chuyen-muc/" + rausach.ToList()[0].CAT_SEO_URL + ".aspx'>" + rausach.ToList()[0].CAT_NAME + "</a> ";
                }
                return s;
            }
            catch (Exception ex)
            {
                clsVproErrorHandler.HandlerError(ex);
                return "";
            }
        }
        private string CatChuoiURL(string s)
        {
            string[] sep = { "/" };
            string[] sep1 = { " " };
            string[] t1 = s.Split(sep, StringSplitOptions.RemoveEmptyEntries);
            string res = "";
            for (int i = (t1.Length>1 ? 1 : 0); i < t1.Length; i++)
            {
                string[] t2 = t1[i].Split(sep1, StringSplitOptions.RemoveEmptyEntries);
                if (t2.Length > 0)
                {
                    if (res.Length > 0)
                    {
                        res += "//";
                    }
                    res += t2[0];
                }
            }
            return res.Substring(0, res.Length - 5);
        }
        #endregion
        //Total product
        public int Total_product()
        {
            try
            {
                var list = db.ESHOP_NEWs.Where(n => n.NEWS_TYPE == 1).ToList();
                return list.Count;
            }
            catch (Exception)
            {
                
                throw;
            }
        }
        public int getCatid(string cat_seo,string _news_Seo)
        {
            int _catid=0;
            if (!String.IsNullOrEmpty(cat_seo))
            {
                var list = db.ESHOP_CATEGORies.Where(n => n.CAT_SEO_URL == cat_seo).ToList();
                if (list.Count > 0)
                {
                    if (list[0].CAT_RANK > 1)
                    {
                        string[] a = list[0].CAT_PARENT_PATH.Split(',');
                        _catid = Utils.CIntDef(a[1]);
                    }
                    else _catid = list[0].CAT_ID;
                }
                else
                {
                    var list2 = (from a in db.ESHOP_NEWs
                                join b in db.ESHOP_NEWS_CATs on a.NEWS_ID equals b.NEWS_ID
                                where a.NEWS_SEO_URL == _news_Seo
                                select new { b.ESHOP_CATEGORy.CAT_RANK, b.ESHOP_CATEGORy.CAT_ID, b.ESHOP_CATEGORy.CAT_PARENT_PATH }).ToList();
                    if (list2.Count > 0)
                    {
                        if (list2[0].CAT_RANK > 1)
                        {
                            string[] a = list2[0].CAT_PARENT_PATH.Split(',');
                            _catid = Utils.CIntDef(a[1]);
                        }
                        else _catid = list2[0].CAT_ID;
                    }
                }
            }
            
            return _catid;
        }
        public int getPosition(string cat_seo, string news_seo)
        {
            if (getType(cat_seo, news_seo) == 0)
                return 4;
            return 5;
        }
        public int getType(string cat_seo, string news_seo)
        {
            var list = db.ESHOP_CATEGORies.Where(n => n.CAT_ID == getCatid(cat_seo, news_seo)).ToList();
            if (list.Count > 0)
                return Utils.CIntDef(list[0].CAT_TYPE);
            return 0;
        }
        public string getVideoNews(object news_link)
        {
            string _sResult = "";

            if (!String.IsNullOrEmpty(Utils.CStrDef(news_link)))
            {
                _sResult += "<iframe style='display: block; margin-left: auto; margin-right: auto; width:100%;height:320px'";
                _sResult += " src='http://www.youtube.com/embed/" + Get_Embed(Utils.CStrDef(news_link)) + "?rel=0' frameborder='0' width='100%' height='320px'></iframe>";
            }
            return _sResult;
        }
        public string getImagesYoutube(object news_link)
        {
            if (!String.IsNullOrEmpty(Utils.CStrDef(news_link)))
            { 
                string []a=Utils.CStrDef(news_link).Split('=');
                return "http://img.youtube.com/vi/"+a[a.Length-1]+"/0.jpg";
            }
            return "";
        }
        public List<Pro_details_entity> getProinfo(int id)
        {
            List<Pro_details_entity> l = new List<Pro_details_entity>();
            var list = (from a in db.ESHOP_NEWs
                        join b in db.ESHOP_NEWS_CATs on a.NEWS_ID equals b.NEWS_ID
                        where a.NEWS_ID == id
                        select new
                        {
                            a.NEWS_ID,
                            a.NEWS_TITLE,
                            a.NEWS_DESC,
                            a.NEWS_SEO_URL,
                            a.NEWS_URL,
                            a.NEWS_PRICE1,
                            a.UNIT_ID1,
                            a.UNIT_ID2,
                            a.NEWS_FIELD2,
                            a.NEWS_IMAGE3,
                            b.ESHOP_CATEGORy.CAT_SEO_URL
                        }).ToList();
            foreach (var i in list)
            {
                Pro_details_entity enti = new Pro_details_entity();
                enti.NEWS_ID = i.NEWS_ID;
                enti.NEWS_TITLE = i.NEWS_TITLE;
                enti.NEWS_DESC = i.NEWS_DESC;
                enti.NEWS_PRICE1 =Utils.CDecDef(i.NEWS_PRICE1);
                enti.NEWS_FIELD2 = i.NEWS_FIELD2;
                enti.NEWS_URL = i.NEWS_URL;
                enti.NEWS_SEO_URL = i.NEWS_SEO_URL;
                enti.CAT_SEO_URL = i.CAT_SEO_URL;
                enti.NEWS_IMAGE3 = i.NEWS_IMAGE3;
                enti.UNIT_ID1 = Utils.CIntDef(i.UNIT_ID1);
                enti.UNIT_ID2 = Utils.CIntDef(i.UNIT_ID2);
                l.Add(enti);
            }
            return l;
        }
        public string getNameCate(int id)
        {
            var list = db.ESHOP_CATEGORies.Where(n => n.CAT_ID == id).ToList();
            if (list.Count > 0)
                return list[0].CAT_NAME;
            return "";
        }
        public List<ESHOP_CATEGORy> loadListThuonghieu()
        {
            var list = db.ESHOP_CATEGORies.Where(n => n.CAT_TYPE == 2 && n.CAT_RANK == 2).ToList();
            return list;
        }
        public int avgRating(object news_id)
        {
            int _newsid = Utils.CIntDef(news_id);
            var list = db.ESHOP_NEWS_COMMENTs.Where(n => n.NEWS_ID == _newsid&&n.COMMENT_STATUS==1).ToList();
            if (list.Count > 0)
            {
                int _rat = Utils.CIntDef(list.Sum(n => n.COMMENT_RATING));
                return _rat / list.Count;
            }
            return 0;
        }
    }
}
