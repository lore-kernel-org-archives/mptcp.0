Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB16A18BC03
	for <mptcp@lists.linux.dev>; Tue,  8 Oct 2024 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381516; cv=none; b=h1kheECa1bRzLe7DYv3vBNLvZsDR+qy9LlLVqUJmoEH9xXxvntZ1We86cDJZFsdPBt9xWKjqFWJQMwOIqVyx8hQSjhGUTF3b7sJO0tk3jMohv7k9cbY+NR23WzzgD12k4siEmSg8z9NRHAv1O33kNmS8d1QCLtGvkURAggIJhHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381516; c=relaxed/simple;
	bh=Qa09CNLFIWC3rTR+k0zQzrj9qeydL721G+2djdFNGBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBzdXX9EEIZBpkjCbgm+r9zVp0NAnkGVgmhBbSXtFZTTod1Yk59jUtezBfeMnYsglZ7A5xgcPgArXXOl1yuewdXWyrhb1nungYleZWuSGYLXgzJ67PKwAraDNCTmQAA6ct62cYVj6nA36oVXj/gEETJ1xA4N9PYXOQkqiWjVVzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcDU+tdw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcDU+tdw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F1BC4CEC7;
	Tue,  8 Oct 2024 09:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728381516;
	bh=Qa09CNLFIWC3rTR+k0zQzrj9qeydL721G+2djdFNGBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rcDU+tdwdNOWgaCby0yt1cvt5NuLp4/p54VCSv4S0ADjN2NKwME2jHezQpydNEtV/
	 bj2tOAKg/vQyz67MBmAdpzV51yeRDbz6HHcUI97a9HXU+4bP4ilcvPB9/Bi6NO+nj1
	 cdCamfv+cJraXmMty+Ci1+zoPM6rinJQYi2QTumb4Dvw8Z/zs0K66Bgff8H/tUvvY8
	 f/NXzl9X6uu4igu1u/p0xelr+HPudJEv/jScsOYsCcfSSrltcg7ev7W6zPf36bsWqQ
	 5DQmU1BDQw7hygx6yZTRCz+ljOH8dgaYYsMyx9l6Kus7uoHGwWBCrfkegads01ILf2
	 QD88z/Z9feYZQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 06/13] mptcp: refactor dump_addr with get_addr
Date: Tue,  8 Oct 2024 17:58:10 +0800
Message-ID: <1eff3615defa58a09e307874d3b30c6d6431d271.1728381245.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728381245.git.tanggeliang@kylinos.cn>
References: <cover.1728381245.git.tanggeliang@kylinos.cn>
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
index 9d502ab4d91d..bcee83306e40 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1866,8 +1866,9 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -1877,16 +1878,18 @@ static int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
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
@@ -1895,16 +1898,15 @@ static int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
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

