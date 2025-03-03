Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0661F13C9D4
	for <mptcp@lists.linux.dev>; Mon,  3 Mar 2025 04:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740975939; cv=none; b=MjYZCK7kS3NuaK+/d6RtUdlHWy6eXXD5pF78uK8GLYdY2NAjFrtkCMxQaKqTnC8BRLrWVGEOYNUGMP65PEDpNwAhsFAHOxL5bdZa2ZkQiZ0iUMbBMtVE35/1v4Ra1NXiyPMerKxlSQtXnQZV5yd3HgOSb0Ag7q2L1itBXv6oKbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740975939; c=relaxed/simple;
	bh=94Gp+qjQvPTcQkzM8f6qrecPX8qRpFXvlqRUbwsy3r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyjszMl+TzyNHc3O6Z7BTrlSHXvKWsdnYWkmLgyypHgSZe9nqkJTlGoH2bmOROIkat+nfYjTkZVqG1PiakLD9SMW34nSvXa4Jq+96raXGNzoaPZlKXQ6eH+sFnjitQ56lDXZE8ncaOTTKqB54+3gCQVSfX3FUCB5CYikEnRMllc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxWJeCsN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxWJeCsN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE3EC4CED6;
	Mon,  3 Mar 2025 04:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740975938;
	bh=94Gp+qjQvPTcQkzM8f6qrecPX8qRpFXvlqRUbwsy3r0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uxWJeCsNVNJ4XxQzNtN5EW9SKcppYGIpm47lIvpNvL1UcEQ16o/aoguneMOc3QdrP
	 JE8HSQStVA1Y+Z+pj3XVRcwcODa3LxuoZdj6KS95OSlGyz1bjm8mwYD1R0emD596/I
	 AxnvCPiFyPcuwaof33U2oq0dG/tl0I9uCul7t5n5uB3uatWnKX/W/eeFv6DOm9go4m
	 vbLjXGy7rxamgoDqDxnpyE2paXhvMTr9DTVkoMqm6uYK6U3DbQfkqDmulT3aUS6EYx
	 ZpbDzgrgGwUjJt493iefF6o35PgK11RPA1f1Ey0i7XJsiGDySwx3lEag2Vb28AjnMP
	 3MqxBOqyycyaA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 10/11] mptcp: pm: make get_local_id helpers static
Date: Mon,  3 Mar 2025 12:22:58 +0800
Message-ID: <0bdf5e5472e44780ce51d9241e33e2e010ecd23a.1740975633.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740975633.git.tanggeliang@kylinos.cn>
References: <cover.1740975633.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Now mptcp_pm_get_local_id() can directly invoke get_local_id() interface
through "ops" of "msk->pm". Instead of using mptcp_pm_is_userspace() to
check which get_local_id() helper to invoke.

Then mptcp_pm_nl_get_local_id() and mptcp_userspace_pm_get_local_id()
helpers can be static.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           | 4 +---
 net/mptcp/pm_kernel.c    | 4 ++--
 net/mptcp/pm_userspace.c | 4 ++--
 net/mptcp/protocol.h     | 4 ----
 4 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 1ce58d16370a..848393511997 100644
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
index 8a5966e6e3e3..3d5beaafc3ec 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -693,8 +693,8 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
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
index d53f44df9641..05495f6e771a 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -127,8 +127,8 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
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
index 3579c31650fa..776f164a21eb 100644
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

