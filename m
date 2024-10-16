Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1800B205136
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070002; cv=none; b=qscMUT66Cjn6Mo5PbtGKuwZsKER3watCx+DO7TTr9bwHIfNM0OTneabA95d5cXbIL/zBqqD2PdxBrtiCxzC+bJ9iZhd/3Xs5j4+3jprxsXnqts/XlHNMPf00QrSscrORCdXJBZWWQdzib989Aqfy+bY3tMZ1xX9/zaqTKRlK+Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070002; c=relaxed/simple;
	bh=0WacToPcH/djLoibQglKigJoj8OqjuikUBlLO9zRQ5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5i9mP8A64SbSK24XWsxNpBV5lH32SSyaMmT+p1BJc+9cok+0hGI+yUjylVJexmlKARWCFghcjvKhXVR1li7N1B2EAQyfxVU04HZpUrPJXKxWkC8/rCm/ouPSqEGTAN3G/LsgM2PqDFKBNujaEwspEmebupiUxM/Yj/TJ/FSOgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eH/DBQSM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eH/DBQSM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7592BC4CEC5;
	Wed, 16 Oct 2024 09:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729070001;
	bh=0WacToPcH/djLoibQglKigJoj8OqjuikUBlLO9zRQ5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eH/DBQSMDWliKN/rlfUdAxFaiWuLV8NJVvhmycPILqFw8dOygt0PAergn1cZygzfH
	 Z7T/2+vHcKYJ/tHTrfZ3W5+L8h+lTAgjceLB819Vypi4Cmkw87lgoOsN05v9WvXtaQ
	 ABo1YgrNs8cyXDpxZt7oRhP5vrgAFk3RyYiWx2nWr5s01IK0GXE9rma+fphOnxfnsl
	 rklm1XrUoPysaCd5jJOb+y12axiutqBpNaqgA5dB+5QjSGsY6FxjFBQ84UQCvQNouj
	 ILwqDpaBNEbR5s0/FWeJVWJYnVt7MN/oe7XnwmbbjXvLNJ1lIGtsad+6EsSqhVLreP
	 phsZipzv9mEWA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 20/33] mptcp: add loc and rem for set_flags
Date: Wed, 16 Oct 2024 17:12:24 +0800
Message-ID: <386abd0563329d5abd01e0b7dfa9f199e19ed542.1729069854.git.tanggeliang@kylinos.cn>
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

This patch updates the interfaces set_flags to reduce repetitive code,
adds two more parameters "loc" and "rem" for them. These addresses are
parsed in public helper mptcp_pm_nl_set_flags_doit(), then pass them
to mptcp_pm_nl_set_flags() and mptcp_userspace_pm_set_flags().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 57 ++++++++++++++++++++++++----------------
 net/mptcp/pm_userspace.c | 28 ++++++--------------
 net/mptcp/protocol.h     |  4 ++-
 3 files changed, 46 insertions(+), 43 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 0309f7dbd23b..a0d9e3e7b0f2 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -2045,10 +2045,10 @@ static int mptcp_nl_set_flags(struct net *net,
 	return ret;
 }
 
-static int mptcp_pm_nl_set_flags(struct genl_info *info)
+static int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *loc,
+				 struct mptcp_addr_info *rem,
+				 struct genl_info *info)
 {
-	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, };
-	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	u8 changed, mask = MPTCP_PM_ADDR_FLAG_BACKUP |
 			   MPTCP_PM_ADDR_FLAG_FULLMESH;
 	struct net *net = genl_info_net(info);
@@ -2056,59 +2056,72 @@ static int mptcp_pm_nl_set_flags(struct genl_info *info)
 	struct pm_nl_pernet *pernet;
 	u8 lookup_by_id = 0;
 	u8 bkup = 0;
