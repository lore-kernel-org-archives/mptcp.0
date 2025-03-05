Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E5D22E017
	for <mptcp@lists.linux.dev>; Wed,  5 Mar 2025 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741172420; cv=none; b=srIS3VMHPRv5A7r380hghZ9bX7rytS4l+C0asBDLuDKJMqPISCziS3u72D2ObxLO3mMVA5hFQVGTN/pRrAth07UERLtHI0xukG1tJDBxb2b4tZ9JOkyg+uarReBVCX8X3k7iWQzbn+R2t78Vcsg4H9qfcZH1dHyYTh+qo2lvGXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741172420; c=relaxed/simple;
	bh=OJ9uTTv7qiOzPPaUd25ddnhlk0mauKfn0oNkHq6DTUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxE+SkHssopZeFcwuSQ5QCeDfbnDO0LVQ6PaeNSYCevSHejP0L6C7LwgkL52upf1srZ9lewSck+b6b7sIaSP+8PAGQ96gqxjv50EyNQ5HY09eehx7nLyIYb78GQhGxvdC9xoQHOp8sFm3/nVDyntZv3a2CvfVoJ2KsLgZCoHCQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxPqqxni; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxPqqxni"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56A4C4CEE2;
	Wed,  5 Mar 2025 11:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741172419;
	bh=OJ9uTTv7qiOzPPaUd25ddnhlk0mauKfn0oNkHq6DTUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hxPqqxniuVTYqEZXUyrsUeMoNDjkQX5mDR2uLdAs8OIHOWjid4CUgksHqLfj2DuXB
	 VabtjVFBw6gOEPfitIxPEOgvBq8dDK7X/AFXb97BAgeh/cnInMC9e33tsGMv4mHLGU
	 OC1GzD1TWA2WhFUp7ncKqREelbs3dA75OtXg6rOk95SAZgD2qWoCOfR/yQ+F1YBfKu
	 LrWmusjpAJ79yx+StRmqLCEMOOoVJvR6h5ajDQ7Ce90gecQbn2nxHrG8bGW/j+BPfq
	 fcoDUgsk7+yVu22CxEVtFiKZMx8g1QsL16B2FnIZZasfDQ5/yvJ7GLGrBtWC7K/Bs6
	 WMAwRmaoTnwgw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 09/12] mptcp: pm: add get_local_id() interface
Date: Wed,  5 Mar 2025 18:59:50 +0800
Message-ID: <82a0259a67bf70f2e183a41fa0aeb8ddccead338.1741171898.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741171898.git.tanggeliang@kylinos.cn>
References: <cover.1741171898.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds get_local_id() interface for struct mptcp_sched_ops,
then mptcp_pm_get_local_id() can directly invoke get_local_id() interface
through "ops" of "msk->pm". Instead of using mptcp_pm_is_userspace() to
check which get_local_id() helper to invoke.

Rename
	mptcp_pm_nl_get_local_id()/mptcp_userspace_pm_get_local_id()
to
	mptcp_pm_kernel_get_local_id()/mptcp_pm_userspace_get_local_id()

and make them static.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h      | 3 +++
 net/mptcp/pm.c           | 6 ++----
 net/mptcp/pm_kernel.c    | 5 +++--
 net/mptcp/pm_userspace.c | 5 +++--
 net/mptcp/protocol.h     | 4 ----
 5 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index c53ffff0a4cd..6090a9853f45 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -127,6 +127,9 @@ struct mptcp_sched_ops {
 #define MPTCP_PM_BUF_MAX	(MPTCP_PM_NAME_MAX * MPTCP_PM_MAX)
 
 struct mptcp_pm_ops {
+	int (*get_local_id)(struct mptcp_sock *msk,
+			    struct mptcp_pm_addr_entry *skc);
+
 	char			name[MPTCP_PM_NAME_MAX];
 	struct module		*owner;
 	struct list_head	list;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index fc728c55cda5..20eee0dcb369 100644
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
@@ -1060,7 +1058,7 @@ struct mptcp_pm_ops *mptcp_pm_find(const char *name)
 
 int mptcp_pm_validate(struct mptcp_pm_ops *pm)
 {
-	if (!pm->init) {
+	if (!pm->init || !pm->get_local_id) {
 		pr_err("%s does not implement required ops\n", pm->name);
 		return -EINVAL;
 	}
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 8bd4431d8656..5f04dad4efc8 100644
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
@@ -1417,6 +1417,7 @@ static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 }
 
 struct mptcp_pm_ops mptcp_pm_kernel = {
+	.get_local_id		= mptcp_pm_kernel_get_local_id,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index dedff896346f..1753210941a4 100644
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
@@ -698,6 +698,7 @@ static void mptcp_pm_userspace_release(struct mptcp_sock *msk)
 }
 
 static struct mptcp_pm_ops mptcp_pm_userspace = {
+	.get_local_id		= mptcp_pm_userspace_get_local_id,
 	.init			= mptcp_pm_userspace_init,
 	.release		= mptcp_pm_userspace_release,
 	.name			= "userspace",
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2a264124cb17..85c5a5bd3657 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1137,10 +1137,6 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
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

