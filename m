Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A191175D32
	for <mptcp@lists.linux.dev>; Tue,  8 Oct 2024 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381524; cv=none; b=Gw9LWqfJTAQppMx197zeTebdSdIpVQi0SZbuYY4Vf8jVWs9eGmLL0l4OAx2tYP+bZ8qlBNC+XwlEiCyuf7R3/ZWq7PGMFoWYWohDVlTrRrX9RD8qtE0ll3rz6DQx316mqU20uhwXFKvDNMyZrz2uM8z31QfJvrWfKce+4WCiPYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381524; c=relaxed/simple;
	bh=sqvsGb9jlB9GIFEuQkxJkFlXXAUn3U/WBE17ShcHNiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MSKus82Q7Mo7yBQm6ml9WLz7K4tfSz9NXuKf84aXRWRdCqpZtOcmUZGJbnDOHS4dpt19mlRutztiB8IZ69/MsIB5oV//iqWzK+aE/VnQtMaV2kdu9nrCAvLMVRhUk1YpdQXjgm46Zk7adNbsu5QCxhIjZHwoGUvih7ix893izV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfvL0X5N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfvL0X5N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530ECC4CEC7;
	Tue,  8 Oct 2024 09:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728381523;
	bh=sqvsGb9jlB9GIFEuQkxJkFlXXAUn3U/WBE17ShcHNiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jfvL0X5Nz6WmRZFsZru4V+7NOYXPvFdNjwRONMtH9lPi2num0XSzpzYWvV/C26Mo7
	 H8VDQuhHWno4Wwb0nF2t3H9gbrxzQIIvqdmTdg4raHUJJvgNaV41GNLy48FTGvRp04
	 7qPGAbgR3UISZAYiSX+AkI8/lVW2F7Bpx/GdjobklXgpvEKrC5rB7i5k0kVlpITBoD
	 vKYBNw2jPx7MU8P/o0dWSq//M3Vz/irRar/ryn6YC14GOAWy4aVC1jF04EJhQbEDhF
	 YVm3cGtePcAbHI/dN4BGYJlPSeHZWCeLWJoXk4tgVOhinLS57jV8f44+vR+FSKyjTA
	 02laLZnc2aTDQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 10/13] mptcp: change is_backup interfaces as get_flags
Date: Tue,  8 Oct 2024 17:58:14 +0800
Message-ID: <4c31526f9c517d3a551451e2f2be5ae51f2244dd.1728381245.git.tanggeliang@kylinos.cn>
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
index e73afb1e406d..4de3e0060af1 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1165,19 +1165,19 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_pm_addr_entry
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
index da6341008aa9..16a51eb4c585 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1125,8 +1125,8 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
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

