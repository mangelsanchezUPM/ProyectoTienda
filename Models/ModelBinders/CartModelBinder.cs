using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ProyectoTienda.Models.ModelBinders
{
    public class CartModelBinder : IModelBinder
    {
        public object BindModel(ControllerContext controllerContext, ModelBindingContext bindingContext)
        {
            CartModels cart = (CartModels)controllerContext.HttpContext.Session["cart"];
            if (cart == null)
            {
                cart = new CartModels();
                controllerContext.HttpContext.Session["cart"] = cart;
            }
            return cart;
        }
    }
}