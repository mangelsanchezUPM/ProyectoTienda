using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using ProyectoTienda;
using ProyectoTienda.Models;

namespace ProyectoTienda.Controllers
{
    public class OrdersController : Controller
    {
        private Model1Container db = new Model1Container();

        [Authorize]
        public ActionResult Index()
        {
            var client = db.Clients.Where(c => c.Name == User.Identity.Name).FirstOrDefault();
            if (client == null) return new HttpUnauthorizedResult();

            var orders = db.Orders.Where(o => o.ClientId == client.Id).ToList();
            return View(orders);
        }

        // GET: Orders/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null) return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            
            Order order = db.Orders.Find(id);

            if (order == null) return HttpNotFound();

            var productsOrdered = db.ProductsOrdered.Where(po => po.OrderId == order.Id).ToList();
            
            return View(productsOrdered);
        }


        [Authorize]
        // GET: Orders/Create
        public ActionResult Create(Cart cart)
        {
            if (cart.Count == 0) return RedirectToAction("Index", "Cart");

            Client client = db.Clients.Where(c => c.Email.Equals(User.Identity.Name)).FirstOrDefault();

            if (client == null) return new HttpUnauthorizedResult();

            IList<Product> productsToRestock = new List<Product>();

            foreach (var productAndUnits in cart)
            {
                var product = db.Products.Find(productAndUnits.product.Id);

                product.Amount -= productAndUnits.units;

                if (product.Amount < 0) return RedirectToAction("Delete", "Cart", new ProductAndUnits { product = product, units = -product.Amount });

                if (product.Amount <= 2) productsToRestock.Add(product);
            }

            if (productsToRestock.Count > 0)
            {
                db.ProductsWithoutStock.AddRange(productsToRestock.Select(p => new ProductWithoutStock { Product = p }));
            }

            Order order = new Order
            {
                ClientId = client.Id,
                Date = DateTime.Now,
                Total = cart.GetTotal(),
            };


            db.Orders.Add(order);

            var productsOrdered = cart
                .Select(po => new ProductOrdered
                {
                    OrderId = order.Id,
                    ProductId = po.product.Id,
                    Amount = po.units,
                });

            db.ProductsOrdered.AddRange(productsOrdered);

            db.SaveChanges();

            cart.Clear();

            return RedirectToAction("Confirmation", "Orders", order.Id);
        }
    }
}
