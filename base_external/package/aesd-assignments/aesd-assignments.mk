##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

# Fill up the contents below in order to reference your assignment 3 git contents
AESD_ASSIGNMENTS_VERSION = '5ed5d8a1cdcfbd54b1fbeea92a3cb4227e0088a8'
# Using HTTPS URL since SSH may not be available in build environments
AESD_ASSIGNMENTS_SITE = 'https://github.com/cu-ecen-aeld/assignments-3-and-later-fhe1101.git'
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

define AESD_ASSIGNMENTS_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server all
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/aesd-char-driver modules KERNELDIR=$(LINUX_DIR) KERNEL_SRC=$(LINUX_DIR) ARCH=arm64
endef

# Install aesdsocket executable and init script
define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/server/aesdsocket $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/server/aesdsocket-start-stop $(TARGET_DIR)/etc/init.d/S99aesdsocket
	mkdir -p $(TARGET_DIR)/lib/modules/$(LINUX_VERSION)/kernel/drivers/
	$(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar.ko $(TARGET_DIR)/lib/modules/$(LINUX_VERSION)/kernel/drivers/
	$(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar_load $(TARGET_DIR)/usr/sbin/
	$(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar_unload $(TARGET_DIR)/usr/sbin/
endef

$(eval $(generic-package))
