import { Home, User, Palette, ShoppingCart, Package, Sparkles, FileText } from "lucide-react";
import Landing from "./pages/Landing";
import Auth from "./pages/Auth";
import AuthCallback from "./pages/AuthCallback";
import ShadeMatcher from "./pages/ShadeMatcher";
import CosmeticsLibrary from "./pages/CosmeticsLibrary";
import Cart from "./pages/Cart";
import VirtualTryOn from "./pages/VirtualTryOn";
import TermsOfService from "./pages/TermsOfService";
import PrivacyPolicy from "./pages/PrivacyPolicy";
import RefundPolicy from "./pages/RefundPolicy";
import ShippingPolicy from "./pages/ShippingPolicy";

export const navItems = [
  {
    title: "Home",
    to: "/",
    icon: <Home className="h-4 w-4" />,
    page: <Landing />,
  },
  {
    title: "Find Your Match", 
    to: "/shade-matcher",
    icon: <Palette className="h-4 w-4" />,
    page: <ShadeMatcher />,
  },
  {
    title: "Virtual Try-On",
    to: "/virtual-tryon",
    icon: <Sparkles className="h-4 w-4" />,
    page: <VirtualTryOn />,
  },
  {
    title: "Browse Foundations",
    to: "/products",
    icon: <Package className="h-4 w-4" />,
    page: <CosmeticsLibrary />,
  },
  {
    title: "Cart",
    to: "/cart",
    icon: <ShoppingCart className="h-4 w-4" />,
    page: <Cart />,
  },
  {
    title: "Auth",
    to: "/auth",
    icon: <User className="h-4 w-4" />,
    page: <Auth />,
  },
  {
    title: "Auth Callback",
    to: "/auth/callback",
    icon: <User className="h-4 w-4" />,
    page: <AuthCallback />,
  },
  {
    title: "Terms of Service",
    to: "/terms-of-service",
    icon: <FileText className="h-4 w-4" />,
    page: <TermsOfService />,
  },
  {
    title: "Privacy Policy",
    to: "/privacy-policy",
    icon: <FileText className="h-4 w-4" />,
    page: <PrivacyPolicy />,
  },
  {
    title: "Refund Policy",
    to: "/refund-policy",
    icon: <FileText className="h-4 w-4" />,
    page: <RefundPolicy />,
  },
  {
    title: "Shipping Policy",
    to: "/shipping-policy",
    icon: <FileText className="h-4 w-4" />,
    page: <ShippingPolicy />,
  },
];