-	int ret;
 
 	pernet = pm_nl_get_pernet(net);
 
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
-	if (ret < 0)
-		return ret;
-
-	if (addr.addr.family == AF_UNSPEC) {
+	if (loc->addr.family == AF_UNSPEC) {
 		lookup_by_id = 1;
-		if (!addr.addr.id) {
+		if (!loc->addr.id) {
 			GENL_SET_ERR_MSG(info, "missing required inputs");
 			return -EOPNOTSUPP;
 		}
 	}
 
-	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
+	if (loc->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup = 1;
 
 	spin_lock_bh(&pernet->lock);
-	entry = lookup_by_id ? __lookup_addr_by_id(pernet, addr.addr.id) :
-			       __lookup_addr(pernet, &addr.addr);
+	entry = lookup_by_id ? __lookup_addr_by_id(pernet, loc->addr.id) :
+			       __lookup_addr(pernet, &loc->addr);
 	if (!entry) {
 		spin_unlock_bh(&pernet->lock);
 		GENL_SET_ERR_MSG(info, "address not found");
 		return -EINVAL;
 	}
-	if ((addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
+	if ((loc->flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
 	    (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
 		spin_unlock_bh(&pernet->lock);
 		GENL_SET_ERR_MSG(info, "invalid addr flags");
 		return -EINVAL;
 	}
 
-	changed = (addr.flags ^ entry->flags) & mask;
-	entry->flags = (entry->flags & ~mask) | (addr.flags & mask);
-	addr = *entry;
+	changed = (loc->flags ^ entry->flags) & mask;
+	entry->flags = (entry->flags & ~mask) | (loc->flags & mask);
+	*loc = *entry;
 	spin_unlock_bh(&pernet->lock);
 
-	mptcp_nl_set_flags(net, &addr.addr, bkup, changed);
+	mptcp_nl_set_flags(net, &loc->addr, bkup, changed);
 	return 0;
 }
 
-static int mptcp_pm_set_flags(struct genl_info *info)
+static int mptcp_pm_set_flags(struct mptcp_pm_addr_entry *loc,
+			      struct mptcp_addr_info *rem,
+			      struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_set_flags(info);
-	return mptcp_pm_nl_set_flags(info);
+		return mptcp_userspace_pm_set_flags(loc, rem, info);
+	return mptcp_pm_nl_set_flags(loc, rem, info);
 }
 
 int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return mptcp_pm_set_flags(info);
+	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
+	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
+	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct mptcp_addr_info rem = { .family = AF_UNSPEC, };
+	int ret;
+
+	ret = mptcp_pm_parse_entry(attr, info, false, &loc);
+	if (ret < 0)
+		return ret;
+
+	if (attr_rem) {
+		ret = mptcp_pm_parse_addr(attr_rem, info, &rem);
+		if (ret < 0)
+			return ret;
+	}
+
+	return mptcp_pm_set_flags(&loc, &rem, info);
 }
 
 static void mptcp_nl_mcast_send(struct net *net, struct sk_buff *nlskb, gfp_t gfp)
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 4db39bf26cf4..aa4a5d110376 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -537,12 +537,10 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	return err;
 }
 
-int mptcp_userspace_pm_set_flags(struct genl_info *info)
+int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *loc,
+				 struct mptcp_addr_info *rem,
+				 struct genl_info *info)
 {
-	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
-	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
-	struct mptcp_addr_info rem = { .family = AF_UNSPEC, };
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
@@ -555,28 +553,18 @@ int mptcp_userspace_pm_set_flags(struct genl_info *info)
 
 	sk = (struct sock *)msk;
 
-	ret = mptcp_pm_parse_entry(attr, info, false, &loc);
-	if (ret < 0)
-		goto set_flags_err;
-
-	if (attr_rem) {
-		ret = mptcp_pm_parse_addr(attr_rem, info, &rem);
-		if (ret < 0)
-			goto set_flags_err;
-	}
-
-	if (loc.addr.family == AF_UNSPEC ||
-	    rem.family == AF_UNSPEC) {
+	if (loc->addr.family == AF_UNSPEC ||
+	    rem->family == AF_UNSPEC) {
 		GENL_SET_ERR_MSG(info, "invalid address families");
 		ret = -EINVAL;
 		goto set_flags_err;
 	}
 
-	if (loc.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
+	if (loc->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup = 1;
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_userspace_pm_lookup_addr(msk, &loc.addr);
+	entry = mptcp_userspace_pm_lookup_addr(msk, &loc->addr);
 	if (entry) {
 		if (bkup)
 			entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
@@ -586,7 +574,7 @@ int mptcp_userspace_pm_set_flags(struct genl_info *info)
 	spin_unlock_bh(&msk->pm.lock);
 
 	lock_sock(sk);
-	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem, bkup);
+	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc->addr, rem, bkup);
 	release_sock(sk);
 
 set_flags_err:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7fd5a7644a8d..07e7baec7cbe 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1038,7 +1038,9 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
-int mptcp_userspace_pm_set_flags(struct genl_info *info);
+int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *loc,
+				 struct mptcp_addr_info *rem,
+				 struct genl_info *info);
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
-- 
2.43.0

