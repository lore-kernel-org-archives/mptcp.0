Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060E640D584
	for <mptcp@lists.linux.dev>; Sat, 27 Jun 2026 02:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782528267; cv=none; b=ZCtRBHjTM4zzmmEkLsBKZgcLFu0vhGCsc34RfT9GeeJLL9q4Awx0D7zBZ+cCgjsP+p58c9BIRL2NVz5jlOC9DoUg4gbCxaQZp+X1WBnFfEFA/gzqpiEXJj/2Txc0Q6bcADiqTp4KQKfsgAuZOoAxEQUo9gazH7QdaATUX/1YwrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782528267; c=relaxed/simple;
	bh=NTbleiPMETtJkkv0/RiE3XteDjCVdQjlCYKZLBKZuzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TYkeoq+leACYlxwQt6p5fjL+lqs0aH+ON/r/1N2jvr84Y3G+q84Fvbp4URDg4J3Pv8aRWE8giPN0TVlneXbDEG6gYxDZ5WngvSsqF8/V4BoPafPWX3uv6RMc64KOzLwxCyZnSXzQgDPbBASJyQA7P5Ca3WOrwd7tl84M2FMkv2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAe7ck+x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAe7ck+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0771F000E9;
	Sat, 27 Jun 2026 02:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782528265;
	bh=CAAJmUBfv5DdaXylTvTL/UBZpjlCBmn1zuA7+lfy448=;
	h=From:To:Cc:Subject:Date;
	b=LAe7ck+xacTW8PdOx7Sul4rJMEmA2HDb9r0gDf0PYsXwEtNI9F4MPKD9eZZkQx71a
	 MYHj38Rey5OUjKIDJ/1nWj0Rlizpt/GvikH72kisy1mad4d5NrFGBX6Uhq9mSOe9PK
	 oEPLd+fkeA8GOEoT1n6YtuLHbuGDsAqXPdyfc7Qh5pWCQOyqaf+CVmyllQ0QlUXWEw
	 jm/x0VXvm3UflmDZB+9qeld04h2mIHxQNdqDEcFGpClFKPrMHWm0HYEuJJl4WNzEv+
	 sFuqnG5JRCpbUMXQiTGfzR1UGyqsYOsgJXGgqbcdwv4UrdVPnlrw21lRFW1SNVQnlm
	 sr+TkDWkUn59w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net] mptcp: pm: userspace: fix memory quota with RCU delayed free
Date: Sat, 27 Jun 2026 10:44:20 +0800
Message-ID: <9b443bafa57f40a51eb6a43f088ff37d71b39973.1782528088.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In mptcp_pm_nl_remove_doit(), sk_omem_alloc is decremented immediately
but the memory is freed later via kfree_rcu(). This allows a CAP_NET_ADMIN
user to bypass the socket memory quota and exhaust kernel memory by
accumulating RCU callbacks.

Fix by using call_rcu() with a custom callback that uses sock_kfree_s()
to free the entry and decrement sk_omem_alloc atomically. To ensure the
socket remains valid until the callback runs, take a reference with
sock_hold() when storing the socket pointer in the entry, and release it
with sock_put() in the callback.

Fixes: 13b4ece33cf9 ("mptcp: pm: Defer freeing of MPTCP userspace path manager entries")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
This patch addresses the pre-existing issue Sashiko mentioned in
https://sashiko.dev/#/patchset/cover.1782457962.git.tanggeliang@kylinos.cn.
---
 net/mptcp/pm_userspace.c | 18 +++++++++++++-----
 net/mptcp/protocol.h     |  2 ++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index ad6ba658e5a5..7bd20e833d02 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -73,6 +73,8 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 			ret = -ENOMEM;
 			goto append_err;
 		}
+		sock_hold(sk);
+		e->sk = sk;
 
 		if (!e->addr.id && needs_id)
 			e->addr.id = find_next_zero_bit(id_bitmap,
@@ -294,6 +296,16 @@ void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 	spin_unlock_bh(&msk->pm.lock);
 }
 
+static void mptcp_userspace_pm_free_entry(struct rcu_head *head)
+{
+	struct mptcp_pm_addr_entry *entry =
+		container_of(head, struct mptcp_pm_addr_entry, rcu);
+	struct sock *sk = entry->sk;
+
+	sock_kfree_s(sk, entry, sizeof(*entry));
+	sock_put(sk);
+}
+
 int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry *match;
@@ -337,11 +349,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	release_sock(sk);
 
-	kfree_rcu_mightsleep(match);
-	/* Adjust sk_omem_alloc like sock_kfree_s() does, to match
-	 * with allocation of this memory by sock_kmemdup()
-	 */
-	atomic_sub(sizeof(*match), &sk->sk_omem_alloc);
+	call_rcu(&match->rcu, mptcp_userspace_pm_free_entry);
 
 	err = 0;
 out:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index da40c6f3705f..250736eae0be 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -257,6 +257,8 @@ struct mptcp_pm_addr_entry {
 	u32			flags;
 	int			ifindex;
 	struct socket		*lsk;
+	struct sock		*sk;
+	struct rcu_head		rcu;
 };
 
 struct mptcp_data_frag {
-- 
2.53.0

