Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F781DA62E
	for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 02:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740020266; cv=none; b=dJxMlQ3o15fLKwhoeLaJ4NW1iFzgj9pffDlHXLMWh3/3RCE9W4C0K6RoMTWg+x6PurpNarZoj9n31G4ozRBk+beU5UXEsEvQ0yEqOzrT+A1hMQPyaCcDXTmEXl0GBnwwiJxFxb71Pphtx/nYI8oLE4DS189MZnrslonHqfYmg4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740020266; c=relaxed/simple;
	bh=qHlwxH/3odovgKnCENyhjorue50FrKpzQdg/YoZHamg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bvVj6n8OsddmmbA1GjGK9V4u01poNpwV/H02vHH0m9K6UnHjrCmxmjNQT1/bBy+nYQ2VWyIUlSCVpXvwun9cxvp9Z0bCiCk2bAdjlibVC00PeCkwSHq6feWLORUuc0womxXFR7aAvd5iL5B4xcLopyP1dxCeVFkWtovC1frMHe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIi23OKy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIi23OKy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99238C4CED1;
	Thu, 20 Feb 2025 02:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740020266;
	bh=qHlwxH/3odovgKnCENyhjorue50FrKpzQdg/YoZHamg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nIi23OKyIwFlsulgbioZWxpcwD6pGkuB332oCKnp8luY/1QmanvKp21Y7NXFpYHSq
	 HT7OLLA9wXKhWZytzKj7cYw1OC7YQf6IhJ+YMceykx1UtYMxlJD8oG+k988dnnIVDj
	 TxBWa8vvAlS3AgDIvCL5ofx5aQcmoGMN3kJEBb9ZHfz+180QDVT6iyplDYZpoVu2oo
	 ryvZRmFn40cJ9ysHIgo9p1GqYEJQA7l/16gWRzlEzzdF3zkPiw4U86k2x+MBtVnAPp
	 CgaiKcZF/Qo5BIlMiK0ilo8Z50NSMNV5qnU1G9R5eIhs9xR+GXHa423n/Pp52Z3ekJ
	 7Cjdfn84DQEag==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 3/9] mptcp: pm: pass pm_param to get_local_id
Date: Thu, 20 Feb 2025 10:57:27 +0800
Message-ID: <bc226acf8604b95b112d1abb9e3a125fe9a636b2.1740019794.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740019794.git.tanggeliang@kylinos.cn>
References: <cover.1740019794.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch changes the 2nd parameter of get_local_id() interface as
"struct mptcp_pm_param" type. Only "entry" member of this struct is
used.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           | 6 ++++--
 net/mptcp/pm_netlink.c   | 3 ++-
 net/mptcp/pm_userspace.c | 3 ++-
 net/mptcp/protocol.h     | 4 ++--
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6a504c870e1a..e3457f34621c 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -415,6 +415,7 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 {
 	struct mptcp_pm_addr_entry skc_local;
 	struct mptcp_addr_info msk_local;
+	struct mptcp_pm_param param;
 
 	if (WARN_ON_ONCE(!msk))
 		return -1;
@@ -432,9 +433,10 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	skc_local.addr.id = 0;
 	skc_local.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 
+	mptcp_pm_param_set_contexts(&param, &skc_local, NULL);
 	if (mptcp_pm_is_userspace(msk))
-		return mptcp_userspace_pm_get_local_id(msk, &skc_local);
-	return mptcp_pm_nl_get_local_id(msk, &skc_local);
+		return mptcp_userspace_pm_get_local_id(msk, &param);
+	return mptcp_pm_nl_get_local_id(msk, &param);
 }
 
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 0a0fe890c53d..3709ad2c06ef 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1140,8 +1140,9 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 }
 
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
-			     struct mptcp_pm_addr_entry *skc)
+			     struct mptcp_pm_param *param)
 {
+	struct mptcp_pm_addr_entry *skc = &param->entry;
 	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
 	int ret;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 5b3ee43130be..bd235b2d18b3 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -131,10 +131,11 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
 }
 
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
-				    struct mptcp_pm_addr_entry *skc)
+				    struct mptcp_pm_param *param)
 {
 	__be16 msk_sport =  ((struct inet_sock *)
 			     inet_sk((struct sock *)msk))->inet_sport;
+	struct mptcp_pm_addr_entry *skc = &param->entry;
 	struct mptcp_pm_addr_entry *entry;
 
 	spin_lock_bh(&msk->pm.lock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index dbcf4b84e0f0..7987beaa730e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1122,9 +1122,9 @@ void mptcp_pm_param_set_contexts(struct mptcp_pm_param *param,
 				 const struct mptcp_addr_info *addr);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
-			     struct mptcp_pm_addr_entry *skc);
+			     struct mptcp_pm_param *param);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
-				    struct mptcp_pm_addr_entry *skc);
+				    struct mptcp_pm_param *param);
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
 bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
-- 
2.43.0

