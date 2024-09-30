Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025075464B
	for <mptcp@lists.linux.dev>; Mon, 30 Sep 2024 09:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727689517; cv=none; b=q5YmZ/ailNvtjXZ0Gx8RkNQEFAn1k0zFIJSlnXAjRL1mT8Z+0RwXDbhmTfmVjCHxIM8cnuSvSdu3neZ2LmSqcCwOoT6affsyB23chGiDCHKma0x4gUkszyHUkmsNvIMJ7a3dmtZJF0z9ewT/W3U1Ey/n/zBWmrZ8tp0axLvqzww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727689517; c=relaxed/simple;
	bh=lBnJaIToLZgNON5tuGwj6XyXMb5nB7KJ3LKHiyuhQ6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qao/lylpR3lNFlGVV78EZbJoWlMjSEFcA8IrkYTGNKyAnJemxqp1Lz+bEZExxNzS5/N5YJs1zTrwGjDU1c9twTMxuAjfen+MSRQwczUizktlwHFKFdbl9GWySkMuJbLOfinWFakTSfgVpZP0iLkxUzefdQldtqDUoIPmPwTVCUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZH5efdv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZH5efdv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB32C4CEC7;
	Mon, 30 Sep 2024 09:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727689516;
	bh=lBnJaIToLZgNON5tuGwj6XyXMb5nB7KJ3LKHiyuhQ6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AZH5efdv4+8W9NEQ5iJpe1AVKjQcmGBMyBWl9Mkg2GIf1ubwuhYixlJWoPww0p64H
	 5KYxzVjQ1bMeConuO+PWpMr4VCmRM1hBK3VZfdaQYPNsbh8kXd2g1VsU5TVjY/1Ffu
	 XU+WCjTewhF2l7E00P6aYOhmSYd0MbJkyahcEI4Ne9ATS3CdeAQOCFB/aBSJ+5pDL1
	 Isp3KjlbRtp8OMyoAGDiqjhfIcdKLvlfNqMKjNhqOBO9K6Y5q43SRxDh2nyvtAHjJa
	 mBrzzR60LNB3AxKyw899TIWstH5GesyI2bR9Db3ixOo4KG2+mnLPlj6XUiXEzV20GB
	 Ayy/37O95pErQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 5/7] mptcp: refactor dump_addr with id bitmap
Date: Mon, 30 Sep 2024 17:45:00 +0800
Message-ID: <8c8a23df0610ab51f5264069408118a6bfb36aaf.1727689369.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727689369.git.tanggeliang@kylinos.cn>
References: <cover.1727689369.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

With the help of get_addr(), we can refactor dump_addr() interfaces to
reuse send_nlmsg code between the netlink PM and userspace PM.

The current dump_addr() flow looks like this:

	lock();
	for_each_entry(entry)
		send_nlmsg(entry);
	unlock();

After holding the lock, get every entry by walking the address list,
send each one looply, and finally release the lock.

