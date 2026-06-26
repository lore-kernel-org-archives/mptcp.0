Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9141E2F8E8E
	for <mptcp@lists.linux.dev>; Fri, 26 Jun 2026 07:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782458190; cv=none; b=CAcOTg9oL3yrGD+gUkTUhxDyk6NH3KSCzMQFoHgcHrB1ZrKiXaKQc3gvCBgzlWqauwtXZqLupI1BgwjjA5LXeCix+dcVF8laUTmnnJQWbM0rThcnh5g91A3nGb4S5rQrrUgd84+jyKqzToMlEyZOm08gyTlfo5zoieFe69kYeqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782458190; c=relaxed/simple;
	bh=kJACSEWu7WrCR7/aUsj0mlsOAlB4qUDb5nzIaJ0PPt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/KSBcaNHiPUhGnfVJEuJ63GQw7JgQ4Z8gmPZNPv2JR3mgfyZWzjZmWP7eoagb7f+XxPOeFLRvhZyaSqkc8rZqReErstcJS7QDkR0VqteivQLSTPDZOSv3VZ6fUEa7CRdQSUXCFb2W2D/EaVmegm5jDcPDl1VXo59g/PARHgmB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUhbOf10; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUhbOf10"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACAB1F00A3D;
	Fri, 26 Jun 2026 07:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782458189;
	bh=T+NvHeUcISPl13KIV1vBD0DEtiMRJjo9GbNJtF2igaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oUhbOf10Bs052l9+bA62MmnIsxhp6sO1K5SbQ5+i9VS4z4fL82J9N7Cd0Btws/Rlb
	 7x0Bj1mTqwip05R4ux4tmEw0fq0V9YI5VrBiIqrkc4h7VCOs8fXBHzrxZaG3dKfK5m
	 /JZE7Ms60AsjHLPknbZveOWetLHUazsHyblociNkbLQm4409aq70BHisEgwlgYPZH+
	 MWXjfNmUN7IMCl8Fp8QXwCBNmhVA6Otao3rAvgrDvie2Rgb2CpGCh4rBJd2ekd2DaE
	 wzSAQHirw3tC9X0inV5YxeLvTA+Mn/UiPU4BPqI+31VrbRW8cb2EjS3DV2TMh4tNFr
	 Wyy6JHzRTbAFg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v5 1/3] mptcp: pm: userspace: drop delete_local_addr helper
Date: Fri, 26 Jun 2026 15:16:16 +0800
Message-ID: <79e3304ab18efa6a714839d7ca19e45708934120.1782457962.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782457962.git.tanggeliang@kylinos.cn>
References: <cover.1782457962.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Address entries should not be removed from local_addr_list when a subflow
is deleted by the userspace PM, should only be removed when sending a
REMOVE_ADDR.

So mptcp_userspace_pm_delete_local_addr() helper shouldn't be called in
mptcp_pm_nl_subflow_create_doit() and mptcp_pm_nl_subflow_destroy_doit().

Since this helper is open-coding in mptcp_pm_nl_remove_doit(), it can be
dropped now.

Address entries are removed from local_addr_list when sending a REMOVE_ADDR
by the userspace PM, the local_addr_used counter of PM should also be
decremented accordingly.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/403
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 35 ++---------------------------------
 1 file changed, 2 insertions(+), 33 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index ad6ba658e5a5..45463f2f1e60 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -90,30 +90,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	return ret;
 }
 
-/* If the subflow is closed from the other peer (not via a
- * subflow destroy command then), we want to keep the entry
- * not to assign the same ID to another address and to be
- * able to send RM_ADDR after the removal of the subflow.
- */
-static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
-						struct mptcp_pm_addr_entry *addr)
-{
-	struct sock *sk = (struct sock *)msk;
-	struct mptcp_pm_addr_entry *entry;
-
-	entry = mptcp_userspace_pm_lookup_addr(msk, &addr->addr);
-	if (!entry)
-		return -EINVAL;
-
-	/* TODO: a refcount is needed because the entry can
-	 * be used multiple times (e.g. fullmesh mode).
-	 */
-	list_del_rcu(&entry->list);
-	sock_kfree_s(sk, entry, sizeof(*entry));
-	msk->pm.local_addr_used--;
-	return 0;
-}
-
 static struct mptcp_pm_addr_entry *
 mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
 {
@@ -331,6 +307,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	list_del_rcu(&match->list);
+	msk->pm.local_addr_used--;
 	spin_unlock_bh(&msk->pm.lock);
 
 	mptcp_pm_remove_addr_entry(msk, match);
@@ -416,14 +393,9 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	err = __mptcp_subflow_connect(sk, &local, &addr_r);
 	release_sock(sk);
 
-	if (err) {
+	if (err)
 		GENL_SET_ERR_MSG_FMT(info, "connect error: %d", err);
 
-		spin_lock_bh(&msk->pm.lock);
-		mptcp_userspace_pm_delete_local_addr(msk, &entry);
-		spin_unlock_bh(&msk->pm.lock);
-	}
-
  create_err:
 	sock_put(sk);
 	return err;
@@ -540,9 +512,6 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 		goto release_sock;
 	}
 
-	spin_lock_bh(&msk->pm.lock);
-	mptcp_userspace_pm_delete_local_addr(msk, &addr_l);
-	spin_unlock_bh(&msk->pm.lock);
 	mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
 	mptcp_close_ssk(sk, ssk, mptcp_subflow_ctx(ssk));
 	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
-- 
2.53.0

