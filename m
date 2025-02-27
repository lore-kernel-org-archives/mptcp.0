Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4536121CC7A
	for <mptcp@lists.linux.dev>; Thu, 27 Feb 2025 06:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740638661; cv=none; b=ufuiq6nlw7R42zISoKrb1mpnnC1XqgcF6hzeGmrtp8eCnvFhT4QL9ape8uCrGAGjA6EBUGPKGvkiRuBGSeDNXFjH89gL2G2XoGg8/zFjOnLprfKN7EdvfMqDDM9hczRMYjqCP2HWBAT8/3y3fsCVry/4YP7hArcsTnB4wL2ukNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740638661; c=relaxed/simple;
	bh=13Ci+PPqQ1wGMtMD0uB+9jZouttPlQWwaKm9XMRx6sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4BCnyDQCd/q7EVG18CbL70K4RoUP8uDmBJW7wKkRam9hiQe1Bf/gYFNi0GqWlgRr8jmZkSPnOxhQMPjHUAntBj7V8l4k0EP+b1BawL8Q+TI55rLCEyJS4jNjH3oHd+0ZpRRkpYoT85Rp88YmpsxHhYzzQB0pRSF9omyD5tdcf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuHtqIlK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuHtqIlK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB21C4CEE7;
	Thu, 27 Feb 2025 06:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740638660;
	bh=13Ci+PPqQ1wGMtMD0uB+9jZouttPlQWwaKm9XMRx6sI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VuHtqIlKi6AnMfUxdu0RSo9+SxwKnwXv5ofYdyYuAoq2q7DPhTun8GgLAToX9B7j7
	 1ibJX7MBuCsBz/9N1NR5ZLrPeMNdPfD1TfDQ/+u+oyQAwx1XX0Pc74yZiRvatCCokC
	 QJUzO9tZLthZwe8mqU/KS4BTAqdtS04eKqKmKgD5acZ1+PKXAXS73ZZchrJzpUjW/H
	 gIpdpgr/Khc7O6seWloFC0530KPCkM/re08vE6ZytGr6PEn/MBVNEZIYP+DPHewjg9
	 84uxpNoW92kSU4VoAufbFsIuhirOAkVUSlI5sRKyerWN3Z+LvJWnjKYMcsTvpifCFU
	 NhzmnrVPD1Nqg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 3/6] mptcp: pm: drop is_kernel in alloc_anno_list
Date: Thu, 27 Feb 2025 14:43:54 +0800
Message-ID: <353675576c206d346d952315e520f313ad0a2144.1740638334.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740638334.git.tanggeliang@kylinos.cn>
References: <cover.1740638334.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To reduce the path manager's reliance on mptcp_pm_is_userspace()
and mptcp_pm_is_kernel() helpers, this patch drops the check for
mptcp_pm_is_kernel() in the function mptcp_pm_alloc_anno_list().
Instead, add a new parameter "reissue" for this function, pass
"false" to this function in the in-kernel PM while pass "true"
to it in the userspace PM.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 7 ++++---
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.h     | 3 ++-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 23c28e37ab8f..0d98c2df72f7 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -358,7 +358,8 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 }
 
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-			      const struct mptcp_addr_info *addr)
+			      const struct mptcp_addr_info *addr,
+			      bool reissue)
 {
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
@@ -369,7 +370,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 
 	if (add_entry) {
-		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
+		if (WARN_ON_ONCE(!reissue))
 			return false;
 
 		sk_reset_timer(sk, &add_entry->add_timer,
@@ -595,7 +596,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		/* If the alloc fails, we are on memory pressure, not worth
 		 * continuing, and trying to create subflows.
 		 */
-		if (!mptcp_pm_alloc_anno_list(msk, &local.addr))
+		if (!mptcp_pm_alloc_anno_list(msk, &local.addr, false))
 			return;
 
 		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 98fe8808d1e1..05d59ad1a0bc 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -232,7 +232,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
 
-	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
+	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr, true)) {
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ef1d43406f9b..0b6695fbb645 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1023,7 +1023,8 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 				 struct mptcp_addr_info *rem,
 				 u8 bkup);
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-			      const struct mptcp_addr_info *addr);
+			      const struct mptcp_addr_info *addr,
+			      bool reissue);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_add_entry *
-- 
2.43.0

