Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE4B2BB09
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588509; cv=none; b=XPvS7/myk+y4nulzida1/BkuTTvpMkaQE6yGWdavNXPqee+eiQYKyoLWFBWNPWMg19yiHhoJL/9AozLFXF97KhOOBhhKiTeBH17oOBd9zQ2px2MYRz5Tj0/ZUHZUwRtfUQ+UGGhfi/g1or5zyXBxeM+8WCyz0Ac5R72phxf7vAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588509; c=relaxed/simple;
	bh=rnjq03QbUQsTb+fneYzboTolCRVkWS3DCNBKsYmXCLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUjDcpch4WD1BzcwWTvdWi05L+YclZngf2SLNg/XkBmTWzuOtCFi3bO0WZJZ0snOnBKbspM9tJtDwiQNumjLUIesewOgGZxRNiXkXoz+UwVNE++ypdRmtumC2/zNIUa8bGqxmfDoPuiaXIjjFMELxw74BdhOT/5IBG63IgaeaEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXggbb5J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXggbb5J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E141CC4CEC3;
	Tue, 22 Oct 2024 09:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588509;
	bh=rnjq03QbUQsTb+fneYzboTolCRVkWS3DCNBKsYmXCLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BXggbb5JMs7eawjkOX4BipSxD2EYukXR+NuMVsm1F7AQkpmM4/L4BoRuZsZXt8p5l
	 sp5W+yrscYFdMhRlsnvQkIj+Q3FvrUPaKNf2RiwW2acL5A1PfImSiZz01LBiEtWNzk
	 seplOOG6Uwu2l9P+hycPPziLVq5MoAiJn3HXV+kY1tHZ7xSqUp90qqcrdE89XUexq2
	 DmwxiNQh2V3vctbNp4il22jDqSUoINv1M4/OaoTpTK1ee6Ro4uP2aEbs3YbfyPKFmT
	 QHg8nJnEOGxwPVkJEHmCVvnYHPsksH8OmcXFvevWC8NlKcWWwRIqQHrfdPg12JjJG2
	 Jf93Jqay1ZrIA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 10/36] mptcp: add addr parameter for get_addr
Date: Tue, 22 Oct 2024 17:14:18 +0800
Message-ID: <a281cec1038c044cb746609e6fbaab331a751241.1729588019.git.tanggeliang@kylinos.cn>
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

The netlink messages are sent both in mptcp_pm_nl_get_addr() and
mptcp_userspace_pm_get_addr(), this makes the code somewhat repetitive.
This is because the netlink PM and userspace PM use different locks to
protect the address entry that needs to be sent via the netlink message.
The former uses pernet->lock, and the latter uses msk->pm.lock.

The current get_addr() flow looks like this:

	lock();
	entry = get_entry();
	send_nlmsg(entry);
	unlock();

After holding the lock, get the entry from the list, send the entry, and
finally release the lock.

This patch changes the process by getting the entry while holding the lock,
then making a copy of the entry so that the lock can be released. Finally,
the copy of the entry is sent without locking:

	lock();
	entry = get_entry();
	*copy = *entry;
	unlock();

	send_nlmsg(copy);

This way we can reuse this send_nlmsg() code between the netlink PM and
userspace PM.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 33 ++++++++++++++++++---------------
 net/mptcp/pm_userspace.c | 24 +++++++++++++-----------
 net/mptcp/protocol.h     |  3 ++-
 3 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9a886caa336e..bfd8bc3dfb86 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1792,13 +1792,14 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-static int mptcp_pm_nl_get_addr(u8 id, struct genl_info *info)
+static int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
+				struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry *entry;
 	struct sk_buff *msg;
+	int ret = -EINVAL;
 	void *reply;
-	int ret;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
@@ -1814,34 +1815,36 @@ static int mptcp_pm_nl_get_addr(u8 id, struct genl_info *info)
 
 	spin_lock_bh(&pernet->lock);
 	entry = __lookup_addr_by_id(pernet, id);
-	if (!entry) {
+	if (entry) {
+		*addr = *entry;
+		ret = 0;
+	}
+	spin_unlock_bh(&pernet->lock);
+
+	if (ret) {
 		GENL_SET_ERR_MSG(info, "address not found");
-		ret = -EINVAL;
-		goto unlock_fail;
+		goto fail;
 	}
 
-	ret = mptcp_nl_fill_addr(msg, entry);
+	ret = mptcp_nl_fill_addr(msg, addr);
 	if (ret)
-		goto unlock_fail;
+		goto fail;
 
 	genlmsg_end(msg, reply);
 	ret = genlmsg_reply(msg, info);
-	spin_unlock_bh(&pernet->lock);
 	return ret;
 
-unlock_fail:
-	spin_unlock_bh(&pernet->lock);
-
 fail:
 	nlmsg_free(msg);
 	return ret;
 }
 
-static int mptcp_pm_get_addr(u8 id, struct genl_info *info)
+static int mptcp_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
+			     struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_get_addr(id, info);
-	return mptcp_pm_nl_get_addr(id, info);
+		return mptcp_userspace_pm_get_addr(id, addr, info);
+	return mptcp_pm_nl_get_addr(id, addr, info);
 }
 
 int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
@@ -1854,7 +1857,7 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		return ret;
 
-	ret = mptcp_pm_get_addr(addr.addr.id, info);
+	ret = mptcp_pm_get_addr(addr.addr.id, &addr, info);
 	return ret;
 }
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 079baceb9ca1..d1f2b592b47c 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -632,7 +632,8 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	return ret;
 }
 
-int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info)
+int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
+				struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
@@ -664,26 +665,27 @@ int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info)
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
-	if (!entry) {
+	if (entry) {
+		*addr = *entry;
+		ret = 0;
+	}
+	spin_unlock_bh(&msk->pm.lock);
+	release_sock(sk);
+
+	if (ret) {
 		GENL_SET_ERR_MSG(info, "address not found");
-		ret = -EINVAL;
-		goto unlock_fail;
+		goto fail;
 	}
 
-	ret = mptcp_nl_fill_addr(msg, entry);
+	ret = mptcp_nl_fill_addr(msg, addr);
 	if (ret)
-		goto unlock_fail;
+		goto fail;
 
 	genlmsg_end(msg, reply);
 	ret = genlmsg_reply(msg, info);
-	spin_unlock_bh(&msk->pm.lock);
-	release_sock(sk);
 	sock_put(sk);
 	return ret;
 
-unlock_fail:
-	spin_unlock_bh(&msk->pm.lock);
-	release_sock(sk);
 fail:
 	nlmsg_free(msg);
 out:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6326e8f4bf5c..ffc18646976b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1128,7 +1128,8 @@ bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
-int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info);
+int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
+				struct genl_info *info);
 
 static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
 {
-- 
2.45.2

