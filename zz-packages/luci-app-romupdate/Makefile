include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-romupdate
PKG_VERSION:=1.0
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-romupdate
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=LuCI support for ROM Online Update
  DEPENDS:=+wget +coreutils-date
  PKGARCH:=all
endef

define Build/Compile
endef

define Package/luci-app-romupdate/install
	$(INSTALL_DIR) $(1)/usr/lib/luci/controller
	$(INSTALL_DIR) $(1)/usr/lib/luci/model/cbi
	$(INSTALL_DIR) $(1)/etc/config
	$(CP) ./luasrc/controller/* $(1)/usr/lib/luci/controller/
	$(CP) ./luasrc/model/cbi/* $(1)/usr/lib/luci/model/cbi/
endef

$(eval $(call BuildPackage,luci-app-romupdate))
