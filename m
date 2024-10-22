Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1F22209B
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588519; cv=none; b=LCkjGWcD3qEOsccn9J1ol0g2cmjdzP3TLQvR1kKW+SUzpAKl0LLaUqdQfz3XLCGxwKEoe89gWdgUazJFiYVoydZrUDTIvdY9thH9nGdkmWLDikgcTNMSR4/Jy9/+OSlRBxOJFWwOP5YyZih1Hf0rFwgcqvc9WwoRwKpaXYW2MIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588519; c=relaxed/simple;
	bh=keAOnNKahgjswD3U9xoRloNYhPEGFMbCPFOlLg1hvlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9H/55j8u7vgaYWT09e2c1drhw//1s3d3qfsPWhGzFRUaGIyXrFHafTk7PRnDe2BA0Nn+VWGix8s1iOFOi1voK2Dr2C10D7uLUbo1Dn0QoBUm+4BZ7Rn8IlQXmSG+3qTsx+Y5oDO7lA3f/Y2IDext1RlmMAEqcn1fHaMnPXW1O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8gIxNwm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8gIxNwm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26A3C4CEC3;
	Tue, 22 Oct 2024 09:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588518;
	bh=keAOnNKahgjswD3U9xoRloNYhPEGFMbCPFOlLg1hvlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S8gIxNwmeqM0EzP31CRa4/G+6yE3xwnrHkHwbMQralCVj0MEfAbInErGRwy+KhN/l
	 bLv1dF8MJsFzMhqgezLQnux4Md8PV6skizMjX7Jab1jRbGawfyGCZ6lvyvemQ25NxL
	 Har1n4qTYmalvpUmAHhBziGwTc450u16fnKuVpabxZrUwK8yL2G3KzyQesrpEQbJjS
	 2bonC9LOx4VWbcobjGU4OlAWtz3q4AVUS2XM4b9ZYZ2Fhm+NthMcMdChJc0nnRS4Pj
	 Tix88CVoIOyQguFuNgk1c/mGK5spJ4FlroWtpsZx/TtCAzBaCcQOWX1oPtxEPOHV8o
	 TbmaMEPJlmWZA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 16/36] mptcp: reuse sending nlmsg code in dump_addr
Date: Tue, 22 Oct 2024 17:14:24 +0800
Message-ID: <fb42734469a939589a27e41b312177cc83d70931.1729588019.git.tanggeliang@kylinos.cn>
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

With the previous commit, we can reuse the send_nlmsg() code in
dump_addr interfaces between the netlink PM and userspace PM.
They only need to implement their own dump_addr() interfaces to
hold the different locks, copy the different address lists to an
id bitmap, then release the locks.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 56 +++++++++++++++++++++-------------------
 net/mptcp/pm_userspace.c | 50 +++++------------------------------
 net/mptcp/protocol.h     |  4 +--
 3 files changed, 38 insertions(+), 72 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 1777421344e2..c6476cb464b0 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1864,33 +1864,50 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
