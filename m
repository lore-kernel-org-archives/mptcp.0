Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC51183063
	for <mptcp@lists.linux.dev>; Mon, 30 Sep 2024 09:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727689518; cv=none; b=mwUY5Uo+9hqbWQ5y+jlq4gHisAyKpSuCOdstOr0Y28nyu/K8Z8qXHGI6js3cVl+UfO19ApHrVwUb8t2/un34p9WCwqdzFUEwqGq2EDBHaTpjy3dm4TAd9cfDVio0YqJbtvD+r8whU9DiUMbgjmu7x7FJ5IBXoYdKmDNRxjlcbkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727689518; c=relaxed/simple;
	bh=UrfiO/BI+wNhUFfeuFbMb2KQPnT6X3XTPdXmHWVGqf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=asZ6rv8ICgTcoN0N/lxJk5vXmOk+4RnubgKeAr9T6fghs0pCS7Uxntbud97cbOBcbIRXQZN3SVBffnVq+vBXLcC6vYZbddTgaBlldMcuJmHFPomK1ulzokXZ3dX3rXtS3Hae8q7udqEBOPq36LTsrpClWeWPEKCqaCEbZZZ359Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVMW5uQU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVMW5uQU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E66C4CED2;
	Mon, 30 Sep 2024 09:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727689518;
	bh=UrfiO/BI+wNhUFfeuFbMb2KQPnT6X3XTPdXmHWVGqf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XVMW5uQUQnI7SGS5U6mc7kwBnsPZUuIhGc27oGTKVRAdfUAyucO3Ip51seXi8jpvW
	 xynSautZsKkrhbSYWmjnEIMGPLXiRhbWQpmjPUoIm4DwN9vmPphH5Rw8PMb6Io496z
	 wVCPiPsrge4YjVnhyl30r4KpBr7E40FvBU6TeYIHuS19zMRFuRW767RNwIS0joOV/t
	 vzSsKtJw01Uwu8eN/TY6K+x8XMUSTa9uBMct0PcVvPGtgDJ4xndMNRf34FdwizGDKX
	 atH/ze2xaL2sDHR6KPeLGOUWoX1NOGYW4g2sHMf1oruUw9B1tnw8werB1TUXO4OOwE
	 enquB3LdwzeEg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 6/7] mptcp: reuse sending nlmsg code in dump_addr
Date: Mon, 30 Sep 2024 17:45:01 +0800
Message-ID: <4a02fcd8efa3b13389bc7211f0c75ca335f1755f.1727689369.git.tanggeliang@kylinos.cn>
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

With the previous commit, we can reuse the send_nlmsg() code in
dump_addr interfaces between the netlink PM and userspace PM.
They only need to implement their own dump_addr() interfaces to
hold the different locks, copy the different address lists to an
id bitmap, then release the locks.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 51 +++++++++++++++++++-------------------
 net/mptcp/pm_userspace.c | 53 ++++++----------------------------------
 net/mptcp/protocol.h     |  4 +--
 3 files changed, 35 insertions(+), 73 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d921d1bc0682..777d84a4e0cd 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1862,11 +1862,30 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
-				 struct netlink_callback *cb)
+static int mptcp_pm_nl_dump_addr(struct mptcp_id_bitmap *bitmap,
+				 const struct genl_info *info)
+{
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet(genl_info_net(info));
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
 	int id = cb->args[0];
@@ -1875,13 +1894,8 @@ static int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 
 	bitmap = (struct mptcp_id_bitmap *)cb->ctx;
 
-	if (!id) {
-		struct pm_nl_pernet *pernet = pm_nl_get_pernet(net);
-
-		spin_lock_bh(&pernet->lock);
-		bitmap_copy(bitmap->map, pernet->id_bitmap.map, MPTCP_PM_MAX_ADDR_ID + 1);
-		spin_unlock_bh(&pernet->lock);
-	}
+	if (!id)
+		mptcp_pm_dump_addr(bitmap, info);
 
 	for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
 		if (test_bit(i, bitmap->map)) {
@@ -1890,7 +1904,7 @@ static int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 				break;
 			}
 
-			if (entry.addr.id <= id)
+			if (id && entry.addr.id <= id)
 				continue;
 
 			hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
@@ -1913,21 +1927,6 @@ static int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
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
index de552ba542f6..b17cf8cd698c 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -625,22 +625,15 @@ int mptcp_userspace_pm_set_flags(struct genl_info *info)
 	return ret;
 }
 
-int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
-				 struct netlink_callback *cb)
+int mptcp_userspace_pm_dump_addr(struct mptcp_id_bitmap *bitmap,
+				 const struct genl_info *info)
 {
-	const struct genl_info *info = genl_info_dump(cb);
-	struct net *net = sock_net(msg->sk);
-	struct mptcp_pm_addr_entry entry;
-	struct mptcp_id_bitmap *bitmap;
+	struct net *net = genl_info_net(info);
 	struct mptcp_sock *msk;
 	struct nlattr *token;
-	int id = cb->args[0];
 	int ret = -EINVAL;
 	struct sock *sk;
-	void *hdr;
-	int i;
 
-	bitmap = (struct mptcp_id_bitmap *)cb->ctx;
 	token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 
 	msk = mptcp_token_get_sock(net, nla_get_u32(token));
@@ -656,41 +649,11 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 		goto out;
 	}
 
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
-			if (mptcp_userspace_pm_get_addr(i, &entry, info)) {
-				GENL_SET_ERR_MSG(info, "address not found");
-				break;
-			}
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
 
 out:
 	sock_put(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index be2028ffebde..0a4edb7ee1ed 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1125,8 +1125,8 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_in
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

