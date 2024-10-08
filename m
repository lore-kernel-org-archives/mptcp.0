Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B2018C35A
	for <mptcp@lists.linux.dev>; Tue,  8 Oct 2024 09:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381514; cv=none; b=nAf30MfiWhBlBvO2fxRWZSqqaQGoNDkmQtlxrVnHmskAeIt6xqsMsVP4e8fun7WRZj9rpGGS+W02PxGW48cefZ6pIDlDYJ8YustNxOkGiPSmr92012cnDsCrBsOI7NUbymQqxmIR2EYbfA55MpZgmcaWdIKBAdwPetX09HlmOkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381514; c=relaxed/simple;
	bh=8QCAb4ToExdilyQy6Bppll54+qw2gcRjAPPMFY8K6h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DcBXlxEMXABThiUk6uKiPLWqTErCjm/uOeqJmvv9PQFkVnPM0nL8WloXz9yn4gGaT2dvySYLlZOD5pjHKP3/1GvRmK+ocwRxiIOCouPxfWOo9YeCdvuNUjL2QTAv8yLyfAEJHvcTv2SzJQSNt7Q+YX3JMzrZfdzINQ+0t0AG2sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdRCfZLn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdRCfZLn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69819C4CEC7;
	Tue,  8 Oct 2024 09:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728381514;
	bh=8QCAb4ToExdilyQy6Bppll54+qw2gcRjAPPMFY8K6h0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VdRCfZLnvOBtvxL8VRPQuwf8fRY8SuxH2ZJjmHg/Dgif4sLCPhZpznLVsxv5oEPUP
	 Ilw7AMsOsQPXckEFBnC0p/Eh/z0DJoKRstW9mGB09d2qrA7tBSmoEQEuMb4saM7egr
	 rowZJ8oweSIG7Q5D6z/p66cM4WU+3uXd1IRvzR9W8gTTULvjXLaQTiRIc7MJIgFd4X
	 /tUMti2+Ow8nUacOFbQlV03Puwwtqny/NRjkSUMBYLpL+IU6GmyiaFYjnpmsG/xAJA
	 La5z1vmk4Z6jVb8cK3Yfxu0r3O8Zyqb7xytUF0aVpyWKk+RhmAqzNBUPaaDEJLxHhF
	 vJdt1YZ2lahYw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 05/13] mptcp: refactor dump_addr with id bitmap
Date: Tue,  8 Oct 2024 17:58:09 +0800
Message-ID: <1e7ae17f94e8cc843e401460928b6ef24f1f50a4.1728381245.git.tanggeliang@kylinos.cn>
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

With the help of get_addr(), we can refactor dump_addr() interfaces to
reuse send_nlmsg code between the netlink PM and userspace PM.

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
every copy of entry by using get_addr(), and send each one looply.

This patch is the first part of refactoring dump_addr().

Without changing the position of the locks, the dump process is split
into two parts: copying the ID bitmap first, and then traversing the
ID bitmap, use lookup_addr_by_id() to get the entry, then send each
one through nlmsg:

	lock();
	for_each_entry(entry)
		set_bit(bitmap);
	for_each_bit(bitmap) {
		entry = lookup_addr_by_id();
		send_nlmsg(entry);
	}
	unlock();

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   |  6 ++++-
 net/mptcp/pm_userspace.c | 54 +++++++++++++++++++++++++++++-----------
 2 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2ab966393c55..9d502ab4d91d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1868,16 +1868,20 @@ static int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 {
 	struct net *net = sock_net(msg->sk);
 	struct mptcp_pm_addr_entry *entry;
+	struct mptcp_id_bitmap *bitmap;
 	struct pm_nl_pernet *pernet;
 	int id = cb->args[0];
 	void *hdr;
 	int i;
 
+	bitmap = (struct mptcp_id_bitmap *)cb->ctx;
 	pernet = pm_nl_get_pernet(net);
 
 	spin_lock_bh(&pernet->lock);
+	if (!id)
+		bitmap_copy(bitmap->map, pernet->id_bitmap.map, MPTCP_PM_MAX_ADDR_ID + 1);
 	for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
-		if (test_bit(i, pernet->id_bitmap.map)) {
+		if (test_bit(i, bitmap->map)) {
 			entry = __lookup_addr_by_id(pernet, i);
 			if (!entry)
 				break;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 373ff0186bee..2f1afb719ecf 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -582,6 +582,21 @@ int mptcp_userspace_pm_set_flags(struct genl_info *info)
 	return ret;
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
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb)
 {
@@ -589,9 +604,11 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_id_bitmap *bitmap;
 	struct mptcp_sock *msk;
+	int id = cb->args[0];
 	int ret = -EINVAL;
 	struct sock *sk;
 	void *hdr;
+	int i;
 
 	bitmap = (struct mptcp_id_bitmap *)cb->ctx;
 
@@ -603,24 +620,33 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (test_bit(entry->addr.id, bitmap->map))
-			continue;
+	if (!id)
+		ret = mptcp_userspace_pm_set_bitmap(msk, bitmap);
+	for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
+		if (test_bit(i, bitmap->map)) {
+			entry = mptcp_userspace_pm_lookup_addr_by_id(msk, i);
+			if (!entry)
+				break;
+
+			if (id && entry->addr.id <= id)
+				continue;
 
-		hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
-				  cb->nlh->nlmsg_seq, &mptcp_genl_family,
-				  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
-		if (!hdr)
-			break;
+			hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
+					  cb->nlh->nlmsg_seq, &mptcp_genl_family,
+					  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
+			if (!hdr)
+				break;
 
-		if (mptcp_nl_fill_addr(msg, entry) < 0) {
-			genlmsg_cancel(msg, hdr);
-			break;
-		}
+			if (mptcp_nl_fill_addr(msg, entry) < 0) {
+				genlmsg_cancel(msg, hdr);
+				break;
+			}
 
-		__set_bit(entry->addr.id, bitmap->map);
-		genlmsg_end(msg, hdr);
+			id = entry->addr.id;
+			genlmsg_end(msg, hdr);
+		}
 	}
+	cb->args[0] = id;
 	spin_unlock_bh(&msk->pm.lock);
 	release_sock(sk);
 	ret = msg->len;
-- 
2.43.0

