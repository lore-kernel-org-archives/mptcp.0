Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557700;
	b=o94CgrADci/i65iADhUn6g9GULf7APT93pHSYRcElsd34Gh9jQXuJ1Mc19+KE5ZMkOXg
	 47fgRywX+h+D1g3VOt9uQ3i3sS4ecR40JZ37oByk2szRCH0HEJA2ZyCbZCx3VDGMiTZzS
	 x50ltRqIh+EFseG4IW6vrXVWLMPlWDkwS+zJZyze3Sc//voGRSrqwYaKLVxKYWYyCIbIC
	 DNKBVoWt0uKKCtxz/ltgtbRvGveCKWSarF6VwIDgbU0cv+ckvtfWCHuoXVF5IUURQXQUB
	 tIHPjnFJJeXV39qKt35vNx5Ebo7m1RRhbw6fUcGScC1Ow7/II8BXhn43zCBBT+r6Xxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557700;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=7pRhur8ZGxhqu3F51REZblc0i0b68VtaqNjP9V5f5K8=;
	b=xfIt1DPrzxKhv1skKfoM+6abeMCskAykL3mEUjxSxc3p48d7lU+YKm+dL/wURzV85MZ+
	 bF19fY9o8mb86OnL+CB1K8/Zsr53ezEiEQOYfeBOplx+W+uklAHItgnELgIgbgt0+1W0m
	 CevxUws7BNiup2lAnK7O28V2hnKOrV4MFV7V48siKUXMvPMxCw6fLFWG3N8OTWMtqdkfD
	 dD6SEAFVr8APtOFzODRIc0Y7TGuyRxin6r/3rIzG1RWH/cWNTKni8ajU+vYG4UrIxGiPW
	 S7Ui01OexRN/zLSZp+lQkFMi93aIRRmIJJAd/muq/HaIyUoMyB3LkKaSVlfOyJvAPQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WRSSI9Nz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EC2606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WRSSI9Nz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0E71F000C0;
	Tue, 24 Nov 2026 22:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557699;
	bh=7pRhur8ZGxhqu3F51REZblc0i0b68VtaqNjP9V5f5K8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WRSSI9Nzn1/0MNF5jZUN4Zdh8HohQ8w/PrV+ieeg3Iv35iJ1kWEaAvErB8chGwcmD
	 PsDLLLP7TgKnXhzmXNz0LSQ5kydtF/bq5ax+K3/g7ZqYcO4X2niIsz85aacUc5ZNj2
	 +3NEKOd3hrXukwmxDSdRwJiCCDrryfwhXVuIv0do/4Sfa6wL+7P9gt1k2XyhaSJ8hU
	 GTFxGvbbEvNS8MR9kIBs53m1hIwVV4jDlsHtVuGg/FgpCXCItWPbPeDtS+s1JQtxVM
	 e7kdONikCCX39W254zWkIF6Pq3o6RpqpyWM/5QoUoQ8x6NMAbfA6xIrwS7Z7AWJzNA
	 7Ab8CK3a+vmDA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:51 +0100
Subject: [PATCH mptcp-net v3 34/50] mptcp: don't charge the backlog twice
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-34-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5181; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ViU/v4vjAFCtLCIc8A18W+U8OR1e85ZfOGtR/5xOMWA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOHnmv9dLX1h/0G6mh06aT2jVBCfRZcePZL7judFy7
 uDqTyr8HaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABPxmM7I0PUk7d6uZRKy6+wO
 bLzMoWJkLyW07MDtrP69767Y905508jIMC/zOF+zeVhU86p/oQvLlq25kXWl3C7igCtLT4SYy5n
 jTAA=
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
index 504fe4a9954f..c9ef23276399 100644
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
@@ -2456,12 +2450,6 @@ static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs)
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
 
@@ -4691,8 +4679,7 @@ static void mptcp_graft_subflows(struct sock *sk)
 		/* Subflows joining after __inet_accept() will get the
 		 * mem CG properly initialized at mptcp_finish_join() time,
 		 * but subflows pending in join_list need explicit
-		 * initialization before flushing `backlog_unaccounted`
-		 * or MPTCP can later unexpectedly observe unaccounted memory.
+		 * initialization by the loop below.
 		 */
 		mptcp_data_lock(sk);
 		list_splice_init(&msk->join_list, &join_list);
@@ -4724,26 +4711,6 @@ static void mptcp_graft_subflows(struct sock *sk)
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

