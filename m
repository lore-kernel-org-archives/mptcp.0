Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893FD163
	for <mptcp@lists.linux.dev>; Sun, 23 Feb 2025 14:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740320840; cv=none; b=HrQGitNpZWcuIlRRnA2fRGkeKkEE5apZCCdMlKfMxaHRfxtxZ6Mfv5SKTM3vZOBlB2jLcUSg3ew5A3KEZeHksqkNmmwBEw/AkicmtSYH+uCbV7xH+Cuqf5xLtG//Nxsn+5jN4MkJ+Ev0y8RcPhEnD9/1/cyHdjLndkZ5RyW+57w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740320840; c=relaxed/simple;
	bh=VaxlueEpyL6CFmRKiJDLB1qXryLZmlosRKG6JmfCLeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nB+lsQt3Iz1OXJtL/G6huj6z7ya2gAiy8sMYiXwkZ7Bk83sYvow6zXd6M0i+vcznCOtMccs4tfWIfYKS65/qXSDVQz2BszaWhes5NqQ93TSOKtKt5mren4YwOTg16QNcd4QxjgtfYmiInliz7DG3AAnPXRW+GpJv7TdE+zk7+z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHj9YUtJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHj9YUtJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477CBC4CEE7;
	Sun, 23 Feb 2025 14:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740320840;
	bh=VaxlueEpyL6CFmRKiJDLB1qXryLZmlosRKG6JmfCLeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WHj9YUtJVGN6pH/JX2kp/ljIKALR6SpYkJAvuCrZBSL6Oow8fdoOc9mPQ5MCpMZ6D
	 9ZDWjVVdy5owCr1d1KsWr+vmtQKPlTt4zIIBluNa/5hzC5bl5Vpr6A/zY+mlB/wI0f
	 BEhbSaPxIbRNzItZncAl2fzGf76m9WsJ6VnHOtMgS268K9Fb1I2TeVsXsPdMqY4wu6
	 IDOICTy73Q81b+V0Rk/a+woMs1ZfZUNbhmTvmh2N4+6aahQysetAyoO236Wb9ng7KP
	 k4ZWfL9pCunzbdRQZ0NlGONX0ico+98gqLN6H0z4Ce8TLZxoH+80Z+WYRQilzbVMW4
	 +ihnAe0kAoA6Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 12/13] mptcp: pm: drop is_backup helpers
Date: Sun, 23 Feb 2025 22:26:17 +0800
Message-ID: <0262f8f4937db2daebaffd8f375dd8dc623b45fb.1740320007.git.tanggeliang@kylinos.cn>
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

Now mptcp_pm_nl_is_backup() and mptcp_userspace_pm_is_backup()
helpers can be dropped, and mptcp_pm_is_backup() can directly
invoke get_priority() interface through "ops" of "msk->pm".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           | 5 +----
 net/mptcp/pm_netlink.c   | 5 -----
 net/mptcp/pm_userspace.c | 6 ------
 net/mptcp/protocol.h     | 2 --
 4 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 06be751fea21..9db1c62ae0cd 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -434,10 +434,7 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 
 	mptcp_local_address((struct sock_common *)skc, &skc_local);
 
-	if (mptcp_pm_is_userspace(msk))
-		return mptcp_userspace_pm_is_backup(msk, &skc_local);
-
-	return mptcp_pm_nl_is_backup(msk, &skc_local);
+	return msk->pm.ops->get_priority(msk, &skc_local);
 }
 
 static int mptcp_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 64808f4e7808..5932be406bde 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1184,11 +1184,6 @@ static bool mptcp_pm_nl_get_priority(struct mptcp_sock *msk,
 	return backup;
 }
 
-bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
-{
-	return mptcp_pm_nl_get_priority(msk, skc);
-}
-
 #define MPTCP_PM_CMD_GRP_OFFSET       0
 #define MPTCP_PM_EV_GRP_OFFSET        1
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 3c8b61ed345b..b618dc7c916a 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -163,12 +163,6 @@ static bool mptcp_userspace_pm_get_priority(struct mptcp_sock *msk,
 	return backup;
 }
 
-bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
-				  struct mptcp_addr_info *skc)
-{
-	return mptcp_userspace_pm_get_priority(msk, skc);
-}
-
 static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *info)
 {
 	struct mptcp_sock *msk;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b6441328dc3c..0aa882e175f1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1137,8 +1137,6 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
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

