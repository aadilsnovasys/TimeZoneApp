using Microsoft.AspNetCore.Mvc;
using System;

namespace TimeZoneApp.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            // Get the current time and time zone
            var currentTime = DateTime.Now;
            var timeZone = TimeZoneInfo.Local;

            // Pass data to the view
            ViewBag.CurrentTime = currentTime;
            ViewBag.TimeZone = timeZone.DisplayName;

            return View();
        }
    }
}
