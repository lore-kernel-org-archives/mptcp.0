Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9CB13C9D4
	for <mptcp@lists.linux.dev>; Mon,  3 Mar 2025 04:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740975940; cv=none; b=AW6ZkZ7S0LQf12f3oKnF3h2OlLR7l6q93rF7B6KXQigBFlhnOjDE1klGzRJGhvHes5CNV3mE1++Wnm9ObUb6cXpC8TUu3NOuY1kxf7kYjUkqPkH3lFOpONEksdl46UbhAhnL2APudPceFsHHRaG/QYnYnKQRiFIAKCkWo+hTd3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740975940; c=relaxed/simple;
	bh=ch5qu7ELLT8n30XRNlQpXpnV0iyqIrXd5MgS7a63sLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcxe7QEi2hsd7MeSVsusiw0t9re+QPDD+hI+k1O6XmSyhJPlBODNFtU21nh+gfkaEnyMXXBTz7CBMf8SjmG2fkv/goLRbCoq+mVioaL5imqVTgbJrrU6a2+JTVqPXZBwfpiI+Ww7kFrP0XlfjD0QuT4mGuy9shNGfRMlOjREjdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6Ty7pv/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6Ty7pv/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B66C4CEE4;
	Mon,  3 Mar 2025 04:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740975940;
	bh=ch5qu7ELLT8n30XRNlQpXpnV0iyqIrXd5MgS7a63sLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l6Ty7pv/gpiBsUPvmzP2xvUYc7DPGkCeGxHEeH8MSJJRVmRzTuwrgCEu5paKvRbw/
	 xLb/W9497NB24xWhBuqc4kMRjPziZdBlw//AD2bhGUgdiv/iW9/MSKLpqXNKQ3ZobM
	 5oHThQPSlzvsfv95TobjC7kEvi3fFAc5a6+kEfK/3VTeEJmr+Bsm6fGN8PZaIfF3x9
	 ewmA1bqab2LFWEer/kJYf+0J/yP1/T98UaTWLKInmo9V7pukdAR+Or1zqm8Jk0/2+7
	 DMMAF29wVKA17PABE8HyuKMfftC+t7bnMl5KbFidWL8iDgMHtNwOKRcp6Q/26QDDh9
	 Bwl62hlrQYY1Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 11/11] mptcp: pm: make is_backup helpers static
Date: Mon,  3 Mar 2025 12:22:59 +0800
Message-ID: <d5af8eb77f61d28f81ba36925d5f183ce14a2ed6.1740975633.git.tanggeliang@kylinos.cn>
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

Now mptcp_pm_is_backup() can directly invoke get_priority() interface
through "ops" of "msk->pm". Instead of using mptcp_pm_is_userspace()
to check which is_backup() helper to invoke.

Then mptcp_pm_nl_is_backup() and mptcp_userspace_pm_is_backup() helpers
can be static.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           | 5 +----
 net/mptcp/pm_kernel.c    | 3 ++-
 net/mptcp/pm_userspace.c | 4 ++--
 net/mptcp/protocol.h     | 2 --
 4 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 848393511997..89a1a0ba9f79 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -881,10 +881,7 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 
 	mptcp_local_address((struct sock_common *)skc, &skc_local);
 
-	if (mptcp_pm_is_userspace(msk))
-		return mptcp_userspace_pm_is_backup(msk, &skc_local);
-
-	return mptcp_pm_nl_is_backup(msk, &skc_local);
+	return msk->pm.ops->get_priority(msk, &skc_local);
 }
 
 static void mptcp_pm_subflows_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 3d5beaafc3ec..5cc6cda01ba2 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -723,7 +723,8 @@ static int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
 	return ret;
 }
 
-bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
+static bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk,
+				  struct mptcp_addr_info *skc)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct mptcp_pm_addr_entry *entry;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 05495f6e771a..b30c8aa45610 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -146,8 +146,8 @@ static int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 	return mptcp_userspace_pm_append_new_local_addr(msk, skc, true);
 }
 
-bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
-				  struct mptcp_addr_info *skc)
+static bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
+					 struct mptcp_addr_info *skc)
 {
 	struct mptcp_pm_addr_entry *entry;
 	bool backup;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 776f164a21eb..b5f50feb52fa 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1138,8 +1138,6 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
-bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
-bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
-- 
2.43.0

