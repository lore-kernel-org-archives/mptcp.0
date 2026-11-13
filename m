Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599697;
	b=As8aE7N1ZzlT52EttE6UVmuBaPerPzsQd+z946RLFXcgF0Vk4CXlkVBqXYx+0mwo09cm
	 SDfwdYI8afOxdbAapzFG2sTTftBJQw/ISDcCAQjOA6NSNYRGN4Pxj2RjQrkuz9tISWjRW
	 8XdcQO1OYhJKmNEiuMY5hD7v6nP6lT1ISOqkCislDMu3B4E5hu6zMMWtrLR/Z4oiysNNr
	 qbUUC78AOgxcAbHCfnXb5oNRIHufZcrFCK/VkUBfKMYOCyC+vAO61IXxk5B9CBvcsBYt7
	 AENP0Q9FsU7xxhmvXsxm9tyxZpZ1P+ECS+ELQjw6KTyG7RDZqErFWMYxIYBSAudQXGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599697;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=H82IBm6DO/p1viyPZ1HA7TGUJwp1BkQgoerZpC941wM=;
	b=K7YsnUwHdZxP4bewmQrgPxdM7RbRolCiqY0GLm/9RTuuhjOAXSqfdit0Sx7bZQREkjQ6
	 aD3AxJctZJuCRwOec6P/E2M0ge5CTry5wptsjnLwU3q2zCp70ZszRVq2ZpLu3LT34veoq
	 3SangxOU1qtG81AxDSonO0b7dcisn57rmj45lFuTXFo/ymxyv7cB4RIPMLTde6xQag89g
	 AX8+fG2cG5T+YJH5kDQR/y+MJfx0nRorEwtqcjfx4zwjmJlbXM7RpwZ5BysN2nkMJ/VQs
	 z2I3my5zLn28dJFwN/lpnC6z5pjheEWlj9mDDDulz1ZSwlyQKckKOxODfF+TArIuODw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GBWz6o6c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE57E606BCD8
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GBWz6o6c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55801F000CC;
	Fri, 13 Nov 2026 19:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599697;
	bh=H82IBm6DO/p1viyPZ1HA7TGUJwp1BkQgoerZpC941wM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GBWz6o6cgGD2deKcQf+pI8POmqtt5JFZDRmsTyQUSeI/oIMlrMaz+Pip32aJk1oea
	 JrA86zYOCzCSpv2NItJM86T5G07BY0aY0ZCr/xrpi6eASBy37Gyl8U0fLU/tX+xD9c
	 c3IZxZ01iddch0V+q8egk4zf/uC7lA0nHmWsC1uEKm9u417tAOTyfgUDJU+MgUIZb8
	 M/+2MJuwdOfb7z4BBBrYO/FmD5yXnO6IB/6Qb4ARpVSqr3Rz30aPCNv+AbHuzL6tmF
	 /Vsiv26gMCmoGHmTXe4Pg03cH4CkQALhKX4bGLpNUa/OgwV3Xf/MEBf0XTs4ICkiTJ
	 qa9PIPjF4vzFA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:54:08 +0100
Subject: [PATCH mptcp-net 30/34] mptcp: don't charge the backlog twice at
 accept()
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-mptcp-cmason-fixes-v1-30-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5181; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=e+ZCAH8Ga2HEasO5YB/yBUdYv5u1cJJ7E4hqjd550tQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Zz3fuDU+4d4Xjmu7OFSVdz55FJlT8N3gy4utJ2wOT
 KitTJg8t6OUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAi07MYGZpXL9V03rXT3qKq
 +vPNpi97GZnlGMq6LF+6r/8n6a9fdJaR4Y6nwL+OTn2LBZuLF9swP2/+yrP6+1d9uXABiXXfD++
 cygcA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Chris Mason <mason@kernel.org>

accept() can permanently overcharge the memory cgroup of an MPTCP
server, so the server can be OOM killed, if the new connection received
data while its MPTCP socket was locked.

The sockets of an MPTCP connection have no memory cgroup before
accept(), which then charges the sk_forward_alloc and the sk_rmem_alloc
of the MPTCP socket (msk) and of each subflow. mptcp_graft_subflows()
also charges msk->backlog_unaccounted: the truesize of the skbs that
__mptcp_add_backlog() queued while the socket lock of the msk was held
and their subflow had no memory cgroup. But the first charge already
covers each of these skbs that has not been freed, in the sk_rmem_alloc
of its subflow or of the msk, so no later uncharge matches the extra
charge.

