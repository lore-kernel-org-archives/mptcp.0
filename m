Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1E470
	for <mptcp@lists.linux.dev>; Wed, 21 Jul 2021 14:31:51 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id 37so2103059pgq.0
        for <mptcp@lists.linux.dev>; Wed, 21 Jul 2021 07:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ruQNvGIwwCFoxUseL8wHoEXK+URq/aLs5b639Ag/Qio=;
        b=tmK/yAf5IRw8wMGqYKDYPK+ksixBJiHBN2TAqzC9bUtCnb0Ub+ymMQfFxv8QkrXCrG
         tFnlO83bliLTeTYc7tSb7ytR7zzKGWHhOj1sxFNh8JmZWnM9KlQsjRIVtrAVnBh/8U0k
         DMUaIwRdNhvid9GADfhgiDXRHBG7O1++d2XCQpKBPofV4FfF79ONeO84eJ9XZakUkJTi
         WaAtgsatOfTtA+vO77EVsSsTIT4ZgIy7Sy9XeS3l5bYX1RFljnLBhQ9fs40GSp4WtMyD
         /VA31To9ghIvmFrhCLsu8FgEGn9eopIqinz7AVD5FsZnSFRX82oFnITYA9DfFI4+yq5j
         nFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ruQNvGIwwCFoxUseL8wHoEXK+URq/aLs5b639Ag/Qio=;
        b=t1yug0cYeDb0SRBqXojTgS407dhOdMNT4O2wW2eFeur+JyOY9tmoOq2H1ZTC/FxIOl
         BO53gWG6H0q4yG6RjekClgAn2NSCy8VJVQvZLdIxLcAxzSmjJbXhBQiXVisEyDlmXL+e
         KxD1fXXEO3JugqzGxE5zhSIKO2SgcLGoLw1fY+JmqaTYJ9XEn9le18JLEArbYdu3CvEr
         ahW4CvPeDRoCGcZJOYOuB1hiZ0MAQWHP+1Bef03O1Td6t4TQ76Chawp+eOZqz8EjCiaO
         P6DtMbEz5k5O93syXmFsSHkzGYIz+GOcaOaVz323JEK9nK9i7KGstxOqFUZW9h4Fbu4z
         hEjw==
X-Gm-Message-State: AOAM530HEN6xwonmhCnDhaduKEKSRTHTVWS+VSrjRzL5RSEM8eWpahCp
	/xENXQCmUgNo4UA+yyYS+OXqQ/uKLLnT/g==
X-Google-Smtp-Source: ABdhPJw2ye829qwjiGePPH1RTsnxC/6iPETGabqEUsg19wnj+UMER8ia9ZEyxX8VjasdV3TdP/OGrw==
X-Received: by 2002:a63:5903:: with SMTP id n3mr36669137pgb.104.1626877910655;
        Wed, 21 Jul 2021 07:31:50 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id i6sm21723147pfa.44.2021.07.21.07.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 07:31:50 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 06/10] mptcp: add netdev down event handler
Date: Wed, 21 Jul 2021 22:31:30 +0800
Message-Id: <149236d46fe59a177a2f36a5c6e45941a1e0c2fd.1626877655.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <e9de213a59a066c6beaba2895a7c60412b654601.1626877655.git.geliangtang@gmail.com>
References: <cover.1626877655.git.geliangtang@gmail.com> <b5f63eb4ad680a99fc806d2406968a6a5f272f01.1626877655.git.geliangtang@gmail.com> <0000f0168f0d8d1cd34bbe5463aed721225446e2.1626877655.git.geliangtang@gmail.com> <93ffe9fbfda6d2efdbab73373b6efbbce3a36b00.1626877655.git.geliangtang@gmail.com> <f1175761821947749ac9724deb3009b9b2747bbd.1626877655.git.geliangtang@gmail.com> <e9de213a59a066c6beaba2895a7c60412b654601.1626877655.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added the net device DOWN event handler function named
mptcp_fm_cmd_del_addr. In it, traverse the local address list to find
the deleting address entry, pass this entry to mptcp_pm_free_addr_entry,
then start the rcu_work to remove the subflow and signal the RM_ADDR
suboption.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/pm_fullmesh.c |  2 ++
 net/mptcp/pm_netlink.c  | 20 ++++++++++++++++++++
 net/mptcp/protocol.h    |  1 +
 3 files changed, 23 insertions(+)

diff --git a/net/mptcp/pm_fullmesh.c b/net/mptcp/pm_fullmesh.c
index 6c52a64657f4..beb6e4c7cf46 100644
--- a/net/mptcp/pm_fullmesh.c
+++ b/net/mptcp/pm_fullmesh.c
@@ -17,6 +17,8 @@ static void addr_event_handler(unsigned long event, struct net *net,
 
 	if (event == NETDEV_UP)
 		mptcp_fm_cmd_add_addr(net, addr);
+	else if (event == NETDEV_DOWN)
+		mptcp_fm_cmd_del_addr(net, addr);
 }
 
 static int mptcp_pm_addr4_event(struct notifier_block *this,
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 533818b4dba2..765d59dd2a5d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1984,6 +1984,26 @@ int mptcp_fm_cmd_add_addr(struct net *net, const struct mptcp_addr_info *addr)
 	return 0;
 }
 
+int mptcp_fm_cmd_del_addr(struct net *net, struct mptcp_addr_info *addr)
+{
+	struct pm_nl_pernet *pernet = net_generic(net, pm_nl_pernet_id);
+	struct mptcp_pm_addr_entry *entry, *tmp;
+
+	spin_lock_bh(&pernet->lock);
+	list_for_each_entry_safe(entry, tmp, &pernet->local_addr_list, list) {
+		if (addresses_equal(&entry->addr, addr, false)) {
+			list_del_rcu(&entry->list);
+			spin_unlock_bh(&pernet->lock);
+			mptcp_pm_free_addr_entry(net, entry);
+
+			return 0;
+		}
+	}
+	spin_unlock_bh(&pernet->lock);
+
+	return 0;
+}
+
 #endif
 
 static int __net_init pm_nl_init_net(struct net *net)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 78a9cd90b0f9..1dbd8de17a22 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -813,6 +813,7 @@ unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk);
 #if IS_ENABLED(CONFIG_MPTCP_FULLMESH)
 void __init mptcp_pm_fm_init(void);
 int mptcp_fm_cmd_add_addr(struct net *net, const struct mptcp_addr_info *addr);
+int mptcp_fm_cmd_del_addr(struct net *net, struct mptcp_addr_info *addr);
 #endif
 
 void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk);
-- 
2.31.1

