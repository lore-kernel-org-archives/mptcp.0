Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BA970
	for <mptcp@lists.linux.dev>; Wed, 21 Jul 2021 14:31:49 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id 21so2380238pfp.3
        for <mptcp@lists.linux.dev>; Wed, 21 Jul 2021 07:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CUjKcFOY0DsQhRoE3lq7W5AD8U4BMebFd4LiVmNXoHU=;
        b=JTeFKA1wX+9gaTlvF/wu8jsChlTJDSbFxPBDyc5AWejBg4TleWnqisUlYtwZFkt0Ej
         K3/qu5ufABpIf0/SRvfbDaG4h9aJUqy48p/qKXxDayrqGKSLXEdPHA+Gyl/AqSJwXpwh
         3x1QCtcYSrpyMgjvTA/dEpkkzojepXjdSPa3gPRqG0ipNRSl4fWNFa2Ah3M9i4+x+Xg5
         wIuo21P8fFV3pfdb6mdExHqmzRoGcGnKxswQnXGgbV2Y0A6kW96l7xHfClK1l6omrpIl
         RqCDlTbMyu0bUT5P7VA1fjWDI/QANHEqjyhKAjONT4NadVZZtV1mMcqVejlTL9KFRT1p
         QxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CUjKcFOY0DsQhRoE3lq7W5AD8U4BMebFd4LiVmNXoHU=;
        b=CjnxA3icnzmZruAbJ3nHZmT/xTsmTA8sc1ImHXsyW3eobDG0LuC/ZhG02nYx6EDJwn
         cpsVRgQcHvMaXcdgIBvRuKjjYKsmedbJj0KvC6Y+8G0q5I2p/khnanOpMrEp7tfW+6xZ
         ebxtIrkkiFbPgUfUs5iInkLUABHaocN8/tUqq5Q/CFSFwG7xlkmTWwP1S5vxZGVFSoht
         ek9Dsmc8ZDqcYbuCM5T4Tx1DsiR4uFGo9/140FMKhlqf9PWy0d92938uqowk90iM/Ztu
         q9jdZcWE6ve7mti7tC6Pr2B+BSe7kliDAuNICdZLKP1XNsmtc6Ss81nphh3nYxKKnmnI
         j/vA==
X-Gm-Message-State: AOAM5339nII98u6vnyPB2hFvR516OlowFvK8V5NPriXO8D9ZdBg9pEPP
	ZJhA9bh5conNE7b4tihj1lw0FkortvVKhg==
X-Google-Smtp-Source: ABdhPJzCHUedDiDHd0Rs/5N/ke8GbMW8p4h70cfzSdIG9d4pGc27Odfx4VAdM9EWmmFcQASzHBYsWg==
X-Received: by 2002:a63:e211:: with SMTP id q17mr36724861pgh.363.1626877909105;
        Wed, 21 Jul 2021 07:31:49 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id i6sm21723147pfa.44.2021.07.21.07.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 07:31:48 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 05/10] mptcp: invoke mptcp_nl_remove_subflow_and_signal_addr in rcu_work
Date: Wed, 21 Jul 2021 22:31:29 +0800
Message-Id: <e9de213a59a066c6beaba2895a7c60412b654601.1626877655.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <f1175761821947749ac9724deb3009b9b2747bbd.1626877655.git.geliangtang@gmail.com>
References: <cover.1626877655.git.geliangtang@gmail.com> <b5f63eb4ad680a99fc806d2406968a6a5f272f01.1626877655.git.geliangtang@gmail.com> <0000f0168f0d8d1cd34bbe5463aed721225446e2.1626877655.git.geliangtang@gmail.com> <93ffe9fbfda6d2efdbab73373b6efbbce3a36b00.1626877655.git.geliangtang@gmail.com> <f1175761821947749ac9724deb3009b9b2747bbd.1626877655.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mptcp_nl_remove_subflow_and_signal_addr will be invoked in the atomic
context in the next patch. So we need to move it into the rcu_work to
remove the subflow and signal the RM_ADDR suboption.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/pm_netlink.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3437de74f003..533818b4dba2 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1177,6 +1177,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 
 struct addr_entry_release_work {
 	struct rcu_work	rwork;
+	struct net *net;
 	struct mptcp_pm_addr_entry *entry;
 };
 
@@ -1184,10 +1185,14 @@ static void mptcp_pm_release_addr_entry(struct work_struct *work)
 {
 	struct addr_entry_release_work *w;
 	struct mptcp_pm_addr_entry *entry;
+	struct net *net;
 
 	w = container_of(to_rcu_work(work), struct addr_entry_release_work, rwork);
+	net = w->net;
 	entry = w->entry;
 	if (entry) {
+		if (net)
+			mptcp_nl_remove_subflow_and_signal_addr(net, &entry->addr);
 		if (entry->lsk)
 			sock_release(entry->lsk);
 		kfree(entry);
@@ -1195,13 +1200,14 @@ static void mptcp_pm_release_addr_entry(struct work_struct *work)
 	kfree(w);
 }
 
-static void mptcp_pm_free_addr_entry(struct mptcp_pm_addr_entry *entry)
+static void mptcp_pm_free_addr_entry(struct net *net, struct mptcp_pm_addr_entry *entry)
 {
 	struct addr_entry_release_work *w;
 
 	w = kmalloc(sizeof(*w), GFP_ATOMIC);
 	if (w) {
 		INIT_RCU_WORK(&w->rwork, mptcp_pm_release_addr_entry);
+		w->net = net;
 		w->entry = entry;
 		queue_rcu_work(system_wq, &w->rwork);
 	}
@@ -1283,8 +1289,7 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
 	__clear_bit(entry->addr.id, pernet->id_bitmap);
 	spin_unlock_bh(&pernet->lock);
 
-	mptcp_nl_remove_subflow_and_signal_addr(sock_net(skb->sk), &entry->addr);
-	mptcp_pm_free_addr_entry(entry);
+	mptcp_pm_free_addr_entry(sock_net(skb->sk), entry);
 
 	return ret;
 }
@@ -1345,7 +1350,7 @@ static void __flush_addrs(struct list_head *list)
 		cur = list_entry(list->next,
 				 struct mptcp_pm_addr_entry, list);
 		list_del_rcu(&cur->list);
-		mptcp_pm_free_addr_entry(cur);
+		mptcp_pm_free_addr_entry(NULL, cur);
 	}
 }
 
-- 
2.31.1

