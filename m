Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4AD360
	for <mptcp@lists.linux.dev>; Tue, 11 Mar 2025 06:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741675602; cv=none; b=iQ+UwwjUXtLUpLdb4mHsTPMWnDm6KYl1zHY4QO1eknqvLmYlJiX+FvMY05Q9910KPI3goKI+4C+xaL/+rqmaMHAejYErs8FE760FamNmeoPGWOpmjrJV8rxLW0xLUHF98A6FhH6Bn6Zxc1LMjeubNAECW+BehcwD9B1mytztuBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741675602; c=relaxed/simple;
	bh=3pSdRl72NPBSLmsNzmBbIGDRz8yVC91f/w9oeV51xjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLsIELt8/TA9+Rg3NZsBwBC/BTf4+X+UQxmnmFiikhwGIFIO+nO3P3sGdFFSw86MuPlb72xg4ww7fhBI/wUO187k2E8XF0tQAc6oXsp1wsXGFk0Mylt3hpZuXBDsaGrVf2V0vh7lKojwFPx/EHbNoke3ysenh2MnK9ZoSzGuy/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2efTX8x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2efTX8x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EFEC4CEEA;
	Tue, 11 Mar 2025 06:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741675602;
	bh=3pSdRl72NPBSLmsNzmBbIGDRz8yVC91f/w9oeV51xjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W2efTX8xb04riuOsYQrS901+PiYhGHEOrT5b07wcqDgQpIMwKfsC4NcRiuv1LeN02
	 GpN0mMXa2FRVEsnbt/iJYJ60AlJKK088VEOm8o+3EtERbiE86Qhj1bp1PzDQNqKaDq
	 td0ikqnDMaAb2yqQThnreHBKtwf6JIx1pDQCZUCH3Td9bsWYKpAnYrc6jFIMX2rhcj
	 AuFf042Fd0V8tc0fRy7vS8nTYoH9zqjT3mlUPokWhebqUbMRS0gfKaHNy8f/a+cjAJ
	 tZ570LVasR+FGB7tYVTtvwe7K+9UbOUaBrTL/WYyfcW8Ji4xzQgdV1moNKWec1jwQ0
	 wIT5X1V54A4kw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH RESEND mptcp-next v11 05/10] mptcp: pm: add get_local_id() interface
Date: Tue, 11 Mar 2025 14:46:22 +0800
Message-ID: <061e62fc02eb7944356ffd49cbcf202d833e65e0.1741674285.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741674285.git.tanggeliang@kylinos.cn>
References: <cover.1741674285.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20250311064622.oPIMk6Sh9d9TV4-GSH_WWFSVdkEC9swThZIX9PL6G-Q@z>

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds get_local_id() interface for struct mptcp_sched_ops,
then mptcp_pm_get_local_id() can directly invoke get_local_id() interface
through "ops" of "msk->pm". Instead of using mptcp_pm_is_userspace() to
check which get_local_id() helper to invoke.

Also rename mptcp_pm_nl_get_local_id() to mptcp_pm_kernel_get_local_id()
and mptcp_userspace_pm_get_local_id() to mptcp_pm_userspace_get_local_id(),
and make them static.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h      | 3 +++
 net/mptcp/pm.c           | 9 ++++++---
 net/mptcp/pm_kernel.c    | 5 +++--
 net/mptcp/pm_userspace.c | 5 +++--
 net/mptcp/protocol.h     | 4 ----
 5 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 69f7b35e57c3..169e19440b03 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -116,6 +116,9 @@ struct mptcp_sched_ops {
 #define MPTCP_PM_NAME_MAX	16
 
 struct mptcp_pm_ops {
+	int (*get_local_id)(struct mptcp_sock *msk,
+			    struct mptcp_pm_addr_entry *skc);
+
 	char			name[MPTCP_PM_NAME_MAX];
 	struct module		*owner;
 	struct list_head	list;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index bf318cecb242..6eaf072a472a 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -872,9 +872,7 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	skc_local.addr.id = 0;
 	skc_local.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 
-	if (mptcp_pm_is_userspace(msk))
-		return mptcp_userspace_pm_get_local_id(msk, &skc_local);
-	return mptcp_pm_nl_get_local_id(msk, &skc_local);
+	return msk->pm.ops->get_local_id(msk, &skc_local);
 }
 
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
@@ -1052,6 +1050,11 @@ struct mptcp_pm_ops *mptcp_pm_find(const char *name)
 
 int mptcp_pm_validate(struct mptcp_pm_ops *pm_ops)
 {
+	if (!pm_ops->get_local_id) {
+		pr_err("%s does not implement required ops\n", pm_ops->name);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 687a423f5252..1380e529aa02 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -693,8 +693,8 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	return err;
 }
 
-int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
-			     struct mptcp_pm_addr_entry *skc)
+static int mptcp_pm_kernel_get_local_id(struct mptcp_sock *msk,
+					struct mptcp_pm_addr_entry *skc)
 {
 	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
@@ -1419,6 +1419,7 @@ static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 }
 
 struct mptcp_pm_ops mptcp_pm_kernel = {
+	.get_local_id		= mptcp_pm_kernel_get_local_id,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 6afab631580f..81ddc14bc273 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -126,8 +126,8 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
 	return NULL;
 }
 
-int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
-				    struct mptcp_pm_addr_entry *skc)
+static int mptcp_pm_userspace_get_local_id(struct mptcp_sock *msk,
+					   struct mptcp_pm_addr_entry *skc)
 {
 	__be16 msk_sport =  ((struct inet_sock *)
 			     inet_sk((struct sock *)msk))->inet_sport;
@@ -689,6 +689,7 @@ static void mptcp_pm_userspace_release(struct mptcp_sock *msk)
 }
 
 static struct mptcp_pm_ops mptcp_pm_userspace = {
+	.get_local_id		= mptcp_pm_userspace_get_local_id,
 	.release		= mptcp_pm_userspace_release,
 	.name			= "userspace",
 	.owner			= THIS_MODULE,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a1670463519f..282067717b39 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1139,10 +1139,6 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
-int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
-			     struct mptcp_pm_addr_entry *skc);
-int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
-				    struct mptcp_pm_addr_entry *skc);
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
 bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
-- 
2.43.0

