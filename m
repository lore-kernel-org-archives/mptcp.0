Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39985306482
	for <mptcp@lists.linux.dev>; Fri, 14 Nov 2025 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763111853; cv=none; b=YMGgzYB3Tc/VEhuRAWn634V/iG2hjPeH7HXcqDbljbnOrpaSxL2mdteSzFswDcRy50ekv//Mqnj9E7kNAo/pHUOk3QI+3VHG0NPm9YhXvJYg2YovnALqjP/iBjQTFx4T54czNdzAVoxaMzXemFAPoHegK0rwgUxZIwMn7FM/mio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763111853; c=relaxed/simple;
	bh=/CYJLyQn2n0CDNeRzNqoO0z25QvPgF0U0FXl2/CgiwU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=UtfugOUsig4fHoeq1h1Lc7bu/tL/ozBrFWf9L3hDIOC2zQwF0rj1PemJ3xQMUubUB5oJQIl/NOYdMor1QU6LJfcQJZaMnka3IUR4sH604u6iQY1EarEyusHFWWrTbCLDAnvVaI3iaBwGs/dinpSZ9H+100fAyZFMvULLoCBdtY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SOZx4KFQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOZx4KFQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763111851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r04fH9s6q2z3sXswqtpreQvr6eQAnIgPSR25ar7VrDg=;
	b=SOZx4KFQZSqXxd1caxE8PlhYEuGYFdKzNEcJsvSXkUDgRDiNDjDf0npYQEhTvPbSWtztm4
	9fz1ypFBmYNrrPI7ohawWzzMNfSCFUyvNQ6DRDbxFcv1n0CA6hE4JUINIfmAVWDJylqlSb
	2vGN15c2qDDVF0Y1XHnoddJJw8dzM9c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-7ePpACd7OBiNEESc_0bL4Q-1; Fri,
 14 Nov 2025 04:17:29 -0500
X-MC-Unique: 7ePpACd7OBiNEESc_0bL4Q-1
X-Mimecast-MFC-AGG-ID: 7ePpACd7OBiNEESc_0bL4Q_1763111849
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5A30180047F
	for <mptcp@lists.linux.dev>; Fri, 14 Nov 2025 09:17:28 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.173])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 187451800451
	for <mptcp@lists.linux.dev>; Fri, 14 Nov 2025 09:17:27 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v4 mptcp-next 3/3] Squash-to: "mptcp: leverage the backlog for RX packet processing"
Date: Fri, 14 Nov 2025 10:17:14 +0100
Message-ID: <89f8e00a62b8255050d498b861c7e4785c375775.1763111767.git.pabeni@redhat.com>
In-Reply-To: <cover.1763111767.git.pabeni@redhat.com>
References: <cover.1763111767.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TmE1QZjV92I689WMFBUW3Lszmz_dCgevnJ3-P3eAC0U_1763111849
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

If a subflow receives data before gaining the memcg while the msk
socket lock is held at accept time, or the PM locks the msk socket
while still unaccepted and subflows push data to it at the same time,
the mptcp_graph_subflows() can complete with a non empty backlog.

The msk will try to borrow such memory, but (some) of the skbs there
where not memcg charged. When the msk finally will return such accounted
memory, we should hit the same splat of #597.
[even if so far I was unable to replicate this scenario]

This patch tries to address such potential issue by:
- explicitly keep track of the amount of memory added to the backlog
  not CG accounted
- additionally accounting for such memory at accept time
- preventing any subflow from adding memory to the backlog not CG
  accounted after the above flush

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v3 -> v4:
  - fixed a bunch of typos
  - fixed build error when CG are not enabled
