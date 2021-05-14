Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E53D71
	for <mptcp@lists.linux.dev>; Fri, 14 May 2021 14:32:33 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id g24so15506839pji.4
        for <mptcp@lists.linux.dev>; Fri, 14 May 2021 07:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=79Qfskin4lRmdCASxoMQEuJjJJ4j5q81EEEvfHmpc2c=;
        b=vGff3VHmGw3LMUlTcA0xiEiyt52t2/ZXHO8ryu3mb816eAupt5s02qvYZYrDqMnLN/
         /GGU2tnEMlagjlTsNQPihrwq7TsKQKO89vG5zfsyMUJXh7/iP1CJmvcqIqvr4Fm8pX+m
         Drjcr6ssFXJRgIUIHhqDDGcQv9khqv/ANvu9yVWi56Jz0bAZmWhvGEh0R8SPqVsCxDEj
         bVEzWM5eFGdCiJVHHtrAeqU/XHdLMHvqxu3m/6J+AAl0EaT6qts4LBUZQXRW07l4e+pV
         iqEmL0pUGZQB1HllJW6dQ5D711j+mMTA0+qAsa34SlqAvF92hfUerkx05xj/MA0WfbAH
         HRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=79Qfskin4lRmdCASxoMQEuJjJJ4j5q81EEEvfHmpc2c=;
        b=osmm12AlNppp+sIAgFH3uPLZj+Q3nIrt0kejqqBAZIYfUNhfprRFZrm8YtfO3A63PU
         L0yu5kkXkeWV5SLoJXS8JhIItuHtAYENOXbGPieVd6JKwLBz7PH9nUn/vUGRH8QPW4AG
         Tfa9jPExHw1QAybytz2LbYVGOacOU+UwttgwvSVJqtxht6rDZouGJf8RPXeqY3g74WPU
         IOhTDiIhy6h5yZ1BQMhad9ksPUFEyCimEO39VmavCYM689Dan/zAp9019WQqInLLcH3Q
         aIBQ2uNMkKK15/588zxB110hnVzhzRXjD04nZWy61WF5BQf64V7I90h8aSv2BqkOqYf4
         uaxA==
X-Gm-Message-State: AOAM533Nm8T2hQfsYmKwodccmp+O2tZuxL5ZTXVKZYXwhpxok5dqg5A5
	3B8KHa0Fa1wzTm2DVcSyxgQ3ZDpDpHY=
X-Google-Smtp-Source: ABdhPJx5vqzWjXDm67iMD503Q6gIMLAhsHr4kiNmpMf4PvG93tBrkzt+tJLN5oBS/NAxLLxoIDKNFQ==
X-Received: by 2002:a17:90a:6be1:: with SMTP id w88mr11509958pjj.101.1621002752663;
        Fri, 14 May 2021 07:32:32 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id n129sm4390208pfn.54.2021.05.14.07.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 07:32:32 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v6 mptcp-next 4/6] mptcp: add add_list in mptcp_pm_data
Date: Fri, 14 May 2021 22:32:17 +0800
Message-Id: <850406b0f49fa0a76b4825b36c55426a0d033d52.1621002341.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <ae0d32922128771f09b230e5718774472a088207.1621002341.git.geliangtang@gmail.com>
References: <cover.1621002341.git.geliangtang@gmail.com> <d051657e9c51ccb27b32d443777896c6ae519444.1621002341.git.geliangtang@gmail.com> <2a6a925510a7d79f0c2101d5d353f6b74f0e69bb.1621002341.git.geliangtang@gmail.com> <ae0d32922128771f09b230e5718774472a088207.1621002341.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like the anno_list member in struct mptcp_pm_data, this patch added a
new member named add_list in it, to save all the received ADD_ADDRs in
this add_list.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/pm.c         |  1 +
 net/mptcp/pm_netlink.c | 89 +++++++++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.c   |  1 +
 net/mptcp/protocol.h   |  2 +
 4 files changed, 87 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 9d00fa6d22e9..9456fe17b6a3 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -324,6 +324,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 
 	spin_lock_init(&msk->pm.lock);
 	INIT_LIST_HEAD(&msk->pm.anno_list);
+	INIT_LIST_HEAD(&msk->pm.add_list);
 
 	mptcp_pm_nl_data_init(msk);
 }
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 4fff8aef45e4..3fcc167ea702 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -39,6 +39,11 @@ struct mptcp_pm_anno_entry {
 	u8			retrans_times;
 };
 
+struct mptcp_pm_add_entry {
+	struct list_head	list;
+	struct mptcp_addr_info	addr;
+};
+
 #define MAX_ADDR_ID		255
 #define BITMAP_SZ DIV_ROUND_UP(MAX_ADDR_ID + 1, BITS_PER_LONG)
 
@@ -483,6 +488,69 @@ static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
 	mptcp_pm_create_subflow_or_signal_addr(msk);
 }
 
