using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace vpro.eshop.cpanel.Components
{
    public class setCookieCheck
    {
         HttpCookie mycookie = new HttpCookie("checkbaogia");

        public setCookieCheck()
        {
            // Check the Request Cookies collection for the cookie.
            if (System.Web.HttpContext.Current.Request.Cookies["checkbaogia"] != null)
            {
                mycookie = System.Web.HttpContext.Current.Request.Cookies["checkbaogia"];
            }
        }

        public void Addcookie(string Item)
        {
            mycookie.Values["Item_"+Item] = Item;
            mycookie.Expires = DateTime.Now.AddMonths(1);

            // Add cookie
            System.Web.HttpContext.Current.Response.Cookies.Add(mycookie);
        }

        public HttpCookie GetCookie()
        {
            return mycookie;
        }

        public void Removecookie()
        {
         
            // Remove cookie
            mycookie.Expires = DateTime.Now.AddDays(-1);
            System.Web.HttpContext.Current.Response.Cookies.Add(mycookie);
            

        }
    }
}