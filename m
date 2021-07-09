Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA40072
	for <mptcp@lists.linux.dev>; Fri,  9 Jul 2021 11:04:49 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so5855641pjo.3
        for <mptcp@lists.linux.dev>; Fri, 09 Jul 2021 04:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WGvQKXmgARLpZHTF1eGhgQVD9umN94tPsFPOWXfqWwA=;
        b=PtFLAz7r+gLMZD5agg8IlWLod+IkgpVzrRDkYvILlg9ReL5yvEEv4Zaw/32H7vdpzi
         qsOdlbdGK4jajULh8stDmwVTUh6XfAZrjXawP2I/pRUl0AU1lkT5v4bAS/Pzqd2GETiH
         /eb6iRjChPOZCzfJ5ZwBMR2oFD1pULRN7hlbK7n2JXgNQFLrHdsd7EnmubtVMjZybBxG
         WCWjZZLMJeogmVU+UClhz7W41d9KX5N7loZen8g0s/Gkr00CLUzjb11dyv0Vx2SSLEGE
         JwdFP/7pbFw5v9z8EXHcimSV6Jw8tq3jOExbRzPBU6VR535sgLozzpgOFLD2IicutaBH
         y1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WGvQKXmgARLpZHTF1eGhgQVD9umN94tPsFPOWXfqWwA=;
        b=WR71xqy+oc8vmRHwN5QZRtDpfzCodUKOTIHZY+Id1maBS0XRjVcVvYg3wb67/JPj8U
         eICExhdrFZkuzfVZ5xFf3sxGlsXT1up2juDRNjx1ab7UKHoj7XicMKCDFKtMrnBQ7ThQ
         0Dn1HDD7d3uEzp1l5s7PVtw/rRCXi2D2/PVL713rj0J5b23Ad58SQhHxNX6M6DFIgVdZ
         ZuogO+CJ3DJvMsQXwxrcThM6K1oR5FTznaqiJz1ujyNTXr9fr+dbqRZXXgKjel4eO9EB
         2bRzUnaRrXkMVjTmqOViafWC9/73VvR+DbSu3SL5jUS1dhLMgoCWoIuX3w4Fc0RJfp0N
         FNrQ==
X-Gm-Message-State: AOAM5319QWLtPvZwGouahoAdu7uoMOFmsq5D+dxMwpq0+y0hH7TvvyNe
	jv2FTWwi7XMLFgh/b7+z9CTZbngJRme3VA==
X-Google-Smtp-Source: ABdhPJymUuDO4Bh10tGEEL+OCVwV+Zmx5tkg4RDaOmFsZDq8x3LZEzoucc1s4z+x8uj9NGfLZFh+sA==
X-Received: by 2002:a17:90a:2f8a:: with SMTP id t10mr10351751pjd.146.1625828689338;
        Fri, 09 Jul 2021 04:04:49 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id s15sm6247902pfu.97.2021.07.09.04.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 04:04:49 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 5/9] mptcp: register ipv6 addr notifier
Date: Fri,  9 Jul 2021 19:04:32 +0800
Message-Id: <f4ea9c590e22735421bf6a4f11628bbbb493da16.1625825505.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <3a4cae1a5964f864bc7cb74d311c014cda279a2a.1625825505.git.geliangtang@gmail.com>
References: <cover.1625825505.git.geliangtang@gmail.com> <974215e2c4ec6e953bd28882820507b0638c3a8a.1625825505.git.geliangtang@gmail.com> <b699c90050c80f3c79b5fa42d1d9c18c46a21014.1625825505.git.geliangtang@gmail.com> <8b000137623aa94ab4f7c6b883c2003d91f3d147.1625825505.git.geliangtang@gmail.com> <3a4cae1a5964f864bc7cb74d311c014cda279a2a.1625825505.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch registered a ipv6 addr notifier, named mptcp_pm_addr6_notifier,
to deal with the events of net device UP, DOWN and CHANGE, and skip the
loopback device.

Save the ipv6 address, and pass it to the event handler.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/pm_fullmesh.c | 44 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/net/mptcp/pm_fullmesh.c b/net/mptcp/pm_fullmesh.c
index 7c2d2b23fac3..4b2eddc2b4e9 100644
--- a/net/mptcp/pm_fullmesh.c
+++ b/net/mptcp/pm_fullmesh.c
@@ -5,6 +5,7 @@
 #include <linux/kernel.h>
 #include <linux/inetdevice.h>
 #include <net/tcp.h>
+#include <net/addrconf.h>
 #include <net/netns/generic.h>
 #include <net/mptcp.h>
 #include <uapi/linux/mptcp.h>
@@ -170,6 +171,40 @@ static struct notifier_block mptcp_pm_addr4_notifier = {
 	.notifier_call = mptcp_pm_addr4_event,
 };
 
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+
+static int mptcp_pm_addr6_event(struct notifier_block *this,
+				unsigned long event, void *ptr)
+{
+	const struct inet6_ifaddr *ifa6 = (struct inet6_ifaddr *)ptr;
+	struct net *net = dev_net(ifa6->idev->dev);
+	int addr_type = ipv6_addr_type(&ifa6->addr);
+	struct mptcp_addr_info addr = { 0 };
+
+	if (!(event == NETDEV_UP || event == NETDEV_DOWN || event == NETDEV_CHANGE))
+		goto out;
+
+	if (ifa6->scope > RT_SCOPE_LINK ||
+	    addr_type == IPV6_ADDR_ANY ||
+	    (addr_type & IPV6_ADDR_LOOPBACK) ||
+	    (addr_type & IPV6_ADDR_LINKLOCAL))
+		goto out;
+
+	addr.family = AF_INET6;
+	addr.addr6 = ifa6->addr;
+
+	addr_event_handler(event, net, &addr);
+
+out:
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block mptcp_pm_addr6_notifier = {
+	.notifier_call = mptcp_pm_addr6_event,
+};
+
+#endif
+
 static int __net_init pm_fm_init_net(struct net *net)
 {
 	struct pm_fm_pernet *pernet = net_generic(net, pm_fm_pernet_id);
@@ -222,8 +257,17 @@ void __init mptcp_pm_fm_init(void)
 	if (ret)
 		goto err_reg_inetaddr;
 
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	ret = register_inet6addr_notifier(&mptcp_pm_addr6_notifier);
+	if (ret)
+		goto err_reg_inet6addr;
+#endif
 	return;
 
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+err_reg_inet6addr:
+	unregister_inetaddr_notifier(&mptcp_pm_addr4_notifier);
+#endif
 err_reg_inetaddr:
 	unregister_pernet_subsys(&mptcp_pm_fm_pernet_ops);
 }
-- 
2.31.1

