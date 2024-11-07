Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB53918FDBC
	for <mptcp@lists.linux.dev>; Thu,  7 Nov 2024 06:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730961964; cv=none; b=Fi1Z9qluvaW9mCQ+YVeJvyOINDnY5/utG5N8KrajxJXchMpogjUt4EOakbQe/N2BaOCALKgZDXTc0c+NuaXyyPNRTujrwHlnbF94mXR0schPCEXYUGOO7L1MDLFhX3NAinsvhzj10m3I2Hy3rT9be2QcN2cif20joJgfX+cEZBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730961964; c=relaxed/simple;
	bh=5o/RexNH5o9ejy7sjm73FIti2A508JVxELeTk+Z/j54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UvcAEkcR0vvxU2trItib3XcXr1Q1Lg/d3bQbUNkJ/0P9N5PatBEuCYtFXibmEvUAo/PaxdRpoLETaP/ze7fcJ+vDu7mGIacKbyV7LNNsl5b5pvYFzPQ12RrDcVhR6ZmLdtnJhbSXQ90EeNsNCvUklGoPVIXlAj+4F+goG2MxBX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcnRxZql; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcnRxZql"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52815C4CECD;
	Thu,  7 Nov 2024 06:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730961963;
	bh=5o/RexNH5o9ejy7sjm73FIti2A508JVxELeTk+Z/j54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WcnRxZqlc5U6bKu6kmJErUHaGsu8E1yGFNkERIj9zo39v+Ll0O/xNv1x4k4QYvvji
	 CK8cWe2sK0S6BBpf/N/bowiEa23/IqkwraozkkmZY3LJCG9TBM47RmWb5kkTsFbTmt
	 mFgPIaZvFPKYkLX64f8utAIE9wsLzklpkl4/qZoP0IRxheHV8opv4jvUFhJltYplCm
	 QAjqSMdJ0QqH4/1iHbJ40y7agW9iaWdAn5nT/9Cda/epzUwzDd7aaP1StGKfCdgQmJ
	 EJIERqy2VBxD3Rs90j692xeXohN3ZpFKhbrN9kDeWtJ9idbnFlokEbMCAqf7NiuBcy
	 ggRSlq2c+9QfA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 7/9] mptcp: drop struct mptcp_pm_add_entry
Date: Thu,  7 Nov 2024 14:45:41 +0800
Message-ID: <b881437711fb806cbe9aa7a0b2e36b5bb3cc1c84.1730961810.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1730961809.git.tanggeliang@kylinos.cn>
References: <cover.1730961809.git.tanggeliang@kylinos.cn>
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

Although this increases the size of the structure even more, but that's OK
to do so because it is not used in an array.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c | 26 +++++++++-----------------
 net/mptcp/protocol.h   | 20 +++++++++++++++-----
 2 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 00911fae5d88..3f3eaa18ffae 100644
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
@@ -257,11 +249,11 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
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
 
@@ -275,7 +267,7 @@ mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_addr_info saddr;
 	bool ret = false;
 
@@ -296,7 +288,7 @@ bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
 
 static void mptcp_pm_add_timer(struct timer_list *timer)
 {
-	struct mptcp_pm_add_entry *entry = from_timer(entry, timer, add_timer);
+	struct mptcp_pm_addr_entry *entry = from_timer(entry, timer, add_timer);
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
 
@@ -338,11 +330,11 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
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
 
@@ -366,7 +358,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *add_entry = NULL;
+	struct mptcp_pm_addr_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct net *net = sock_net(sk);
 
@@ -402,7 +394,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 {
-	struct mptcp_pm_add_entry *entry, *tmp;
+	struct mptcp_pm_addr_entry *entry, *tmp;
 	struct sock *sk = (struct sock *)msk;
 	LIST_HEAD(free_list);
 
@@ -1474,7 +1466,7 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				     const struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_addr_entry *entry;
 
 	entry = mptcp_pm_del_add_timer(msk, addr, false);
 	if (entry) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 775ac2fd6854..1414e79564c7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -239,9 +239,19 @@ struct mptcp_pm_data {
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
@@ -1019,10 +1029,10 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
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
 bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
-- 
2.45.2

