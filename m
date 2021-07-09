Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AEF72
	for <mptcp@lists.linux.dev>; Fri,  9 Jul 2021 11:04:53 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id 21so8426816pfp.3
        for <mptcp@lists.linux.dev>; Fri, 09 Jul 2021 04:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QGl9RCzLxsOqjpEyQAo7nw9KAWLxczFkorvZrudZFEQ=;
        b=qQV5Dp9QT/Lam1eSLRpMq2ZzUSgjpwTRf8Tt3jebpsRJ1sLUSqpu8fypuK+bNvVkST
         wqh4gaTjjmYTHw7HBWILsev3yRrvvLOMissYRvNYUjBULCClaOYUORv5aNG167Kb1x/a
         AG0lHk2Zxn5JMrsvNa2weJmrmfwOt89Ecr0OIJb6BzuvXd7Ye28lbnNWO9vZv5ujQ2Mt
         v8jJPGpCY2zZJP3pu50HEwUc+kslUxPkDyAqZB6yc/TBWW8sDOzzjMk9YCwus+jN5eeJ
         F2GBGyC4CS4g28VAfjFdpzkqhh1lBaYg8sn4nJO+0wMqNNL420z+LjDC1DaCP0QxuXvM
         Y0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QGl9RCzLxsOqjpEyQAo7nw9KAWLxczFkorvZrudZFEQ=;
        b=GdALsKZ2nAFj9P5WJG+VWESiiqlQ3EivVV5rNdRrV5xWD/TwAU+l15GEb0cb8FSBSI
         4fPiVHGNpWSFRyddAeuJPN2eHJ91NLdCKykmWUJ6nlt9IwXsqV/ZqCJVlOB9n5eJ/nkq
         mcNw/YvihZMfsgTiTmBTU0HIDZwdU5Ty/8LU0dEBr/jN1ZmYLRgHighBe5l4gLsus+Ap
         9Wcb3hCUIZcSEX/JYxj6yyIPEPS13qDX70oedrghFveXP2b0krMOXvqm651z7+P1+0rj
         cQSkdFwhriDSWjFA5DCYUo5FapN3uiJFDoKxqyxmfDAnIOJkTwG+EMri7J7dBNDgdlZ0
         H53Q==
X-Gm-Message-State: AOAM5327qFHzbnrQgZ7MEzKo4593+jEyqY7BYIZt80D2oyKXMt0LnjM+
	bu5AiDRgYgGKXR35ZSwD1LY4DmNn9xK9+Q==
X-Google-Smtp-Source: ABdhPJxovcfnZCWun4vL+PK9RHmZaXQ3xRMw4eCUKmWQ1sOmojGcZigwk7614EMrZEMP8oJ5Yhk/sQ==
X-Received: by 2002:a63:f556:: with SMTP id e22mr37346743pgk.189.1625828692600;
        Fri, 09 Jul 2021 04:04:52 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id s15sm6247902pfu.97.2021.07.09.04.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 04:04:52 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 7/9] mptcp: add netdev down event handler
Date: Fri,  9 Jul 2021 19:04:34 +0800
Message-Id: <9761e92041968743463b3e3836cc54d063e296b6.1625825505.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <077d3ff80fa785e602669724bb4fed9789a98e70.1625825505.git.geliangtang@gmail.com>
References: <cover.1625825505.git.geliangtang@gmail.com> <974215e2c4ec6e953bd28882820507b0638c3a8a.1625825505.git.geliangtang@gmail.com> <b699c90050c80f3c79b5fa42d1d9c18c46a21014.1625825505.git.geliangtang@gmail.com> <8b000137623aa94ab4f7c6b883c2003d91f3d147.1625825505.git.geliangtang@gmail.com> <3a4cae1a5964f864bc7cb74d311c014cda279a2a.1625825505.git.geliangtang@gmail.com> <f4ea9c590e22735421bf6a4f11628bbbb493da16.1625825505.git.geliangtang@gmail.com> <077d3ff80fa785e602669724bb4fed9789a98e70.1625825505.git.geliangtang@gmail.com>
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
 net/mptcp/pm_fullmesh.c | 105 ++++++++++++++++++++++++++++++++++++++++
 net/mptcp/pm_netlink.c  |   2 +-
 net/mptcp/protocol.h    |   1 +
 3 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_fullmesh.c b/net/mptcp/pm_fullmesh.c
index 1ef268d34360..a48287ff4cc0 100644
--- a/net/mptcp/pm_fullmesh.c
+++ b/net/mptcp/pm_fullmesh.c
@@ -102,6 +102,17 @@ static void mptcp_pm_fm_subflow_established(struct mptcp_sock *msk)
 	mptcp_pm_fm_create_subflow(msk);
 }
 
