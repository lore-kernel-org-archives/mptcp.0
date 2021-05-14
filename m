Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C091C71
	for <mptcp@lists.linux.dev>; Fri, 14 May 2021 14:32:30 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id b21so16285055plz.0
        for <mptcp@lists.linux.dev>; Fri, 14 May 2021 07:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kb4lQO/B4ZAxVnczchP2wus1g/xQmtlfox0+hykADG0=;
        b=s9/rMF6oEYJyrcvPmwC59gQ8X2Y7gdxgqJ18HxGlEN/niLd+FJzwhOhfgQwGZGMTtM
         iQfYilQU1zU3ULc3nQDpml0IahYCB/36jVK3Sx1EhAIktpjvs+QREJlc8XqBkMzfH6Rx
         LDURB0EXe3ZyhLI6Wwa/Gf1SbPwWCmAxCWcbs4DbkUb+l0R/W7tpK3DXQmEOC7VLPEel
         DOAsWPKkQctAtf3Lrfogb+75/mw4cV8EphS6kkDBCEr6YDTopMySmam5xJ9NOkVA1x6w
         pK9AogvnNkaHFndns3Fy7oM1XH7/ehBTBFw1DmhLUdvTOXFCQMxj5rwiIhpwVXA/NEpr
         ds3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kb4lQO/B4ZAxVnczchP2wus1g/xQmtlfox0+hykADG0=;
        b=EULSQtr+zuRcnm/jA2YZQ2MVrfmG7JuapJqkSwSmaNI2qVSrdg2F48jInbwC5ei5L9
         ILnsqWdVzIqf5J6NHm6n+guApstMAVSQVYSU8TH4OnIxdzh2+8vMJoYJdxK/6dPBbIW+
         6loFvH4qmL/7399H6vZj6KfImWOzKRiL3tbDyivWi/JOO/kGqg/MAzACRi+/usl6TQN9
         Ei9XHOVUIxwYa0cRquvf+/rZHFVTVsH35KwKXNacsu8hI5yWf8wR3AvolACc7XZ0zsYF
         nKS/kHTE+8yEnaF6hdBE0lzGWuo23xc4a46Gfx55OiaxWJ9ZvnpyHdUImnO+rt1KQZAu
         uRBQ==
X-Gm-Message-State: AOAM531PRokgQhd8L5SLthnH5d2HGMBmvkGcWCYWSo23ZEnA4XWbh3uI
	YQtBMkyurFUdWB3i8otwLopEzoD83BE=
X-Google-Smtp-Source: ABdhPJxhDSdN2qC3r5pwtkjYyFFIzBr2JAfDnRWixjP4LFZ3GwpU0G9o8b/IiNT6yg/4V6/5oXatFg==
X-Received: by 2002:a17:90a:1d44:: with SMTP id u4mr11536646pju.46.1621002750305;
        Fri, 14 May 2021 07:32:30 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id d9sm9350876pjx.41.2021.05.14.07.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 07:32:30 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v6 mptcp-next 3/6] mptcp: rename mptcp_pm_add_entry to mptcp_pm_anno_entry
Date: Fri, 14 May 2021 22:32:16 +0800
Message-Id: <ae0d32922128771f09b230e5718774472a088207.1621002341.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <2a6a925510a7d79f0c2101d5d353f6b74f0e69bb.1621002341.git.geliangtang@gmail.com>
References: <cover.1621002341.git.geliangtang@gmail.com> <d051657e9c51ccb27b32d443777896c6ae519444.1621002341.git.geliangtang@gmail.com> <2a6a925510a7d79f0c2101d5d353f6b74f0e69bb.1621002341.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch renamed struct mptcp_pm_add_entry to mptcp_pm_anno_entry, since
these entries will be added to the anno_list of PM.

Also rename the struct member add_timer to anno_timer.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c    |  2 +-
 net/mptcp/pm_netlink.c | 50 +++++++++++++++++++++---------------------
 net/mptcp/protocol.h   |  8 +++----
 3 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index ab9e39d2e645..82fc481a25f0 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1063,7 +1063,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
 		} else {
 			mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
-			mptcp_pm_del_add_timer(msk, &mp_opt.addr);
+			mptcp_pm_del_anno_timer(msk, &mp_opt.addr);
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
 		}
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d094588afad8..4fff8aef45e4 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -31,10 +31,10 @@ struct mptcp_pm_addr_entry {
 	struct socket		*lsk;
 };
 
-struct mptcp_pm_add_entry {
+struct mptcp_pm_anno_entry {
 	struct list_head	list;
 	struct mptcp_addr_info	addr;
-	struct timer_list	add_timer;
+	struct timer_list	anno_timer;
 	struct mptcp_sock	*sock;
 	u8			retrans_times;
 };
@@ -263,11 +263,11 @@ static void check_work_pending(struct mptcp_sock *msk)
 		WRITE_ONCE(msk->pm.work_pending, false);
 }
 
