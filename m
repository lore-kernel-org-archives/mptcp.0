Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75635205145
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069992; cv=none; b=Ua+xxDrsgPReyovz/hwTl2RF9EHI2BtkUD0A0iMQ7PtcNTww/uYI9apeT867z5D5kxPdCctoFhn8lJuslRMU2lonxHb7B6yqoEEbEUMWthv2t7DTk/ri5kQpoCtAu9AJrHo3DfNke3ZPhVacMTuebUNCtU3E13jRQWhS+NLv+40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069992; c=relaxed/simple;
	bh=fS25HspfdwV/SIJKYDmGSEbgSzFfNuNX5z7IQvNR6s8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qADu9q5u1wpgeVLXsvy4zLG7TSD0j/7morKswsn6Nl7sWoBkPNtSubRCwmLncB8xiUflOTyeagRcenf4OXQGpj5/U80NOyujBiJ2LUpeg6UM3QkBB3SMj7mX70s0/GsuEgMxrEiqvpvlWRZudRdgxNz9DAJwRFeEd0i4xKm0oDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXaTdAzi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXaTdAzi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28712C4CECF;
	Wed, 16 Oct 2024 09:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729069992;
	bh=fS25HspfdwV/SIJKYDmGSEbgSzFfNuNX5z7IQvNR6s8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jXaTdAzi+a0Phu8pGJvqSvR6wd6Eg4isnY0dUfeaEW+owrcdmsZDvxmzySgJKKcFM
	 X+6pqNFfdBf6+xae23mbAC4LFjNQybWrFfH/YZJFpzljtlX8MmFtMlEMFEVEYLIRzh
	 yAalfjX8i0T1bea5k0fmvo6Ib5A/uHpB/ceSMg54StWCeGKslSUodKXap9oB51vgLR
	 ws8USR+db10fBKycVr6ycNqm5BvU9wmCasfHuLDu/aRQQSdJ9H1AYNW4QMWgbqG338
	 AMT6kVxQSu2PqEOJZFX0k0xc+/vhTOQlI2hRa7+UAdQCqVrG7Lx+9OS3nrvsYT/YTZ
	 MjlYPCFg75S4g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 15/33] mptcp: refactor dump_addr with get_addr
Date: Wed, 16 Oct 2024 17:12:19 +0800
Message-ID: <81ce998b590fab2912dcdffd89d670fa9ee26e6f.1729069854.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729069853.git.tanggeliang@kylinos.cn>
References: <cover.1729069853.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch is the second part of refactoring dump_addr().

With the help of get_addr(), only copy the address list to an id
bitmap while holding the lock, then release the lock immediately.

After that, without locking, walking the copied id bitmap to get
every copy of entry by using get_addr(), and send each one looply:

	lock();
	for_each_entry(entry)
		set_bit(bitmap);
	unlock();

	for_each_bit(bitmap) {
		copy = get_addr();
		send_nlmsg(copy);
	}

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 20 +++++++++++---------
 net/mptcp/pm_userspace.c | 23 ++++++++++++-----------
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 0f107564fcfd..ce6385d8fdb4 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1867,8 +1867,9 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 static int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb)
 {
+	const struct genl_info *info = genl_info_dump(cb);
 	struct net *net = sock_net(msg->sk);
-	struct mptcp_pm_addr_entry *entry;
+	struct mptcp_pm_addr_entry entry;
 	struct mptcp_id_bitmap *bitmap;
 	struct pm_nl_pernet *pernet;
 	int id = cb->args[0];
@@ -1878,16 +1879,18 @@ static int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 	bitmap = (struct mptcp_id_bitmap *)cb->ctx;
 	pernet = pm_nl_get_pernet(net);
 
-	spin_lock_bh(&pernet->lock);
-	if (!id)
+	if (!id) {
+		spin_lock_bh(&pernet->lock);
 		bitmap_copy(bitmap->map, pernet->id_bitmap.map, MPTCP_PM_MAX_ADDR_ID + 1);
+		spin_unlock_bh(&pernet->lock);
+	}
+
 	for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
 		if (test_bit(i, bitmap->map)) {
-			entry = __lookup_addr_by_id(pernet, i);
-			if (!entry)
+			if (mptcp_pm_nl_get_addr(i, &entry, info))
 				break;
 
-			if (entry->addr.id <= id)
+			if (entry.addr.id <= id)
 				continue;
 
 			hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
@@ -1896,16 +1899,15 @@ static int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			if (!hdr)
 				break;
 
-			if (mptcp_nl_fill_addr(msg, entry) < 0) {
+			if (mptcp_nl_fill_addr(msg, &entry) < 0) {
 				genlmsg_cancel(msg, hdr);
 				break;
 			}
 
-			id = entry->addr.id;
+			id = entry.addr.id;
 			genlmsg_end(msg, hdr);
 		}
 	}
-	spin_unlock_bh(&pernet->lock);
 
 	cb->args[0] = id;
 	return msg->len;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 237383cfd12e..8c7fc1fd1e2b 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -602,7 +602,7 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb)
 {
 	const struct genl_info *info = genl_info_dump(cb);
-	struct mptcp_pm_addr_entry *entry;
+	struct mptcp_pm_addr_entry entry;
 	struct mptcp_id_bitmap *bitmap;
 	struct mptcp_sock *msk;
 	int id = cb->args[0];
@@ -619,17 +619,20 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 
 	sk = (struct sock *)msk;
 
-	lock_sock(sk);
-	spin_lock_bh(&msk->pm.lock);
-	if (!id)
+	if (!id) {
+		lock_sock(sk);
+		spin_lock_bh(&msk->pm.lock);
 		ret = mptcp_userspace_pm_set_bitmap(msk, bitmap);
+		spin_unlock_bh(&msk->pm.lock);
+		release_sock(sk);
+	}
+
 	for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
 		if (test_bit(i, bitmap->map)) {
-			entry = mptcp_userspace_pm_lookup_addr_by_id(msk, i);
-			if (!entry)
+			if (mptcp_userspace_pm_get_addr(i, &entry, info))
 				break;
 
-			if (id && entry->addr.id <= id)
+			if (id && entry.addr.id <= id)
 				continue;
 
 			hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
@@ -638,18 +641,16 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 			if (!hdr)
 				break;
 
-			if (mptcp_nl_fill_addr(msg, entry) < 0) {
+			if (mptcp_nl_fill_addr(msg, &entry) < 0) {
 				genlmsg_cancel(msg, hdr);
 				break;
 			}
 
-			id = entry->addr.id;
+			id = entry.addr.id;
 			genlmsg_end(msg, hdr);
 		}
 	}
 	cb->args[0] = id;
-	spin_unlock_bh(&msk->pm.lock);
-	release_sock(sk);
 	ret = msg->len;
 
 	sock_put(sk);
-- 
2.43.0

