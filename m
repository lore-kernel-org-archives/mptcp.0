Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254181;
	b=O35FNuzFBcNvLoqje078MIeBLqXzXRpNrHDeVpjVBl5dFRozPQYOGguLMGfC9Afz3vfV
	 VqZSsCSMo9ugzFbEZ5YIVQpd+gJ8Cf8eSTizGRK9egJuWFx1UIiukafauf5okTKrJYlFO
	 tbf6rJfWnXSpIO8jRH15OHCfTs4Ti/qO0V0yndLoF2mRUdfg+Uvsysx+meEMrDbmXI82I
	 cLaXupA49FWDJjU/D1QFMwSHGzZnzJ5TNRLzn29ExVDX9UPw7ToMRTWSfRtNPq1TR3212
	 ECedAI02hdFJUq6LgfLPcWlbo2B1QDkLlJlUuiUAQe92LfhvCTBHDzo1BTYG9hqMAKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254181;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=L1gvAJYNOqbRb4bvNcN6DGiZGp3u5no0S21usfmnpGk=;
	b=NAY4/g1HTKnGss0+vbfIR0XSCbKdjN/EAj8k69MEei2FV1FOwWfnSCBGWZ0kap4BaAYC
	 57zUG1qbB+OPN6uxCPY9NIHL6HCmfe/C6keytLcxpAPyonVpxn+WLKo8lXFuZeKWMe90Y
	 RTY3mdBPPIjal4Z5Grpebs642u7Ue12TVmfHllTJLCo7gYneholavyIEnqoeMhs94A8Fl
	 8FVd2d7J4VG2aTsDn6Vp6X4GEtgdGW76WkdnEUiYt7PcVw7EocKHWisCtMUJMXm1DBFiV
	 xWdqR0d48XfzmQnkdciTm5x9W9ad9JeVmiHvaoZ85DLYdJ31pya6VxCjJWa8uOmc2Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=izxvMkbs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A334F606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=izxvMkbs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A6E1F000C4;
	Sat, 21 Nov 2026 09:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254181;
	bh=L1gvAJYNOqbRb4bvNcN6DGiZGp3u5no0S21usfmnpGk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=izxvMkbswof5IgbyMZDgqqcmjbtq+8ltaAmgQpihEJolutEfctJvvVPMbpbVQ+vgs
	 ZemfFOwBPkbvFiaNs/o2FBuulbC9tKzbuL0OjF1Z6btcdZn7rolqgKPHWt47Cjxn0N
	 li3WmcHRGSeJT+HpfBiTNmbNHBOhK2/JWZJSj1cffAhcBLPE0JdKTWzTJ7t7nPje+M
	 pTDtuuGML8QNxC2+RF43ulrSb65jwGcO29fV5HsbfIzQiaepueWKPvM75rvTytchR/
	 NcESFamFUxkm0/z2vFPBVgnsb9D1wQf04tit6S7dwa7fNoZNhWN0PnJkY64Z/heCEm
	 W5+MLoDHuaEAA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:46 +0100
Subject: [PATCH mptcp-net v2 48/62] mptcp: don't charge the backlog twice
 at accept()
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-48-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5181; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Y6+xTjfUbeJYg+bBesSZxSAYvxzjy5tMgpZ5jslWtdg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ03Mc0sUF5Nhq+jeHPRFazDjvesydy8dCfs6avKPr5
 dw33/12dpSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExk4SKGv1J//hS3cT9o5uKs
 mrZyxqUN5kdD5l6Z/N/Do7licYrvs5UM/6tXTJ+wW3rKvAJXjtTt299PmRZUmXPcQ79vQ5rMtFc
 vbfkA
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
index 8749ba146363..9f5e8b5cde60 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -802,12 +802,6 @@ static void __mptcp_add_backlog(struct sock *sk,
 
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
@@ -2454,12 +2448,6 @@ static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs)
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
 
@@ -4663,8 +4651,7 @@ static void mptcp_graft_subflows(struct sock *sk)
 		/* Subflows joining after __inet_accept() will get the
 		 * mem CG properly initialized at mptcp_finish_join() time,
 		 * but subflows pending in join_list need explicit
-		 * initialization before flushing `backlog_unaccounted`
-		 * or MPTCP can later unexpectedly observe unaccounted memory.
+		 * initialization by the loop below.
 		 */
 		mptcp_data_lock(sk);
 		list_splice_init(&msk->join_list, &join_list);
@@ -4696,26 +4683,6 @@ static void mptcp_graft_subflows(struct sock *sk)
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
index d0ae782c9ade..9a9dbab672af 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -394,7 +394,6 @@ struct mptcp_sock {
 
 	struct list_head backlog_list;	/* protected by the data lock */
 	u32		backlog_len;
-	u32		backlog_unaccounted;
 };
 
 #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)

-- 
2.55.0

