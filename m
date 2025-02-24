Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFAB20AF7D
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 08:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740384834; cv=none; b=iGDUP4TejA6vLITnIraHewYmX+FXluK13G4ymADSD4RyaKwLGIE7mXVcoFjKwpUsWRTWkmRVfNxGsCqGcKLBSUlpN1NXC/x7TVTAluTfNQ8quWwU+w93LcIZQqTKBcCHXej6sJTLepaCRqUsqK5kWPgHuKH63cgqxSbtaA3Xi9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740384834; c=relaxed/simple;
	bh=mR8zQ501/FwysZh5cA+ljZiZfZgamM7wV7cp/X7dyGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFjzBpQX65Wf8jTAVsPR6KbLGh5jhZCXnV2z+O5Pkfgr0tKdP2wWuoPBMKX5XhUg6IEDmSN5/GSVOCYxLvkHbZr/AzbaaVqA97nhM8ycmm4WybcHRIYAfcq8/dWKophbnAjkrCl7wIx58VfqUVyuvi9WloHdtWu9f8N7maLI8Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ayftqkux; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ayftqkux"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8C6C4CEDD;
	Mon, 24 Feb 2025 08:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740384834;
	bh=mR8zQ501/FwysZh5cA+ljZiZfZgamM7wV7cp/X7dyGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ayftqkuxj9jFVCz4FZ1iCdlR1wDlFAsn56y6bRNgU2kQsXr1RG/XEm+WTSHqb9+IQ
	 wwp23fiBgDxRlDOyTHou1ki+1IF6jl/iE58SSH5CxCZ7nI0V4IzKeX4tnmGZ7qSzhB
	 iYNwEvkDx8YLgnSCxIgEcUJ0uHFtueKGWeLG0cGAcKy2ao+BhJdQgg607W3jYwMfTC
	 7l6BjgouZzi+JNYWdtarxQ+oI/cTHQ5fqWWfJidWO4FK2UlRt7joBH3kcdWt6sMA/8
	 4SOLFUEu3kpbvWjF7MWzJQwulx1zhG4vFLqXlbtfgFoIle+ktfnTdGbG4ggKmr+kif
	 iyuEb8wEkRI4g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 3/6] mptcp: pm: use addr entry for get_local_id
Date: Mon, 24 Feb 2025 16:13:35 +0800
Message-ID: <f62a745622785d4f80bedf768c6aca6f8514775e.1740384564.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740384564.git.tanggeliang@kylinos.cn>
References: <cover.1740384564.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The following code in mptcp_userspace_pm_get_local_id() that assigns "skc"
to "new_entry" is not allowed in BPF if we use the same code to implement
the get_local_id() interface of a BFP path manager:

	memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
	new_entry.addr = *skc;
	new_entry.addr.id = 0;
	new_entry.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;

To solve the issue, this patch moves this assignment to "new_entry" forward
to mptcp_pm_get_local_id(), and then passing "new_entry" as a parameter to
both mptcp_pm_nl_get_local_id() and mptcp_userspace_pm_get_local_id().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           |  9 ++++++---
 net/mptcp/pm_netlink.c   | 11 ++++-------
 net/mptcp/pm_userspace.c | 17 ++++++-----------
 net/mptcp/protocol.h     |  6 ++++--
 4 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 16cacce6c10f..ac7b39148bd3 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -403,7 +403,7 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 {
-	struct mptcp_addr_info skc_local;
+	struct mptcp_pm_addr_entry skc_local = { 0 };
 	struct mptcp_addr_info msk_local;
 
 	if (WARN_ON_ONCE(!msk))
@@ -413,10 +413,13 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	 * addr
 	 */
 	mptcp_local_address((struct sock_common *)msk, &msk_local);
-	mptcp_local_address((struct sock_common *)skc, &skc_local);
-	if (mptcp_addresses_equal(&msk_local, &skc_local, false))
+	mptcp_local_address((struct sock_common *)skc, &skc_local.addr);
+	if (mptcp_addresses_equal(&msk_local, &skc_local.addr, false))
 		return 0;
 
+	skc_local.addr.id = 0;
+	skc_local.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
+
 	if (mptcp_pm_is_userspace(msk))
 		return mptcp_userspace_pm_get_local_id(msk, &skc_local);
 	return mptcp_pm_nl_get_local_id(msk, &skc_local);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 4bebc4963c42..033cba59023f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1139,7 +1139,8 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	return err;
 }
 
-int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
+int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
+			     struct mptcp_pm_addr_entry *skc)
 {
 	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
@@ -1148,7 +1149,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	pernet = pm_nl_get_pernet_from_msk(msk);
 
 	rcu_read_lock();
-	entry = __lookup_addr(pernet, skc);
+	entry = __lookup_addr(pernet, &skc->addr);
 	ret = entry ? entry->addr.id : -1;
 	rcu_read_unlock();
 	if (ret >= 0)
@@ -1159,12 +1160,8 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	if (!entry)
 		return -ENOMEM;
 
-	entry->addr = *skc;
-	entry->addr.id = 0;
+	*entry = *skc;
 	entry->addr.port = 0;
-	entry->ifindex = 0;
-	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
-	entry->lsk = NULL;
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true);
 	if (ret < 0)
 		kfree(entry);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 6bf6a20ef7f3..5b3ee43130be 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -131,27 +131,22 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
 }
 
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
-				    struct mptcp_addr_info *skc)
+				    struct mptcp_pm_addr_entry *skc)
 {
-	struct mptcp_pm_addr_entry *entry = NULL, new_entry;
 	__be16 msk_sport =  ((struct inet_sock *)
 			     inet_sk((struct sock *)msk))->inet_sport;
+	struct mptcp_pm_addr_entry *entry;
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_userspace_pm_lookup_addr(msk, skc);
+	entry = mptcp_userspace_pm_lookup_addr(msk, &skc->addr);
 	spin_unlock_bh(&msk->pm.lock);
 	if (entry)
 		return entry->addr.id;
 
-	memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
-	new_entry.addr = *skc;
-	new_entry.addr.id = 0;
-	new_entry.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
-
-	if (new_entry.addr.port == msk_sport)
-		new_entry.addr.port = 0;
+	if (skc->addr.port == msk_sport)
+		skc->addr.port = 0;
 
-	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry, true);
+	return mptcp_userspace_pm_append_new_local_addr(msk, skc, true);
 }
 
 bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3d72ca155322..ef1d43406f9b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1126,8 +1126,10 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
-int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
-int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
+			     struct mptcp_pm_addr_entry *skc);
+int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
+				    struct mptcp_pm_addr_entry *skc);
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
 bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
-- 
2.43.0

