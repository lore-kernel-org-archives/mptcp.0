Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4012BB09
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588517; cv=none; b=bV67WK9UiAhf+FyWuYZKuTMKAT33t9g2iSEehXfxGrg8YM8g8vPcHgoUl8qhr5rxlgnuNfyO6eN/6SUTiIVA6n/qvoKdqcOcvMAJ7AxlXGts5BHLkFPruwpRteXuDN0isAV34QAHj32qemwCxRx69kv/A1eTU5qCh16Z6cKZNBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588517; c=relaxed/simple;
	bh=5lKVdwdZK/vUgY/eIG/VN3eC2z2aTSBHLMI8ipWKyjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sf6w3ZJkzC2AlVLbiku9anXjedlyV9SWyCQpUmch2Sh4rJIxyAw2tluPv7go/hOB8mcp5mUzbUrOQfS7jIK3EQyV+TxiLp+nKiVZmichCpA68BLdDxb9nmuzZRUTkNueZGWRa+MklFbcC8SFDmmKi1ob4JrwSRkPixHLFEgFXpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P10ksFyp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P10ksFyp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBF9C4CEE3;
	Tue, 22 Oct 2024 09:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588517;
	bh=5lKVdwdZK/vUgY/eIG/VN3eC2z2aTSBHLMI8ipWKyjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P10ksFypop3tNv1GaYgHTgphHXsehYIBeG9m0+VjhUgOvCCeC0pqjNBcNVoObnaM0
	 Cbw3uoOm/Yo6C7bn/Lg0JNW7jTL/jlru4htcltLvh1Ou3yicp19GHoJQrjOSEyHTQL
	 xY/S3+gU/zqXtooXy7C/ETY797Ri1XXZ6VyykMF8jrLDBvBc2LmheU3sLGatnFdEHU
	 Z6JFU6AHdgsHgGu0aN0WYcGmbBYY/21miQMOOf0h6XsbvQFYHII/IDat9RTPqyipTi
	 AUTRk2iqBR4dIRYgKUTVVpd+wnIv4ayA3DkC8gh4kSc4sB40m8VowvaK0LxqVglNiB
	 nfw1XyykzhBzg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 15/36] mptcp: refactor dump_addr with get_addr
Date: Tue, 22 Oct 2024 17:14:23 +0800
Message-ID: <4130a9b51561eed4bec0de97b0bd9b024a16b605.1729588019.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729588019.git.tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
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
index 4cee5942200c..1777421344e2 100644
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
2.45.2

