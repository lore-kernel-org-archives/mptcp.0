Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B73188CC9
	for <mptcp@lists.linux.dev>; Fri, 13 Dec 2024 07:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734075354; cv=none; b=laJ0FHM1BMVmJ6cyZaoV6h4aFuEbpkqV/V1LSMBDw/D2ey1b+R30WDVEadaqTgebJqrZF7MjKnKVs0ClnHpb80UVbsv4QIJCifqcRogz+k3lO1gb/n5yVAIlHm0Hmz2ArpVpfKRgtHYDvC0CgmcYRkASeq5YO1xx7SP7tcNBUPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734075354; c=relaxed/simple;
	bh=4qlIe3plnXxnoCAfoAXspEXjYeFyZXnr92u5oCbCKro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=al0EzQzF/xiY9uBA9g5hOGAos7ITAUPosUitBreEYJ4gyhxBZMdxASKj4tgvLFk3WEtiY0zIRjzZvWo1jXsboePWdsrgu/5nYA3xqHIBKz/xLHhtwP/xokuOANBk6Gs2u94+h6lW5CZzT2y440lf44P6T6JM7/qmW+yjlGLEK/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3Wtbcvk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3Wtbcvk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C66C4CED0;
	Fri, 13 Dec 2024 07:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734075354;
	bh=4qlIe3plnXxnoCAfoAXspEXjYeFyZXnr92u5oCbCKro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C3Wtbcvkm7kz6cbcAStTZc5YCtVFZZ6HslcsZ1w2An0YOFGrRd5XhTa/YED+kubD2
	 G+BRtMvjfmGiSs05SfvrSV+uTDhaXGkVYuhYXtHvBEky6yLLN/VE5SnHfKExYdLcsL
	 efrfpYt4TpUQQsiQTa2nx8w+vXttjBoM02P4H7I1e3rs/vVAmpAqOYP7AF+WE+e1bS
	 oF9oa8isRrhaW9xOyZKrmSoXdC2I/DnG0cguxBzHYB0v8FQ+fdv3E8Jk2XsVPIayS1
	 aBXQGHPvSGk/xbwULVMYJkNm51UBMCJwkEJdcnfiG/jOtxfbl2BEYSCkok872ODid3
	 OjOQhDnQOJWrg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 8/8] mptcp: reuse sending nlmsg code in dump_addr
Date: Fri, 13 Dec 2024 15:35:29 +0800
Message-ID: <8d1c6172111ac7a9d140e451233b6baa15481e07.1734074788.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1734074788.git.tanggeliang@kylinos.cn>
References: <cover.1734074788.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

With the help of get_addr(), we can modify dump_addr() interfaces
to reuse send_nlmsg code between the netlink PM and userspace PM.

The current dump_addr() flow looks like this:

	lock();
	for_each_entry(entry)
		send_nlmsg(entry);
	unlock();

After holding the lock, get every entry by walking the address list,
send each one looply, and finally release the lock.

This set changes the process by copying the address list to an id
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

With this, we can reuse the send_nlmsg() code in dump_addr() interfaces
between the netlink PM and userspace PM. They only need to implement
their own dump_addr() interfaces to hold the different locks, copy the
different address lists to an id bitmap, then release the locks.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           | 43 ++++++++++++++++++++++++++++++++++++----
 net/mptcp/pm_netlink.c   | 35 +++-----------------------------
 net/mptcp/pm_userspace.c | 41 ++++++++++++++------------------------
 net/mptcp/protocol.h     |  6 ++----
 4 files changed, 59 insertions(+), 66 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 0aaf16319c34..22c0ca77ca0d 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -485,20 +485,55 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb,
+static int mptcp_pm_dump_addr(mptcp_pm_addr_id_bitmap_t *bitmap,
 			      const struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_dump_addr(msg, cb, info);
-	return mptcp_pm_nl_dump_addr(msg, cb, info);
+		return mptcp_userspace_pm_dump_addr(bitmap, info);
+	return mptcp_pm_nl_dump_addr(bitmap, info);
 }
 
 int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
 				struct netlink_callback *cb)
 {
 	const struct genl_info *info = genl_info_dump(cb);
+	mptcp_pm_addr_id_bitmap_t *bitmap;
+	struct mptcp_pm_addr_entry entry;
+	int id = cb->args[0];
+	void *hdr;
+	int i;
+
+	bitmap = (mptcp_pm_addr_id_bitmap_t *)cb->ctx;
+
+	mptcp_pm_dump_addr(bitmap, info);
+
+	for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
+		if (test_bit(i, bitmap->map)) {
+			if (mptcp_pm_get_addr(i, &entry, info))
+				break;
+
+			if (id && entry.addr.id <= id)
+				continue;
+
+			hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
+					  cb->nlh->nlmsg_seq,
+					  &mptcp_genl_family, NLM_F_MULTI,
+					  MPTCP_PM_CMD_GET_ADDR);
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
+	}
 
