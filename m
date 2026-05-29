Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43742E7397
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 03:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780024936; cv=none; b=lG2x67i/oOgnwPljVBrAk5+wGshnyt1I8JSQ5dXv4pioS1ePWdjJG7ksJHxoYWTcpuNxnrRpLfi0R0HVrt5nho5Mdr2Q/gipGIjPw9p6UsqmuzTeIxJQkvn8IleLLfgt3URetInOhA99d3DH6qTHbOtQiLOXNlHCVG2iTVAYsUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780024936; c=relaxed/simple;
	bh=68FxwL4sYU3QKtoem93zSbxBS5PaCwBlE1GZuWL0q48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m+0T5wEqWIneOcYvPyclDpZmac4VZ6jXvFZpAIx9n9RVxV9QwSjtE0zKNNNlZGddk5sbxKQVkDGtpLgE8gGHM81E6JlSap0v2TyE6xoaaedMVX2YIU3hE8v/C9zplddCOI6K9f3sHKms9IQ2IRywoLLOVWMkSegtMJyW0LRDi5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E21cA5k7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E21cA5k7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D84E1F00A3C;
	Fri, 29 May 2026 03:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780024934;
	bh=DpGFWX5sH5x3NiULMC+ThpJbHAA0MwLxWaqsfDFrSY0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=E21cA5k7A6ZznaC4q78IGpgQowgSFclIECIdRugvbb7EsXYrCqK3R8WTf+8yM6TRq
	 kf8m6bvYZv9MuOdok8ULirKI2nXCVBuWNk3IL7bAHByQ0LOsWhN4hFNchoyfqZhkxI
	 CXxU4YXaxLAN24ZAlbfHpRkUah4VkLryR6gmtUy5B0/wEbWZmaW0eaMEFaqYIoPtsg
	 cyCzyLzzebhhAJEaaW2y3Gp1kjhscvXcYUH4uqekkFv3aAK1OJAhKLsW2/uV02VX50
	 4rKuhbCT3r4qQLTkSshVt0oMO5ayYFI06iM/NPgK6y1L8ECcj6y9o6661rhjo67DPA
	 vVfUMUrXtzLyQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 29 May 2026 13:21:49 +1000
Subject: [PATCH mptcp-next v4 11/15] mptcp: pm: rename add_entry structure
 to add_addr
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-mptcp-add-addr6-port-ts-v4-11-cea393fa33a2@kernel.org>
References: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
In-Reply-To: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3971; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=68FxwL4sYU3QKtoem93zSbxBS5PaCwBlE1GZuWL0q48=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqGQZWGjzebOrNJi1pc3GdBRZzuOEDF0zqutdJA
 zDCssZgybOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahkGVgAKCRD2t4JPQmmg
 c8WmD/9wFOyDNsji0YzkYMunYgVtUqbZ3eRgSk0d6Ou1/ycKMLq2kMcQvy/EojdKYh6QunaRU6y
 UWRxVMWuyzs5hVqpxu6KBEurIRr/CFsiAq5OD3Lku5t/cDylx523ixN6bgmSAdFyIQoMBQD0n/m
 mBBB95h3qdr5CASTA4SjR6qGuioJ5bk3NfoiI7QEcmCA9GTAipG1idv1NB4jhjKaUk6Qk+VdVzc
 vAsYwQbaEj0mLWCxdgzfmVosJGI6z2X7qn/5bT7Z+wKv58fPt2wpuZjasVXHc6+MV/CnugC1FiF
 xOKys7kPvMAs7/hkEaQlBXJo8PI4wkK8xD0hK4NKHd+EFXMIt8IKC+leG6ca8BWvzhXbZ1QHSuq
 PN4w5Ths5ptalS9BcQM7m3+VFU6TxOVwh6A79YsV6SbthicsY/ioy8MICPmWUUHXmB4AnNBLFCn
 NkW71BbWhU5ujIxS5r/jG86RZLF75gLJW4oz2W73U/QUF+ichNiUjBtJ4t3h4YyfXkt1FKG08p7
 xw4/mqo0BHD30+iAiT2HxovsC4x7yZ6nLrmihVJLvphBcTvnZkzJFoUPLzzRchJZq7DaMpK54QJ
 dr2uaSjKTtIlCW0kIh/iwW5eHC2AdHoP6R7NnDZU+wueVIqcI6rN3EIjYSfQApyGbzE4VrpXpvy
 50I/n58yYZ7fN0A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Using only the 'add' prefix is confusing: does it refer to a generic
added entry or address, or specifically to ADD_ADDRs. Using add_addr
removes this confusion.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c       | 22 +++++++++++-----------
 net/mptcp/protocol.h |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 08d06090a0a0..3d930298d9d8 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -12,7 +12,7 @@
 
 #define ADD_ADDR_RETRANS_MAX	3
 
-struct mptcp_pm_add_entry {
+struct mptcp_pm_add_addr {
 	struct list_head	list;
 	struct mptcp_addr_info	addr;
 	u8			retrans_times;
@@ -133,11 +133,11 @@ bool mptcp_pm_has_subflow_saddr(const struct mptcp_sock *msk,
 	return false;
 }
 
-static struct mptcp_pm_add_entry *
+static struct mptcp_pm_add_addr *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_add_addr *entry;
 
 	lockdep_assert_held(&msk->pm.lock);
 
@@ -152,7 +152,7 @@ mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				     const struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_add_addr *entry;
 	bool ret;
 
 	entry = mptcp_pm_del_add_timer(msk, addr, false);
@@ -164,7 +164,7 @@ bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
 
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_add_addr *entry;
 	struct mptcp_addr_info saddr;
 	bool ret = false;
 
@@ -340,8 +340,8 @@ static unsigned int mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk)
 
 static void mptcp_pm_add_timer(struct timer_list *timer)
 {
-	struct mptcp_pm_add_entry *entry = timer_container_of(entry, timer,
-							      add_timer);
+	struct mptcp_pm_add_addr *entry = timer_container_of(entry, timer,
+							     add_timer);
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
 	unsigned int timeout = 0;
@@ -397,12 +397,12 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	sock_put(sk);
 }
 
-struct mptcp_pm_add_entry *
+struct mptcp_pm_add_addr *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id)
 {
 	struct sock *sk = (struct sock *)msk;
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_add_addr *entry;
 	struct timer_list *timer = NULL;
 
 	rcu_read_lock();
@@ -434,7 +434,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *add_entry = NULL;
+	struct mptcp_pm_add_addr *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
 	unsigned int timeout;
 
@@ -471,7 +471,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 static void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 {
-	struct mptcp_pm_add_entry *entry, *tmp;
+	struct mptcp_pm_add_addr *entry, *tmp;
 	struct sock *sk = (struct sock *)msk;
 	LIST_HEAD(free_list);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1d9834252515..52af825c3f8e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1136,7 +1136,7 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
-struct mptcp_pm_add_entry *
+struct mptcp_pm_add_addr *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id);
 bool mptcp_pm_has_subflow_saddr(const struct mptcp_sock *msk,

-- 
2.53.0

