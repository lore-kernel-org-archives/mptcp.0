Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76E917BD3
	for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 08:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589051; cv=none; b=cGwMOX9hdfjH09+XhBPryDFRabG9RvDvOlwntABqhoK5g7WmeUaO2a+l48d/wSrNoF+WIilRkqp6kooiWJ37JCY7U1TvE9amkaB3TM8JLX+luzagDQ6hehjWPaf9pZ2TkobJpPlqOrv4Ym5QfP6uIy3IMkGP5uiLJ8NdbdrnA1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589051; c=relaxed/simple;
	bh=f0e6F+ivXNWcy5LLkAIgtf0gsblVOmqzNopG+jGxoZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AKSmPU2+T9buTAi/C4imYytKvqU79rAh4K14qcSyYVJ8ySMI0CfrkhRGdn4hrxMCRFs2jDOeH07k8oxY6UK1y6EESAv/QgW4Oc+RqbAoHWzAiwV3FS+Ef4nZFvnfSmNd3/Y/rx1w/LJdlaCD4rHaBLoqkBOyLS0iHnq4MK+ou3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cb4FM8fn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cb4FM8fn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584E8C433F1;
	Thu, 22 Feb 2024 08:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708589051;
	bh=f0e6F+ivXNWcy5LLkAIgtf0gsblVOmqzNopG+jGxoZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cb4FM8fnqkP3RRPBbTKL1jY+ZpQo2H6B5m/yGPBWt7Lx9psj6RzlvJt2G4ebKh0xC
	 V0Gqkczmu9CrRxRh0jeVFwftt6WyJBoNRwdxBxB2bZnMAiAHslXh4aBRaHvCgLyvRh
	 Q05v1ih/luaMfRxCZDUp7mw6gsebReIZodA86Y0ljR4rxa9wbxvmMf4Z0IWuPTlf3Y
	 ZI0EQyyVqaxsIdc183jVFNEOg3dBFn01+ST19Wl6YsSuZyHBnZwBnJrvIerkyF/l8t
	 7Ypnz9uGdETavGrnH90I0v2486+JM02e6NBkg8jJF6hy6D5hZUWJ+ASigSlpdfUr2/
	 cEQlHE5i5rXKg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 6/7] mptcp: add check_id for lookup_anno_list_by_saddr
Date: Thu, 22 Feb 2024 16:03:57 +0800
Message-Id: <608dcc5649b212dc1a37c72fa7b465d3e8619316.1708588977.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708588977.git.tanggeliang@kylinos.cn>
References: <cover.1708588977.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new helper mptcp_addresses_equal_check_id() to test the
address ids, as well as the address. This can be used to test if the two
given addresses are identically equal, they have both the same address and
the same address id.

Add a new parameter check_id for mptcp_lookup_anno_list_by_saddr(), pass
it to mptcp_addresses_equal_check_id(). Then in mptcp_pm_del_add_timer(),
the input parameter check_id can be passed as the new parameter into
mptcp_lookup_anno_list_by_saddr(). After this, this condition:

        (!check_id || entry->addr.id == addr->id)

can be dropped, only test if 'entry' is NULL is enough.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c         |  2 +-
 net/mptcp/pm_netlink.c | 13 +++++++------
 net/mptcp/protocol.h   | 10 +++++++++-
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 55406720c607..2f5ccafe7e34 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -257,7 +257,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 
 	spin_lock_bh(&pm->lock);
 
-	if (mptcp_lookup_anno_list_by_saddr(msk, addr) && READ_ONCE(pm->work_pending))
+	if (mptcp_lookup_anno_list_by_saddr(msk, addr, false) && READ_ONCE(pm->work_pending))
 		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
 
 	spin_unlock_bh(&pm->lock);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 5c17d39146ea..7d755c0a32bb 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -237,14 +237,15 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr)
+				const struct mptcp_addr_info *addr,
+				bool check_id)
 {
 	struct mptcp_pm_add_entry *entry;
 
 	lockdep_assert_held(&msk->pm.lock);
 
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, addr, true))
+		if (mptcp_addresses_equal_check_id(&entry->addr, addr, true, check_id))
 			return entry;
 	}
 
@@ -324,12 +325,12 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	struct sock *sk = (struct sock *)msk;
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
-	if (entry && (!check_id || entry->addr.id == addr->id))
+	entry = mptcp_lookup_anno_list_by_saddr(msk, addr, check_id);
+	if (entry)
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
 	spin_unlock_bh(&msk->pm.lock);
 
-	if (entry && (!check_id || entry->addr.id == addr->id))
+	if (entry)
 		sk_stop_timer_sync(sk, &entry->add_timer);
 
 	return entry;
@@ -344,7 +345,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
+	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr, false);
 
 	if (add_entry) {
 		if (mptcp_pm_is_kernel(msk))
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7905783c95e4..130d4c55e10a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -673,6 +673,13 @@ bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 			   const struct mptcp_addr_info *b, bool use_port);
 void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr);
 
+static inline bool mptcp_addresses_equal_check_id(const struct mptcp_addr_info *a,
+						  const struct mptcp_addr_info *b,
+						  bool use_port, bool check_id)
+{
+	return mptcp_addresses_equal(a, b, use_port) ? a->id == b->id : false;
+}
+
 /* called with sk socket lock held */
 int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 			    const struct mptcp_addr_info *remote);
@@ -966,7 +973,8 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id);
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr);
+				const struct mptcp_addr_info *addr,
+				bool check_id);
 int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 					 unsigned int id,
 					 u8 *flags, int *ifindex);
-- 
2.40.1

