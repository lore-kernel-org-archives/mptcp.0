Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2EE3C1D
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 06:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708497090; cv=none; b=hCz9mb0QchQLJWMBRtMA0DhZTxk3rBCjzjlhIO77yQICh9MwkuREjWQH4ctpCC6W/R2rfEejGKTK+i+H8FvS4UpEC7H+Lco/kRJHcopUD+myu34uRCaIM1jMdQxtpNVsyFv5EBUP7bH3K8rhi0pd6LlvwSH4H65bsJHc094JcnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708497090; c=relaxed/simple;
	bh=2nnh2AFA49JVBD47uIUChTD6udxQy4S2ueKqazNay44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VbvLGNqoiiu1oqSB09Zdma8Xhvfv6cERZ30Ksx8VN+GKTSXWZmYdTs2fZzW17RmAjFdM0S+iMI/4ZBYG5TC7lVqeNkYmc/KMkmOZGpEtOmUAOH064/+kPhBR6qrwR5np62lO65MV97v9TKwGsIeWvq2jrgLm2+BR84jt+0eGOo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iC3Zbof3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iC3Zbof3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDD1C433C7;
	Wed, 21 Feb 2024 06:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708497090;
	bh=2nnh2AFA49JVBD47uIUChTD6udxQy4S2ueKqazNay44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iC3Zbof3gFFFn8EPHHyNo/kGCsyMs0q10Hu36xiTpFcrvvcpBZDtgOjYBQTgI9VuM
	 KRs72/wjl52ZEfVuKXoeaqDxFbshysfrvv8WKPfBtaiXV4Z1j/5IWbcdQfhgFIbIQx
	 q7iHRWEpZrAtilxoU7bYV2s0gsD/LGS0YQMrut3hK6RDy1xYkwynIotd37pvfdBbLR
	 Of2NWW6o7IVW1+MrUKXU6mKTgcNpKMiCewd2m+SGdl0RWdKGhTBFiJhHOOu5YaJ71V
	 R0GudMAQUfCqOkLM8h6/9XX6CGmropozUSyJoehq2TDFM9crgGa2wKnCyRm3F73kqD
	 WZiQNA+xzk62Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 7/8] mptcp: add check_id for lookup_anno_list_by_saddr
Date: Wed, 21 Feb 2024 14:31:14 +0800
Message-Id: <fe35233e351bbe2db9c3eb98dc13fff8ea5c60df.1708497039.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708497039.git.tanggeliang@kylinos.cn>
References: <cover.1708497039.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add a new parameter check_id for mptcp_lookup_anno_list_by_saddr(), and
pass it to mptcp_addresses_equal(). Then in mptcp_pm_del_add_timer(),
the input parameter check_id can be passed as the new parameter into
mptcp_lookup_anno_list_by_saddr(). After this, this condition:

        (!check_id || entry->addr.id == addr->id)

can be dropped, only test if 'entry' is NULL is enough.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c         |  2 +-
 net/mptcp/pm_netlink.c | 13 +++++++------
 net/mptcp/protocol.h   |  3 ++-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index c632c9ef69db..eb977922cf06 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -257,7 +257,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 
 	spin_lock_bh(&pm->lock);
 
-	if (mptcp_lookup_anno_list_by_saddr(msk, addr) && READ_ONCE(pm->work_pending))
+	if (mptcp_lookup_anno_list_by_saddr(msk, addr, false) && READ_ONCE(pm->work_pending))
 		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
 
 	spin_unlock_bh(&pm->lock);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 1bf5c3440f84..4519dfa79775 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -242,14 +242,15 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr)
+				const struct mptcp_addr_info *addr,
+				bool check_id)
 {
 	struct mptcp_pm_add_entry *entry;
 
 	lockdep_assert_held(&msk->pm.lock);
 
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, addr, true, false))
+		if (mptcp_addresses_equal(&entry->addr, addr, true, check_id))
 			return entry;
 	}
 
@@ -329,12 +330,12 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
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
@@ -349,7 +350,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
+	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr, false);
 
 	if (add_entry) {
 		if (mptcp_pm_is_kernel(msk))
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1c32f579e1a1..1c4c7a61e73b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -967,7 +967,8 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
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

