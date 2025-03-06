Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCD92045AE
	for <mptcp@lists.linux.dev>; Thu,  6 Mar 2025 11:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258923; cv=none; b=oFkKdKSRkx6Cd44VJoqrphj4w1GkJEfnor8MKl0WwdBR5MsDlBmJYtUWbZgVMmx5pI/r2kUJ9VUjEak/KIcaFSrklVhKk316XTz0JlwoBSgNLycryYsTtBU1Obu8xXBaPqXLV8vRjhdmjKuWQrqT/oIaGuPielgfOHsV1dAuB+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258923; c=relaxed/simple;
	bh=pqPgFO6bggwblTnNyi2ZioI4yeR4qWTz0V8A/V5rwrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvfWNJxWU6jFBwEkLWWnPv+XXzsyGvlVKl+LULA9ydpUn2hHJzVekHimbIDYw8UFkRdMPpj/7wtRNmQVoBRcv77PJyd9ckLputC58KppXZnjCTtIb6NhuFB6GXPyH4X1ddOK+17XOqYIa8cD/xajY1h+MHOrMA5JTom8ZKQz0Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjwNL0XQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjwNL0XQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F452C4CEE0;
	Thu,  6 Mar 2025 11:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741258923;
	bh=pqPgFO6bggwblTnNyi2ZioI4yeR4qWTz0V8A/V5rwrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WjwNL0XQnsJyqSVQOVAy7e6hIFOb2TGtboIk9ZZRfc5v0DX18Qqj/m9nlpd/88i6W
	 uTGyB4jx0azRGA4AtqObk90XmdGLXuvsbpx83rQeP7Lx400HtRAPpk82VijJsdoQ2L
	 Gck56QdRpQJq+bzedsYqwmoMpCwcfU1xAlshLuOHErBpAcPeeRkABW/aPeFLTHzkqf
	 HI7BSCbnqVwPLfFO1+iCJ39MIjHDDId7DVV6RC0h69DzrFLrVGZr4SeT4eTTECiM9r
	 fWQXi+IS6joNizABO5nUU/d7R5gWR6XX73AOa00KqBr1j9C8BY19yqKmWC68vZWCf1
	 +VwLgrB0ezGTw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 06/12] mptcp: pm: add get_local_id() interface
Date: Thu,  6 Mar 2025 19:01:41 +0800
Message-ID: <f66db501cf684fd025a218e60335d7d8413402bf.1741258415.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741258415.git.tanggeliang@kylinos.cn>
References: <cover.1741258415.git.tanggeliang@kylinos.cn>
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
 net/mptcp/pm.c           | 4 +---
 net/mptcp/pm_kernel.c    | 5 +++--
 net/mptcp/pm_userspace.c | 5 +++--
 net/mptcp/protocol.h     | 4 ----
 5 files changed, 10 insertions(+), 11 deletions(-)

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
index 1a2f1715871c..d2dfd91cab46 100644
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
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 03c4584cca7a..a67e94c02c64 100644
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
index fa9bb385feb9..6cae1ae5e9be 100644
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

