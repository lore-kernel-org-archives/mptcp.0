Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508F972
	for <mptcp@lists.linux.dev>; Sat,  8 May 2021 10:34:11 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id b15so9700270pfl.4
        for <mptcp@lists.linux.dev>; Sat, 08 May 2021 03:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mhHaIGRJdPxaVMDtrNeOx7rD0qNlWbp67hON/dK5j9g=;
        b=AUdMn9cXRozDg2qJDP9+rwW7+64/U4J0CeRYMwimQWKaJCzoL3FNOsoffzp8TuDowf
         X1s/oeLcMQ++ETYqoQV24A6y79uJU1fuSkmNdqS9O5pxrAbU7XAn9nvHBfj4ZMBCG/HM
         HvFGZLEE9h3b4cI3ts9N6NUGubuyWAdBRfQI1i9TB5I8CRjRPaRwjpgx5chydTu6e6tA
         CsmSkuOa72NX9IttePjIOb+W2kudxLWMAQRyygRYXoE7V+gxq5ga8G9LlxCQF6axDlKe
         vo+6aA7QenUwTCsGca+zF7i7edqwcnkbvHHS3gXQkJEg1mTPQMFFUOVFNdLZD5awiXCe
         t73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mhHaIGRJdPxaVMDtrNeOx7rD0qNlWbp67hON/dK5j9g=;
        b=He6np/zUjXicU/pnSC8K8gYImMMTlcKYLv4JdsGSqQOVXGb/LqCCt/zowot4lS5Acw
         W1TWjWiiqjQSkoOBs7sR1XytTzSJIwlPPtatn6BHVQ1q095sUC5uJatddGhfO8+Y7hgX
         4wZ/oFLLadg3njW+hh9WWOYifYm37UAUi/W0oDEde8k6MGM2zLy+CaWwXC4PatpONZ82
         8CsxcYJ7OBMPOvW9WnF1WO1wArdKQ/TbFNmpvg8F/OvZ28qZrEQHsveJIqcHJpmdEwxb
         4eWXcjwyRYStH1cdAXO6VQUkP1h20nFuFI7+derBl5W1xb9ot5En4VfvUfWrw1yCdJii
         aveA==
X-Gm-Message-State: AOAM532PpypOpLpDS1iC8Z28rlU8yAdptMGPDWFR9SDV+1gj9YyNs0Rx
	wbuVLg7Kl6CA9WIAL1J8GCe4nvFWS/o=
X-Google-Smtp-Source: ABdhPJxatUX42vWl5P+dSoaanIsq93T/WWoIoPzGBnhthxVU/i+bnsAy+yT6XQ157uMj/RvVvUta6Q==
X-Received: by 2002:aa7:908c:0:b029:209:aacd:d8b with SMTP id i12-20020aa7908c0000b0290209aacd0d8bmr15373638pfa.74.1620470050730;
        Sat, 08 May 2021 03:34:10 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id l35sm6461799pgm.10.2021.05.08.03.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 03:34:10 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v5 mptcp-next 3/5] mptcp: add add_list in mptcp_pm_data
Date: Sat,  8 May 2021 18:33:26 +0800
Message-Id: <b2a2ef7d225e72395055f34445968d25939b6b0f.1620469774.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <04612972cea357bc84aa01e145ac689a8397f466.1620469774.git.geliangtang@gmail.com>
References: <cover.1620469774.git.geliangtang@gmail.com> <0edd6a3ad45c1f67a350356298ed4333fc42dac3.1620469774.git.geliangtang@gmail.com> <04612972cea357bc84aa01e145ac689a8397f466.1620469774.git.geliangtang@gmail.com>
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
 net/mptcp/pm_netlink.c | 74 ++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c   |  1 +
 net/mptcp/protocol.h   |  2 ++
 4 files changed, 78 insertions(+)

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
index d094588afad8..47a515af2b0a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -483,6 +483,72 @@ static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
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
+	LIST_HEAD(free_list);
+
+	pr_debug("msk=%p", msk);
+
+	spin_lock_bh(&msk->pm.lock);
+	list_splice_init(&msk->pm.add_list, &free_list);
+	spin_unlock_bh(&msk->pm.lock);
+
+	list_for_each_entry_safe(entry, tmp, &free_list, list)
+		kfree(entry);
+}
+
 static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
@@ -513,6 +579,8 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	remote = msk->pm.remote;
 	if (!remote.port)
 		remote.port = sk->sk_dport;
+	if (!mptcp_pm_alloc_add_list(msk, &remote))
+		return;
 	memset(&local, 0, sizeof(local));
 	local.family = remote.family;
 
@@ -612,6 +680,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 		list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
 			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
+			struct mptcp_pm_add_entry *entry;
 			u8 id = subflow->local_id;
 
 			if (rm_type == MPTCP_MIB_RMADDR)
@@ -631,6 +700,11 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
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
index 652e55a0c6e8..446076388637 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2882,6 +2882,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk)
 	skb_rbtree_purge(&msk->out_of_order_queue);
 	mptcp_token_destroy(msk);
 	mptcp_pm_free_anno_list(msk);
+	mptcp_pm_free_add_list(msk);
 }
 
 static void mptcp_destroy(struct sock *sk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index fd7ff2d28cb3..d19deee01896 100644
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
 struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
-- 
2.31.1

