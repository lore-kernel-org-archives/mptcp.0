Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A878070
	for <mptcp@lists.linux.dev>; Wed, 21 Jul 2021 14:31:46 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id 37so2102820pgq.0
        for <mptcp@lists.linux.dev>; Wed, 21 Jul 2021 07:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5FZmuicvLbzy9B62fMvXg0GQ6kOR6Py7zMo+Ddzou0A=;
        b=thHcEETUmrXPe+9/iGmAX32pF3r0AVqm1zUuyyLYp+4JgQH+JU2fb7WpkZZpMrUqzd
         gMR61zhm+FOe3BYMM7jRXxNK3X5iJIdff/xjQMz7FZuG1uEVkFi+l/VFWqACqB64XcZ4
         2jbleoK0lW5Bow0Pydn1cR7uxRSW3cBZBw0ZLKEa1jijZtYk7AyAAxPOzAUFggpOIUNe
         9r4m4so6H/IQlnd724JIno20CNsmH1kMI54NyFvIotwJrVBe67bywpGxToHUcAM/IBgE
         pTuJNpfButIxuDJbCALe1DTSRG4+cIZpnR939itbzQMMLRzwgO5rwJ4e61uwajZAUzmT
         ghsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5FZmuicvLbzy9B62fMvXg0GQ6kOR6Py7zMo+Ddzou0A=;
        b=fYzbttNIJ6U+6JvHuXqpPmZzeXmzoxYOIfLLjlv1hi6j0nZgHXV11po/K7/ohW8dz4
         gEbEaU6xE406ajpNxvVW1DswOjCLh4zF6kSYdBtz5bJ75j8DYHHmEtxAszDlWVVKGLoB
         kOnrbqx+hzpx9ZvAo3Jw98skiUJ9xObS2d4b1mm/OIoYSV/sfDlbCwXBN+jk0glvnwd4
         I2xquqZN7RQNGvD8LtkoRCFtI3pBWdJetJz3HZJkSfVKthHfsvboaNAUWfGDhzFfyrEm
         t3e6PXvOLU48V5KI7sTI03N9WTQIsgs2UwdlgepiwfervVeE6nI62g9X5PqPMReax/p0
         5w/Q==
X-Gm-Message-State: AOAM533qu5iCBm+lsuhKgf6hfXur4wSYFSH3RMZlyT9o6wyal7v0PHKD
	ocRLNbnaTT5voJPRnb6wjdAIic4/ElpShw==
X-Google-Smtp-Source: ABdhPJwqWk9UksuQzdK4zHmydTKQHCJI+WAKYDZ+kCbUtd3BfX/X/Apu9c04XVuLI8+yxr7Fq6cJmg==
X-Received: by 2002:a62:a20d:0:b029:35b:73da:dc8d with SMTP id m13-20020a62a20d0000b029035b73dadc8dmr478213pff.54.1626877906128;
        Wed, 21 Jul 2021 07:31:46 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id i6sm21723147pfa.44.2021.07.21.07.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 07:31:45 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 03/10] mptcp: register ipv6 addr notifier
Date: Wed, 21 Jul 2021 22:31:27 +0800
Message-Id: <93ffe9fbfda6d2efdbab73373b6efbbce3a36b00.1626877655.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <0000f0168f0d8d1cd34bbe5463aed721225446e2.1626877655.git.geliangtang@gmail.com>
References: <cover.1626877655.git.geliangtang@gmail.com> <b5f63eb4ad680a99fc806d2406968a6a5f272f01.1626877655.git.geliangtang@gmail.com> <0000f0168f0d8d1cd34bbe5463aed721225446e2.1626877655.git.geliangtang@gmail.com>
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
 net/mptcp/pm_fullmesh.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/net/mptcp/pm_fullmesh.c b/net/mptcp/pm_fullmesh.c
index 38a44ce8a5fa..bac06ddc658b 100644
--- a/net/mptcp/pm_fullmesh.c
+++ b/net/mptcp/pm_fullmesh.c
@@ -3,6 +3,8 @@
 #define pr_fmt(fmt) "MPTCP: " fmt
 
 #include <linux/kernel.h>
+#include <linux/inetdevice.h>
+#include <net/addrconf.h>
 #include <net/mptcp.h>
 
 #include "protocol.h"
@@ -41,8 +43,47 @@ static struct notifier_block mptcp_pm_addr4_notifier = {
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
 void __init mptcp_pm_fm_init(void)
 {
 	if (register_inetaddr_notifier(&mptcp_pm_addr4_notifier))
 		return;
+
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	if (register_inet6addr_notifier(&mptcp_pm_addr6_notifier))
+		unregister_inetaddr_notifier(&mptcp_pm_addr4_notifier);
+#endif
 }
-- 
2.31.1

