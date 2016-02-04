using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace vpro.eshop.cpanel.Components
{
    public class getCookiebaogia
    {
        setCookieCheck cklike = new setCookieCheck();
        public List<string> Listcookie_check()
        {
            try
            {
                HttpCookie mycookie = cklike.GetCookie();
                List<string> l = new List<string>();
                if (System.Web.HttpContext.Current.Request.Cookies["checkbaogia"] != null)
                {
                    if (mycookie.HasKeys)
                    {
                        for (int j = 0; j < mycookie.Values.Count; j++)
                        {
                            l.Add(mycookie.Values[j]);
                        }
                    }
                }
                return l;

            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}