-				 struct netlink_callback *cb)
+static int mptcp_pm_nl_dump_addr(struct mptcp_id_bitmap *bitmap,
+				 const struct genl_info *info)
+{
+	struct net *net = genl_info_net(info);
+	struct pm_nl_pernet *pernet;
+
+	pernet = pm_nl_get_pernet(net);
+
+	spin_lock_bh(&pernet->lock);
+	bitmap_copy(bitmap->map, pernet->id_bitmap.map, MPTCP_PM_MAX_ADDR_ID + 1);
+	spin_unlock_bh(&pernet->lock);
+
+	return 0;
+}
+
+static int mptcp_pm_dump_addr(struct mptcp_id_bitmap *bitmap,
+			      const struct genl_info *info)
+{
+	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
+		return mptcp_userspace_pm_dump_addr(bitmap, info);
+	return mptcp_pm_nl_dump_addr(bitmap, info);
+}
+
+int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
+				struct netlink_callback *cb)
 {
 	const struct genl_info *info = genl_info_dump(cb);
-	struct net *net = sock_net(msg->sk);
 	struct mptcp_pm_addr_entry entry;
 	struct mptcp_id_bitmap *bitmap;
-	struct pm_nl_pernet *pernet;
 	int id = cb->args[0];
 	void *hdr;
 	int i;
 
 	bitmap = (struct mptcp_id_bitmap *)cb->ctx;
-	pernet = pm_nl_get_pernet(net);
 
-	if (!id) {
-		spin_lock_bh(&pernet->lock);
-		bitmap_copy(bitmap->map, pernet->id_bitmap.map, MPTCP_PM_MAX_ADDR_ID + 1);
-		spin_unlock_bh(&pernet->lock);
-	}
+	if (!id)
+		mptcp_pm_dump_addr(bitmap, info);
 
 	for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
 		if (test_bit(i, bitmap->map)) {
-			if (mptcp_pm_nl_get_addr(i, &entry, info))
+			if (mptcp_pm_get_addr(i, &entry, info))
 				break;
 
-			if (entry.addr.id <= id)
+			if (id && entry.addr.id <= id)
 				continue;
 
 			hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
@@ -1913,21 +1930,6 @@ static int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 	return msg->len;
 }
 
-static int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
-{
-	const struct genl_info *info = genl_info_dump(cb);
-
-	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_dump_addr(msg, cb);
-	return mptcp_pm_nl_dump_addr(msg, cb);
-}
-
-int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
-				struct netlink_callback *cb)
-{
-	return mptcp_pm_dump_addr(msg, cb);
-}
-
 static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
 {
 	struct nlattr *attr = info->attrs[id];
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 8c7fc1fd1e2b..d815bfa57532 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -598,20 +598,12 @@ static int mptcp_userspace_pm_set_bitmap(struct mptcp_sock *msk,
 	return 0;
 }
 
-int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
-				 struct netlink_callback *cb)
+int mptcp_userspace_pm_dump_addr(struct mptcp_id_bitmap *bitmap,
+				 const struct genl_info *info)
 {
-	const struct genl_info *info = genl_info_dump(cb);
-	struct mptcp_pm_addr_entry entry;
-	struct mptcp_id_bitmap *bitmap;
 	struct mptcp_sock *msk;
-	int id = cb->args[0];
 	int ret = -EINVAL;
 	struct sock *sk;
-	void *hdr;
-	int i;
-
-	bitmap = (struct mptcp_id_bitmap *)cb->ctx;
 
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
@@ -619,39 +611,11 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 
 	sk = (struct sock *)msk;
 
-	if (!id) {
-		lock_sock(sk);
-		spin_lock_bh(&msk->pm.lock);
-		ret = mptcp_userspace_pm_set_bitmap(msk, bitmap);
-		spin_unlock_bh(&msk->pm.lock);
-		release_sock(sk);
-	}
-
-	for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
-		if (test_bit(i, bitmap->map)) {
-			if (mptcp_userspace_pm_get_addr(i, &entry, info))
-				break;
-
-			if (id && entry.addr.id <= id)
-				continue;
-
-			hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
-					  cb->nlh->nlmsg_seq, &mptcp_genl_family,
-					  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
-			if (!hdr)
-				break;
-
-			if (mptcp_nl_fill_addr(msg, &entry) < 0) {
-				genlmsg_cancel(msg, hdr);
-				break;
-			}
-
-			id = entry.addr.id;
-			genlmsg_end(msg, hdr);
-		}
-	}
-	cb->args[0] = id;
-	ret = msg->len;
+	lock_sock(sk);
+	spin_lock_bh(&msk->pm.lock);
+	ret = mptcp_userspace_pm_set_bitmap(msk, bitmap);
+	spin_unlock_bh(&msk->pm.lock);
+	release_sock(sk);
 
 	sock_put(sk);
 	return ret;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4358a9a21270..833ad44c6e65 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1130,8 +1130,8 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_in
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
 bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
-int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
-				 struct netlink_callback *cb);
+int mptcp_userspace_pm_dump_addr(struct mptcp_id_bitmap *bitmap,
+				 const struct genl_info *info);
 int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 				const struct genl_info *info);
 
-- 
2.45.2