This patch changes the process by copying the address list to an
id bitmap while holding the lock, then release the lock immediately.

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
 net/mptcp/pm_netlink.c   | 30 +++++++++++-------
 net/mptcp/pm_userspace.c | 67 ++++++++++++++++++++++++++++------------
 2 files changed, 67 insertions(+), 30 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index dc87f9ee9000..d921d1bc0682 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1865,23 +1865,32 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 static int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb)
 {
+	const struct genl_info *info = genl_info_dump(cb);
 	struct net *net = sock_net(msg->sk);
-	struct mptcp_pm_addr_entry *entry;
-	struct pm_nl_pernet *pernet;
+	struct mptcp_pm_addr_entry entry;
+	struct mptcp_id_bitmap *bitmap;
 	int id = cb->args[0];
 	void *hdr;
 	int i;
 
-	pernet = pm_nl_get_pernet(net);
+	bitmap = (struct mptcp_id_bitmap *)cb->ctx;
+
+	if (!id) {
+		struct pm_nl_pernet *pernet = pm_nl_get_pernet(net);
+
+		spin_lock_bh(&pernet->lock);
+		bitmap_copy(bitmap->map, pernet->id_bitmap.map, MPTCP_PM_MAX_ADDR_ID + 1);
+		spin_unlock_bh(&pernet->lock);
+	}
 
-	spin_lock_bh(&pernet->lock);
 	for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
-		if (test_bit(i, pernet->id_bitmap.map)) {
-			entry = __lookup_addr_by_id(pernet, i);
-			if (!entry)
+		if (test_bit(i, bitmap->map)) {
+			if (mptcp_pm_get_addr(i, &entry, info)) {
+				GENL_SET_ERR_MSG(info, "address not found");
 				break;
+			}
 
-			if (entry->addr.id <= id)
+			if (entry.addr.id <= id)
 				continue;
 
 			hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
@@ -1890,16 +1899,15 @@ static int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
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
index 95c7cb56e9b4..de552ba542f6 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -38,6 +38,21 @@ mptcp_userspace_pm_lookup_addr(struct mptcp_sock *msk, const struct mptcp_addr_i
 	return NULL;
 }
 
+static int mptcp_userspace_pm_set_bitmap(struct mptcp_sock *msk,
+					 struct mptcp_id_bitmap *bitmap)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (test_bit(entry->addr.id, bitmap->map))
+			continue;
+
+		__set_bit(entry->addr.id, bitmap->map);
+	}
+
+	return 0;
+}
+
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    struct mptcp_pm_addr_entry *entry,
 						    bool needs_id)
@@ -615,13 +630,15 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 {
 	const struct genl_info *info = genl_info_dump(cb);
 	struct net *net = sock_net(msg->sk);
-	struct mptcp_pm_addr_entry *entry;
+	struct mptcp_pm_addr_entry entry;
 	struct mptcp_id_bitmap *bitmap;
 	struct mptcp_sock *msk;
 	struct nlattr *token;
+	int id = cb->args[0];
 	int ret = -EINVAL;
 	struct sock *sk;
 	void *hdr;
+	int i;
 
 	bitmap = (struct mptcp_id_bitmap *)cb->ctx;
 	token = info->attrs[MPTCP_PM_ATTR_TOKEN];
@@ -639,28 +656,40 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 		goto out;
 	}
 
-	lock_sock(sk);
-	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (test_bit(entry->addr.id, bitmap->map))
-			continue;
+	if (!id) {
+		lock_sock(sk);
+		spin_lock_bh(&msk->pm.lock);
+		ret = mptcp_userspace_pm_set_bitmap(msk, bitmap);
+		spin_unlock_bh(&msk->pm.lock);
+		release_sock(sk);
+	}
 
-		hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
-				  cb->nlh->nlmsg_seq, &mptcp_genl_family,
-				  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
-		if (!hdr)
-			break;
+	for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
+		if (test_bit(i, bitmap->map)) {
+			if (mptcp_userspace_pm_get_addr(i, &entry, info)) {
+				GENL_SET_ERR_MSG(info, "address not found");
+				break;
+			}
 
-		if (mptcp_nl_fill_addr(msg, entry) < 0) {
-			genlmsg_cancel(msg, hdr);
-			break;
-		}
+			if (id && entry.addr.id <= id)
+				continue;
 
-		__set_bit(entry->addr.id, bitmap->map);
-		genlmsg_end(msg, hdr);
+			hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
+					  cb->nlh->nlmsg_seq, &mptcp_genl_family,
+					  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
+			if (!hdr)
+				break;
+
+			if (mptcp_nl_fill_addr(msg, &entry) < 0) {
+				genlmsg_cancel(msg, hdr);
+				break;
+			}
+
+			id = entry.addr.id;
+			genlmsg_end(msg, hdr);
+		}
 	}
-	spin_unlock_bh(&msk->pm.lock);
-	release_sock(sk);
+	cb->args[0] = id;
 	ret = msg->len;
 
 out:
-- 
2.43.0

