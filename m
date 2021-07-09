Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFE372
	for <mptcp@lists.linux.dev>; Fri,  9 Jul 2021 11:04:44 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id b8-20020a17090a4888b02901725eedd346so5855479pjh.4
        for <mptcp@lists.linux.dev>; Fri, 09 Jul 2021 04:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OmveKdtK8fBKQtLLakEBJzW6SzQ4v9I4vqWpGBlgvwQ=;
        b=ixgjVcV9rSBIExGjMSCWpl26f/EZX1a59qgNXoB7OWKhZJXpC89BYEyucgp4RyWsSY
         o88jY/I61y5zjJiHf2RB1/GlvIMbYSJZ+fAGYEwaIGtEVb3H+J8Wg4WCxRk4qv4DfMQm
         voM5TBaIs57f7k4PVPbZlX+IMUEUmx3TlerPFDGkAZIFDWtQbuKvMTT5Xsoqvi+Y/tCD
         hf6oElL/DXcdsXdC4LgJMv2G3N7jz1UiEL2sXVKEqKm6ABqsCEm7qJ0HkDp6daJ8ycci
         K6F1ZYNRmpzqb/rGq8nXlR/01UIJBsbmxBHoJbJYF0hNJRD/lTZIJ5eGqThdXtw2HWva
         GSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OmveKdtK8fBKQtLLakEBJzW6SzQ4v9I4vqWpGBlgvwQ=;
        b=gemASmrfACoLMXEH1JDOGbHxGB/Oq3VBD2Bch0ZEDthr8/+hoH4gqooDgkCkdAD3oN
         GncZzKfyBL1H00pLH6PApJBunYUM7iWaUmQKOU+2CZGQhkOC7u3sXNeGt1zFF5kp02/E
         thbFLquqrPyyXHfbDy90iGfuKc0Tj7kHc3Ki1tKlg1UNe6jEpp1HhYAO3HXFhkdUhfxg
         gKxmgP5Lt52X2aWQGB5F4UL4Xiyw3KUUzId/Jy4svdRxNmRFNizgJbRNe9c5HOPNpGWA
         sTvT3tT8hoZL+MfFKPhRrka4fjIlGjHl9hjP2ZNZw+CcLJKSx93TJGiDGus733hygqgM
         Z5Xw==
X-Gm-Message-State: AOAM530kEf99XS6geU9jGdofUXgrHXb4mgTlBGJvXNH8bLlhxoOpPbpu
	c60LWEZ7IrSVSQ07IP59x/nWMxO1SzXC0Q==
X-Google-Smtp-Source: ABdhPJw+miUTvVxm2MyCc4GOh7cFZ8Z12Zgkfr/e4CLv2YSKu9eCIs3NwdTD+qRB4wIjDbYy+s/UMg==
X-Received: by 2002:a17:90a:86c6:: with SMTP id y6mr1607271pjv.16.1625828684406;
        Fri, 09 Jul 2021 04:04:44 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id s15sm6247902pfu.97.2021.07.09.04.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 04:04:44 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 2/9] mptcp: add fullmesh path manager
Date: Fri,  9 Jul 2021 19:04:29 +0800
Message-Id: <b699c90050c80f3c79b5fa42d1d9c18c46a21014.1625825505.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <974215e2c4ec6e953bd28882820507b0638c3a8a.1625825505.git.geliangtang@gmail.com>
References: <cover.1625825505.git.geliangtang@gmail.com> <974215e2c4ec6e953bd28882820507b0638c3a8a.1625825505.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added the in-kernel fullmesh path manager. Implemented two
new init functions, mptcp_pm_fm_init and mptcp_pm_fm_data_init, and two
new struct, mptcp_fm_addr_entry and pm_fm_pernet.

In mptcp_pm_fm_init, register a pernet operation mptcp_pm_fm_pernet_ops.

In mptcp_pm_fm_data_init, initialize the necessary fields of mptcp_pm_data.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/Makefile      |  2 +-
 net/mptcp/pm.c          |  3 ++
 net/mptcp/pm_fullmesh.c | 85 +++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h    |  2 +
 4 files changed, 91 insertions(+), 1 deletion(-)
 create mode 100644 net/mptcp/pm_fullmesh.c

diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index 6dae6852ee3a..dc7347d6fa39 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -2,7 +2,7 @@
 obj-$(CONFIG_MPTCP) += mptcp.o
 
 mptcp-y := protocol.o subflow.o options.o token.o crypto.o ctrl.o pm.o diag.o \
-	   mib.o pm_netlink.o sockopt.o
+	   mib.o pm_netlink.o pm_fullmesh.o sockopt.o
 
 obj-$(CONFIG_SYN_COOKIES) += syncookies.o
 obj-$(CONFIG_INET_MPTCP_DIAG) += mptcp_diag.o
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index aa003cf72b68..35039ceb8aec 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -331,9 +331,12 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 
 	if (!strcmp(pm, "netlink"))
 		mptcp_pm_nl_data_init(msk);
+	else if (!strcmp(pm, "fullmesh"))
+		mptcp_pm_fm_data_init(msk);
 }
 
 void __init mptcp_pm_init(void)
 {
 	mptcp_pm_nl_init();
+	mptcp_pm_fm_init();
 }
diff --git a/net/mptcp/pm_fullmesh.c b/net/mptcp/pm_fullmesh.c
new file mode 100644
index 000000000000..4cdcb572b125
--- /dev/null
+++ b/net/mptcp/pm_fullmesh.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt) "MPTCP: " fmt
+
+#include <linux/kernel.h>
+#include <net/tcp.h>
+#include <net/netns/generic.h>
+#include <net/mptcp.h>
+#include <uapi/linux/mptcp.h>
+
+#include "protocol.h"
+
+#define MPTCP_PM_FM_MAX_ADDR	8
+
+static int pm_fm_pernet_id;
+
+struct mptcp_fm_addr_entry {
+	struct list_head	list;
+	struct mptcp_addr_info	addr;
+};
+
+struct pm_fm_pernet {
+	/* protects pernet updates */
+	spinlock_t		lock;
+	struct list_head	local_addr_list;
+	unsigned int		next_id;
+};
+
+void mptcp_pm_fm_data_init(struct mptcp_sock *msk)
+{
+	struct mptcp_pm_data *pm = &msk->pm;
+
+	WRITE_ONCE(pm->work_pending, true);
+	WRITE_ONCE(pm->accept_addr, true);
+	WRITE_ONCE(pm->accept_subflow, MPTCP_PM_FM_MAX_ADDR);
+}
+
+static int __net_init pm_fm_init_net(struct net *net)
+{
+	struct pm_fm_pernet *pernet = net_generic(net, pm_fm_pernet_id);
+
+	spin_lock_init(&pernet->lock);
+	INIT_LIST_HEAD_RCU(&pernet->local_addr_list);
+	pernet->next_id = 1;
+
+	return 0;
+}
+
+static void __flush_addrs(struct net *net, struct list_head *list)
+{
+	while (!list_empty(list)) {
+		struct mptcp_fm_addr_entry *cur;
+
+		cur = list_entry(list->next,
+				 struct mptcp_fm_addr_entry, list);
+		list_del_rcu(&cur->list);
+	}
+}
+
+static void __net_exit pm_fm_exit_net(struct list_head *net_list)
+{
+	struct net *net;
+
+	list_for_each_entry(net, net_list, exit_list) {
+		struct pm_fm_pernet *pernet = net_generic(net, pm_fm_pernet_id);
+
+		__flush_addrs(net, &pernet->local_addr_list);
+	}
+}
+
+static struct pernet_operations mptcp_pm_fm_pernet_ops = {
+	.init		= pm_fm_init_net,
+	.exit_batch	= pm_fm_exit_net,
+	.id		= &pm_fm_pernet_id,
+	.size		= sizeof(struct pm_fm_pernet),
+};
+
+void __init mptcp_pm_fm_init(void)
+{
+	int ret;
+
+	ret = register_pernet_subsys(&mptcp_pm_fm_pernet_ops);
+	if (ret)
+		return;
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 17f2a2894fe6..3de2a298e8d9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -793,6 +793,8 @@ unsigned int mptcp_pm_get_add_addr_signal_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk);
+void __init mptcp_pm_fm_init(void);
+void mptcp_pm_fm_data_init(struct mptcp_sock *msk);
 
 void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_sockopt_sync_all(struct mptcp_sock *msk);
-- 
2.31.1

