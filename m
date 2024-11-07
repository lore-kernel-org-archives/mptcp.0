Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F5482C60
	for <mptcp@lists.linux.dev>; Thu,  7 Nov 2024 06:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730961962; cv=none; b=BcS+6np4gAo7Ivt+0icb2lgFQFQ08D+o3Q9MkJcqCA9I0tA934HFZJBdA/PaWE0hqcxfa6Qb/k0gaQ6s35mu7sPSD8bB27noXJoevJZ1fEv8hFWHoDsIfExfRJ9iJyyxa+RHj8GOJdcGeM+PJzEbJG+X82xmK9e0l2NbU+ZZYHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730961962; c=relaxed/simple;
	bh=KNLyy3WOxdQ4fKinaki2JR9AWUseKrMcP6S6KdqA1IM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VolcbD5M+ewzzBE7ocy6THMBLmKGRuiRGb99OU6XEkXU8DkEmawVEwZn1tbVyK6DZW+2LgSnA99AAA3ydJ2oKEUHnxywvbHGawXW5WF5sRJeVZmgZe5LHl0SdJ25v5/8q6QQrXbUKNhF+QCkDZiTIrVz/FtTVej5BpgN6l2dagk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYvPTX3y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYvPTX3y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747B1C4CECC;
	Thu,  7 Nov 2024 06:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730961961;
	bh=KNLyy3WOxdQ4fKinaki2JR9AWUseKrMcP6S6KdqA1IM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bYvPTX3yK8mqMeKL6oPjgqxPswFuAeZGF1ukRSr1HVnAJGz2Kt+UM7Wv5TpGOf7ah
	 EAQJtetVAjAfRMHK7o0hd9M2L5Np0HrRDVcYu3yoIvEbZMJ79PjXyiwUUVuUT0RCrB
	 ds1rB1NIaSlFTCAsA4uqVieI/0R1IIUUnHuikWaQcB3LXwmyzJk8uJ31O1eqCc6Y/7
	 R6/qb+4e6rveIft16kpZKLZvsKhobtnARUFmZZiwuo7gDTeV4AHhVmh4zkhD/qPV7X
	 4jpFQLJwPY9hB4hn8Wgy2J6X6BwUH/pLHhZmd4Pew8/rykv4HthRwiW7OT8u/4kBPi
	 73O7bqwZ4fhmA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 6/9] mptcp: use mptcp_pm_local in pm_netlink only
Date: Thu,  7 Nov 2024 14:45:40 +0800
Message-ID: <b101754b454313dadde8c89634982f9052e0cfc7.1730961810.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1730961809.git.tanggeliang@kylinos.cn>
References: <cover.1730961809.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

struct mptcp_pm_local is used in pm_netlink to reduce memory usage, but
it has less effect in pm_userspace because userspace pm doesn't use an
array of struct mptcp_pm_addr_entry type.

So this patch moves struct mptcp_pm_local to pm_netlink and restores the
use of mptcp_pm_addr_entry type parameters in __mptcp_subflow_connect().
In this case, only one "struct mptcp_pm_addr_entry" is needed, that's not
reserving too much memory.

This patch makes the path manager code simpler, and easier to implement
the BPF path manager.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 26 ++++++++++++++++++++++----
 net/mptcp/pm_userspace.c |  7 +------
 net/mptcp/protocol.h     |  8 +-------
 net/mptcp/subflow.c      |  2 +-
 4 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 8aba7670345d..00911fae5d88 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -40,6 +40,12 @@ struct pm_nl_pernet {
 	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 };
 
+struct mptcp_pm_local {
+	struct mptcp_addr_info	addr;
+	u8			flags;
+	int			ifindex;
+};
+
 #define MPTCP_PM_ADDR_MAX	8
 #define ADD_ADDR_RETRANS_MAX	3
 
@@ -638,8 +644,14 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			continue;
 
 		spin_unlock_bh(&msk->pm.lock);
-		for (i = 0; i < nr; i++)
-			__mptcp_subflow_connect(sk, &local, &addrs[i]);
+		for (i = 0; i < nr; i++) {
+			struct mptcp_pm_addr_entry entry = { 0 };
+
+			entry.addr = local.addr;
+			entry.flags = local.flags;
+			entry.ifindex = local.ifindex;
+			__mptcp_subflow_connect(sk, &entry, &addrs[i]);
+		}
 		spin_lock_bh(&msk->pm.lock);
 	}
 	mptcp_pm_nl_check_work_pending(msk);
@@ -755,9 +767,15 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 		return;
 
 	spin_unlock_bh(&msk->pm.lock);
-	for (i = 0; i < nr; i++)
-		if (__mptcp_subflow_connect(sk, &locals[i], &remote) == 0)
+	for (i = 0; i < nr; i++) {
+		struct mptcp_pm_addr_entry entry = { 0 };
+
+		entry.addr = locals[i].addr;
+		entry.flags = locals[i].flags;
+		entry.ifindex = locals[i].ifindex;
+		if (__mptcp_subflow_connect(sk, &entry, &remote) == 0)
 			sf_created = true;
+	}
 	spin_lock_bh(&msk->pm.lock);
 
 	if (sf_created) {
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index a98da9a44bfa..db09350b5022 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -368,7 +368,6 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_pm_addr_entry entry = { 0 };
 	struct mptcp_addr_info addr_r;
-	struct mptcp_pm_local local;
 	struct mptcp_sock *msk;
 	int err = -EINVAL;
 	struct sock *sk;
@@ -415,12 +414,8 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	local.addr = entry.addr;
-	local.flags = entry.flags;
-	local.ifindex = entry.ifindex;
-
 	lock_sock(sk);
-	err = __mptcp_subflow_connect(sk, &local, &addr_r);
+	err = __mptcp_subflow_connect(sk, &entry, &addr_r);
 	release_sock(sk);
 
 	spin_lock_bh(&msk->pm.lock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 19a811220621..775ac2fd6854 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -236,12 +236,6 @@ struct mptcp_pm_data {
 	struct mptcp_rm_list rm_list_rx;
 };
 
-struct mptcp_pm_local {
-	struct mptcp_addr_info	addr;
-	u8			flags;
-	int			ifindex;
-};
-
 struct mptcp_pm_addr_entry {
 	struct list_head	list;
 	struct mptcp_addr_info	addr;
@@ -736,7 +730,7 @@ bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr);
 
 /* called with sk socket lock held */
-int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
+int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_addr_entry *local,
 			    const struct mptcp_addr_info *remote);
 int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 				struct socket **new_sock);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 07352b15f145..2ae8f467abc1 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1586,7 +1586,7 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 #endif
 }
 
-int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
+int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_addr_entry *local,
 			    const struct mptcp_addr_info *remote)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-- 
2.45.2

