using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Text.RegularExpressions;
using System.Data.Linq.SqlClient;

namespace vpro.eshop.cpanel.page
{
    /// <summary>
    /// Summary description for Complete_Ajax
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class Complete_Ajax : System.Web.Services.WebService
    {
        eshopdbDataContext db = new eshopdbDataContext();
        [WebMethod]
        public List<CategoryEntityComplete> autocomplete(string searchitem)
        {
            return searchComplete(searchitem);
        }
        private string ClearUnicode(string SourceString)
        {

            SourceString = Regex.Replace(SourceString, "[ÂĂÀÁẠẢÃÂẦẤẬẨẪẰẮẶẲẴàáạảãâầấậẩẫăằắặẳẵ]", "a");
            SourceString = Regex.Replace(SourceString, "[ÈÉẸẺẼÊỀẾỆỂỄèéẹẻẽêềếệểễ]", "e");
            SourceString = Regex.Replace(SourceString, "[IÌÍỈĨỊìíịỉĩ]", "i");
            SourceString = Regex.Replace(SourceString, "[ÒÓỌỎÕÔỒỐỔỖỘƠỜỚỞỠỢòóọỏõôồốộổỗơờớợởỡ]", "o");
            SourceString = Regex.Replace(SourceString, "[ÙÚỦŨỤƯỪỨỬỮỰùúụủũưừứựửữ]", "u");
            SourceString = Regex.Replace(SourceString, "[ỲÝỶỸỴỳýỵỷỹ]", "y");
            SourceString = Regex.Replace(SourceString, "[đĐ]", "d");

            return SourceString;
        }
        public List<CategoryEntityComplete> searchComplete(string searchitem)
        {
            List<CategoryEntityComplete> l = new List<CategoryEntityComplete>();
            var list = (from a in db.ESHOP_NEWs
                        join b in db.ESHOP_NEWS_CATs on a.NEWS_ID equals b.NEWS_ID
                        where (SqlMethods.Like(a.NEWS_KEYWORD_ASCII, ClearUnicode("%" + searchitem + "%")))
                        && a.NEWS_TYPE == 1
                        select new
                        {
                            a.NEWS_TITLE,
                            a.NEWS_PUBLISHDATE,
                            b.ESHOP_CATEGORy.CAT_NAME
                        }).Distinct().OrderByDescending(n => n.NEWS_PUBLISHDATE).OrderByDescending(n => n.CAT_NAME).Take(12);
            foreach (var i in list)
            {
                CategoryEntityComplete enti = new CategoryEntityComplete();
                enti.catname = i.CAT_NAME;
                enti.title = i.NEWS_TITLE;
                l.Add(enti);
            }
            return l;
        }
        public class CategoryEntityComplete
        {
            public string catname { get; set; }
            public string title { get; set; }
        }
    }
}
