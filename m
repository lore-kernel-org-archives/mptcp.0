Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC07E22E41E
	for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 07:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736924518; cv=none; b=nJ9p0fdFAnju4+WvW4yYIYQAxhTZRJtwAiuEGulR24q2QceKp7Vf2A3bUvEND6b6JbELh9zxOnOedxxFqUq8gQmLz5noLmOaMzzS56sm6DK3y2YTdQ5l9Z62ELExjVYdy0CT+jhg/u+DQXyuAJ27Z+r8RYlCcDX3cCqRLdtdwSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736924518; c=relaxed/simple;
	bh=vbo1MeBj54yhSnKdcYJ9yRu/z0wysu894AvA45TtkM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d73Lyp//I9lyeCTcgx+SLXkqDu9eE7N5goHSroJf1t4Qree9KEWuB9OTvtj3lo9txFKTlusdCOq07WB2U1qAkxz6Pj3JTscBrmOOr+kNz2mT9bRAfR42VtU9K+pVuuPS3WJbmQcadainJAmWrH5PMOnyKtprmNKlcGyinKj2200=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5S3p7Xw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5S3p7Xw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DBD0C4CEE4;
	Wed, 15 Jan 2025 07:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736924518;
	bh=vbo1MeBj54yhSnKdcYJ9yRu/z0wysu894AvA45TtkM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r5S3p7XwKpxTkIbMpVPTKBmkMy12xOOXN57+osmBTRTnp3z7/0cEhw1fBJ8oOEda+
	 r1Wp+8J455Ebg937mWd7v6CM2bR+PrhW8iWEadzFr7nOMPCpx8O6OJ8qTs5bW/pilu
	 XY0Q2LZQRR2wU0aGIwOXhdsVjkyOihKFF7AJAlGtzp/Wry/on313H6flNDa/XW5ve4
	 Wo0dfmBIjw11iHXGBEnHCeKDKVqe/yed/e2W5e7Gr64g/obJLu9Z8tuQyYG67TZl12
	 NFJvFryWxBJiQE28hCXwSoWsuqxzaX48uWIHf5QKsIQ/e3h6vN+1TOTN8EkCfj2XDI
	 hNAHqvUTsnE5g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 6/7] mptcp: update address type of get_local_id
Date: Wed, 15 Jan 2025 15:01:39 +0800
Message-ID: <049fa7d83e8e1d3ebde8599169006128f3fb0ec7.1736924314.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736924314.git.tanggeliang@kylinos.cn>
References: <cover.1736924314.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The following code in mptcp_userspace_pm_get_local_id() that assigns 'skc'
to 'new_entry' is not allowed in BPF if we use the same code to implement
get_local_id() interface of a BFP path manager:

        memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
        new_entry.addr = *skc;
        new_entry.addr.id = 0;
        new_entry.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;

To solve the issue, this patch moves this assignment to 'new_entry' forward
to mptcp_pm_get_local_id(), and then passing 'new_entry' as a parameter to
both mptcp_pm_nl_get_local_id() and mptcp_userspace_pm_get_local_id().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           | 10 +++++++---
 net/mptcp/pm_netlink.c   | 12 ++++--------
 net/mptcp/pm_userspace.c | 17 ++++++-----------
 net/mptcp/protocol.h     |  6 ++++--
 4 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 16cacce6c10f..8d9acc984a36 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -403,7 +403,7 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 {
-	struct mptcp_addr_info skc_local;
+	struct mptcp_pm_addr_entry skc_local = { 0 };
 	struct mptcp_addr_info msk_local;
 
 	if (WARN_ON_ONCE(!msk))
@@ -413,12 +413,16 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
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
+	skc_local.addr.port = 0;
 	return mptcp_pm_nl_get_local_id(msk, &skc_local);
 }
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index afd517ff260c..16c901fabfa2 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1139,7 +1139,8 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	return err;
 }
 
-int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
+int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
+			     struct mptcp_pm_addr_entry *local)
 {
 	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
@@ -1148,7 +1149,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	pernet = pm_nl_get_pernet_from_msk(msk);
 
 	rcu_read_lock();
-	entry = __lookup_addr(pernet, skc);
+	entry = __lookup_addr(pernet, &local->addr);
 	ret = entry ? entry->addr.id : -1;
 	rcu_read_unlock();
 	if (ret >= 0)
@@ -1159,12 +1160,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	if (!entry)
 		return -ENOMEM;
 
-	entry->addr = *skc;
-	entry->addr.id = 0;
-	entry->addr.port = 0;
-	entry->ifindex = 0;
-	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
-	entry->lsk = NULL;
+	*entry = *local;
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true);
 	if (ret < 0)
 		kfree(entry);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index eda4277bfff4..4f3e742ee41b 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -131,27 +131,22 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
 }
 
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
-				    struct mptcp_addr_info *skc)
+				    struct mptcp_pm_addr_entry *local)
 {
-	struct mptcp_pm_addr_entry *entry = NULL, new_entry;
 	__be16 msk_sport =  ((struct inet_sock *)
 			     inet_sk((struct sock *)msk))->inet_sport;
+	struct mptcp_pm_addr_entry *entry;
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_userspace_pm_lookup_addr(msk, skc);
+	entry = mptcp_userspace_pm_lookup_addr(msk, &local->addr);
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
+	if (local->addr.port == msk_sport)
+		local->addr.port = 0;
 
-	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry, true);
+	return mptcp_userspace_pm_append_new_local_addr(msk, local, true);
 }
 
 bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index aca3de2baf81..318b293d0be1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1129,8 +1129,10 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
-int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
-int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
+			     struct mptcp_pm_addr_entry *local);
+int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
+				    struct mptcp_pm_addr_entry *local);
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
 bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
-- 
2.43.0

