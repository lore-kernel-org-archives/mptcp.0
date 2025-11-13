Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBE810F2
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 00:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762992668; cv=none; b=oVcVVKx7GIl2yzZQRxpmoYFWvRfAuc0LZMNf8O+fBfM9pMdaLhq6Fs/iL7UKb5W/KGv038xqU5lzNqzLo9mmVM3k8NW27y3ky2pcua94RLvIjww6dc9ab9GiX6JYyk44meguYqlXTZWGkwR0Lw204sDmbv122oyaA8hPavLCMuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762992668; c=relaxed/simple;
	bh=KE1DJZwMoyR1ElDfpz+h1vqDvjHnc6npxfqejYYzdEo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Rc87xwxHkv5C3yLfISNLpMjBvUdKU2DXt2bZA4Qvf0cBY4mjFBL90snliXpcjx77LpDJb/mzD6oI2GUbgI96RC27q+MaL5IkGOWUkRTGu5z/qECzNBX2dBUHlJnZEVgnNtc5eaEGEbf58tCM5rtuV/x68k5DLxHbucxn4PBeinI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DlUltSMq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlUltSMq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762992666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VUPf97zcN4CGTMgWAhbPgHtPUModoV424KfSMBZSl4o=;
	b=DlUltSMqi9dfBt3HVc8IvNYVUopGTe0lGWzG0giy27gug/VyzDNOicYVu7PpiL27rHUfDn
	a0vTWsG6OUcbAj+1xpekMP6rLMlO/28hR4v1bJvctifDn2qYqZBtuU8XTB4OPPCFNyqQhS
	3QpMjfZJ5im1kkF5Ch4tVRFeRL046tA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-ZAy97YZVMymEo0us69mm1A-1; Wed,
 12 Nov 2025 19:11:04 -0500
X-MC-Unique: ZAy97YZVMymEo0us69mm1A-1
X-Mimecast-MFC-AGG-ID: ZAy97YZVMymEo0us69mm1A_1762992664
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F03A21956096
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 00:11:03 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.120])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B3B430044E9
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 00:11:02 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-net 3/3] Squash-to: "mptcp: leverage the backlog for RX packet processing"
Date: Thu, 13 Nov 2025 01:10:52 +0100
Message-ID: <ee40999f77d0186abba2a6b21958c1a8c4881c57.1762992570.git.pabeni@redhat.com>
In-Reply-To: <cover.1762992570.git.pabeni@redhat.com>
References: <cover.1762992570.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vh8snmPIJZFoVVPOmPJ__WmeoHIDDzXKrQivS7H6S5o_1762992664
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
- additionally accouting for such memory at accept time
- preventing any subflow from adding memory to the backlog not CG
  accounted after the above flush

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 64 +++++++++++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.h |  1 +
 2 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index addd8025d235..abf0edc4b888 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -658,6 +658,7 @@ static void __mptcp_add_backlog(struct sock *sk,
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sk_buff *tail = NULL;
+	struct sock *ssk = skb->sk;
 	bool fragstolen;
 	int delta;
 
@@ -671,18 +672,26 @@ static void __mptcp_add_backlog(struct sock *sk,
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
+	 * accounted, mptcp_grapt_subflows will handle it.
+	 */
+	if (!ssk->sk_memcg)
+		msk->backlog_unaccounted += delta;
 }
 
 static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
@@ -2154,6 +2163,12 @@ static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs)
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
@@ -4059,6 +4074,22 @@ static void mptcp_graft_subflows(struct sock *sk)
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
+	if (mem_cgroup_sockets_enabled) {
+		LIST_HEAD(join_list);
+
+		/* Subflows joining after __inet_accept() with get the
+		 * mem CG properly initialized at mptcp_finish_join() time,
+		 * but subflows pending in join_list need explicit
+		 * initialization before flushing `backlog_unaccounted`
+		 * or we can cat unexpeced unaccounted memory later.
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
 
@@ -4070,10 +4101,35 @@ static void mptcp_graft_subflows(struct sock *sk)
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
+		 * fwd and rmem only
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

