Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE2319ADBF
	for <mptcp@lists.linux.dev>; Thu, 10 Oct 2024 05:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728539298; cv=none; b=Fszpb9H9ke4KfUvGeM0z0iYOj90bV8ZQQ41lm15F5egac0sq2MlW6on6iP4dG3yeEegJSUMsoVKzVpMqpFzKCKmmSm8XgKDba4EnKkesNdlPV+9xB+PA43PziwzfXOVDBGrSi999DnhufU18dxgJveVtzc4IIHpNsFtRZNwfxbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728539298; c=relaxed/simple;
	bh=w8uVBfMMFSk91XeX7WkJKvpb8039kHGiurzZGYVCqHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lz3nb7oGUFNZAF+mSlOIMTgqLurXdijVU52J6Qq+x6cQ6dZZdUAKRQDbKkj4PMFKpotum2oFLxCY0uJhx/LQics38R/lkGHcJssDXpoPvXgb618dyjWFGlcSaH0DeivM38Bam7w7YVLX9ttOKtK9gGlMI28ZxtjvIGigGVA3o8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geSvcLjB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geSvcLjB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C75C4CEC5;
	Thu, 10 Oct 2024 05:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728539298;
	bh=w8uVBfMMFSk91XeX7WkJKvpb8039kHGiurzZGYVCqHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=geSvcLjBjt/pEMoLBSsQOGqUCDYC5PLsPe85DCpIm5e9gSoHn1LJPRsjqEYz8EWWJ
	 pYWUljgrZIRipIdSaaTlXdnqMeeuYFmkvd7QAdfEZrNiv8NoDU5j5yAXps2l01XetI
	 PhKAM4mCFyzieMJ2+hwR/6dng1MQfQzFFWAjHqAgWNSWAgegmiGgF9Qeau+KZOu0AW
	 5NrF/Ew6Tm5L/UjSEFH19qRej3toL2nRhv3+0wfw0Z5GzjH+NK47M6aHRy5oEBacsu
	 PWFK6OQKlFP+UT4lFCYbppInlYjFEG1e1zAHy4gNIcirST7SSscku01ZzBL07UChNA
	 3/gbBeUnxkt1g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 06/15] mptcp: refactor dump_addr with get_addr
Date: Thu, 10 Oct 2024 13:47:51 +0800
Message-ID: <5e5ca655f0559b196812b9a9fb0870c1a6938f9b.1728538976.git.tanggeliang@kylinos.cn>
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
index 9a544cf47a2b..0d6e444a9f83 100644
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
index 2f1afb719ecf..ad011a4fad4e 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -601,7 +601,7 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb)
 {
 	const struct genl_info *info = genl_info_dump(cb);
-	struct mptcp_pm_addr_entry *entry;
+	struct mptcp_pm_addr_entry entry;
 	struct mptcp_id_bitmap *bitmap;
 	struct mptcp_sock *msk;
 	int id = cb->args[0];
@@ -618,17 +618,20 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 
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
@@ -637,18 +640,16 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
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

