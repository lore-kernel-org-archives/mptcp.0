Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D6E8120D
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588531; cv=none; b=na1QM5eizxexDtmU1nKx028UjS30Si0A+PHKqiK7nrX4Ek+bNhkSFeSl7EHaVvtny4wANEHAp5f/wZq0/jgCzRVJrkdpf91PxKsnRm/5kSwOGm0JFbih7W7Xy9XH4u63BIjbK1rL7RONvRMMOjdGWk3k1HQlH7CnfgryvOBzAmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588531; c=relaxed/simple;
	bh=mUOeBJcUstaFnHejt/0tNXcp3+fLs/PVFjt9u8ahYKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ehvmhk/c79FbM1KBJp57zQl3qWzVRgLNnzh/NlWsnTp8AFojiJ0Siw1NWSF8oUVOXP/bmpKKaR3VaMMlyB8f1j80Q/PXim06gMXqiMm5XsSHDUsY3z1vcyrrybxNW4/CCPnwzx0V6ztpi65nDokDopEsQvw21qlxK7ZFoUFRPWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfVdrILS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfVdrILS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DF3C4CEC3;
	Tue, 22 Oct 2024 09:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588531;
	bh=mUOeBJcUstaFnHejt/0tNXcp3+fLs/PVFjt9u8ahYKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TfVdrILSoNSFiTTEjmSJtpP482U/Gu7yeap33ARgnn01ni22YGmoL31CLx2rtZ8KS
	 AQs8nVwkVRLbTHNUGt4c4mZceK9oDd75hRa6v1Qv55At6g/GKlJrI0g3bib+tkxyAm
	 AErAzzlg0YLz8K2FVSsIm1UTVd1XBvJiM/A84aEKPawyXp4JpIFSMZBFR6mZbL4mAr
	 fIrqcH8O1pgQRZ7RmQPZ5pevT0+RNWN8fE65JrmUB8lHMk8gOpin2k+DW1lnleDXKN
	 a2OdeYCQdleWhTHz4o3j916X/cxIFRfJp4KZNGEJeUlNwBcnJWvIJ9RkXrWMsRlJif
	 FHq+6+dJhkGJQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 24/36] mptcp: drop struct mptcp_pm_add_entry
Date: Tue, 22 Oct 2024 17:14:32 +0800
Message-ID: <c1a57a18940b94c6db9ce423fe3d84e050397589.1729588019.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729588019.git.tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

There is no need to add a dedicated address entry type "mptcp_pm_add_entry"
to represent ADD_ADDR addresses. Additional fields for ADD_ADDR addresses
can be added into struct mptcp_pm_addr_entry directly. This makes the path
manager code simpler.

Here "union" can be used to merge struct mptcp_pm_addr_entry and struct
mptcp_pm_add_entry into one. Then all mptcp_pm_add_entry can be replaced by
mptcp_pm_addr_entry.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c | 26 +++++++++-----------------
 net/mptcp/protocol.h   | 20 +++++++++++++++-----
 2 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 15f97e7af182..06f0c7df575e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -18,14 +18,6 @@
 
 static int pm_nl_pernet_id;
 
-struct mptcp_pm_add_entry {
-	struct list_head	list;
-	struct mptcp_addr_info	addr;
-	u8			retrans_times;
-	struct timer_list	add_timer;
-	struct mptcp_sock	*sock;
-};
-
 struct pm_nl_pernet {
 	/* protects pernet updates */
 	spinlock_t		lock;
@@ -247,11 +239,11 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 	return true;
 }
 
-struct mptcp_pm_add_entry *
+struct mptcp_pm_addr_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_addr_entry *entry;
 
 	lockdep_assert_held(&msk->pm.lock);
 
@@ -265,7 +257,7 @@ mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_addr_info saddr;
 	bool ret = false;
 
@@ -286,7 +278,7 @@ bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
 
 static void mptcp_pm_add_timer(struct timer_list *timer)
 {
-	struct mptcp_pm_add_entry *entry = from_timer(entry, timer, add_timer);
+	struct mptcp_pm_addr_entry *entry = from_timer(entry, timer, add_timer);
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
 
@@ -328,11 +320,11 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	__sock_put(sk);
 }
 
-struct mptcp_pm_add_entry *
+struct mptcp_pm_addr_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_addr_entry *entry;
 	struct sock *sk = (struct sock *)msk;
 	struct timer_list *add_timer = NULL;
 
@@ -356,7 +348,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *add_entry = NULL;
+	struct mptcp_pm_addr_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct net *net = sock_net(sk);
 
@@ -392,7 +384,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 {
-	struct mptcp_pm_add_entry *entry, *tmp;
+	struct mptcp_pm_addr_entry *entry, *tmp;
 	struct sock *sk = (struct sock *)msk;
 	LIST_HEAD(free_list);
 
@@ -1439,7 +1431,7 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				      const struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_addr_entry *entry;
 
 	entry = mptcp_pm_del_add_timer(msk, addr, false);
 	if (entry) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d9badf270b15..9dc01140af23 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -243,9 +243,19 @@ struct mptcp_pm_data {
 struct mptcp_pm_addr_entry {
 	struct list_head	list;
 	struct mptcp_addr_info	addr;
-	u8			flags;
-	int			ifindex;
-	struct socket		*lsk;
+	union {
+		struct {
+			u8			flags;
+			int			ifindex;
+			struct socket		*lsk;
+		};
+		/* mptcp_pm_add_entry */
+		struct {
+			u8			retrans_times;
+			struct timer_list	add_timer;
+			struct mptcp_sock	*sock;
+		};
+	};
 };
 
 struct mptcp_data_frag {
@@ -1028,10 +1038,10 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
-struct mptcp_pm_add_entry *
+struct mptcp_pm_addr_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id);
-struct mptcp_pm_add_entry *
+struct mptcp_pm_addr_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
 int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *loc,
-- 
2.45.2

