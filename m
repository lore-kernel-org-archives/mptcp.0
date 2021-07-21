Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C17070
	for <mptcp@lists.linux.dev>; Wed, 21 Jul 2021 14:31:48 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id x16so1048326plg.3
        for <mptcp@lists.linux.dev>; Wed, 21 Jul 2021 07:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TXsvaEuFBwhBvBwbRBE9J7kgc6qM7TObAkEMq+rbPaU=;
        b=b+upCscTtSFmgLBnX+uZVcIPe2Fa1naIO/yzuu3RJex8SYlNVg0xw5SRq05TVf5DL8
         P9K1oGLgipNWNH9OigTyYnYOtlfBd4Bd4W7ELce0fYX7TTSJUkTp5KQ852FDePvI1Oaa
         O8rJz6czkomrcOBBJanQ4VnQx6nYC+li0AgrH9sPLiQNz65/0qihadqTa9xxT2PqqvED
         3MIe/VGdyKx+Sj4UI04Y+PPea0CMOv/6RRpLX7y1xH9p6CD/A7fM9Xz6Vo2bEPMUxH8c
         ejmkX5iKoFEczUJZr/v12Nn9K9WLnRwgeikNta26vTP/m4pelOyzkOwHYwkNTMoV7Dda
         ghSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TXsvaEuFBwhBvBwbRBE9J7kgc6qM7TObAkEMq+rbPaU=;
        b=El//vvmDrtiNFrTfRLhf1DmoS0g/fkD0721rkTYlovFsENxTGRHAuS3X3WdouJNMgm
         8VcSq5g/UobtPssZoh/fiX8YsAgshjeJEAQLclb2Z3KefcFMMwhc4zslVVwyp/Kqnuid
         GqIQ3QSvhkoztkB2OHeRws2ijxVmVNQoyJscGG5DvJ2MxwdLZq4hWirjGalarkpM76IH
         r0SlvPm4eHdaTPIDda/xlteDiuwt2E4BV88yvd+oevXT0/En4o7EJ+voxuVtfemO57mt
         0xJXlMm7wRHRtykHq6nqyLHwtept3xWfsor7K+MfboHsKySYHCcnLQrvaMOBSXld9vg6
         hECw==
X-Gm-Message-State: AOAM532l3XetdMVRn4qZSUxD2UW4iJQVy9TwMCu9LF1/7ZKikfMzZmCP
	B7Jb4KlDJNUuk/SQw19PK+w/kDF9jir91A==
X-Google-Smtp-Source: ABdhPJxite7WMq5Mpovh8zBKsX17D7xs9GsyMlT5Af1j1B19NvLjiwksLExuQsasqL+yKpkVJfqxvg==
X-Received: by 2002:a17:903:234c:b029:12b:3fd8:5fb6 with SMTP id c12-20020a170903234cb029012b3fd85fb6mr27455603plh.49.1626877907569;
        Wed, 21 Jul 2021 07:31:47 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id i6sm21723147pfa.44.2021.07.21.07.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 07:31:47 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 04/10] mptcp: add netdev up event handler
Date: Wed, 21 Jul 2021 22:31:28 +0800
Message-Id: <f1175761821947749ac9724deb3009b9b2747bbd.1626877655.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <93ffe9fbfda6d2efdbab73373b6efbbce3a36b00.1626877655.git.geliangtang@gmail.com>
References: <cover.1626877655.git.geliangtang@gmail.com> <b5f63eb4ad680a99fc806d2406968a6a5f272f01.1626877655.git.geliangtang@gmail.com> <0000f0168f0d8d1cd34bbe5463aed721225446e2.1626877655.git.geliangtang@gmail.com> <93ffe9fbfda6d2efdbab73373b6efbbce3a36b00.1626877655.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added the net device UP event handler function named
mptcp_fm_cmd_add_addr. In it, alloc an address entry, populate it, and
append this entry to the local address list. Then invoke
mptcp_nl_add_subflow_or_signal_addr to create the new subflows.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 include/uapi/linux/mptcp.h |  1 +
 net/mptcp/pm_fullmesh.c    |  3 +++
 net/mptcp/pm_netlink.c     | 31 +++++++++++++++++++++++++++++--
 net/mptcp/protocol.h       |  1 +
 4 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 7b05f7102321..f66038b9551f 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -73,6 +73,7 @@ enum {
 #define MPTCP_PM_ADDR_FLAG_SIGNAL			(1 << 0)
 #define MPTCP_PM_ADDR_FLAG_SUBFLOW			(1 << 1)
 #define MPTCP_PM_ADDR_FLAG_BACKUP			(1 << 2)
+#define MPTCP_PM_ADDR_FLAG_FULLMESH			(1 << 3)
 
 enum {
 	MPTCP_PM_CMD_UNSPEC,
diff --git a/net/mptcp/pm_fullmesh.c b/net/mptcp/pm_fullmesh.c
index bac06ddc658b..6c52a64657f4 100644
--- a/net/mptcp/pm_fullmesh.c
+++ b/net/mptcp/pm_fullmesh.c
@@ -14,6 +14,9 @@ static void addr_event_handler(unsigned long event, struct net *net,
 {
 	if (!mptcp_is_fullmesh_enabled(net))
 		return;
+
+	if (event == NETDEV_UP)
+		mptcp_fm_cmd_add_addr(net, addr);
 }
 
 static int mptcp_pm_addr4_event(struct notifier_block *this,
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ac0aa6faacfa..3437de74f003 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -170,7 +170,8 @@ select_local_address(const struct pm_nl_pernet *pernet,
 	rcu_read_lock();
 	__mptcp_flush_join_list(msk);
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
+		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) &&
+		    !(entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
 			continue;
 
 		if (entry->addr.family != sk->sk_family) {
@@ -745,7 +746,8 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		addr_max = pernet->add_addr_signal_max;
 		WRITE_ONCE(pernet->add_addr_signal_max, addr_max + 1);
 	}
-	if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
+	if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW ||
+	    entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH) {
 		addr_max = pernet->local_addr_max;
 		WRITE_ONCE(pernet->local_addr_max, addr_max + 1);
 	}
@@ -1954,6 +1956,31 @@ static struct genl_family mptcp_genl_family __ro_after_init = {
 	.n_mcgrps	= ARRAY_SIZE(mptcp_pm_mcgrps),
 };
 
+#if IS_ENABLED(CONFIG_MPTCP_FULLMESH)
+
+int mptcp_fm_cmd_add_addr(struct net *net, const struct mptcp_addr_info *addr)
+{
+	struct pm_nl_pernet *pernet = net_generic(net, pm_nl_pernet_id);
+	struct mptcp_pm_addr_entry *entry;
+
+	entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->addr = *addr;
+	entry->addr.id = 0;
+	entry->addr.port = 0;
+	entry->flags |= MPTCP_PM_ADDR_FLAG_FULLMESH;
+	entry->ifindex = 0;
+
+	mptcp_pm_nl_append_new_local_addr(pernet, entry);
+	mptcp_nl_add_subflow_or_signal_addr(net);
+
+	return 0;
+}
+
+#endif
+
 static int __net_init pm_nl_init_net(struct net *net)
 {
 	struct pm_nl_pernet *pernet = net_generic(net, pm_nl_pernet_id);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2c3a4d507454..78a9cd90b0f9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -812,6 +812,7 @@ unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk);
 #if IS_ENABLED(CONFIG_MPTCP_FULLMESH)
 void __init mptcp_pm_fm_init(void);
+int mptcp_fm_cmd_add_addr(struct net *net, const struct mptcp_addr_info *addr);
 #endif
 
 void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk);
-- 
2.31.1

