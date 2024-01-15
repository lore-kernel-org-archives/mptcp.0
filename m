Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B26175B6
	for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdO17wa/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705331811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dqjthjaFFdHcHkZA01AKebv1RjaCFSHUn2HyjPTFQXI=;
	b=PdO17wa/OkMvSPnYnEY75+NKpALoAxTQKQ7eUa3MBvNcwSI1XcVgle0PbO1eXT5YGQCuCO
	gIc+R386l+T6EVHm1kLAPCoI04Lb/aHhVx2BEvZgys7mAVyaqWr+fPZQdmbdpiIBU3osdq
	ONvRy2upYMbuZS/KVPa/qaBbE6i3Pns=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-j1P6KS7ENmKMHjVAoaa0Aw-1; Mon, 15 Jan 2024 10:16:49 -0500
X-MC-Unique: j1P6KS7ENmKMHjVAoaa0Aw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7A529230EA
	for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 15:16:48 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.49])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 36BBB1C060B2
	for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 15:16:48 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 2/4] mptcp: fix rcv space initialization
Date: Mon, 15 Jan 2024 16:16:31 +0100
Message-ID: <d11b37b395876b19d415bbc2bc2cac71209c5e5f.1705331716.git.pabeni@redhat.com>
In-Reply-To: <cover.1705331716.git.pabeni@redhat.com>
References: <cover.1705331716.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

mptcp_rcv_space_init() is supposed to happen under the msk socket
lock, but active msk socket does that without such protection.

Leverage the existing mptcp_propagate_state() helper to that extent.
We need to ensure mptcp_rcv_space_init will happen before
mptcp_rcv_space_adjust(), and the release_cb does not assure that:
explicitly check for such condition.

While at it, move the wnd_end initialization out of mptcp_rcv_space_init(),
it never belonged there.

Note that the race does not produce ill effect in practice, but
change allows cleaning-up and defying better the locking model.

Fixes: a6b118febbab ("mptcp: add receive buffer auto-tuning")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 10 ++++++----
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/subflow.c  |  4 ++--
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5129e1235cc5..c41f49532a0a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1963,6 +1963,9 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 	if (copied <= 0)
 		return;
 
+	if (!msk->rcvspace_init)
+		mptcp_rcv_space_init(msk, msk->first);
+
 	msk->rcvq_space.copied += copied;
 
 	mstamp = div_u64(tcp_clock_ns(), NSEC_PER_USEC);
@@ -3163,6 +3166,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->bytes_received = 0;
 	msk->bytes_sent = 0;
 	msk->bytes_retrans = 0;
+	msk->rcvspace_init = 0;
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
@@ -3250,6 +3254,7 @@ void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk)
 {
 	const struct tcp_sock *tp = tcp_sk(ssk);
 
+	msk->rcvspace_init = 1;
 	msk->rcvq_space.copied = 0;
 	msk->rcvq_space.rtt_us = 0;
 
@@ -3260,8 +3265,6 @@ void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk)
 				      TCP_INIT_CWND * tp->advmss);
 	if (msk->rcvq_space.space == 0)
 		msk->rcvq_space.space = TCP_INIT_CWND * TCP_MSS_DEFAULT;
-
-	WRITE_ONCE(msk->wnd_end, msk->snd_nxt + tcp_sk(ssk)->snd_wnd);
 }
 
 void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
@@ -3481,10 +3484,9 @@ void mptcp_finish_connect(struct sock *ssk)
 	WRITE_ONCE(msk->write_seq, subflow->idsn + 1);
 	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
 	WRITE_ONCE(msk->snd_una, msk->write_seq);
+	WRITE_ONCE(msk->wnd_end, msk->snd_nxt + tcp_sk(ssk)->snd_wnd);
 
 	mptcp_pm_new_connection(msk, ssk, 0);
-
-	mptcp_rcv_space_init(msk, ssk);
 }
 
 void mptcp_sock_graft(struct sock *sk, struct socket *parent)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ebb32b7563be..385aa92926d7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -304,7 +304,8 @@ struct mptcp_sock {
 			nodelay:1,
 			fastopening:1,
 			in_accept_queue:1,
-			free_first:1;
+			free_first:1,
+			rcvspace_init:1;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 90984b053adc..23f639e0d8c3 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -424,6 +424,8 @@ void __mptcp_sync_state(struct sock *sk, int state)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	__mptcp_propagate_sndbuf(sk, msk->first);
+	if (!msk->rcvspace_init)
+		mptcp_rcv_space_init(msk, msk->first);
 	if (sk->sk_state == TCP_SYN_SENT) {
 		mptcp_set_state(sk, state);
 		sk->sk_state_change(sk);
@@ -545,7 +547,6 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		}
 	} else if (mptcp_check_fallback(sk)) {
 fallback:
-		mptcp_rcv_space_init(msk, sk);
 		mptcp_propagate_state(parent, sk);
 	}
 	return;
@@ -1744,7 +1745,6 @@ static void subflow_state_change(struct sock *sk)
 	msk = mptcp_sk(parent);
 	if (subflow_simultaneous_connect(sk)) {
 		mptcp_do_fallback(sk);
-		mptcp_rcv_space_init(msk, sk);
 		pr_fallback(msk);
 		subflow->conn_finished = 1;
 		mptcp_propagate_state(parent, sk);
-- 
2.43.0

