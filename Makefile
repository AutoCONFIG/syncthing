include $(TOPDIR)/rules.mk

PKG_NAME:=syncthing
PKG_VERSION:=1.29.2
PKG_RELEASE:=1

PKG_SOURCE:=syncthing-linux-arm64-v$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/syncthing/syncthing/releases/download/v$(PKG_VERSION)
PKG_HASH:=272c0be3fa487a0ef9152396c13dbeb55cd8ff94a3c05578979c4406918e59a4

PKG_BUILD_DIR=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)/$(PKG_NAME)

PKG_MAINTAINER:=Yun Wang <maoerpet@foxmail.com>
PKG_LICENSE:=MPL-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_CPE_ID:=cpe:/a:syncthing:syncthing

include $(INCLUDE_DIR)/package.mk

define Package/syncthing
  URL:=https://syncthing.net
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Continuous file synchronization program
  USERID:=syncthing=499:syncthing=499
endef

define Package/syncthing/conffiles
/etc/config/syncthing
/etc/syncthing
endef

define Package/syncthing/description
  Syncthing replaces proprietary sync and cloud services with something
  open, trustworthy and decentralized. Your data is your data alone and
  you deserve to choose where it is stored, if it is shared with some
  third party and how it's transmitted over the Internet.
endef

define Package/syncthing/install
	$(INSTALL_DIR) $(1)/etc/syncthing
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF) $(CURDIR)/files/syncthing.conf $(1)/etc/config/syncthing
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) $(CURDIR)/files/syncthing.init $(1)/etc/init.d/syncthing
	$(INSTALL_DIR) $(1)/usr/bin/
	$(CP) $(PKG_BUILD_DIR)/syncthing $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/sysctl.d/
	$(INSTALL_BIN) $(CURDIR)/files/syncthing-sysctl.conf $(1)/etc/sysctl.d/90-syncthing-inotify.conf
endef

$(eval $(call BuildPackage,syncthing))
