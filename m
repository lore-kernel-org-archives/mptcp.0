Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B26B1DB14D
	for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736935191; cv=none; b=iayrkRJCv7BTdD6L6EByLesWaTwQN4IIzmi1vnGqr52IIHoetSKszVHkidI7USADkKs1h5L4u5fnyB91sCsIr76TuwjwLDPmjSr1UTOA25t4PllAAdFNTY3IjIgLIdv5rujvNOeSkrdVANWbMkuiLu5WPDBbxOIut0qJZxEDgRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736935191; c=relaxed/simple;
	bh=7mkYii45NYgmQcvp6vpUD1R88k+FO4BEjXgso8lwUgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdP913GTyx8oOeVqzi1j6ww4XBMX4yOKlajnSqGhjpE9Me6NLNMqCr3gSu9zuu2W9Lme4SxrjBArSybgIdQ58LA3DTWm68e3kRJneR4d+6Jn1syRj9lUs1kRAGIkdnT2wixd54LIkOTVtsBq6dpgUal8+TfXhXUzp6+CozXCNu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHPMVT0b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHPMVT0b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E44C4CEE2;
	Wed, 15 Jan 2025 09:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736935191;
	bh=7mkYii45NYgmQcvp6vpUD1R88k+FO4BEjXgso8lwUgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hHPMVT0bjCmr9AWgUzYNByQ5HfiCnGPggtk+oHXKgyZR9WYCuF+CYLCAXsn8qWBmM
	 1GgqQpWa+CVXKAvcvMduiJfReR61aM9KlqHwJ+7cqlUkJjZs98A4Zpbu+qloS8rv/I
	 b2CadwSKF4tpYMTBDVAU536ZBT8WVnNNc6QMlWMN3iydZr8ahQX8mDVtGtuEzm2bFO
	 Z0ixc+D7tUVABTNb0jJ+xwLUJKpz2BzTsuRwGFN3RlCFkkbTl9+TwJmwMKUFRRgBaT
	 jEhiM8e6YzjWzdlkHNcZzIDOBTUdvvzm/m0snwE8gci7eaNzBiicyY73GePF/1YCSQ
	 R8wiOxz+//SxA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 6/6] mptcp: change is_backup interfaces as get_flags
Date: Wed, 15 Jan 2025 17:59:32 +0800
Message-ID: <2c8cc97535d697aadc62d222f3af85f865efec30.1736935086.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736935086.git.tanggeliang@kylinos.cn>
References: <cover.1736935086.git.tanggeliang@kylinos.cn>
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
index 16cacce6c10f..e275be73b963 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -425,13 +425,16 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
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
index afd517ff260c..e7febe3f00ae 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1172,18 +1172,19 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
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
index eda4277bfff4..1713e9bb6945 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -154,18 +154,18 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry, true);
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
index aca3de2baf81..e8d8236a40e1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1132,8 +1132,10 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
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

