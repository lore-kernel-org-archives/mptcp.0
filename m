Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A20B19F471
	for <mptcp@lists.linux.dev>; Thu, 16 Jan 2025 07:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737012439; cv=none; b=C039Jcoyi+V5XV2nxrdmyPZG/RHeQBAUWtEz8Zy8p6CuLmf1ML1tFMCJjHSWmJPS6PUGhOY+X4tpew5hxfljJFewxZG9jezl/KDYf9DqyeNgthNSmMxtjTzN0nx0Ioqlozxoe6bInjyJ4Vk9OznOxhxWf5GmtMQKwM4mDgZfKHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737012439; c=relaxed/simple;
	bh=vH5wAZiDpfELiOZgfd+b/WPpWpt3F4Ql620iO7GMNl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXlf/Zs78S9UFIkEOVKMiWWJtlPOhdUqxVEB9qJV0jEEcrL5no1RWAsvdzn0DsHEklgL+DaYo04s+OY6wJa+dQRKce+dP+bX6hFi+RNRrsbsk60pXhQl5E3wNIVXrz9znQLFpi8AYO32gLDkVJuJKGgXtWftBbiyLu4iokr16MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkPvQrNy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkPvQrNy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD33C4CEE2;
	Thu, 16 Jan 2025 07:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737012438;
	bh=vH5wAZiDpfELiOZgfd+b/WPpWpt3F4Ql620iO7GMNl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CkPvQrNywYkAlNQzloUnhHFDdsSjqzW9zjPu/DY+0NcahuoWWRMknBCSOnD2gyvNO
	 F91QEemBQlMlCeX0Ertvu4OtDMCOngO+OOg5bq5c9U+tWDeQ4Vemx76dHHKLSdZv5x
	 czJPOBjcCous8L04eQluyJ1c4oB0jzpgIfTZHOLNE8etK0nNCGkA0c7f7n2dFaL8nq
	 Y/RiBlPjAVjO0Ol8zdtJhrmptDeZJnQDprKBWClBOHtEABLMi99fLLJg6Jd1HbZvjC
	 m5WkKiCW1wwcdORK86JaoxkzPNahEh51DOhdzOP3Ymrh90Nn4M0MTsm7XS5qFjRYOe
	 mW5lP2n2xKSsA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 7/7] mptcp: change is_backup interfaces as get_flags
Date: Thu, 16 Jan 2025 15:26:59 +0800
Message-ID: <75f5ab33f0a11d32eeaa9af698df6e64bb1da951.1737012165.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737012165.git.tanggeliang@kylinos.cn>
References: <cover.1737012165.git.tanggeliang@kylinos.cn>
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
 net/mptcp/pm_netlink.c   |  8 ++++----
 net/mptcp/pm_userspace.c | 10 +++++-----
 net/mptcp/protocol.h     |  4 ++--
 4 files changed, 16 insertions(+), 13 deletions(-)

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
index afd517ff260c..c0971b09c5f6 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1172,18 +1172,18 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	return ret;
 }
 
-bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
+u8 mptcp_pm_nl_get_flags(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
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
index 9a6c17948d7e..5e9b95270942 100644
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
index aca3de2baf81..821d9d51e27c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1132,8 +1132,8 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
-bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
-bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+u8 mptcp_pm_nl_get_flags(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+u8 mptcp_userspace_pm_get_flags(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
-- 
2.43.0

