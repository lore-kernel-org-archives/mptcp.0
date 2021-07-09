Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E6272
	for <mptcp@lists.linux.dev>; Fri,  9 Jul 2021 11:04:46 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id o4so4827596plg.1
        for <mptcp@lists.linux.dev>; Fri, 09 Jul 2021 04:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hiRtq9aXNBEDpLjrC0TKN6OE8Nq00E3LPh9YRAIin3I=;
        b=ppl1uCKOQFzbUwVM71EMzIdHeDUYpKjPoMW3niaWUZlloqkiTE2qko4+g6WTNuJnrd
         atPBCymDwTw8NvO9eFTO2JythrOcOqQzfeTk/phAqPKCo952pey4rxRg0QUKKAk41czT
         4ozVVbO0MCX+BrdkkIozYxDqWz8OcIiFEII2uUYToWvwWdAbDo84i+tqrohNaLdlKWXB
         2QoL8rtgiFaTEnloEwtIeUUnL+ECAFpZuGthfWCTJT1mcu30Y1aZPOJYcU3FM6W4CVBU
         tGdSbDeiDf4bu6dIw4GhMQsK7Jz31dDT2ZFPno1Fe0cjbak24DcIWkSsDHoqspWAqvX8
         uixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hiRtq9aXNBEDpLjrC0TKN6OE8Nq00E3LPh9YRAIin3I=;
        b=o9cb1U28wrqFCvjEql6slYLuO8bwlVsWt8XT7zdO3sWW6az3zbUdT0MdQqAAnAOD/8
         +VPrLZ/uFRB22YG4UNptM6T1JshdY75qkYlcia/L4jWTNzHrVSIAGtsMqwUZO1C3Oe4v
         6lJrvcAGWaRV9aKHmpgQwKEVcFj7AwWu2ZMe2B3DiIV6huv9jQw+ixHJNz7WEY6tKxzu
         94bYMLKX4dfuqwg9Vi2NmAy9/xxMmVz1U9NZeKMMKFPRtb+jifIJMJKbVaGIfFl2B4Qb
         9t2L234dVBdI81c4WOIqXJZK7A+aNYJJ5YXjoRDgDOkC9VCp5/t7zt5Tq3/f9FZ83DC7
         YkJQ==
X-Gm-Message-State: AOAM533SI6RWZ++1va4dJ/id8NOC2SAMr8hbaa/4RnTRbny7MtWwL04g
	azwQ10ZtFT4A8b/z1yx+RHHgKn5xkgfIDQ==
X-Google-Smtp-Source: ABdhPJypQS6YybmSIeYFIZQxXLUNtITFmOIZ2UUubNT85bfpIHlOGp6XWHdxKvP4j9FFk8aKLVu+fA==
X-Received: by 2002:a17:902:be0d:b029:f9:c913:821f with SMTP id r13-20020a170902be0db02900f9c913821fmr30590134pls.2.1625828686143;
        Fri, 09 Jul 2021 04:04:46 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id s15sm6247902pfu.97.2021.07.09.04.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 04:04:45 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 3/9] mptcp: add fullmesh worker
Date: Fri,  9 Jul 2021 19:04:30 +0800
Message-Id: <8b000137623aa94ab4f7c6b883c2003d91f3d147.1625825505.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <b699c90050c80f3c79b5fa42d1d9c18c46a21014.1625825505.git.geliangtang@gmail.com>
References: <cover.1625825505.git.geliangtang@gmail.com> <974215e2c4ec6e953bd28882820507b0638c3a8a.1625825505.git.geliangtang@gmail.com> <b699c90050c80f3c79b5fa42d1d9c18c46a21014.1625825505.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch implemented the fullmesh worker named mptcp_pm_fm_work. In
it, deal with the PM established status and invoke the function
mptcp_pm_fm_create_subflow to create the subflow.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/pm_fullmesh.c | 95 +++++++++++++++++++++++++++++++++++++++++
 net/mptcp/pm_netlink.c  |  8 ++--
 net/mptcp/protocol.c    |  2 +
 net/mptcp/protocol.h    |  5 +++
 4 files changed, 106 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_fullmesh.c b/net/mptcp/pm_fullmesh.c
index 4cdcb572b125..b27f13a031e3 100644
--- a/net/mptcp/pm_fullmesh.c
+++ b/net/mptcp/pm_fullmesh.c
@@ -26,6 +26,101 @@ struct pm_fm_pernet {
 	unsigned int		next_id;
 };
 
