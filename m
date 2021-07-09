Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7D272
	for <mptcp@lists.linux.dev>; Fri,  9 Jul 2021 11:04:48 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id k20so2617934pgg.7
        for <mptcp@lists.linux.dev>; Fri, 09 Jul 2021 04:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NQjL0tKWObl2WEjlagHZVyo8z3U9pz2nSGOwU8J5WPM=;
        b=ByXFNB+r8w6dOYc+HbP7MyoxjG0qLjJrqm008g4bvBD823+9yTZpjh6Ov0M2ei0nif
         MUR4iAyU+vSnI5+VePX7ftgaUmyc76BKq9/wi+tnG5hiGTacMbZ6YbeCZGAPDE9yGh+F
         nqCSSkMgn8yIoYAmuaD3azgcEbwEApco/xKfE5UsT/QwWeL88tH0KeZsJx9HThWVE+Si
         MrXoMh3zS3A/Qd7xPEULxU4ClyyWa4iTBYxfys9I0T6KaYERTaGBprf5NR5KiL9lSReK
         Ki+FPpWrllBdO25dIHWEigldeAItO4A/wWn1D1jt0AoJQwe77B0FFZrN+zLjcLCkUvS5
         8iQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NQjL0tKWObl2WEjlagHZVyo8z3U9pz2nSGOwU8J5WPM=;
        b=bzHummgEYXZSce130U7/umK8PHtl4z8xqAfC3ql0FBPIgF5IsCD8dQp8lLGPd8cOcp
         xmlwfTzSZh21nJtX8iCOIiJwBv7JFBvScVtXoe6QH1KEALKyN2WC0trNE4K4mT2CVtV6
         G/Gh7fveFCQ34HyJuhvTcKXaxZ2iqQydoZeEsLfHBBfn/K/KR4d+l2YFHKL/0f2s313D
         l7gk5mdrLcW33XM2xdDvxX2/M2LEarF9CKmX6Qnz6Lvx3s13ztP1U3gr7po2mZGRXHAT
         yayD4bKLHsqf5nLDwZDiXi2k2mUoU3V4yfiyBeX/PBCTOZ9z74DU2koVdcykmX42vhgX
         jkHQ==
X-Gm-Message-State: AOAM531DYWHcA2Aad9dr+m5MLkQG2UgXbu9EzDgZ5bNYfSsANaVKH1Ew
	IFN3jQWyiDRi/4yEgK1O9GSYrKA/NxfgAg==
X-Google-Smtp-Source: ABdhPJxtip1ye5B/2L7jBBb1D5asXBaMWLVxFxQ7g2lZEPCMhDCMerFYMK+0em2xIW+B+w4SvOO7MA==
X-Received: by 2002:a62:bd15:0:b029:31c:a584:5f97 with SMTP id a21-20020a62bd150000b029031ca5845f97mr30374760pff.33.1625828687738;
        Fri, 09 Jul 2021 04:04:47 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id s15sm6247902pfu.97.2021.07.09.04.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 04:04:47 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 4/9] mptcp: register ipv4 addr notifier
Date: Fri,  9 Jul 2021 19:04:31 +0800
Message-Id: <3a4cae1a5964f864bc7cb74d311c014cda279a2a.1625825505.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <8b000137623aa94ab4f7c6b883c2003d91f3d147.1625825505.git.geliangtang@gmail.com>
References: <cover.1625825505.git.geliangtang@gmail.com> <974215e2c4ec6e953bd28882820507b0638c3a8a.1625825505.git.geliangtang@gmail.com> <b699c90050c80f3c79b5fa42d1d9c18c46a21014.1625825505.git.geliangtang@gmail.com> <8b000137623aa94ab4f7c6b883c2003d91f3d147.1625825505.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch registered a ipv4 addr notifier, named mptcp_pm_addr4_notifier,
to deal with the events of net device UP, DOWN and CHANGE, and skip the
loopback device.

Save the ipv4 address, and pass it to the event handler.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/pm_fullmesh.c | 49 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/net/mptcp/pm_fullmesh.c b/net/mptcp/pm_fullmesh.c
index b27f13a031e3..7c2d2b23fac3 100644
--- a/net/mptcp/pm_fullmesh.c
+++ b/net/mptcp/pm_fullmesh.c
@@ -3,6 +3,7 @@
 #define pr_fmt(fmt) "MPTCP: " fmt
 
 #include <linux/kernel.h>
+#include <linux/inetdevice.h>
 #include <net/tcp.h>
 #include <net/netns/generic.h>
 #include <net/mptcp.h>
@@ -130,6 +131,45 @@ void mptcp_pm_fm_data_init(struct mptcp_sock *msk)
 	WRITE_ONCE(pm->accept_subflow, MPTCP_PM_FM_MAX_ADDR);
 }
 
+static int mptcp_fm_cmd_mod_addr(struct net *net, const struct mptcp_addr_info *addr)
+{
+	return 0;
+}
+
+static void addr_event_handler(unsigned long event, struct net *net,
+			       struct mptcp_addr_info *addr)
+{
+	if (event == NETDEV_CHANGE)
+		mptcp_fm_cmd_mod_addr(net, addr);
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
 static int __net_init pm_fm_init_net(struct net *net)
 {
 	struct pm_fm_pernet *pernet = net_generic(net, pm_fm_pernet_id);
@@ -177,4 +217,13 @@ void __init mptcp_pm_fm_init(void)
 	ret = register_pernet_subsys(&mptcp_pm_fm_pernet_ops);
 	if (ret)
 		return;
+
+	ret = register_inetaddr_notifier(&mptcp_pm_addr4_notifier);
+	if (ret)
+		goto err_reg_inetaddr;
+
+	return;
+
+err_reg_inetaddr:
+	unregister_pernet_subsys(&mptcp_pm_fm_pernet_ops);
 }
-- 
2.31.1

