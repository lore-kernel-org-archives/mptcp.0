Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C00B22C6DC
	for <mptcp@lists.linux.dev>; Sat,  7 Dec 2024 01:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733533699; cv=none; b=jFZ1t5W7RdMNdlRpgotIywaEMtefveBj/hUtgN0eFxRl1aAb57EroPuT33fRvQz9E9E+MqrrNuFx3UJ95GJztKh6D2ei7db8eyGug2jcHANcTUY2M9yAiuLoFcLoZrJ6w0385/NyxjJCaJ8CAJitYg2c+V1zf+nRmLIDrO3c/5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733533699; c=relaxed/simple;
	bh=gwt2KH+LvrEn821v0dBq/BqW3QDkNIQLjCr/zqpXe0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OR5khSpIJ2GpVoHIgSfbKaJltMFHBU8lOPWxmcfhgF9ErgC/L8CnixYlny+UxYheIXX0uExqNP+UXOX5GF8pWtTdOcwSSE0TyJ0gHlOVyR9B7+cRfDh1QiilywUdaLXWT3XM7oMbz4JqkmCE0csga/TPIbWCPbFpFkMhbcHoF3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNiWZK7G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNiWZK7G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776DCC4CEDF;
	Sat,  7 Dec 2024 01:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733533699;
	bh=gwt2KH+LvrEn821v0dBq/BqW3QDkNIQLjCr/zqpXe0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FNiWZK7G9iq3IREkFdRpVr32S2GEpBDQOzcmpMcDrFs3HNOIWaI9pek4iSHcc52gv
	 8vYClpoE8mZ5SmTv8h1z5u0CGpzzOl7ir8bo/wKh+Hoa7/G12ZaCdjQ/R52WwgY+Lt
	 3zo+vIzoDPMqhwf26aIV1oO1+tBSs2ZcuqLxWYQCPg/OB9/xFElP1ysUaMNZ999xTe
	 261x6gLv6cWUOL+luwbNw87FVzi0PI6jNWrKMIxWnDzV3u8fg0RWlYwREgqHFlOopN
	 wkiQsU7Jlz9GnX4Im9iRALH0VBVtO1Wr/ewxkPyS+rKlxuRqgSzxDda+1t2KWJ/ri/
	 BNwQ0Op153a+g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 7/7] mptcp: reuse sending nlmsg code in dump_addr
Date: Sat,  7 Dec 2024 09:07:27 +0800
Message-ID: <7b12fbbff77bbdbddbb06bb5207df219e105668f.1733533215.git.geliang@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733533215.git.geliang@kernel.org>
References: <cover.1733533215.git.geliang@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

A new type mptcp_pm_addr_id_bitmap_t is defined to easily modify
dump_addr() interface of the path managers to accept an id_bitmap
type parameter. It also allows this parameter of dump_addr() can
be modified by BPF program when implementing this interface of a
BFP path manager.

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
 include/net/mptcp.h      |  7 +++++++
 net/mptcp/pm.c           | 42 +++++++++++++++++++++++++++++++++++----
 net/mptcp/pm_netlink.c   | 35 +++-----------------------------
 net/mptcp/pm_userspace.c | 43 ++++++++++++++--------------------------
 net/mptcp/protocol.h     |  9 ++-------
 5 files changed, 65 insertions(+), 71 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 814b5f2e3ed5..220b1f60e8c1 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -120,6 +120,13 @@ struct mptcp_sched_ops {
 	void (*release)(struct mptcp_sock *msk);
 } ____cacheline_aligned_in_smp;
 
+/* max value of mptcp_addr_info.id */
+#define MPTCP_PM_MAX_ADDR_ID		U8_MAX
+
+typedef struct {
+	DECLARE_BITMAP(map, MPTCP_PM_MAX_ADDR_ID + 1);
+} mptcp_pm_addr_id_bitmap_t;
+
 #ifdef CONFIG_MPTCP
 void mptcp_init(void);
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 0aaf16319c34..b862a8e4c706 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -485,20 +485,54 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
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
 
-	return mptcp_pm_dump_addr(msg, cb, info);
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
+	}
+
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
index 7dc417255e8f..dd6a1f62c268 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -614,20 +614,25 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
-				 struct netlink_callback *cb,
-				 const struct genl_info *info)
+static int mptcp_userspace_pm_reset_bitmap(struct mptcp_sock *msk,
+					   mptcp_pm_addr_id_bitmap_t *bitmap)
 {
-	struct id_bitmap {
-		DECLARE_BITMAP(map, MPTCP_PM_MAX_ADDR_ID + 1);
-	} *bitmap;
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
-	bitmap = (struct id_bitmap *)cb->ctx;
 
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
@@ -637,27 +642,9 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 
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
index 1f9c66f53865..ed629320ba56 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -208,9 +208,6 @@ enum mptcp_addr_signal_status {
 	MPTCP_RM_ADDR_SIGNAL,
 };
 
-/* max value of mptcp_addr_info.id */
-#define MPTCP_PM_MAX_ADDR_ID		U8_MAX
-
 struct mptcp_pm_data {
 	struct mptcp_addr_info local;
 	struct mptcp_addr_info remote;
@@ -1127,11 +1124,9 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_in
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

