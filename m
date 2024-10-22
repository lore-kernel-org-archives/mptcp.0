Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53168120D
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588527; cv=none; b=NzEnv5yz1EokzfMH0AWrkqPKSRKvGeJlrnr+QEa7oXEkYddteObuRRjZG2oKByw0yPrmTToa+iFfIORBYQYVmaS3a0rjRX4tY9eUAL0ntJg3+Zp4WrGwksdjZjdYhEBf/pJfls4vFSi0/++3QoXso568NhDDMJpQ7+vk2QnOLUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588527; c=relaxed/simple;
	bh=9Pk5wYY+X+QMjq60iMJExGGBNks8DQGMyNC6bKH2zyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9b5NNAsi02W3lu2vh8uqTJ6RGSbWrcDrI9zKzBxYgXJCGjvV9hxrh6ACMxjf3fN5/jIxquMvHGOsPxijlAhSJmuWXoyTE3ZsiwjlHAr7mj/ic7mOuajkIBwfRvWZxiXZnEkzqW5R6oQrjame8DPRn/aVQEt6v2/7UJs6qO4pOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPVMlZKn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPVMlZKn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC10C4CEE3;
	Tue, 22 Oct 2024 09:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588526;
	bh=9Pk5wYY+X+QMjq60iMJExGGBNks8DQGMyNC6bKH2zyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QPVMlZKnbNuxA6DRAx4RI5sF3PLDQDgelUERQo2W7FPu0dg5UCjp7PP+MuHa+s17v
	 6KbRj5gdRIvXLRvZi9haMLK76dXZUbCNe8EsZvtaGXshYSEzGPdUKWaczSITs157Gq
	 lbD7Muhsd18C4kXXJgJX3eG8l/O6Bj7WxNdLr4vJggXOXuRL/0gR8BRK8qppjdV+HD
	 SMDyfY9JFAlAE+5fKAlJ52N9kNXQxSMfQy/o1dELeFGXnxDvjXRA9YK3rl5uBHsDmz
	 BtGCz2OIOefs54OH2Nxl9kl1OUVMKhpjyxcVUI74M/8yMctkTF1WmV24b8HT6IWG2j
	 Zyu4JSFlekPxg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 21/36] mptcp: update address type of get_local_id
Date: Tue, 22 Oct 2024 17:14:29 +0800
Message-ID: <697ad8ffc8987b12a232b3855e6960b49c186d4b.1729588019.git.tanggeliang@kylinos.cn>
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

The following code in mptcp_userspace_pm_get_local_id() that assigns "skc"
to "new_entry" is not allowed in BPF if we use the same code to implement
the get_local_id() interface of a BFP path manager:

	memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
	new_entry.addr = *skc;
	new_entry.addr.id = 0;
	new_entry.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;

To solve the issue, this patch moves this assignment to "new_entry" forward
to mptcp_pm_get_local_id(), and then passing "new_entry" as a parameter to
both mptcp_pm_nl_get_local_id() and mptcp_userspace_pm_get_local_id().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           | 10 ++++++++--
 net/mptcp/pm_netlink.c   | 11 +++--------
 net/mptcp/pm_userspace.c | 17 ++++++-----------
 net/mptcp/protocol.h     |  4 ++--
 4 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index b6e6859903ef..d28e844eba2d 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -404,6 +404,7 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 {
 	struct mptcp_addr_info skc_local;
 	struct mptcp_addr_info msk_local;
+	struct mptcp_pm_addr_entry local;
 
 	if (WARN_ON_ONCE(!msk))
 		return -1;
@@ -416,9 +417,14 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	if (mptcp_addresses_equal(&msk_local, &skc_local, false))
 		return 0;
 
+	memset(&local, 0, sizeof(struct mptcp_pm_addr_entry));
+	local.addr = skc_local;
+	local.addr.id = 0;
+	local.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
+
 	if (mptcp_pm_is_userspace(msk))
-		return mptcp_userspace_pm_get_local_id(msk, &skc_local);
-	return mptcp_pm_nl_get_local_id(msk, &skc_local);
+		return mptcp_userspace_pm_get_local_id(msk, &local);
+	return mptcp_pm_nl_get_local_id(msk, &local);
 }
 
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 5cd5241da3c6..032c9eb2e48d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1137,7 +1137,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	return err;
 }
 
-int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
+int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_pm_addr_entry *local)
 {
 	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
@@ -1146,7 +1146,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	pernet = pm_nl_get_pernet_from_msk(msk);
 
 	rcu_read_lock();
-	entry = __lookup_addr(pernet, skc);
+	entry = __lookup_addr(pernet, &local->addr);
 	if (entry)
 		ret = entry->addr.id;
 	rcu_read_unlock();
@@ -1158,12 +1158,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	if (!entry)
 		return -ENOMEM;
 
-	entry->addr = *skc;
-	entry->addr.id = 0;
-	entry->addr.port = 0;
-	entry->ifindex = 0;
-	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
-	entry->lsk = NULL;
+	*entry = *local;
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true);
 	if (ret < 0)
 		kfree(entry);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index aa4a5d110376..c749f5dccdf9 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -131,27 +131,22 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
 }
 
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
-				    struct mptcp_addr_info *skc)
+				    struct mptcp_pm_addr_entry *local)
 {
-	struct mptcp_pm_addr_entry *entry = NULL, new_entry;
+	struct mptcp_pm_addr_entry *entry = NULL;
 	__be16 msk_sport =  ((struct inet_sock *)
 			     inet_sk((struct sock *)msk))->inet_sport;
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_userspace_pm_lookup_addr(msk, skc);
+	entry = mptcp_userspace_pm_lookup_addr(msk, &local->addr);
 	spin_unlock_bh(&msk->pm.lock);
 	if (entry)
 		return entry->addr.id;
 
-	memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
-	new_entry.addr = *skc;
-	new_entry.addr.id = 0;
-	new_entry.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
-
-	if (new_entry.addr.port == msk_sport)
-		new_entry.addr.port = 0;
+	if (local->addr.port == msk_sport)
+		local->addr.port = 0;
 
-	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry, true);
+	return mptcp_userspace_pm_append_new_local_addr(msk, local, true);
 }
 
 bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 25d2d3def17a..4ff6b7e37947 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1127,8 +1127,8 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
-int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
-int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_pm_addr_entry *local);
+int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_pm_addr_entry *local);
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
 bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
-- 
2.45.2