+static struct mptcp_fm_addr_entry *
+select_local_address(const struct pm_fm_pernet *pernet,
+		     struct mptcp_sock *msk)
+{
+	struct mptcp_fm_addr_entry *entry, *ret = NULL;
+	struct sock *sk = (struct sock *)msk;
+
+	msk_owned_by_me(msk);
+
+	rcu_read_lock();
+	__mptcp_flush_join_list(msk);
+	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
+		if (entry->addr.family != sk->sk_family)
+				continue;
+
+		if (!lookup_subflow_by_saddr(&msk->conn_list, &entry->addr)) {
+			ret = entry;
+			break;
+		}
+	}
+	rcu_read_unlock();
+	return ret;
+}
+
+static void check_work_pending(struct mptcp_sock *msk)
+{
+	if (msk->pm.local_addr_used == MPTCP_PM_FM_MAX_ADDR ||
+	    msk->pm.subflows == MPTCP_PM_FM_MAX_ADDR)
+		WRITE_ONCE(msk->pm.work_pending, false);
+}
+
+static void mptcp_pm_fm_create_subflow(struct mptcp_sock *msk)
+{
+	unsigned int local_addr_max = MPTCP_PM_FM_MAX_ADDR;
+	unsigned int subflows_max = MPTCP_PM_FM_MAX_ADDR;
+	struct sock *sk = (struct sock *)msk;
+	struct mptcp_fm_addr_entry *local;
+	struct pm_fm_pernet *pernet;
+
+	pernet = net_generic(sock_net(sk), pm_fm_pernet_id);
+
+	if (msk->pm.local_addr_used < local_addr_max &&
+	    msk->pm.subflows < subflows_max &&
+	    !READ_ONCE(msk->pm.remote_deny_join_id0)) {
+		local = select_local_address(pernet, msk);
+		if (local) {
+			struct mptcp_addr_info remote = { 0 };
+
+			msk->pm.local_addr_used++;
+			msk->pm.subflows++;
+			check_work_pending(msk);
+			remote_address((struct sock_common *)sk, &remote);
+			spin_unlock_bh(&msk->pm.lock);
+			__mptcp_subflow_connect(sk, &local->addr, &remote, 0, 0);
+			spin_lock_bh(&msk->pm.lock);
+			return;
+		}
+
+		/* lookup failed, avoid fourther attempts later */
+		msk->pm.local_addr_used = local_addr_max;
+		check_work_pending(msk);
+	}
+}
+
+static void mptcp_pm_fm_fully_established(struct mptcp_sock *msk)
+{
+	mptcp_pm_fm_create_subflow(msk);
+}
+
+static void mptcp_pm_fm_subflow_established(struct mptcp_sock *msk)
+{
+	mptcp_pm_fm_create_subflow(msk);
+}
+
+void mptcp_pm_fm_work(struct mptcp_sock *msk)
+{
+	struct mptcp_pm_data *pm = &msk->pm;
+
+	msk_owned_by_me(msk);
+
+	spin_lock_bh(&msk->pm.lock);
+
+	pr_debug("msk=%p status=%x", msk, pm->status);
+	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
+		pm->status &= ~BIT(MPTCP_PM_ESTABLISHED);
+		mptcp_pm_fm_fully_established(msk);
+	}
+	if (pm->status & BIT(MPTCP_PM_SUBFLOW_ESTABLISHED)) {
+		pm->status &= ~BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
+		mptcp_pm_fm_subflow_established(msk);
+	}
+
+	spin_unlock_bh(&msk->pm.lock);
+}
+
 void mptcp_pm_fm_data_init(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 56263c2c4014..d050dbd89e24 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -108,8 +108,8 @@ static void local_address(const struct sock_common *skc,
 #endif
 }
 
-static void remote_address(const struct sock_common *skc,
-			   struct mptcp_addr_info *addr)
+void remote_address(const struct sock_common *skc,
+		    struct mptcp_addr_info *addr)
 {
 	addr->family = skc->skc_family;
 	addr->port = skc->skc_dport;
@@ -121,8 +121,8 @@ static void remote_address(const struct sock_common *skc,
 #endif
 }
 
-static bool lookup_subflow_by_saddr(const struct list_head *list,
-				    struct mptcp_addr_info *saddr)
+bool lookup_subflow_by_saddr(const struct list_head *list,
+			     struct mptcp_addr_info *saddr)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_addr_info cur;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 938690f87b8f..2af54eb5fe44 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2343,6 +2343,8 @@ static void mptcp_worker(struct work_struct *work)
 		pm = mptcp_get_path_manager(net);
 		if (!strcmp(pm, "netlink"))
 			mptcp_pm_nl_work(msk);
+		else if (!strcmp(pm, "fullmesh"))
+			mptcp_pm_fm_work(msk);
 	}
 
 	if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3de2a298e8d9..99c23a1887d8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -717,6 +717,10 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
 				struct mptcp_addr_info *addr);
+bool lookup_subflow_by_saddr(const struct list_head *list,
+			     struct mptcp_addr_info *saddr);
+void remote_address(const struct sock_common *skc,
+		    struct mptcp_addr_info *addr);
 
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
@@ -794,6 +798,7 @@ unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk);
 void __init mptcp_pm_fm_init(void);
+void mptcp_pm_fm_work(struct mptcp_sock *msk);
 void mptcp_pm_fm_data_init(struct mptcp_sock *msk);
 
 void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk);
-- 
2.31.1

