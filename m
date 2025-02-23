Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44622163
	for <mptcp@lists.linux.dev>; Sun, 23 Feb 2025 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740320839; cv=none; b=mKlb01DCZG3sLh75C0T9L48TyAW97VwU9uhhvXB43dwaunWnwsXqj0a0THRxC0XR1zPOerqAHA0tuYus/m5fLcVDzMXSOEGQNeYAB0WJX/nnZpEU9AItFx9jE9GEA6lAHAm70T24TKWFKuRYNfQRe46/osnAsZRUbvqAAUc0AGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740320839; c=relaxed/simple;
	bh=mWMQIscGsc1KtkIz5+A8nwazjkwu2I68JeJ23qduncA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXTZBw0bIlL9IE2QXkbY5FVPrh/vxm4B0PEcCgVqi7Ajvf1G6ROsMgr7J09JUo/j1juT/cEgP7ANrUQlCGxR810g6qx7nUvXBS5IJDj1x0uLMFiP5AJWwHIqcQg4JcJMwzmtWUPiEhC4mPGzB9ww6ykcyH2h2NyQW50ACa395ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7FF20lY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7FF20lY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE3AC4CEEA;
	Sun, 23 Feb 2025 14:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740320838;
	bh=mWMQIscGsc1KtkIz5+A8nwazjkwu2I68JeJ23qduncA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M7FF20lYc14R+xgF3dsh7gOMDvtFLYoFuUspXMXNkbyNc3hEBJVOggmbO7qNQyE/m
	 fPjYmScyqG+4BZRKRG9BjTFYnLcBRkMMRnBvakbX1oumgykqylz7H0qWDCLQxRilyp
	 EiZAbFlwGGZ2WxImVanLUC0BxB9LCcU+27rTy+yKMAk2rxYwTeJuXMcBDOZqRKT3r4
	 RWTpek1b7NfdW51BRNnu60IjtjxL37aRH1PNXgugW+kT7t3KbKTkE1Osadd6tGBrnH
	 nkftmcso9Xcsh4rcHInh7KaD56sGQfKo43b7wut4q8bLhVWar7qQB7BIzLTg/dXHPq
	 bM8eEkeOSNMmQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 11/13] mptcp: pm: drop get_local_id helpers
Date: Sun, 23 Feb 2025 22:26:16 +0800
Message-ID: <d57baa269edb137d0ccfa89a5222dfb956fc905c.1740320007.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740320007.git.tanggeliang@kylinos.cn>
References: <cover.1740320007.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Now mptcp_pm_nl_get_local_id() and mptcp_userspace_pm_get_local_id()
helpers can be dropped, and mptcp_pm_get_local_id() can directly invoke
get_local_id() interface through "ops" of "msk->pm".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           | 4 +---
 net/mptcp/pm_netlink.c   | 4 ++--
 net/mptcp/pm_userspace.c | 4 ++--
 net/mptcp/protocol.h     | 4 ----
 4 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 103b6b205dca..06be751fea21 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -425,9 +425,7 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	skc_local.addr.id = 0;
 	skc_local.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 
-	if (mptcp_pm_is_userspace(msk))
-		return mptcp_userspace_pm_get_local_id(msk, &skc_local);
-	return mptcp_pm_nl_get_local_id(msk, &skc_local);
+	return msk->pm.ops->get_local_id(msk, &skc_local);
 }
 
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index aa9be671293d..64808f4e7808 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1139,8 +1139,8 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	return err;
 }
 
-int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
-			     struct mptcp_pm_addr_entry *skc)
+static int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
+				    struct mptcp_pm_addr_entry *skc)
 {
 	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 17450cf8f920..3c8b61ed345b 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -130,8 +130,8 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
 	return NULL;
 }
 
-int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
-				    struct mptcp_pm_addr_entry *skc)
+static int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
+					   struct mptcp_pm_addr_entry *skc)
 {
 	__be16 msk_sport =  ((struct inet_sock *)
 			     inet_sk((struct sock *)msk))->inet_sport;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 809611125c5e..b6441328dc3c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1136,10 +1136,6 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
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

