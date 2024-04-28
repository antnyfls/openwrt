# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2024 OpenWrt.org

define KernelPackage/crypto-hw-rockchip
    SUBMENU:=$(CRYPTO_MENU)
    TITLE:=Rockchip Cryptographic Engine driver
    DEPENDS:= \
	@LINUX_6_6 \
	@TARGET_rockchip \
	+kmod-crypto-hw-engine
    KCONFIG:= \
	CONFIG_CRYPTO_DEV_ROCKCHIP \
	CONFIG_CRYPTO_DEV_ROCKCHIP_DEBUG=n
    FILES:= \
	$(LINUX_DIR)/drivers/crypto/rockchip/rk_crypto.ko
    AUTOLOAD:=$(call AutoLoad,09,crypto_engine rk_crypto)
    $(call AddDepends/crypto)
endef

define KernelPackage/crypto-hw-rockchip/description
 This driver interfaces with the hardware crypto accelerator.
 Supporting cbc/ecb chainmode, and aes/des/des3_ede cipher mode.
endef

$(eval $(call KernelPackage,crypto-hw-rockchip))


define KernelPackage/crypto-hw-rockchip2
    SUBMENU:=$(CRYPTO_MENU)
    TITLE:=Rockchip's cryptographic offloader V2
    DEPENDS:= \
	@LINUX_6_6 \
	@TARGET_rockchip \
	+kmod-crypto-hw-engine
    KCONFIG:= \
	CONFIG_CRYPTO_DEV_ROCKCHIP2 \
	CONFIG_CRYPTO_DEV_ROCKCHIP2_DEBUG=n
    FILES:=$(LINUX_DIR)/drivers/crypto/rockchip/rk_crypto2.ko
    AUTOLOAD:=$(call AutoLoad,09,crypto_engine rk_crypto2)
    $(call AddDepends/crypto)
endef

define KernelPackage/crypto-hw-rockchip2/description
 This driver interfaces with the hardware crypto offloader present
 on RK3566, RK3568 and RK3588.
endef

$(eval $(call KernelPackage,crypto-hw-rockchip2))


define KernelPackage/crypto-hw-engine
    SUBMENU:=$(CRYPTO_MENU)
    TITLE:=Hardware crypto devices
    HIDDEN:=1
    KCONFIG:= \
	CONFIG_CRYPTO_AES \
	CONFIG_CRYPTO_HW=y \
	CONFIG_CRYPTO_ENGINE \
	CRYPTO_SM3_GENERIC \
	CRYPTO_SKCIPHER \
	CONFIG_CRYPTO_LIB_DES
    DEPENDS:= \
	@LINUX_6_6 \
	@TARGET_rockchip \
	+kmod-crypto-cbc \
	+kmod-crypto-des \
	+kmod-crypto-ecb \
	+kmod-crypto-hash \
	+kmod-crypto-kpp \
	+kmod-crypto-md5 \
	+kmod-crypto-rsa \
	+kmod-crypto-sha1 \
	+kmod-crypto-sha256 \
	+kmod-crypto-sha512
    FILES:= \
	$(LINUX_DIR)/crypto/crypto_engine.ko \
	$(LINUX_DIR)/crypto/sm3_generic.ko
    AUTOLOAD:=$(call AutoLoad,09,crypto_engine)
    $(call AddDepends/crypto)
endef

define KernelPackage/crypto-hw-engine/description
 Hardware Crypto Engine
endef

$(eval $(call KernelPackage,crypto-hw-engine))