-	return mptcp_pm_dump_addr(msg, cb, info);
+	cb->args[0] = id;
+	return msg->len;
 }
 
 static int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 0d826bfc4718..831c440d6cc5 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1783,48 +1783,19 @@ int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 	return ret;
 }
 
-int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
-			  struct netlink_callback *cb,
+int mptcp_pm_nl_dump_addr(mptcp_pm_addr_id_bitmap_t *bitmap,
 			  const struct genl_info *info)
 {
 	struct net *net = genl_info_net(info);
-	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
-	int id = cb->args[0];
-	void *hdr;
-	int i;
 
 	pernet = pm_nl_get_pernet(net);
 
 	rcu_read_lock();
-	for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
-		if (test_bit(i, pernet->id_bitmap)) {
-			entry = __lookup_addr_by_id(pernet, i);
-			if (!entry)
-				break;
-
-			if (entry->addr.id <= id)
-				continue;
-
-			hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
-					  cb->nlh->nlmsg_seq, &mptcp_genl_family,
-					  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
-			if (!hdr)
-				break;
-
-			if (mptcp_nl_fill_addr(msg, entry) < 0) {
-				genlmsg_cancel(msg, hdr);
-				break;
-			}
-
-			id = entry->addr.id;
-			genlmsg_end(msg, hdr);
-		}
-	}
+	bitmap_copy(bitmap->map, pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	rcu_read_unlock();
 
-	cb->args[0] = id;
-	return msg->len;
+	return 0;
 }
 
 static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 0d9bea3a04a2..0db477b703a5 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -614,18 +614,25 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
-				 struct netlink_callback *cb,
-				 const struct genl_info *info)
+static int mptcp_userspace_pm_reset_bitmap(struct mptcp_sock *msk,
+					   mptcp_pm_addr_id_bitmap_t *bitmap)
 {
-	mptcp_pm_addr_id_bitmap_t *bitmap;
 	struct mptcp_pm_addr_entry *entry;
+
+	bitmap_zero(bitmap->map, MPTCP_PM_MAX_ADDR_ID + 1);
+
+	mptcp_for_each_userspace_pm_addr(msk, entry)
+		__set_bit(entry->addr.id, bitmap->map);
+
+	return 0;
+}
+
+int mptcp_userspace_pm_dump_addr(mptcp_pm_addr_id_bitmap_t *bitmap,
+				 const struct genl_info *info)
+{
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
 	struct sock *sk;
-	void *hdr;
-
-	bitmap = (mptcp_pm_addr_id_bitmap_t *)cb->ctx;
 
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
@@ -635,27 +642,9 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
-	mptcp_for_each_userspace_pm_addr(msk, entry) {
-		if (test_bit(entry->addr.id, bitmap->map))
-			continue;
-
-		hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
-				  cb->nlh->nlmsg_seq, &mptcp_genl_family,
-				  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
-		if (!hdr)
-			break;
-
-		if (mptcp_nl_fill_addr(msg, entry) < 0) {
-			genlmsg_cancel(msg, hdr);
-			break;
-		}
-
-		__set_bit(entry->addr.id, bitmap->map);
-		genlmsg_end(msg, hdr);
-	}
+	ret = mptcp_userspace_pm_reset_bitmap(msk, bitmap);
 	spin_unlock_bh(&msk->pm.lock);
 	release_sock(sk);
-	ret = msg->len;
 
 	sock_put(sk);
 	return ret;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index da2cf524c5da..ed629320ba56 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1124,11 +1124,9 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_in
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
 bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
-int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
-			  struct netlink_callback *cb,
+int mptcp_pm_nl_dump_addr(mptcp_pm_addr_id_bitmap_t *bitmap,
 			  const struct genl_info *info);
-int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
-				 struct netlink_callback *cb,
+int mptcp_userspace_pm_dump_addr(mptcp_pm_addr_id_bitmap_t *bitmap,
 				 const struct genl_info *info);
 int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 			 const struct genl_info *info);
-- 
2.45.2

