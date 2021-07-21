Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308B870
	for <mptcp@lists.linux.dev>; Wed, 21 Jul 2021 14:31:45 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id v14so1037338plg.9
        for <mptcp@lists.linux.dev>; Wed, 21 Jul 2021 07:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/rZdOy5e8PBfcTQnLaSSS/kgITZqKl0qNXKa/rgiDDI=;
        b=EpNeX1EmOCv1EzAntniDAFpQKPT+VFrHVL9Y1GSvTvh966Hk1AtPtG2Ck8rn4KBABz
         YXHnflCKecitJD7PHnD22ArQTrsAyW1tfwYZStYJTO0HQ4kZd+6ObaAjiefeqKWHn/1U
         Kqm8arSHWdOySUvvWJNTcQiHelUm/NzNnK6qUyLN6JSYPZ8SgYbqqS/qdvKynhRHoA2O
         jwtfN99/SBzaOul6u1k51ccUHVteHb/Z8AeuDbNg5UmYT/ksSZk+i/HwijnuL19p6NAI
         f4aPtFHV0OO/nHuW4NZCJW/w9NPwYZKU4OTjYy/is+c1+bZ3IEOEPpb+/5Iuf6YLZCL8
         c6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/rZdOy5e8PBfcTQnLaSSS/kgITZqKl0qNXKa/rgiDDI=;
        b=TgN3tC+snqpIhPE6ovUHsCzdEdOLBVr/OOtnURQDTVuJyXJVUCL2zR4Iolp72mlNrI
         H7D5w2Ll1Mhk7KgJZTE/TQ3zNmgkVC/dKArnIGRpbwRWNwmk2u6JeD4o4KIQ/1wu1hG8
         b3so1Eq6weC0RyQj6bokgUcEgmot8TgDYLINdvJ0jEGGT4m+IWYkmPOE0YX76eFgz0Dp
         tcIZudHU6Vb1dvAbe5VmrfU7eRF8jJk3zbUljsifHqBoL340cHjMBhu7nx0Xe5Yo6CyB
         iG5cL9PuZhuE5B5FfntUv+RDfkZvlehNXosfWIkkTdFb0/SK/Gxv19xET50sV79K2nny
         nOIA==
X-Gm-Message-State: AOAM531OBT7002MmQNgwiPo8bWTvY1fRFk8AC1wRLDoPlaJi2GzzvK1U
	GcwQDk0RNaUq+tQ3ENgWTp9ikAf4/FNsTQ==
X-Google-Smtp-Source: ABdhPJwCioTSjPGT0btqeZ5dK1LgP+uyLK8db5xfA/VRewMYCJNtSRYJl239SezglVKsk27f5lPjKA==
X-Received: by 2002:a17:90a:6391:: with SMTP id f17mr4039376pjj.27.1626877904695;
        Wed, 21 Jul 2021 07:31:44 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id i6sm21723147pfa.44.2021.07.21.07.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 07:31:44 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 02/10] mptcp: register ipv4 addr notifier
Date: Wed, 21 Jul 2021 22:31:26 +0800
Message-Id: <0000f0168f0d8d1cd34bbe5463aed721225446e2.1626877655.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <b5f63eb4ad680a99fc806d2406968a6a5f272f01.1626877655.git.geliangtang@gmail.com>
References: <cover.1626877655.git.geliangtang@gmail.com> <b5f63eb4ad680a99fc806d2406968a6a5f272f01.1626877655.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a new file pm_fullmesh.c, and modify Makefile and
Kconfig to support it.

Implemented a new function mptcp_pm_fm_init(). In it registered a ipv4
addr notifier, named mptcp_pm_addr4_notifier, to deal with the events
of net device UP, DOWN and CHANGE, and skip the loopback device.

Save the ipv4 address, and pass it to the event handler.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/Kconfig       | 10 +++++++++
 net/mptcp/Makefile      |  1 +
 net/mptcp/pm.c          |  3 +++
 net/mptcp/pm_fullmesh.c | 48 +++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h    |  3 +++
 5 files changed, 65 insertions(+)
 create mode 100644 net/mptcp/pm_fullmesh.c

diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
index 10c97e19a7da..fd7f02ec6442 100644
--- a/net/mptcp/Kconfig
+++ b/net/mptcp/Kconfig
@@ -37,4 +37,14 @@ config MPTCP_KUNIT_TEST
 
 	  If unsure, say N.
 
+config MPTCP_FULLMESH
+	bool "The fullmesh path manager mode"
+	default n
+	help
+	  Use the fullmesh path manager mode. In this mode, all the net device
+	  addresses will use to create the subflows automatically. When the
+	  addresses are deleted, the subflows will be closed automatically.
+
+	  If unsure, say N.
+
 endif
diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index 0a0608b6b4b4..83c59c8fdbbf 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -13,3 +13,4 @@ mptcp_token_test-objs := token_test.o
 obj-$(CONFIG_MPTCP_KUNIT_TEST) += mptcp_crypto_test.o mptcp_token_test.o
 
 obj-$(CONFIG_BPF) += bpf.o
+obj-$(CONFIG_MPTCP_FULLMESH) += pm_fullmesh.o
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 0ed3e565f8f8..57c69e8d4bed 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -353,4 +353,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 void __init mptcp_pm_init(void)
 {
 	mptcp_pm_nl_init();
+#if IS_ENABLED(CONFIG_MPTCP_FULLMESH)
+	mptcp_pm_fm_init();
+#endif
 }
diff --git a/net/mptcp/pm_fullmesh.c b/net/mptcp/pm_fullmesh.c
new file mode 100644
index 000000000000..38a44ce8a5fa
--- /dev/null
+++ b/net/mptcp/pm_fullmesh.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt) "MPTCP: " fmt
+
+#include <linux/kernel.h>
+#include <net/mptcp.h>
+
+#include "protocol.h"
+
+static void addr_event_handler(unsigned long event, struct net *net,
+			       struct mptcp_addr_info *addr)
+{
+	if (!mptcp_is_fullmesh_enabled(net))
+		return;
+}
+
+static int mptcp_pm_addr4_event(struct notifier_block *this,
+				unsigned long event, void *ptr)
+{
+	const struct in_ifaddr *ifa = (struct in_ifaddr *)ptr;
+	struct net *net = dev_net(ifa->ifa_dev->dev);
+	struct mptcp_addr_info addr = { 0 };
+
+	if (!(event == NETDEV_UP || event == NETDEV_DOWN || event == NETDEV_CHANGE))
+		goto out;
+
+	if (ifa->ifa_scope > RT_SCOPE_LINK ||
+	    ipv4_is_loopback(ifa->ifa_local))
+		goto out;
+
+	addr.family = AF_INET;
+	addr.addr.s_addr = ifa->ifa_local;
+
+	addr_event_handler(event, net, &addr);
+
+out:
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block mptcp_pm_addr4_notifier = {
+	.notifier_call = mptcp_pm_addr4_event,
+};
+
+void __init mptcp_pm_fm_init(void)
+{
+	if (register_inetaddr_notifier(&mptcp_pm_addr4_notifier))
+		return;
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ce972edc7bbe..2c3a4d507454 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -810,6 +810,9 @@ unsigned int mptcp_pm_get_add_addr_signal_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk);
+#if IS_ENABLED(CONFIG_MPTCP_FULLMESH)
+void __init mptcp_pm_fm_init(void);
+#endif
 
 void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_sockopt_sync_all(struct mptcp_sock *msk);
-- 
2.31.1