---
 net/mptcp/protocol.c | 64 +++++++++++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.h |  1 +
 2 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2364c144bf4f..ad3c43a9c3f4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -678,6 +678,7 @@ static void __mptcp_add_backlog(struct sock *sk,
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sk_buff *tail = NULL;
+	struct sock *ssk = skb->sk;
 	bool fragstolen;
 	int delta;
 
@@ -691,18 +692,26 @@ static void __mptcp_add_backlog(struct sock *sk,
 		tail = list_last_entry(&msk->backlog_list, struct sk_buff, list);
 
 	if (tail && MPTCP_SKB_CB(skb)->map_seq == MPTCP_SKB_CB(tail)->end_seq &&
-	    skb->sk == tail->sk &&
+	    ssk == tail->sk &&
 	    __mptcp_try_coalesce(sk, tail, skb, &fragstolen, &delta)) {
 		skb->truesize -= delta;
 		kfree_skb_partial(skb, fragstolen);
 		__mptcp_subflow_lend_fwdmem(subflow, delta);
-		WRITE_ONCE(msk->backlog_len, msk->backlog_len + delta);
-		return;
+		goto account;
 	}
 
 	list_add_tail(&skb->list, &msk->backlog_list);
 	mptcp_subflow_lend_fwdmem(subflow, skb);
-	WRITE_ONCE(msk->backlog_len, msk->backlog_len + skb->truesize);
+	delta = skb->truesize;
+
+account:
+	WRITE_ONCE(msk->backlog_len, msk->backlog_len + delta);
+
+	/* Possibly not accept()ed yet, keep track of memory not CG
+	 * accounted, mptcp_graft_subflows() will handle it.
+	 */
+	if (!mem_cgroup_from_sk(ssk))
+		msk->backlog_unaccounted += delta;
 }
 
 static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
@@ -2179,6 +2188,12 @@ static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
+	/* After CG initialization, subflows should never add skb before
+	 * gaining the CG themself.
+	 */
+	DEBUG_NET_WARN_ON_ONCE(msk->backlog_unaccounted && sk->sk_socket &&
+			       mem_cgroup_from_sk(sk));
+
 	/* Don't spool the backlog if the rcvbuf is full. */
 	if (list_empty(&msk->backlog_list) ||
 	    sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
@@ -4089,6 +4104,22 @@ static void mptcp_graft_subflows(struct sock *sk)
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
+	if (mem_cgroup_sockets_enabled) {
+		LIST_HEAD(join_list);
+
+		/* Subflows joining after __inet_accept() will get the
+		 * mem CG properly initialized at mptcp_finish_join() time,
+		 * but subflows pending in join_list need explicit
+		 * initialization before flushing `backlog_unaccounted`
+		 * or MPTCP can later unexpectedly observe unaccounted memory.
+		 */
+		mptcp_data_lock(sk);
+		list_splice_init(&msk->join_list, &join_list);
+		mptcp_data_unlock(sk);
+
+		__mptcp_flush_join_list(sk, &join_list);
+	}
+
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
@@ -4100,10 +4131,35 @@ static void mptcp_graft_subflows(struct sock *sk)
 		if (!ssk->sk_socket)
 			mptcp_sock_graft(ssk, sk->sk_socket);
 
+		if (!mem_cgroup_sk_enabled(sk))
+			goto unlock;
+
 		__mptcp_inherit_cgrp_data(sk, ssk);
 		__mptcp_inherit_memcg(sk, ssk, GFP_KERNEL);
+
+unlock:
 		release_sock(ssk);
 	}
+
+	if (mem_cgroup_sk_enabled(sk)) {
+		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
+		int amt;
+
+		/* Account the backlog memory; prior accept() is aware of
+		 * fwd and rmem only.
+		 */
+		mptcp_data_lock(sk);
+		amt = sk_mem_pages(sk->sk_forward_alloc +
+				   msk->backlog_unaccounted +
+				   atomic_read(&sk->sk_rmem_alloc)) -
+		      sk_mem_pages(sk->sk_forward_alloc +
+				   atomic_read(&sk->sk_rmem_alloc));
+		msk->backlog_unaccounted = 0;
+		mptcp_data_unlock(sk);
+
+		if (amt)
+			mem_cgroup_sk_charge(sk, amt, gfp);
+	}
 }
 
 static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 161b704be16b..199f28f3dd5e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -360,6 +360,7 @@ struct mptcp_sock {
 
 	struct list_head backlog_list;	/* protected by the data lock */
 	u32		backlog_len;
+	u32		backlog_unaccounted;
 };
 
 #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
-- 
2.51.1