+static void mptcp_pm_fm_rm_addr_received(struct mptcp_sock *msk)
+{
+	mptcp_pm_nl_rm_addr_received(msk);
+}
+
+static void mptcp_pm_fm_rm_subflow_received(struct mptcp_sock *msk,
+					    const struct mptcp_rm_list *rm_list)
+{
+	mptcp_pm_nl_rm_subflow_received(msk, rm_list);
+}
+
 void mptcp_pm_fm_work(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
@@ -111,6 +122,10 @@ void mptcp_pm_fm_work(struct mptcp_sock *msk)
 	spin_lock_bh(&msk->pm.lock);
 
 	pr_debug("msk=%p status=%x", msk, pm->status);
+	if (pm->status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
+		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
+		mptcp_pm_fm_rm_addr_received(msk);
+	}
 	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
 		pm->status &= ~BIT(MPTCP_PM_ESTABLISHED);
 		mptcp_pm_fm_fully_established(msk);
@@ -173,6 +188,93 @@ static int mptcp_fm_cmd_add_addr(struct net *net, const struct mptcp_addr_info *
 	return 0;
 }
 
+static int mptcp_fm_remove_subflow_and_signal_addr(struct net *net, struct mptcp_addr_info *addr)
+{
+	struct mptcp_rm_list list = { .nr = 0 };
+	long s_slot = 0, s_num = 0;
+	struct mptcp_sock *msk;
+
+	list.ids[list.nr++] = addr->id;
+
+	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
+		struct sock *sk = (struct sock *)msk;
+		bool remove_subflow;
+
+		if (list_empty(&msk->conn_list))
+			goto next;
+
+		lock_sock(sk);
+		remove_subflow = lookup_subflow_by_saddr(&msk->conn_list, addr);
+		if (remove_subflow) {
+			spin_lock_bh(&msk->pm.lock);
+			mptcp_pm_remove_addr(msk, &list);
+			mptcp_pm_fm_rm_subflow_received(msk, &list);
+			spin_unlock_bh(&msk->pm.lock);
+		}
+		release_sock(sk);
+
+next:
+		sock_put(sk);
+		cond_resched();
+	}
+	return 0;
+}
+
+struct addr_entry_release_work {
+	struct rcu_work rwork;
+	struct net *net;
+	struct mptcp_fm_addr_entry *entry;
+};
+
+static void mptcp_pm_release_addr_entry(struct work_struct *work)
+{
+	struct addr_entry_release_work *w;
+	struct mptcp_fm_addr_entry *entry;
+	struct net *net;
+
+	w = container_of(to_rcu_work(work), struct addr_entry_release_work, rwork);
+	net = w->net;
+	entry = w->entry;
+	if (entry) {
+		mptcp_fm_remove_subflow_and_signal_addr(net, &entry->addr);
+		kfree(entry);
+	}
+	kfree(w);
+}
+
+static void mptcp_pm_free_addr_entry(struct net *net, struct mptcp_fm_addr_entry *entry)
+{
+	struct addr_entry_release_work *w;
+
+	w = kmalloc(sizeof(*w), GFP_ATOMIC);
+	if (w) {
+		INIT_RCU_WORK(&w->rwork, mptcp_pm_release_addr_entry);
+		w->net = net;
+		w->entry = entry;
+		queue_rcu_work(system_wq, &w->rwork);
+	}
+}
+
+static int mptcp_fm_cmd_del_addr(struct net *net, struct mptcp_addr_info *addr)
+{
+	struct pm_fm_pernet *pernet = net_generic(net, pm_fm_pernet_id);
+	struct mptcp_fm_addr_entry *entry, *tmp;
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
 static int mptcp_fm_cmd_mod_addr(struct net *net, const struct mptcp_addr_info *addr)
 {
 	return 0;
@@ -183,6 +285,8 @@ static void addr_event_handler(unsigned long event, struct net *net,
 {
 	if (event == NETDEV_UP)
 		mptcp_fm_cmd_add_addr(net, addr);
+	else if (event == NETDEV_DOWN)
+		mptcp_fm_cmd_del_addr(net, addr);
 	else if (event == NETDEV_CHANGE)
 		mptcp_fm_cmd_mod_addr(net, addr);
 }
@@ -267,6 +371,7 @@ static void __flush_addrs(struct net *net, struct list_head *list)
 		cur = list_entry(list->next,
 				 struct mptcp_fm_addr_entry, list);
 		list_del_rcu(&cur->list);
+		mptcp_pm_free_addr_entry(net, cur);
 	}
 }
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index debec16e9209..dea4dc4ad36e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -642,7 +642,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 	}
 }
 
-static void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
+void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
 {
 	mptcp_pm_nl_rm_addr_or_subflow(msk, &msk->pm.rm_list_rx, MPTCP_MIB_RMADDR);
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ea93bd1b4fde..fabadfd10af3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -792,6 +792,7 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_data_init(struct mptcp_sock *msk);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
+void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk);
 void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
 				     const struct mptcp_rm_list *rm_list);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
-- 
2.31.1

