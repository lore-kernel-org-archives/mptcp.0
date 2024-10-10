Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCE118C03D
	for <mptcp@lists.linux.dev>; Thu, 10 Oct 2024 05:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728539296; cv=none; b=gvmEeRd0qkOdvQvqEEVbAvrD+zZWCmH54MTyAlWuVkraWby4jcu7GknFa8j8c8xCQ9AEOt3C09WdrxnKXAbjyh23ZR6Ys6lNIQQjeQ6PmZg/LGUZICZW7l5OiZmPiqNipNa27kn0M0OHbP7IZrbuCXlP/RE5Q8z8uZxscyImSzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728539296; c=relaxed/simple;
	bh=ljjUaWKZc+i/syNmXA6JKF/TvcFFrRPCv1RVTRgAjAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1nUtjICn42MJ5+TtUrITwxFK14Z39vECWvg7N2fwuEHLQrInhsF/NzZXLz8FfrED9aSUdi9NektR1vn10gkvckQnZTdD0TGxdb+XujkvtH4F/cPOnXZBEBumP5py0Jt38XB2aKu/oo0ETjcIQr+g24Cv5LIb5u1x75p93rJCmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R358iydt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R358iydt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C170CC4CEC5;
	Thu, 10 Oct 2024 05:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728539296;
	bh=ljjUaWKZc+i/syNmXA6JKF/TvcFFrRPCv1RVTRgAjAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R358iydtV+rK+i5sHZhXP9d7L3HqAktRoqok9K8NvsD9DP0zogPwEtji4qSYMwx4H
	 Q77MDie1u1C9KBiWKhJpug5t7XYCtCi1PUWdv+l8nzdFJ0cuuRzCD9MsY+0T10cceB
	 3KfT4aTnxXtZ6yXyJisWu0SnItDrSa5SsWj81WhvcGg42KPKmKkvJ0j8Wbfly2MVAQ
	 2B9Ykro/maPe06xB6m83uXoGaUHLUAvfyWvRzzq66RHF1sUNwjRBHIv87ybfga9tU5
	 M5DYrCR8qnix5xaF8602SbgNUPjRdtlAtkieG+n4m3I/HoCm6kPRYORXhUdJ8iW0w0
	 z2nktjdOMP/zg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 05/15] mptcp: refactor dump_addr with id bitmap
Date: Thu, 10 Oct 2024 13:47:50 +0800
Message-ID: <09fd7d78f9fbade68d72d1c1038fa476d47f7b50.1728538976.git.tanggeliang@kylinos.cn>
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
index 2888e4b303c0..9a544cf47a2b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1869,16 +1869,20 @@ static int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
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