+struct mptcp_pm_add_entry *
+mptcp_lookup_add_list_by_id(struct mptcp_sock *msk, u8 id)
+{
+	struct mptcp_pm_add_entry *entry;
+
+	lockdep_assert_held(&msk->pm.lock);
+
+	list_for_each_entry(entry, &msk->pm.add_list, list) {
+		if (entry->addr.id == id)
+			return entry;
+	}
+
+	return NULL;
+}
+
+struct mptcp_pm_add_entry *
+mptcp_lookup_add_list_by_saddr(struct mptcp_sock *msk,
+			       struct mptcp_addr_info *addr)
+{
+	struct mptcp_pm_add_entry *entry;
+
+	lockdep_assert_held(&msk->pm.lock);
+
+	list_for_each_entry(entry, &msk->pm.add_list, list) {
+		if (addresses_equal(&entry->addr, addr, true))
+			return entry;
+	}
+
+	return NULL;
+}
+
+static bool mptcp_pm_alloc_add_list(struct mptcp_sock *msk,
+				    struct mptcp_addr_info *addr)
+{
+	struct mptcp_pm_add_entry *add_entry = NULL;
+
+	lockdep_assert_held(&msk->pm.lock);
+
+	if (mptcp_lookup_add_list_by_saddr(msk, addr))
+		return false;
+
+	add_entry = kmalloc(sizeof(*add_entry), GFP_ATOMIC);
+	if (!add_entry)
+		return false;
+
+	list_add(&add_entry->list, &msk->pm.add_list);
+	add_entry->addr = *addr;
+
+	return true;
+}
+
+void mptcp_pm_free_add_list(struct mptcp_sock *msk)
+{
+	struct mptcp_pm_add_entry *entry, *tmp;
+
+	pr_debug("msk=%p", msk);
+
+	spin_lock_bh(&msk->pm.lock);
+	list_for_each_entry_safe(entry, tmp, &msk->pm.add_list, list)
+		kfree(entry);
+	spin_unlock_bh(&msk->pm.lock);
+}
+
 static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
@@ -501,12 +569,6 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	if (lookup_subflow_by_daddr(&msk->conn_list, &msk->pm.remote))
 		goto add_addr_echo;
 
-	msk->pm.add_addr_accepted++;
-	msk->pm.subflows++;
-	if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
-	    msk->pm.subflows >= subflows_max)
-		WRITE_ONCE(msk->pm.accept_addr, false);
-
 	/* connect to the specified remote address, using whatever
 	 * local address the routing configuration will pick.
 	 */
@@ -516,6 +578,15 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	memset(&local, 0, sizeof(local));
 	local.family = remote.family;
 
+	if (!mptcp_pm_alloc_add_list(msk, &remote))
+		return;
+
+	msk->pm.add_addr_accepted++;
+	msk->pm.subflows++;
+	if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
+	    msk->pm.subflows >= subflows_max)
+		WRITE_ONCE(msk->pm.accept_addr, false);
+
 	spin_unlock_bh(&msk->pm.lock);
 	__mptcp_subflow_connect(sk, &local, &remote, 0, 0);
 	spin_lock_bh(&msk->pm.lock);
@@ -612,6 +683,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 		list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
 			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
+			struct mptcp_pm_add_entry *entry;
 			u8 id = subflow->local_id;
 
 			if (rm_type == MPTCP_MIB_RMADDR)
@@ -631,6 +703,11 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			if (rm_type == MPTCP_MIB_RMADDR) {
 				msk->pm.add_addr_accepted--;
 				WRITE_ONCE(msk->pm.accept_addr, true);
+				entry = mptcp_lookup_add_list_by_id(msk, id);
+				if (entry) {
+					list_del(&entry->list);
+					kfree(entry);
+				}
 			} else if (rm_type == MPTCP_MIB_RMSUBFLOW) {
 				msk->pm.local_addr_used--;
 			}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 35c0b1ca95c3..05ceba3972f6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2888,6 +2888,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk)
 	skb_rbtree_purge(&msk->out_of_order_queue);
 	mptcp_token_destroy(msk);
 	mptcp_pm_free_anno_list(msk);
+	mptcp_pm_free_add_list(msk);
 }
 
 static void mptcp_destroy(struct sock *sk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5ccc0d3e5693..1df8da3da695 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -185,6 +185,7 @@ struct mptcp_pm_data {
 	struct mptcp_addr_info local;
 	struct mptcp_addr_info remote;
 	struct list_head anno_list;
+	struct list_head add_list;
 
 	spinlock_t	lock;		/*protects the whole PM data */
 
@@ -693,6 +694,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 				 struct mptcp_addr_info *addr,
 				 u8 bkup);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
+void mptcp_pm_free_add_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_anno_entry *
 mptcp_pm_del_anno_timer(struct mptcp_sock *msk,
-- 
2.31.1

