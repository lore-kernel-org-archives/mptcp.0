Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336A418C03D
	for <mptcp@lists.linux.dev>; Thu, 10 Oct 2024 05:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728539305; cv=none; b=YzB7V0f7c6LaBGtWQJ75vfXJ2nbIrXDa1vWMB3V3Eph3CAxBhCIBbaaNgafJydH32P6JyRJeqB2aEUArre5s4X6jGMfpv00Rnw6n5lKXt7ET8FbvIUF9/4+58u48AWpr3SaooZHS4cSehSnIzoQhMkjaoc+65z3RjuTJEPIIZhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728539305; c=relaxed/simple;
	bh=rlqY/0Zv4hvalp6tJ7Ebi9dCAPy875VloLxigP6tC+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cu6Pr5lsxq1XEatTc/c7xoRGnu7KA6DjkbwW15T9Xa8agfWqqD25stg94yosBy7awgcqJGygKUe18IXofnVMdG2vRD09agi2pvfRp9jG0M/WQWDdYkxMrgbSP0m4dL7gDixuW3WdRMUKGPv4n2mNJrxr1DeMEgTitDsFt0n40KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMvtM5Jc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMvtM5Jc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA11C4CEC5;
	Thu, 10 Oct 2024 05:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728539305;
	bh=rlqY/0Zv4hvalp6tJ7Ebi9dCAPy875VloLxigP6tC+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sMvtM5JcTqwtcxNBVhdq0JNEsqAh/9oWQxZZgZ8IWXNikVLt221nkbZ/ey1X7cUXN
	 MPKDnOcFcOzk1UL7/9rFqZE2a/KkpyON7flOYyWMowYvKIOjPFrVoUkYscsg7lw33o
	 2qp/CqSE+rWDnS/dQMm+/oIvWvc9Hi4Pgvg0vMd4IHUCKxb2UKKWMXMQD21/f5S+e9
	 Awph+mYmAgyku3fvHd48B/zXJCwzmc+FSGZrHwGXXCYAlmYPWH7aDnfauAUeLBnUWp
	 PtP3MQJZz+RlOem8t9k5DFzPFbFc3f711MA+Vuhe/UACkdgkdCVbFoa0KrPUv84luv
	 01OdTPA516lag==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 10/15] mptcp: change is_backup interfaces as get_flags
Date: Thu, 10 Oct 2024 13:47:55 +0800
Message-ID: <33f7ebb53d3195278d42c7b43f5d286e9ea40b4c.1728538976.git.tanggeliang@kylinos.cn>
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
index 4046e6727cb6..d2ddf467dcce 100644
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
index f42bc6bb19fa..38168eb6d4a0 100644
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
index 6685c76fe151..50b1aea7a719 100644
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
index 767da3cb43cb..20ed572472aa 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1123,8 +1123,8 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
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

