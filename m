Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF7B205158
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070005; cv=none; b=J3UrWbqAYuC1UOzw8sI0a6NQr8EO0iYGpBQmOCUXFpJnR72JifpFPk8wzEQ8LuvKbrCivJ4Jx/VTUBlROcqvmKybJ/Hv5YBR/97lCtAYBCSA+H6H3uB6A9VVHqn7okKsBsLz92qn5Z1G5JNmXEvRE30OBfY16oyRgLjix4wu66o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070005; c=relaxed/simple;
	bh=AM9SIRM6WggImMgxDMfZRW+hJBiC/supZILv4eH611U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FRS+P9dDVguEQ6hRnZqDPwomL/XfI5FsCqKY0DZjriMPZ2bfZyTRpR4jdwyAhmb/fOujcoAfqZ+bBUpuf3IaxleLWmQ/e4PvVASzqiOL4ZekvDAXF0ykV35CpfXaOdo2JHcIMPzvp45sCGAx0orICskeLtCjZeG4vrhHtYdT9Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZUclAUh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZUclAUh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF14C4CEC5;
	Wed, 16 Oct 2024 09:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729070004;
	bh=AM9SIRM6WggImMgxDMfZRW+hJBiC/supZILv4eH611U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tZUclAUh16bbjTCtSzcVyiKtC45qv75NwUCIFacC8+zlbNOU3xUna5apGwkCOKeuc
	 kOG0Wytf+XiYTC7CfeevIiKE9jWmfqiGxju9QFp9c6jaql0hlj9yWGQyPG+czZMMRn
	 fT83MQOWuVrfMRRiwCP6ju1j9nCce4Pc2KOkds91Cte31YvaIeEjYgVMpYCahMC4XT
	 Vn5Z/GC5RJMKrtCsnlNvtHh3zCLMfbOoRu9d22BBw1mmdYPA1bujvVYKIwdUpJaNXD
	 cQnAYdR12j/T/FIzPPPTUi7m714q5/aD79FpAk7hETV/+DDss548mzXUZfI7kvblK/
	 QB5xzzq6cZCeA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 22/33] mptcp: change is_backup interfaces as get_flags
Date: Wed, 16 Oct 2024 17:12:26 +0800
Message-ID: <d52e2d9777a3a35310d12c32a2cc0b58ad7cc206.1729069854.git.tanggeliang@kylinos.cn>
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

The is_backup() interface of path manager is not very common. A more
common approach is to add a get_flags() interface to obtain the flags
value of a given address. Then is_backup() can be implemented through
get_flags() by test whether backup flag is set in the flags value.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           |  7 +++++--
 net/mptcp/pm_netlink.c   |  8 ++++----
 net/mptcp/pm_userspace.c | 10 +++++-----
 net/mptcp/protocol.h     |  4 ++--
 4 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d28e844eba2d..c2229e46de1a 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -430,13 +430,16 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
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
 
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 8ef7faaf9c4a..3029b4e3c1f7 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1166,19 +1166,19 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_pm_addr_entry
 	return ret;
 }
 
-bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
+u8 mptcp_pm_nl_get_flags(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct mptcp_pm_addr_entry *entry;
-	bool backup = false;
+	u8 flags = 0;
 
 	rcu_read_lock();
 	entry = __lookup_addr(pernet, skc);
 	if (entry)
-		backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+		flags = entry->flags;
 	rcu_read_unlock();
 
-	return backup;
+	return flags;
 }
 
 #define MPTCP_PM_CMD_GRP_OFFSET       0
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index c749f5dccdf9..0012b1965421 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -149,19 +149,19 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 	return mptcp_userspace_pm_append_new_local_addr(msk, local, true);
 }
 
-bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
-				  struct mptcp_addr_info *skc)
+u8 mptcp_userspace_pm_get_flags(struct mptcp_sock *msk,
+				struct mptcp_addr_info *skc)
 {
 	struct mptcp_pm_addr_entry *entry;
-	bool backup = false;
+	u8 flags = 0;
 
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_userspace_pm_lookup_addr(msk, skc);
 	if (entry)
-		backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+		flags = entry->flags;
 	spin_unlock_bh(&msk->pm.lock);
 
-	return backup;
+	return flags;
 }
 
 static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *info)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0ae9eef173ea..314f20a436b1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1128,8 +1128,8 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_pm_addr_entry *local);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_pm_addr_entry *local);
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
-bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
-bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+u8 mptcp_pm_nl_get_flags(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+u8 mptcp_userspace_pm_get_flags(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_dump_addr(struct mptcp_id_bitmap *bitmap,
 				 const struct genl_info *info);
 int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-- 
2.43.0

