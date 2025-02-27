Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7735921CC73
	for <mptcp@lists.linux.dev>; Thu, 27 Feb 2025 06:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740638664; cv=none; b=oEKAZc0a/JsFX4a0fA790I+CVDky+ePU5z6kd4cPbwI8Ye1E0HNWrDohp4mznmjjfojPSq56+MQlbE+Ssq6yQHd00RRb7Msnj2h4Q6G9BfEvyMoNYpyECkMEjHR4d6akb4Ny7lYBKlXwEMOeAHt23hgtGOSW4eh+3c8zka0639E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740638664; c=relaxed/simple;
	bh=NmOFtPL4yeEvDOCNQp8MUu/VLI2ehMCKyvv+2cLh6vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMhH95hz7h+9JmtXmnxl2CufzzQTnIL8H+ZYXy9nPTbXqn9nfgwJNACzJHe5FMbOIjFvlX8WOxZeLOAkZ5vGO+TU0DcL7iHf5BtbQu8S7SJdKBeF7Ih3FtPjGgkGiqEFRaF980yLZ0Ltxu9AIKyIKgWuqSwAakSKX0oC4zN3l2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3b/PoQB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3b/PoQB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E08C4CEE4;
	Thu, 27 Feb 2025 06:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740638663;
	bh=NmOFtPL4yeEvDOCNQp8MUu/VLI2ehMCKyvv+2cLh6vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l3b/PoQBLQMgEJPI/Bpm0bsPqsnIawLY065HDtSSjDKA1d/u16Dl82pQ1Ey4F5i3m
	 zdWDQJlpbr5JhsLjf3eEUZqq3Zul9nLD53iuXK3Z7D+xrVNuSvqs6xyZN1cWT2Dwdh
	 DVkkg6azF+yoCz5yKunzmkjI6Ap8Y8NaW3/ewRQQGYpuqUtKDzyPRTlFZMsduZdbC+
	 1MA1hvc/Alpg6Bqtw9lK6/0Z/4GUSJO8gCtIzcEc9CemX+Gst6aPqJe1f6c9WEoqk9
	 oEugVxfQV44W5nQxm20uofYvhEeoRwSoOmrEW1vaLbx6UiZOxWDz9Z4sWuz2V+VcsK
	 pbmG6solv1YIw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 5/6] mptcp: pm: add remote parameter for set_flags
Date: Thu, 27 Feb 2025 14:43:56 +0800
Message-ID: <10ce66a82baec7e37fcde50554c1a0f0f2a9da6a.1740638334.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740638334.git.tanggeliang@kylinos.cn>
References: <cover.1740638334.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The remote address of set_flags() interface is useful for userspace PM,
but unused in in-kernel PM.

But an additional "changed" parameter needs to be passed to set_flags() of
in-kernel PM. One option is to add a "u8 changed" parameter to set_flags()
interface:

	set_flags(struct mptcp_pm_addr_entry *local,
		  struct mptcp_addr_info *remote,
		  u8 changed)

A better option is to add a struct mptcp_pm_addr_entry "remote" parameter
for set_flags(), so that "remote->addr" can be used for userspace PM, and
"remote->flags" can be used for in-kernel PM to replace the additional
"changed" parameter.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           | 20 ++++++++++++++++----
 net/mptcp/pm_netlink.c   |  1 +
 net/mptcp/pm_userspace.c | 21 +++------------------
 net/mptcp/protocol.h     |  2 ++
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 1844107f6f93..adb2735c4131 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -531,7 +531,8 @@ int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
 static int mptcp_pm_set_flags(struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
-	struct nlattr *attr_loc;
+	struct mptcp_pm_addr_entry rem = { .addr = { .family = AF_UNSPEC }, };
+	struct nlattr *attr_loc, *attr_rem;
 	int ret = -EINVAL;
 
 	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR))
@@ -542,9 +543,20 @@ static int mptcp_pm_set_flags(struct genl_info *info)
 	if (ret < 0)
 		return ret;
 
-	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_set_flags(&loc, info);
-	return mptcp_pm_nl_set_flags(&loc, info);
+	if (info->attrs[MPTCP_PM_ATTR_TOKEN]) {
+		attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
+		ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
+		if (ret < 0)
+			return ret;
+
+		if (rem.addr.family == AF_UNSPEC) {
+			NL_SET_ERR_MSG_ATTR(info->extack, attr_rem,
+					    "invalid remote address family");
+			return -EINVAL;
+		}
+		return mptcp_userspace_pm_set_flags(&loc, &rem, info);
+	}
+	return mptcp_pm_nl_set_flags(&loc, &rem, info);
 }
 
 int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e546388070b4..053f2bec9042 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1949,6 +1949,7 @@ static void mptcp_nl_set_flags(struct net *net,
 }
 
 int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
+			  struct mptcp_pm_addr_entry *remote,
 			  struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 05d59ad1a0bc..dddd2daed650 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -553,19 +553,16 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 }
 
 int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
+				 struct mptcp_pm_addr_entry *remote,
 				 struct genl_info *info)
 {
-	struct mptcp_addr_info rem = { .family = AF_UNSPEC, };
 	struct mptcp_pm_addr_entry *entry;
-	struct nlattr *attr, *attr_rem;
 	struct mptcp_sock *msk;
+	struct nlattr *attr;
 	int ret = -EINVAL;
 	struct sock *sk;
 	u8 bkup = 0;
 
-	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR_REMOTE))
-		return ret;
-
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
 		return ret;
@@ -580,18 +577,6 @@ int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
 		goto set_flags_err;
 	}
 
-	attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	ret = mptcp_pm_parse_addr(attr_rem, info, &rem);
-	if (ret < 0)
-		goto set_flags_err;
-
-	if (rem.family == AF_UNSPEC) {
-		NL_SET_ERR_MSG_ATTR(info->extack, attr_rem,
-				    "invalid remote address family");
-		ret = -EINVAL;
-		goto set_flags_err;
-	}
-
 	if (local->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup = 1;
 
@@ -606,7 +591,7 @@ int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
 	spin_unlock_bh(&msk->pm.lock);
 
 	lock_sock(sk);
-	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &local->addr, &rem, bkup);
+	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &local->addr, &remote->addr, bkup);
 	release_sock(sk);
 
 	/* mptcp_pm_nl_mp_prio_send_ack() only fails in one case */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0b6695fbb645..5adb791898ec 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1038,8 +1038,10 @@ bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
 bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				     const struct mptcp_addr_info *addr);
 int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
+			  struct mptcp_pm_addr_entry *remote,
 			  struct genl_info *info);
 int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
+				 struct mptcp_pm_addr_entry *remote,
 				 struct genl_info *info);
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
-- 
2.43.0

