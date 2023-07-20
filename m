Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6F23D6A
	for <mptcp@lists.linux.dev>; Thu, 20 Jul 2023 07:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689836620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RQ2/15kXa/vcBgzL20KPXOCj4jMXFhDHpqFmmnUu4KA=;
	b=Ewzklta3uhYcy3XPUjR5+1XQfpnYO0OCW/ZklrJFll1O3lmG8KllaYeoVAW3zN1XLULBOR
	kzsDkK2G+tYY0ydigHFj4BTmTsvrg/shqKavZi/x5gRKZIp1jiJcwQt7/45YDslvcNtIOs
	PyanRHbirK3V6H9FK8LMSc2HjwRbyuo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-BKzVNmz3NXiFXvyUoMZbMw-1; Thu, 20 Jul 2023 03:03:37 -0400
X-MC-Unique: BKzVNmz3NXiFXvyUoMZbMw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D6D52185A795;
	Thu, 20 Jul 2023 07:03:36 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.225])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2869440D2839;
	Thu, 20 Jul 2023 07:03:36 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next] mptcp: fix rcv buffer auto-tuning.
Date: Thu, 20 Jul 2023 09:03:32 +0200
Message-ID: <099977f9fe49d41ee0aa2eddefe5e2e09da3a3f1.1689836587.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The MPTCP code uses the assumption that the tcp_win_from_space() helper
does not use any TCP-specific field, and thus works correctly operating
on an MPTCP socket.
The commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale") broke
such assumption, and as a consequence most MPTCP connections stall on
zero-window event due to auto-tuning changing the rcv buffer size quite
randomly.
Address the issue synching again the MPTCP auto-tuning code with the TCP
one. To achieve that, factor out the windows size logic in socket
independent helpers, and reuse them in mptcp_rcv_space_adjust(). The MPTCP
level scaling_ratio is selected as the minimum one from the all the subflows,
as a worst-case estimate.

Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
I still see quite frequent failures on mptcp_join tests 19 && 20:
020 multi flows, signal, bidi, link fail
      Info: Test file (size 12288 KB) for server
      syn                                 [ ok ]
      synack                              [ ok ]
      ack                                 [ ok ]
      add                                 [ ok ]
      echo                                [ ok ]
      stale                               [fail] got 0 stale[s] 0 recover[s],   expected stale in range [1..-1],  stale-recover delta 1

