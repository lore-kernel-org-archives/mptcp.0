Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E8E2209B
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588528; cv=none; b=VRFcpeBWzruWQjLU1j4Ff6Bbm/HkTEVxLvek2hYsCYsjYLaW0BIHV3BnudVaMf1iahfGlma0bNn9iXJkQMTkByYPmP++fFrxJJY84sWufZ2XaroNllb5QPgMCMeYVz6NCPNhiRaZyth2/PNezZmKcXzYahkDa8YIpJ7dxO/bg/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588528; c=relaxed/simple;
	bh=Ki0ce+y1gl18Nc11rqcw6lh+KYRp9MDuLKt3n1D9K2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s97OkXTZPVfVLcwB8bUO3G7Ils/2cIWdfrgyvVG3AKVep27rW8/KOSIvAaQHAXHcA7OKH3Bi4AqnepFqzZmkBs3adqpsDje65y+NLgzqZ4XJpHxpRGuuZEmPNqypF1+yiAPhYlQhlk6FiWJnbThNlu69b9s6hJxiVRuC4n2e4gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfAnwDi4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfAnwDi4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C19C4CEC3;
	Tue, 22 Oct 2024 09:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588528;
	bh=Ki0ce+y1gl18Nc11rqcw6lh+KYRp9MDuLKt3n1D9K2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UfAnwDi41esysTLgoLisyqmcsin+S1kF8hdIImyzcxbTHDdoqhR8GVlfg+U7f6TmR
	 tDMcrt8PDNsOaleNJHRpF7O59lgQtWgOIlySPAXSlQ1kc5Bg/2ybH7UNWxtuEwHnF5
	 C8HFlM6rVuH5eEPOBpzpJr/eajDYMHOezCEknTuz+GqVjeCyYkKhYyzpBsbMTDyxaE
	 9DWrQzu/1/fqiJOmzQjeo9LfYq0B7p0z6iChOcloKs85M7Ue1gcD22tqO6PBSlKJlF
	 kZK2vioIVVGsGUnxEn+NPKS5RpPwkO/SfsP1BtHo5hOv+tXOpp6cwdMuFQBIbMLWQ3
	 stORbEBt6mKTg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 22/36] mptcp: change is_backup interfaces as get_flags
Date: Tue, 22 Oct 2024 17:14:30 +0800
Message-ID: <d8538f628ff2264b75c6c5e64e28147cb5793497.1729588019.git.tanggeliang@kylinos.cn>
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
index 032c9eb2e48d..287e715bcf68 100644
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
index 4ff6b7e37947..8efd288bd247 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1130,8 +1130,8 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
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
2.45.2

