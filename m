Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD2320011D
	for <mptcp@lists.linux.dev>; Sun, 23 Feb 2025 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740320453; cv=none; b=FP/1YybcY9oPigQx5C+S4TXQpV/ciYHNlux2/HvpbD5l7Q0oKRmgeuz9J0QMtzuyhnMReH1sBiyqhv/aXsVWXJLyJlk3+dXiXFfUwdwhZNNsufnBSYvqiY16ymz5hl7URoRlDQUFxr1xxT4fhrFD3RrwRmWCBbY92vZ1oNP76LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740320453; c=relaxed/simple;
	bh=rJNbYgViLMPII9wpo4/Db54VHTnqpsYpeOxy1MCo//A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLqBAD3k7gOSAuR4j2hu+TEA5DJcE8UIs5L1Wupe1P3YxBKGzkmtZmTHaQByNrGPRQsP1Aq0OpztU7PG8Bb+90cv8mzut8fi7bZiitziRkTEmo2rFfvY2VKs9IHb12io2UmEBeWIJ30l4549E4/A2ltPxr9P3Pf4zMJ2FtehX0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuR5TiyK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuR5TiyK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFB6C4CEE7;
	Sun, 23 Feb 2025 14:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740320453;
	bh=rJNbYgViLMPII9wpo4/Db54VHTnqpsYpeOxy1MCo//A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RuR5TiyKTop1rrse/80tZ/z87/+cxXHu3oEYijSR0Rcy4wP8munD04t3Y2u4Le7OH
	 d0JJE6tnrxGv3gS7ekX+R2NXQ6R6Il27FRt8UNENyWg0ddZivNYTKyihhkkKVY7zXU
	 e5sqyW6mBJ0/L0O4z4zaYOEr0efbgXrTncEUgMgee5kOAygkyj8+qeK1u2eW2jfq+e
	 PQAnZyYZ3X++23/4CH2SooWDMxQLM/IuX6Y8D7IjGhPlpnhiO3F/d8hRbhhi4fkA4d
	 /qLeiH8cR51xkYHD42aMzwSWm5vufkkCUkMi51AFfL7zwV8Kg1v7d/Kqtz2JfOTWL7
	 cP+Z0CmcUTjOg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 03/13] mptcp: pm: use addr entry for get_local_id
Date: Sun, 23 Feb 2025 22:19:51 +0800
Message-ID: <889e6bbf8352886fadca89ea653a3e735a7ae106.1740320007.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740320007.git.tanggeliang@kylinos.cn>
References: <cover.1740320007.git.tanggeliang@kylinos.cn>
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
index d4328443d844..69a2f7aa1825 100644
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
index ae4544663f06..a6815d02706b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1127,8 +1127,10 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
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

