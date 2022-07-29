Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB92C4A28
	for <mptcp@lists.linux.dev>; Fri, 29 Jul 2022 15:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1659108835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bNLfFuFWLjtQN+kAi5MaO4NDu794mtg+Vhw0dqUf3/c=;
	b=Cayvd+ArHAtCTUOa2UGuS8ZI9qPRkfvMaKO0+g9Xn4oeLscwhMRcA4sRG0hjBc2TGxT2uq
	sQU/NBGCwKNNDWtJJpqFcAWR0Zh7wdfUpj2hZvXh+PhxnlyBoOpdizEd6TgoVgOfFpFHA6
	ddLy8YcWwShy4UAqR9gkrqrca4kpb7E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-153-TKZESC_eM9m1JxROww0MMw-1; Fri, 29 Jul 2022 11:33:54 -0400
X-MC-Unique: TKZESC_eM9m1JxROww0MMw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EFA4C299E741
	for <mptcp@lists.linux.dev>; Fri, 29 Jul 2022 15:33:53 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.205])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7F95318ECB
	for <mptcp@lists.linux.dev>; Fri, 29 Jul 2022 15:33:53 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 2/4] mptcp: more accurate receive buffer updates
Date: Fri, 29 Jul 2022 17:33:02 +0200
Message-Id: <63def511912bf79d6af065dccb155e9304932640.1659107989.git.pabeni@redhat.com>
In-Reply-To: <cover.1659107989.git.pabeni@redhat.com>
References: <cover.1659107989.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Currently mptcp_cleanup_rbuf() makes a significant effort to avoid
acquiring the subflow socket lock, estimating if the tcp level
cleanup could actually send an ack.

Such estimate is a bit rough when accounting for receive window
change, as it consider the msk available buffer space instead
of the announced mptcp-level window.

Let's consider the announced window instead, mirroring closely
the plain TCP implementation. We need to lockless access a bunch
of additional, tcp fields.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/mptcp.h  |  2 ++
 net/ipv4/tcp.c       |  3 +++
 net/mptcp/options.c  |  1 -
 net/mptcp/protocol.c | 14 +++++++++++---
 net/mptcp/protocol.h |  6 +++++-
 5 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 7af7fd48acc7..4b6c66b73bf4 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -136,6 +136,7 @@ static inline bool rsk_drop_req(const struct request_sock *req)
 	return tcp_rsk(req)->is_mptcp && tcp_rsk(req)->drop_req;
 }
 
+void mptcp_receive_window(const struct sock *ssk, int *rwnd);
 void mptcp_space(const struct sock *ssk, int *space, int *full_space);
 bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 		       unsigned int *size, struct mptcp_out_options *opts);
@@ -284,6 +285,7 @@ static inline bool mptcp_skb_can_collapse(const struct sk_buff *to,
 	return true;
 }
 
+static inline void mptcp_receive_window(const struct sock *ssk, int *rwnd) { }
 static inline void mptcp_space(const struct sock *ssk, int *s, int *fs) { }
 static inline void mptcp_seq_show(struct seq_file *seq) { }
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 970e9a2cca4a..9e2df51c0558 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1606,6 +1606,9 @@ void tcp_cleanup_rbuf(struct sock *sk, int copied)
 	if (copied > 0 && !time_to_ack && !(sk->sk_shutdown & RCV_SHUTDOWN)) {
 		__u32 rcv_window_now = tcp_receive_window(tp);
 
+		if (is_tcpsk(sk))
+			mptcp_receive_window(sk, &rcv_window_now);
+
 		/* Optimize, __tcp_select_window() is not cheap. */
 		if (2*rcv_window_now <= tp->window_clamp) {
 			__u32 new_window = __tcp_select_window(sk);
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 30d289044e71..563ef8fe5a85 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -604,7 +604,6 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 	}
 	opts->ext_copy.use_ack = 1;
 	opts->suboptions = OPTION_MPTCP_DSS;
-	WRITE_ONCE(msk->old_wspace, __mptcp_space((struct sock *)msk));
 
 	/* Add kind/length/subtype/flag overhead if mapping is not populated */
 	if (dss_size == 0)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5af3d591a20b..17e2dbe43639 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -535,6 +535,14 @@ static void mptcp_subflow_cleanup_rbuf(struct sock *ssk)
 	unlock_sock_fast(ssk, slow);
 }
 
+void mptcp_receive_window(const struct sock *ssk, int *rwnd)
+{
+	const struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	const struct sock *sk = subflow->conn;
+
+	*rwnd = __mptcp_receive_window(mptcp_sk(sk));
+}
+
 static bool mptcp_subflow_could_cleanup(const struct sock *ssk, bool rx_empty)
 {
 	const struct inet_connection_sock *icsk = inet_csk(ssk);
@@ -550,13 +558,13 @@ static bool mptcp_subflow_could_cleanup(const struct sock *ssk, bool rx_empty)
 
 static void mptcp_cleanup_rbuf(struct mptcp_sock *msk)
 {
-	int old_space = READ_ONCE(msk->old_wspace);
+	int cur_window = __mptcp_receive_window(msk);
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	int space =  __mptcp_space(sk);
+	int new_window =  __mptcp_space(sk);
 	bool cleanup, rx_empty;
 
-	cleanup = (space > 0) && (space >= (old_space << 1));
+	cleanup = new_window > 0 && new_window >= (cur_window << 1);
 	rx_empty = !__mptcp_rmem(sk);
 
 	mptcp_for_each_subflow(msk, subflow) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1bc9f6e77ddd..a54f42462a71 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -260,7 +260,6 @@ struct mptcp_sock {
 	int		rmem_fwd_alloc;
 	struct sock	*last_snd;
 	int		snd_burst;
-	int		old_wspace;
 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
 						 * recovery related fields are under data_lock
 						 * protection
@@ -336,6 +335,11 @@ static inline int __mptcp_rmem(const struct sock *sk)
 	return atomic_read(&sk->sk_rmem_alloc) - READ_ONCE(mptcp_sk(sk)->rmem_released);
 }
 
+static inline int __mptcp_receive_window(const struct mptcp_sock *msk)
+{
+	return atomic64_read(&msk->rcv_wnd_sent) - msk->ack_seq;
+}
+
 static inline int __mptcp_space(const struct sock *sk)
 {
 	return tcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf) - __mptcp_rmem(sk));
-- 
2.35.3

