Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2958C1925AF
	for <mptcp@lists.linux.dev>; Thu, 10 Oct 2024 05:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728539300; cv=none; b=F2uqJheFydYtFM4WHUSBYMqwpQG14Er16I+trbcwu8BaJIhp4+z6zeZ/5xyuiBRI4Y99Jt49wfzABSYesX1JJlX5YvF7txcm0JPyo//wE3g05s46zHOXRC1BnNk4YZu3cuwq0n7meDP/3mBPHUO4MIrbJ8oc+38PuVEreEHO388=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728539300; c=relaxed/simple;
	bh=G8+tUJAR725LeI32UIOej8rBnSQ+X+JipgfcuSo/ELo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8ql3vqlCWz+0cxGVU4XDKUmmGt/a3k0Sa6jP1lqt7xTb8/arNZ0g4CdSXpHrmjXyyJlGedgnxm6P8nIwUdnn9Wec5XEfCOouxFVpKDc8WDtZRZurV8uE9Xpe59MvqO7Ub6OumDppqRq890JiF7hA1Ut1Cq///gnXxztOMS+iHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8kNfzJC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8kNfzJC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74DFC4CEC5;
	Thu, 10 Oct 2024 05:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728539299;
	bh=G8+tUJAR725LeI32UIOej8rBnSQ+X+JipgfcuSo/ELo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d8kNfzJCmItWO85BrW53h7Lt4p4qth7MFzgriDibQf3EM6QJK3v0MptawbIklMiuu
	 DG3A8zkEyRoFgmlp9r85Fmhkgx43daq7fkXFG15EOvWr9TGtwdZdtwMXBzJt7plEYN
	 eKrQCNkViwNe//8NVkIErlbZ5ijG6eXP/PaqO9pVG0jTyIBONGpzwKM1UX2lk/kIwk
	 gz8hEa4JWdFN6bZsU7y2WUzlK7Ad5q4V+nHDWvWqswBnMQTpbt9kFK+E6vJ2fSE756
	 8wn54EsdMXD4aFNRHQuMZukpWQiNGzOGa086TdV4+jVVBei6862boC7HHkucOu8KQ6
	 sYkThJOJ9VKaA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 07/15] mptcp: reuse sending nlmsg code in dump_addr
Date: Thu, 10 Oct 2024 13:47:52 +0800
Message-ID: <a60ce63408188b2574dbd6ab3366fde5817d1d2e.1728538976.git.tanggeliang@kylinos.cn>
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
index 0d6e444a9f83..0309f7dbd23b 100644
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
index ad011a4fad4e..8858877d82b0 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -597,20 +597,12 @@ static int mptcp_userspace_pm_set_bitmap(struct mptcp_sock *msk,
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
@@ -618,39 +610,11 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 
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
index 3b3a09f5d7fc..d8870ba24d02 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1123,8 +1123,8 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_in
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
2.43.0