The fix used here is to remove msk->backlog_unaccounted, its charge in
mptcp_graft_subflows() and the warning that tests it in
mptcp_can_spool_backlog(). An RFC patch [1] removes the same lines, as
part of another approach.

This issue has been found with the help of an LLM, and reproduced in a
VM, with the reproducer shared with the original version of this patch,
on a kernel with the previous patch: 100,000 connections to an MPTCP
server in a memory cgroup. Without this patch, about 63 MB stayed
charged to this memory cgroup once all the connections were closed, and
to its parent after its removal:

  SNAP label=after-100000 rounds=100000 sockets_left_in_srv=0 tcp_mem_pages=0 [...] c_sock=63295488 [...]
  [...]
  SNAP label=c-removed rounds=100000 sockets_left_in_srv=0 tcp_mem_pages=0 c=removed [...] p_sock=63295488 [...]

And about 12 MB with only 50 connections, each getting 20,000 duplicates
of a byte before accept(), beside bare ACKs with RM_ADDR, which make the
MPTCP worker take the socket lock:

  SNAP label=after-50 rounds=50 sockets_left_in_srv=0 tcp_mem_pages=256 [...] c_sock=12881920 [...]

Fixes: 6228efe0cc01 ("mptcp: leverage the backlog for RX packet processing")
Link: https://lore.kernel.org/all/20260924080219.1036588-4-caixinchen1@huawei.com/ [1]
Signed-off-by: Chris Mason <mason@kernel.org>
[ No comment change: the commit message explains why the backlog is
  covered. Commit message: refer to the RFC [1] removing the same lines
  + how the issue was found, and its symptoms. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 35 +----------------------------------
 net/mptcp/protocol.h |  1 -
 2 files changed, 1 insertion(+), 35 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index dd441e5aa435..2a47107001fc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -798,12 +798,6 @@ static void __mptcp_add_backlog(struct sock *sk,
 
 account:
 	WRITE_ONCE(msk->backlog_len, msk->backlog_len + delta);
-
-	/* Possibly not accept()ed yet, keep track of memory not CG
-	 * accounted, mptcp_graft_subflows() will handle it.
-	 */
-	if (!mem_cgroup_from_sk(ssk))
-		msk->backlog_unaccounted += delta;
 }
 
 static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
@@ -2418,12 +2412,6 @@ static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	/* After CG initialization, subflows should never add skb before
-	 * gaining the CG themself.
-	 */
-	DEBUG_NET_WARN_ON_ONCE(msk->backlog_unaccounted && sk->sk_socket &&
-			       mem_cgroup_from_sk(sk));
-
 	if (list_empty(&msk->backlog_list))
 		return false;
 
@@ -4492,8 +4480,7 @@ static void mptcp_graft_subflows(struct sock *sk)
 		/* Subflows joining after __inet_accept() will get the
 		 * mem CG properly initialized at mptcp_finish_join() time,
 		 * but subflows pending in join_list need explicit
-		 * initialization before flushing `backlog_unaccounted`
-		 * or MPTCP can later unexpectedly observe unaccounted memory.
+		 * initialization by the loop below.
 		 */
 		mptcp_data_lock(sk);
 		list_splice_init(&msk->join_list, &join_list);
@@ -4525,26 +4512,6 @@ static void mptcp_graft_subflows(struct sock *sk)
 unlock:
 		release_sock(ssk);
 	}
-
-	if (mem_cgroup_sk_enabled(sk)) {
-		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
-		int amt;
-
-		/* Account the backlog memory; prior accept() is aware of
-		 * fwd and rmem only.
-		 */
-		mptcp_data_lock(sk);
-		amt = sk_mem_pages(sk->sk_forward_alloc +
-				   msk->backlog_unaccounted +
-				   atomic_read(&sk->sk_rmem_alloc)) -
-		      sk_mem_pages(sk->sk_forward_alloc +
-				   atomic_read(&sk->sk_rmem_alloc));
-		msk->backlog_unaccounted = 0;
-		mptcp_data_unlock(sk);
-
-		if (amt)
-			mem_cgroup_sk_charge(sk, amt, gfp);
-	}
 }
 
 static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d76eaed4f01e..18222dd78fed 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -392,7 +392,6 @@ struct mptcp_sock {
 
 	struct list_head backlog_list;	/* protected by the data lock */
 	u32		backlog_len;
-	u32		backlog_unaccounted;
 };
 
 #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)

-- 
2.55.0

