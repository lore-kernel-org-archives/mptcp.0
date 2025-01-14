Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AE022DC20
	for <mptcp@lists.linux.dev>; Tue, 14 Jan 2025 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736846397; cv=none; b=tYedqSRrnJ8r9/2e6+VjbB5Gta4yFuOSVw/b6G/g83W9KtD1E6Jsrjz4Mtb8fA0ysb8Gy9RoY2B9vfYdkv0G8eUcnimv52T1ql3mJwOC5+/WQtatsZoo5hmewADbRkOOjqxwGBBTATMUOEZFNkxLX7Df9DBqXWVCT0qDY8lBNH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736846397; c=relaxed/simple;
	bh=7J7VbhGKvjn1tPk5xfpdtGE6G751m/wWlTuFAD8cXGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KEEi7vPNT8YQoXUoSbe0TH+3FsJaN5oMJ38IGmdJf8/fJN2KQ6I28HUoUR9itJUBbJ+FI3utEIVqWSoSaZZHZqgear6FT3QGi4Wb95RZ7CdQyh+NGuQCT3uZRm7oLRlfgfsVfDjY0eghXH6IvVawYwnezt7Olit5T36zfAYplU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ys9yKXGN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ys9yKXGN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97033C4CEE0;
	Tue, 14 Jan 2025 09:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736846396;
	bh=7J7VbhGKvjn1tPk5xfpdtGE6G751m/wWlTuFAD8cXGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ys9yKXGNNHKsypLfhDJYN9VwmHN9me4JJvnZZi9cL4mKyxRPrEMaQVqdMT53mZPFO
	 63gYuRdH8RXv6MRO2FfeRAWffMmTCLrVqayW0htIB2bRjAwy9L7ea7n37oBetvkh89
	 EjEhH/Wy4cVDsuTn7TumGlzynUrbbBkwtwXCFMalDQXc0IutYq23Iu0SAdTIfurL33
	 OH0NkDGsMg3z2NVs1zJHEEMF04VbgOuhK/Hb5RUwPHvWkEHdiwl+Mvw1s2R88VSUM/
	 ltfANrs4Z5I9ZIv3u/Ng7iyM6pAQ71wIYKz9fuqmnEc0vbUoS7UYymZQxpq8LDSylg
	 Jnub4xSyNzh7g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 6/6] mptcp: change is_backup interfaces as get_flags
Date: Tue, 14 Jan 2025 17:19:38 +0800
Message-ID: <4f65744b7fb8d430e69dd719897df09ba0de2116.1736845893.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736845893.git.tanggeliang@kylinos.cn>
References: <cover.1736845893.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

is_backup() interface of the path managers is not very common. A more
common approach is to add a get_flags() interface to obtain the flags
value of a given address. Then is_backup() can be implemented through
get_flags() by test whether backup flag is set in the flags value.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           |  7 +++++--
 net/mptcp/pm_netlink.c   |  9 +++++----
 net/mptcp/pm_userspace.c | 10 +++++-----
 net/mptcp/protocol.h     |  6 ++++--
 4 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 8d9acc984a36..a0f4d06692cc 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -429,13 +429,16 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 {
 	struct mptcp_addr_info skc_local;
+	u8 flags;
 
 	mptcp_local_address((struct sock_common *)skc, &skc_local);
 
 	if (mptcp_pm_is_userspace(msk))
-		return mptcp_userspace_pm_is_backup(msk, &skc_local);
+		flags = mptcp_userspace_pm_get_flags(msk, &skc_local);
+	else
+		flags = mptcp_pm_nl_get_flags(msk, &skc_local);
 
-	return mptcp_pm_nl_is_backup(msk, &skc_local);
+	return !!(flags & MPTCP_PM_ADDR_FLAG_BACKUP);
 }
 
 static int mptcp_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 16c901fabfa2..4be4214cad34 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1168,18 +1168,19 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
 	return ret;
 }
 
-bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
+u8 mptcp_pm_nl_get_flags(struct mptcp_sock *msk,
+			 struct mptcp_addr_info *skc)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct mptcp_pm_addr_entry *entry;
-	bool backup;
+	u8 flags;
 
 	rcu_read_lock();
 	entry = __lookup_addr(pernet, skc);
-	backup = entry && !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+	flags = entry ? entry->flags : 0;
 	rcu_read_unlock();
 
-	return backup;
+	return flags;
 }
 
 #define MPTCP_PM_CMD_GRP_OFFSET       0
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 22d240128490..34c9f03138ae 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -149,18 +149,18 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 	return mptcp_userspace_pm_append_new_local_addr(msk, local, true);
 }
 
-bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
-				  struct mptcp_addr_info *skc)
+u8 mptcp_userspace_pm_get_flags(struct mptcp_sock *msk,
+				struct mptcp_addr_info *skc)
 {
 	struct mptcp_pm_addr_entry *entry;
-	bool backup;
+	u8 flags;
 
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_userspace_pm_lookup_addr(msk, skc);
-	backup = entry && !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+	flags = entry ? entry->flags : 0;
 	spin_unlock_bh(&msk->pm.lock);
 
-	return backup;
+	return flags;
 }
 
 static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *info)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6f885bd5572d..70a7b5b2f47f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1131,8 +1131,10 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 				    struct mptcp_pm_addr_entry *local);
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
-bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
-bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+u8 mptcp_pm_nl_get_flags(struct mptcp_sock *msk,
+			 struct mptcp_addr_info *skc);
+u8 mptcp_userspace_pm_get_flags(struct mptcp_sock *msk,
+				struct mptcp_addr_info *skc);
 int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
-- 
2.43.0

