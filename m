Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEF120514E
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069994; cv=none; b=hCpxgqax0tfufwfTHR8nP1XChIyjY/P2lNcZ1+oeM3RSELoiaGEtIn+vDOosblV5/PpBDfxmUM/MpYGrTw3yQPqdRvzR2qNJoViKaACohm0HEjEtI4+xLn4dIGfMtv4baPBTvTqtm6oCvFTG3IzCBPAXumSkWqHpnZNLBnepVZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069994; c=relaxed/simple;
	bh=/GqgaJcUqu0tz6qZmEONTuvOkPl7y+qfYB2f2pueq0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfDdMcLE8GKhESgX2TTzbhwh4qDLTjc0QVz7hDIIXuwCZDSlt0gj7S6ZH8R8hViMPdbnDFyFnduphcAgocj53k3IUU1FztMDjJqAiI/TK4lb7DqFq3eK1J49QbnxQPU77u6X1YO1IgVjhtA0VuE3+4AMHtlye9sdyFULAvS6bf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHFzzKdK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHFzzKdK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017B8C4CEC5;
	Wed, 16 Oct 2024 09:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729069994;
	bh=/GqgaJcUqu0tz6qZmEONTuvOkPl7y+qfYB2f2pueq0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VHFzzKdKd6gXZnMbN6TGXlLn5uXq3zugdI3gy6+i4yeDJukH2lSy7oWX08KBjvF82
	 WQiUu06ULetPXK4V1fLO2S1WLd1y/jiYhcZXQ3BWAfQrzBVCIPOroriztn+nVaXnD4
	 qURRYpD6Da1SRyzs3n1I83VtnuxoMf+oKYfX/BEmvrOSCYkkp4PfVigw8n7CPwQ7uj
	 QtsuifGjK5lnhf+l9f/5X0SfTFS9RUv57J9iSfpeLqA3wcSa/b6bbaZJedeE+xiQp3
	 +kwdENRWQ2lhN6GugCOWkrtHRnFDa8bdw2MO5s8kWH4onECR5Mmo0J7jJBqoYcLReJ
	 eiIMu+00BqfuQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 16/33] mptcp: reuse sending nlmsg code in dump_addr
Date: Wed, 16 Oct 2024 17:12:20 +0800
Message-ID: <3da78d9b13772018e51dc500febbe145e8c06623.1729069854.git.tanggeliang@kylinos.cn>
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
index ce6385d8fdb4..558a7da8d995 100644
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
index 5d050d284930..9ac39781a681 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1128,8 +1128,8 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_in
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

