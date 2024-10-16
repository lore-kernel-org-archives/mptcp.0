Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE148205145
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069990; cv=none; b=oyTXLbcBzN1jlfTljvL86NJhkpXgJtZmz2+h5GmihIKlcGBQEV1ZmFcguuPxaPeeJqX5rZhLwXJhjB+MflQw/VXDT+A+HhqFF8e5oDqyu1Wg54LJCKsrR8yKQyHJ34xdrH2I7qfPY+LeLI0V6fcLTfK5PywkMDNsSogfrYaPcpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069990; c=relaxed/simple;
	bh=Ph8tZq87IS+7lVLVzP9KA5mELMgiXG30fYoH5AZQIi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpDdKexjeCsYKJeCbGdhg4fuE3AsiL/nioMtd0XPwsphhbIM6/aJZj3NPBTDA1BAeB0dNYoweU4Cjs3j42hqsdMwb5hbN17vVv1xAlQyO2SsxxZZ8J4dMWlKr7UdK1AV71Mh+pfJcR+yle12SjIokm4TyR0sUMoXUpZKYrVfaxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ux4XjVmr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ux4XjVmr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EDBCC4CECE;
	Wed, 16 Oct 2024 09:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729069990;
	bh=Ph8tZq87IS+7lVLVzP9KA5mELMgiXG30fYoH5AZQIi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ux4XjVmr/K978qfCyimYfsdbST9KmhbIo/Udi/OGbX4Z6CLiR1DNZFfR8m/dYgxtC
	 /+D0jwohh26IIsqrl2BsgKavF5tLLrGr1RSPUhBUWVR+8mkS5TxgfLkv8IQA28rKMS
	 LRr7I6xjk/tAlDnqQhK6HjDvPa2hH+ONyxH/w9uOeKm9XD6eOdO6IGhw9uEJjpEvDm
	 buMe9mY5nMIwLDsjVb+gRC/YpyYL9GXS1/m69/rUUX3KR7g1lc6EUCqN44IIXLwKij
	 HmB8R2LLYbKdEaJKL4C2dzkMxQJkHY/yQ1UbHGXncv6AXMn3aDpnqVqhJDiASsEQNh
	 ZFTuZYWiOHIcA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 14/33] mptcp: refactor dump_addr with id bitmap
Date: Wed, 16 Oct 2024 17:12:18 +0800
Message-ID: <017c79b8733dbca0a81621cec202c6817e79f751.1729069854.git.tanggeliang@kylinos.cn>
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
index 75c07db55409..0f107564fcfd 100644
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
index cb4f2a174d0d..237383cfd12e 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -583,6 +583,21 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+static int mptcp_userspace_pm_set_bitmap(struct mptcp_sock *msk,
+					 struct mptcp_id_bitmap *bitmap)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	mptcp_for_each_address(msk, entry) {
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
@@ -590,9 +605,11 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_id_bitmap *bitmap;
 	struct mptcp_sock *msk;
+	int id = cb->args[0];
 	int ret = -EINVAL;
 	struct sock *sk;
 	void *hdr;
+	int i;
 
 	bitmap = (struct mptcp_id_bitmap *)cb->ctx;
 
@@ -604,24 +621,33 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
-	mptcp_for_each_address(msk, entry) {
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