-struct mptcp_pm_add_entry *
+struct mptcp_pm_anno_entry *
 mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
 				struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_anno_entry *entry;
 
 	lockdep_assert_held(&msk->pm.lock);
 
@@ -281,7 +281,7 @@ mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
 
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_anno_entry *entry;
 	struct mptcp_addr_info saddr;
 	bool ret = false;
 
@@ -300,9 +300,9 @@ bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
 	return ret;
 }
 
-static void mptcp_pm_add_timer(struct timer_list *timer)
+static void mptcp_pm_anno_timer(struct timer_list *timer)
 {
-	struct mptcp_pm_add_entry *entry = from_timer(entry, timer, add_timer);
+	struct mptcp_pm_anno_entry *entry = from_timer(entry, timer, anno_timer);
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
 
@@ -344,11 +344,11 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	__sock_put(sk);
 }
 
-struct mptcp_pm_add_entry *
-mptcp_pm_del_add_timer(struct mptcp_sock *msk,
-		       struct mptcp_addr_info *addr)
+struct mptcp_pm_anno_entry *
+mptcp_pm_del_anno_timer(struct mptcp_sock *msk,
+		        struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_anno_entry *entry;
 	struct sock *sk = (struct sock *)msk;
 
 	spin_lock_bh(&msk->pm.lock);
@@ -358,7 +358,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	spin_unlock_bh(&msk->pm.lock);
 
 	if (entry)
-		sk_stop_timer_sync(sk, &entry->add_timer);
+		sk_stop_timer_sync(sk, &entry->anno_timer);
 
 	return entry;
 }
@@ -366,7 +366,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 				     struct mptcp_pm_addr_entry *entry)
 {
-	struct mptcp_pm_add_entry *add_entry = NULL;
+	struct mptcp_pm_anno_entry *anno_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct net *net = sock_net(sk);
 
@@ -375,18 +375,18 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	if (mptcp_lookup_anno_list_by_saddr(msk, &entry->addr))
 		return false;
 
-	add_entry = kmalloc(sizeof(*add_entry), GFP_ATOMIC);
-	if (!add_entry)
+	anno_entry = kmalloc(sizeof(*anno_entry), GFP_ATOMIC);
+	if (!anno_entry)
 		return false;
 
-	list_add(&add_entry->list, &msk->pm.anno_list);
+	list_add(&anno_entry->list, &msk->pm.anno_list);
 
-	add_entry->addr = entry->addr;
-	add_entry->sock = msk;
-	add_entry->retrans_times = 0;
+	anno_entry->addr = entry->addr;
+	anno_entry->sock = msk;
+	anno_entry->retrans_times = 0;
 
-	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
-	sk_reset_timer(sk, &add_entry->add_timer,
+	timer_setup(&anno_entry->anno_timer, mptcp_pm_anno_timer, 0);
+	sk_reset_timer(sk, &anno_entry->anno_timer,
 		       jiffies + mptcp_get_add_addr_timeout(net));
 
 	return true;
@@ -394,7 +394,7 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 {
-	struct mptcp_pm_add_entry *entry, *tmp;
+	struct mptcp_pm_anno_entry *entry, *tmp;
 	struct sock *sk = (struct sock *)msk;
 	LIST_HEAD(free_list);
 
@@ -405,7 +405,7 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 
 	list_for_each_entry_safe(entry, tmp, &free_list, list) {
-		sk_stop_timer_sync(sk, &entry->add_timer);
+		sk_stop_timer_sync(sk, &entry->anno_timer);
 		kfree(entry);
 	}
 }
@@ -1068,9 +1068,9 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
 static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				      struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_anno_entry *entry;
 
-	entry = mptcp_pm_del_add_timer(msk, addr);
+	entry = mptcp_pm_del_anno_timer(msk, addr);
 	if (entry) {
 		list_del(&entry->list);
 		kfree(entry);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index fd7ff2d28cb3..5ccc0d3e5693 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -694,10 +694,10 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 				 u8 bkup);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
-struct mptcp_pm_add_entry *
-mptcp_pm_del_add_timer(struct mptcp_sock *msk,
-		       struct mptcp_addr_info *addr);
-struct mptcp_pm_add_entry *
+struct mptcp_pm_anno_entry *
+mptcp_pm_del_anno_timer(struct mptcp_sock *msk,
+		        struct mptcp_addr_info *addr);
+struct mptcp_pm_anno_entry *
 mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
 				struct mptcp_addr_info *addr);
 
-- 
2.31.1

