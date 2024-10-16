Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4135205E00
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070006; cv=none; b=fiu8FTraKhKzi6mCzY8iUfJ7JrwFXn4F/5KzidaQDvbun/4+Iw9En66xjk94sqHvEa235rtik1AxIsImRNzpsyHntQKOUGYMS05dNs/t2pFjyMC73t1bWG/uI3Ui28oReA7Rrywgyxw8ENIyLayXhgOULlrtxbsimWtnD+uwh2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070006; c=relaxed/simple;
	bh=gsFr4QHcWTGOUKnHBxjmC7ex3RoNl2UxYGe3yAbAWCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4eA8iwrMx4gjI2wrSyyCTYJfMLbFrlihHpLT9QE5fEKKbuU9oRh9LB7U/SdbgwGWep/H/unUJUeTxqCMHn/d+8dL9gIVmABm15AGsuPIwGoCKYo5oiRMC/br8X/x7omytr28VKLHD6WAV3SurrAgMDrfK0MjlrNmHjgnShdb9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4Ri2FFh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4Ri2FFh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94448C4CECF;
	Wed, 16 Oct 2024 09:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729070006;
	bh=gsFr4QHcWTGOUKnHBxjmC7ex3RoNl2UxYGe3yAbAWCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X4Ri2FFh4LzL9963+ZDOqSbC9kfCiAYTD2BAGHgkNysSMvynS5HCCm/iC88kqb7GM
	 guc8Ao0daxAh0ylG59QgAQnU3NQXfNiL/Q7tuxloSnRkyx69wg0wuuMf0sCUbqp51K
	 Fw7R2ECtfRrw+3wKJyeX3XZn/X+oFw4GRDCDGh7n8gbh1XOc40u2Yph6Yi+Zo8Q/jI
	 pyDYWhH4Tn/UElqG9qFO/cCPKRWITb1/0vifKH9rMiVgjVDG92svOr/08/lF5jt+9d
	 gnbN164FwZLQYDVGcZ6LgrGvxI7yHkgqh4y6F9WqSXBdXFbRc9geKlYG/rXX6K2Rj7
	 vQnSMUtVyqv7g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 23/33] mptcp: drop struct mptcp_pm_local
Date: Wed, 16 Oct 2024 17:12:27 +0800
Message-ID: <82ee6fff2bffda751e680b836dc1d58220bc6158.1729069854.git.tanggeliang@kylinos.cn>
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

The following code in mptcp_pm_nl_subflow_create_doit() that assigns struct
mptcp_pm_addr_entry "entry" to the local struct mptcp_pm_local variable
"local" is not allowed in BPF if we use the same code to implement the
subflow_create() interface of a BFP path manager:

	struct mptcp_pm_local local;

	local.addr = entry.addr;
	local.flags = entry.flags;
	local.ifindex = entry.ifindex;

We should avoid this type of assignment from struct mptcp_pm_addr_entry to
struct mptcp_pm_local.

In fact, there is no need to add a dedicated address entry type for local
address entry. All its fields are the same as struct mptcp_pm_addr_entry,
except that it lacks a "lsk" for the listening socket. So we can use struct
mptcp_pm_addr_entry directly. This makes the path manager code simpler.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 22 ++++++++--------------
 net/mptcp/pm_userspace.c |  7 +------
 net/mptcp/protocol.h     |  8 +-------
 net/mptcp/subflow.c      |  2 +-
 4 files changed, 11 insertions(+), 28 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3029b4e3c1f7..8f91fa2c398b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -149,7 +149,7 @@ static bool lookup_subflow_by_daddr(const struct list_head *list,
 static bool
 select_local_address(const struct pm_nl_pernet *pernet,
 		     const struct mptcp_sock *msk,
-		     struct mptcp_pm_local *new_local)
+		     struct mptcp_pm_addr_entry *new_local)
 {
 	struct mptcp_pm_addr_entry *entry;
 	bool found = false;
@@ -164,9 +164,7 @@ select_local_address(const struct pm_nl_pernet *pernet,
 		if (!test_bit(entry->addr.id, msk->pm.id_avail_bitmap.map))
 			continue;
 
-		new_local->addr = entry->addr;
-		new_local->flags = entry->flags;
-		new_local->ifindex = entry->ifindex;
+		*new_local = *entry;
 		found = true;
 		break;
 	}
@@ -177,7 +175,7 @@ select_local_address(const struct pm_nl_pernet *pernet,
 
 static bool
 select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk,
-		     struct mptcp_pm_local *new_local)
+		     struct mptcp_pm_addr_entry *new_local)
 {
 	struct mptcp_pm_addr_entry *entry;
 	bool found = false;
@@ -195,9 +193,7 @@ select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk,
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
 			continue;
 
-		new_local->addr = entry->addr;
-		new_local->flags = entry->flags;
-		new_local->ifindex = entry->ifindex;
+		*new_local = *entry;
 		found = true;
 		break;
 	}
@@ -534,11 +530,11 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
+	struct mptcp_pm_addr_entry local;
 	unsigned int add_addr_signal_max;
 	bool signal_and_subflow = false;
 	unsigned int local_addr_max;
 	struct pm_nl_pernet *pernet;
-	struct mptcp_pm_local local;
 	unsigned int subflows_max;
 
 	pernet = pm_nl_get_pernet(sock_net(sk));
@@ -660,7 +656,7 @@ static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
  */
 static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 					     struct mptcp_addr_info *remote,
-					     struct mptcp_pm_local *locals)
+					     struct mptcp_pm_addr_entry *locals)
 {
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *entry;
@@ -683,9 +679,7 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 			continue;
 
 		if (msk->pm.subflows < subflows_max) {
-			locals[i].addr = entry->addr;
-			locals[i].flags = entry->flags;
-			locals[i].ifindex = entry->ifindex;
+			locals[i] = *entry;
 
 			/* Special case for ID0: set the correct ID */
 			if (mptcp_addresses_equal(&locals[i].addr, &mpc_addr, locals[i].addr.port))
@@ -721,7 +715,7 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 
 static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 {
-	struct mptcp_pm_local locals[MPTCP_PM_ADDR_MAX];
+	struct mptcp_pm_addr_entry locals[MPTCP_PM_ADDR_MAX];
 	struct sock *sk = (struct sock *)msk;
 	unsigned int add_addr_accept_max;
 	struct mptcp_addr_info remote;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 0012b1965421..c1bc668cce1e 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -339,7 +339,6 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_pm_addr_entry entry = { 0 };
 	struct mptcp_addr_info addr_r;
-	struct mptcp_pm_local local;
 	struct mptcp_sock *msk;
 	int err = -EINVAL;
 	struct sock *sk;
@@ -386,12 +385,8 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
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
index 314f20a436b1..038b50c8e211 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -240,12 +240,6 @@ struct mptcp_pm_data {
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
@@ -743,7 +737,7 @@ bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
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
2.43.0

