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
        Model1Container db = new Model1Container();

        [Authorize]
        // GET: Cart
        public ActionResult Index(Cart cart)
        {
            return View(cart);
        }

        // GET: Cart/Add/{id}
        [Authorize]
        public ActionResult Add(Cart cart, int productId, int units)
        {
            Product product = db.Products.Find(productId);

            if (product == null) return HttpNotFound();

            if (cart.Any(pu => pu.product.Id == product.Id))
            {
                cart.Find(pu => pu.product.Id == product.Id).units += units;
            }
            else
            {
                cart.Add(new ProductAndUnits { product = product, units = units });
            }
            return RedirectToAction("Index", "Products");
        }

        [Authorize]
        // GET: Cart/Delete/5
        public ActionResult Delete(Cart cart, int productId, int? units)
        {
            var p = cart.Find(pu => pu.product.Id == productId);

            if (p != null)
            {
                if (units != null) p.units -= (int)units;

                if (units == null || p.units <= 0) cart.Remove(p);
            }
            return RedirectToAction("Index");
        }
    }
}
