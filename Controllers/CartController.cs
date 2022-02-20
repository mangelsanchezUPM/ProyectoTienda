using ProyectoTienda.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ProyectoTienda.Controllers
{
    public class CartController : Controller
    {
        // GET: Cart
        public ActionResult Index()
        {
            return View();
        }

        // GET: Cart/Add/{id}
        [Authorize]
        public ActionResult Add(Cart cart, int id)
        {
            Model1Container db = new Model1Container();
            Product product = db.Products.Find(id);

            if (product == null)
            {
                return HttpNotFound();
            }
            
            cart.Add(product);
            return RedirectToAction("Index", "Products");
        }

        // GET: Cart/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }
    }
}
