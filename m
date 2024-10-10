Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686CC178372
	for <mptcp@lists.linux.dev>; Thu, 10 Oct 2024 05:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728539314; cv=none; b=mnLajDYdVs9UsjtavXB2birZiVxIt1KVe6c01Lbstm4TxERy7rAFHSTP5kGAxTWKUi392c8EBsnBwOrJjrtBS3ztfGFU+hMMPTsadk0AXt6YfGTJdrDN9P7brQplLBezZmuZGvX3K2z3eCj1AYZ8VrZ6SugY1FFv/OATVvyscwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728539314; c=relaxed/simple;
	bh=nGXPYD9JAuT50yyFZ38LOYzMJS0R297pVdOZ5QLH+0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPErrMhjQon0g7KGZAZOUAVohMv+0SYNj2KspSZiG2+X0q5pV5d3Wuy3Y936NiFaqV1W5q59Urz+PbG+wxSlCDvXp0oNtVVGYB4z9aqfHQSQPuqN34bY9dDjNcuIsnuyV3uyLQlYB9uw80uIA8HyxUeSu5dN+CcOFuw90JNwmNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4d5WimT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4d5WimT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4C8C4CEC6;
	Thu, 10 Oct 2024 05:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728539314;
	bh=nGXPYD9JAuT50yyFZ38LOYzMJS0R297pVdOZ5QLH+0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k4d5WimTdVPyQpz3uqXMC963a4I2Uof2FIe6cLuosFM2RzqxFNT8JU17hda7PCoz/
	 NaURqNLzh34gVFZ/OYFL6ZNCrva1A4VgXicqOvIcto8KYJ65uP6SuUKAKMEsG3gS50
	 vc5hP2mq+X4DtbSU/Z7m5LWt7eOAuiY2ZodltflnVl7kEyKCXEqeBfNIq9M8TMyQVJ
	 kSQ6KHo05VizUa23uTMIwu7iYkQwSIbmzQM/7ZMCU4bLErFDMT3N6zi0ZYtvpuCd0u
	 lV7ZM1+3vw0STap2tvSvlmfnng90rDdmMKi7Carmx1s6lEArJdUfD3FYbhQrKOZM2s
	 3wqi2jToohzaA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 15/15] mptcp: drop struct mptcp_pm_add_entry
Date: Thu, 10 Oct 2024 13:48:00 +0800
Message-ID: <4c6c8196fe0c36ae3ce4fc8b8b28d0e37f581ea3.1728538976.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728538975.git.tanggeliang@kylinos.cn>
References: <cover.1728538975.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

There is no need to add a dedicated address entry type "mptcp_pm_add_entry"
to represent ADD_ADDR addresses. Additional fileds for ADD_ADDR addresses
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
index 03f3b02d4542..83f2d9638bbc 100644
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
index c4842fe5d3ff..a3c59eee6db4 100644
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
@@ -1021,10 +1031,10 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
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
2.43.0

