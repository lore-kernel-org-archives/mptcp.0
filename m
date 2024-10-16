Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A25C20514D
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070023; cv=none; b=RpDEfcmWZ/vOcNN1GwcnVXf6xQvs/w+lPlNE9rMYJxkT+NNnyB3xP+Dm2Vs4OY5sMw4kQe5iL+uvk+NEiSvx3dym4XcaQJUM9q4bWhJ8WtYaUj3H6Fp3OO+kPxY3xT6TTpKZ5Js+muTj141X/eGPANjIQ9XAgQY4oVou/Gqy/FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070023; c=relaxed/simple;
	bh=Avb+Mu8qOS9006sZBjkNAwrFOK2Yr/ih0x0UKoO2OTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dmg321+Pnxy5ZjjTA0qdasc3Mt0Lhhso1GkwpXRTMFp+ZTAIgqGqprOBtdRAA0S32ak15/6fGOsktOKpTJWNDZBC7UF9WP1jm2JnU/yCH3vKTh1XBZSJZ+ARhV+0t0PUhHAYXdVy9wVdfk6rdDVjaEtTrVtA3JyjXkDUM5JUIg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvhpL1cZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvhpL1cZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26B9C4CEC5;
	Wed, 16 Oct 2024 09:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729070023;
	bh=Avb+Mu8qOS9006sZBjkNAwrFOK2Yr/ih0x0UKoO2OTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UvhpL1cZRE5ao4EveL5X5E8vgr5pA2+l03D5zz639pfcJmeLnnhif23XU0YnFyNGd
	 cxuwh2pd52rwMfiTjraxpv8kbOvjDdhTC17yWkq7KZuvLx3bTR60B8RJoxmi+r9jlg
	 Ce8atk+99kdeot4gd5kMFixqt/EPfswU/olG9I4Y+fgYHI/mVhFjhCVARF1LRoOdqY
	 fcHteZ/Vvyf+tayVnBDFK6LGiQT2VoVPCyOiOeN+QZsgaXTmabEpnNzMgRkpSuvLZL
	 6mA5GIPsRVsFvZmFDVL8v6wUCQRP7I+ogB0JrUyz0XmIu52s56/gF2Yo93Blmxn6YA
	 PMXUyWT1BNQPg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 32/33] mptcp: implement userspace pm others interfaces
Date: Wed, 16 Oct 2024 17:12:36 +0800
Message-ID: <60e916cec3bfa62100a7011bd157f3ad4f683964.1729069854.git.tanggeliang@kylinos.cn>
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

This patch implements get_local_id(), get_flags(), get_addr(), dump_addr()
and set_flags() interfaces of the userspace PM.

get_local_id() interface is the same as mptcp_userspace_pm_get_local_id(),
which now can be defined as a wrapper of the interface. While get_flags()
interface is the same as mptcp_userspace_pm_get_flags() too, which now can
be defined as a wrapper of get_flags() interface.

get_addr() interface is a wrapper of mptcp_userspace_pm_lookup_addr_by_id()
helper. While dump_addr() is a wrapper of mptcp_userspace_pm_set_bitmap()
helper. These two interfaces are invoked under holding both the msk socket
lock and the msk pm lock.

Extract set_flags() interface from function mptcp_userspace_pm_set_flags(),
only leave the code for obtaining msk through "info" in this function. This
interface is invoked under holding the msk socket lock.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 86 +++++++++++++++++++++++++++-------------
 1 file changed, 59 insertions(+), 27 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 0ab37f31eee9..f07c77dca84b 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -135,8 +135,8 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
 	return NULL;
 }
 
-int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
-				    struct mptcp_pm_addr_entry *local)
+static int userspace_pm_get_local_id(struct mptcp_sock *msk,
+				     struct mptcp_pm_addr_entry *local)
 {
 	struct mptcp_pm_addr_entry *entry = NULL;
 	__be16 msk_sport =  ((struct inet_sock *)
@@ -154,8 +154,14 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 	return mptcp_userspace_pm_append_new_local_addr(msk, local, true);
 }
 
-u8 mptcp_userspace_pm_get_flags(struct mptcp_sock *msk,
-				struct mptcp_addr_info *skc)
+int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
+				    struct mptcp_pm_addr_entry *local)
+{
+	return userspace_pm_get_local_id(msk, local);
+}
+
+static u8 userspace_pm_get_flags(struct mptcp_sock *msk,
+				 struct mptcp_addr_info *skc)
 {
 	struct mptcp_pm_addr_entry *entry;
 	u8 flags = 0;
@@ -169,6 +175,12 @@ u8 mptcp_userspace_pm_get_flags(struct mptcp_sock *msk,
 	return flags;
 }
 
+u8 mptcp_userspace_pm_get_flags(struct mptcp_sock *msk,
+				struct mptcp_addr_info *skc)
+{
+	return userspace_pm_get_flags(msk, skc);
+}
+
 static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
@@ -546,34 +558,24 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	return err;
 }
 
