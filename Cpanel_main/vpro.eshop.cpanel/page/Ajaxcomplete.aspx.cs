using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using System.Data.Linq.SqlClient;
using System.Web.Services;

namespace vpro.eshop.cpanel.page
{
    public partial class Ajaxcomplete : System.Web.UI.Page
    {
        static eshopdbDataContext db = new eshopdbDataContext();
        [WebMethod]
        public static List<CategoryEntityComplete> autocomplete(string searchitem)
        {
            return searchComplete(searchitem);
        }
        static private string ClearUnicode(string SourceString)
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
        public static List<CategoryEntityComplete> searchComplete(string searchitem)
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