I *think* such failures are still caused by dfa2f0483360 ("tcp: get
rid of sysctl_tcp_adv_win_scale") because it should change (increase?) the
rcv buffer/adv win size, and such tests depends on the transferred files
being significantly larger then the adv win. Since the current breakage is
pretty bad and the above needs more investigation, sharing it now.

@Matttbe: fill free to adjust the tag whatever it fit you better!!!
---
 include/net/tcp.h    | 20 +++++++++++++++-----
 net/mptcp/protocol.c | 14 +++++++-------
 net/mptcp/protocol.h |  8 +++++++-
 net/mptcp/subflow.c  |  2 +-
 4 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2104a71c75ba..33f60088e0df 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1432,22 +1432,32 @@ void tcp_select_initial_window(const struct sock *sk, int __space,
 			       __u32 *window_clamp, int wscale_ok,
 			       __u8 *rcv_wscale, __u32 init_rcv_wnd);
 
-static inline int tcp_win_from_space(const struct sock *sk, int space)
+static inline int __tcp_win_from_space(u8 scaling_ratio, int space)
 {
-	s64 scaled_space = (s64)space * tcp_sk(sk)->scaling_ratio;
+	s64 scaled_space = (s64)space * scaling_ratio;
 
 	return scaled_space >> TCP_RMEM_TO_WIN_SCALE;
 }
 
-/* inverse of tcp_win_from_space() */
-static inline int tcp_space_from_win(const struct sock *sk, int win)
+static inline int tcp_win_from_space(const struct sock *sk, int space)
+{
+	return __tcp_win_from_space(tcp_sk(sk)->scaling_ratio, space);
+}
+
+/* inverse of __tcp_win_from_space() */
+static inline int __tcp_space_from_win(u8 scaling_ratio, int win)
 {
 	u64 val = (u64)win << TCP_RMEM_TO_WIN_SCALE;
 
-	do_div(val, tcp_sk(sk)->scaling_ratio);
+	do_div(val, scaling_ratio);
 	return val;
 }
 
+static inline int tcp_space_from_win(const struct sock *sk, int win)
+{
+	return __tcp_space_from_win(tcp_sk(sk)->scaling_ratio, win);
+}
+
 static inline void tcp_scaling_ratio_init(struct sock *sk)
 {
 	/* Assume a conservative default of 1200 bytes of payload per 4K page.
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9f00a0288a0a..3ab67e0dfda9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -90,6 +90,7 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
 	if (err)
 		return err;
 
+	msk->scaling_ratio = tcp_sk(ssock->sk)->scaling_ratio;
 	WRITE_ONCE(msk->first, ssock->sk);
 	subflow = mptcp_subflow_ctx(ssock->sk);
 	list_add(&subflow->node, &msk->conn_list);
@@ -1906,6 +1907,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
+	u8 scaling_ratio = 255;
 	u32 time, advmss = 1;
 	u64 rtt_us, mstamp;
 
@@ -1936,9 +1938,11 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 
 		rtt_us = max(sf_rtt_us, rtt_us);
 		advmss = max(sf_advmss, advmss);
+		scaling_ratio = min(tp->scaling_ratio, scaling_ratio);
 	}
 
 	msk->rcvq_space.rtt_us = rtt_us;
+	msk->scaling_ratio = scaling_ratio;
 	if (time < (rtt_us >> 3) || rtt_us == 0)
 		return;
 
@@ -1947,8 +1951,8 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 
 	if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_moderate_rcvbuf) &&
 	    !(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
-		int rcvmem, rcvbuf;
 		u64 rcvwin, grow;
+		int rcvbuf;
 
 		rcvwin = ((u64)msk->rcvq_space.copied << 1) + 16 * advmss;
 
@@ -1957,18 +1961,14 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 		do_div(grow, msk->rcvq_space.space);
 		rcvwin += (grow << 1);
 
-		rcvmem = SKB_TRUESIZE(advmss + MAX_TCP_HEADER);
-		while (tcp_win_from_space(sk, rcvmem) < advmss)
-			rcvmem += 128;
-
 		do_div(rcvwin, advmss);
-		rcvbuf = min_t(u64, rcvwin * rcvmem,
+		rcvbuf = min_t(u64, __tcp_space_from_win(scaling_ratio, rcvwin),
 			       READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rmem[2]));
 
 		if (rcvbuf > sk->sk_rcvbuf) {
 			u32 window_clamp;
 
-			window_clamp = tcp_win_from_space(sk, rcvbuf);
+			window_clamp = __tcp_win_from_space(scaling_ratio, rcvbuf);
 			WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
 
 			/* Make subflows follow along.  If we do not do this, we
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1b4457c44fe8..86cd4d9e8432 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -293,6 +293,7 @@ struct mptcp_sock {
 	bool		csum_enabled;
 	bool		allow_infinite_fallback;
 	u8		mpc_endpoint_id;
+	u8		scaling_ratio;
 	u8		recvmsg_inq:1,
 			cork:1,
 			nodelay:1,
@@ -349,9 +350,14 @@ static inline int __mptcp_rmem(const struct sock *sk)
 	return atomic_read(&sk->sk_rmem_alloc) - READ_ONCE(mptcp_sk(sk)->rmem_released);
 }
 
+static inline int mptcp_win_from_space(const struct sock *sk, int space)
+{
+	return __tcp_win_from_space(mptcp_sk(sk)->scaling_ratio, space);
+}
+
 static inline int __mptcp_space(const struct sock *sk)
 {
-	return tcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf) - __mptcp_rmem(sk));
+	return mptcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf) - __mptcp_rmem(sk));
 }
 
 static inline struct mptcp_data_frag *mptcp_send_head(const struct sock *sk)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 9ee3b7abbaf6..ad7080fabb2f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1359,7 +1359,7 @@ void mptcp_space(const struct sock *ssk, int *space, int *full_space)
 	const struct sock *sk = subflow->conn;
 
 	*space = __mptcp_space(sk);
-	*full_space = tcp_full_space(sk);
+	*full_space = mptcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf));
 }
 
 void __mptcp_error_report(struct sock *sk)
-- 
2.41.0