-int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *loc,
-				 struct mptcp_addr_info *rem,
-				 struct genl_info *info)
+static int userspace_pm_set_flags(struct mptcp_sock *msk,
+				  struct mptcp_pm_addr_entry *local,
+				  struct mptcp_addr_info *remote)
 {
 	struct mptcp_pm_addr_entry *entry;
-	struct mptcp_sock *msk;
-	int ret = -EINVAL;
-	struct sock *sk;
 	u8 bkup = 0;
 
-	msk = mptcp_userspace_pm_get_sock(info);
-	if (!msk)
-		return ret;
-
-	sk = (struct sock *)msk;
-
-	if (loc->addr.family == AF_UNSPEC ||
-	    rem->family == AF_UNSPEC) {
-		GENL_SET_ERR_MSG(info, "invalid address families");
-		ret = -EINVAL;
-		goto set_flags_err;
+	if (local->addr.family == AF_UNSPEC ||
+	    remote->family == AF_UNSPEC) {
+		pr_debug("invalid address families\n");
+		return -EINVAL;
 	}
 
-	if (loc->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
+	if (local->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup = 1;
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_userspace_pm_lookup_addr(msk, &loc->addr);
+	entry = mptcp_userspace_pm_lookup_addr(msk, &local->addr);
 	if (entry) {
 		if (bkup)
 			entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
@@ -582,11 +584,29 @@ int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *loc,
 	}
 	spin_unlock_bh(&msk->pm.lock);
 
+	return mptcp_pm_nl_mp_prio_send_ack(msk, &local->addr, remote, bkup);
+}
+
+int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *loc,
+				 struct mptcp_addr_info *rem,
+				 struct genl_info *info)
+{
+	struct mptcp_sock *msk;
+	int ret = -EINVAL;
+	struct sock *sk;
+
+	msk = mptcp_userspace_pm_get_sock(info);
+	if (!msk)
+		return ret;
+
+	sk = (struct sock *)msk;
+
 	lock_sock(sk);
-	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc->addr, rem, bkup);
+	ret = userspace_pm_set_flags(msk, loc, rem);
 	release_sock(sk);
+	if (ret)
+		GENL_SET_ERR_MSG(info, "set_flags failed");
 
-set_flags_err:
 	sock_put(sk);
 	return ret;
 }
@@ -606,6 +626,12 @@ static int mptcp_userspace_pm_set_bitmap(struct mptcp_sock *msk,
 	return 0;
 }
 
+static int userspace_pm_dump_addr(struct mptcp_sock *msk,
+				  struct mptcp_id_bitmap *bitmap)
+{
+	return mptcp_userspace_pm_set_bitmap(msk, bitmap);
+}
+
 int mptcp_userspace_pm_dump_addr(struct mptcp_id_bitmap *bitmap,
 				 const struct genl_info *info)
 {
@@ -621,7 +647,7 @@ int mptcp_userspace_pm_dump_addr(struct mptcp_id_bitmap *bitmap,
 
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
-	ret = mptcp_userspace_pm_set_bitmap(msk, bitmap);
+	ret = userspace_pm_dump_addr(msk, bitmap);
 	spin_unlock_bh(&msk->pm.lock);
 	release_sock(sk);
 
@@ -629,6 +655,12 @@ int mptcp_userspace_pm_dump_addr(struct mptcp_id_bitmap *bitmap,
 	return ret;
 }
 
+static struct mptcp_pm_addr_entry *
+userspace_pm_get_addr(struct mptcp_sock *msk, u8 id)
+{
+	return mptcp_userspace_pm_lookup_addr_by_id(msk, id);
+}
+
 int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 				const struct genl_info *info)
 {
@@ -645,7 +677,7 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
+	entry = userspace_pm_get_addr(msk, id);
 	if (entry) {
 		*addr = *entry;
 		ret = 0;
-- 
2.43.0

