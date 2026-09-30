Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48098343D7F
	for <mptcp@lists.linux.dev>; Wed, 30 Sep 2026 02:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735321; cv=none; b=APUHfa4XN5qNZJL0ZgupJpRukzdylXEveNORJHYplOOodcvpwpbwcXLA/lnprCXjqC75IGmmOA7i4meY9pe6mTb+WxUE0o7IFKITaFOOiFe9ywTE1VoPkcoVF7Kc/dt2/jIj8oLKiYp18EnnlxuNEt4x3VtAluMzLUKluUu7Ipo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735321; c=relaxed/simple;
	bh=jWr2zxCZdHB+8ydFyIwTXdKjC0HMANmCT0RKBw66FNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZ+NSlrAp6baOPfhKnMycqcxc7Z3sA/jxcRh9WxNzooCUhOHkuofo9BEzQ+ZEaKsY3+eK3XkNUVCnnm9GiAM0as0TjvuensCp2bMDfibgqsf0dJw5wzKbL9QV6Jah/6Hg1pPdYpVouwGH65L61rEcTq11x6AUWJ1mlWCBWHBn+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGT++j4P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGT++j4P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AEC1F00893;
	Wed, 30 Sep 2026 02:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790735320;
	bh=uaukxXp96mEKIf3TNQz1To8T1h+WXdqLsHopIocJ9AQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BGT++j4PH3kpqFWvPI1MRjno7pTyLcJ5kyqbBvzYMJYyf0pPqxbkHU+/3O1ceV0s6
	 NLdsBQs6yOMas//MupHihZzxHm88QMwDhDzqz3rlpHWcErTbtiJntS+CcEhcvSdjzx
	 jWulDD6Wjsi9VvCQNpdcDPDFezRT10U1/WKdocvvT5EEfT9XIIcol3DWqVg5od7H5P
	 PuGoEKk63l+eQ+9YWBLn4sIqHU1YIDUDNz4lVk2PlVw2GATZDKVyZWtH9AMHC/7CKF
	 j1kzuGf4lMjFp1FTdQeD/CCQT8apbdOfGuVJ83oTWx5u887JB9w1Ap9YHVQczklHIf
	 kWaCDruzLbwQw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	pabeni@redhat.com
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 09/11] mptcp: track app-limited state in mptcp_sendmsg
Date: Wed, 30 Sep 2026 10:23:43 +0800
Message-ID: <c1cfbd64bd5447d3f8464d2004865afab609d43c.1790734083.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790734083.git.tanggeliang@kylinos.cn>
References: <cover.1790734083.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The application-limited accounting in TCP is updated by
tcp_rate_check_app_limited(), which currently takes a struct sock * and
internally calls tcp_sk(). MPTCP needs to apply the same accounting to
each subflow individually - every subflow is an independent TCP socket
with its own tp->app_limited / delivered state - so wrapping the call as
a struct sock * -> tcp_sk() helper is awkward at the call site.

Split the existing function: keep the logic as
tcp_sock_rate_check_app_limited(struct tcp_sock *tp), and turn
tcp_rate_check_app_limited(struct sock *) into a thin wrapper so the
exported API is unchanged for other TCP users.

Then add mptcp_sock_rate_check_app_limited() that walks every subflow of
the mptcp_sock and runs tcp_sock_rate_check_app_limited() under each
subflow's socket lock. Invoke it from mptcp_sendmsg() right after the
send-side setup, so the delivery-rate app_limited state stays in sync
with what the application actually has to send across each subflow.

With this in place, TCP_INFO.tcpi_delivery_rate_app_limited is reported
correctly for MPTCP connections instead of being left at 0.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tcp.h    |  1 +
 net/ipv4/tcp.c       |  9 +++++++--
 net/mptcp/protocol.c | 18 ++++++++++++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 96a1a23e47fa..7188f9ec3864 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -851,6 +851,7 @@ static inline int tcp_bound_to_half_wnd(struct tcp_sock *tp, int pktsize)
 
 /* tcp.c */
 void tcp_get_info(struct sock *, struct tcp_info *);
+void tcp_sock_rate_check_app_limited(struct tcp_sock *tp);
 void tcp_rate_check_app_limited(struct sock *sk);
 
 /* Read 'sendfile()'-style from a TCP socket */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 5d374053e903..0b41befbbf4f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1099,9 +1099,9 @@ int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
 }
 
 /* If a gap is detected between sends, mark the socket application-limited. */
-void tcp_rate_check_app_limited(struct sock *sk)
+void tcp_sock_rate_check_app_limited(struct tcp_sock *tp)
 {
-	struct tcp_sock *tp = tcp_sk(sk);
+	struct sock *sk = (struct sock *)tp;
 
 	if (/* We have less than one packet to send. */
 	    tp->write_seq - tp->snd_nxt < tp->mss_cache &&
@@ -1114,6 +1114,11 @@ void tcp_rate_check_app_limited(struct sock *sk)
 		tp->app_limited =
 			(tp->delivered + tcp_packets_in_flight(tp)) ? : 1;
 }
+
+void tcp_rate_check_app_limited(struct sock *sk)
+{
+	tcp_sock_rate_check_app_limited(tcp_sk(sk));
+}
 EXPORT_SYMBOL_GPL(tcp_rate_check_app_limited);
 
 int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 319339be8076..1f7aaf3214a0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2055,6 +2055,21 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
 	}
 }
 
+static void mptcp_rate_check_app_limited(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow;
+
+		slow = lock_sock_fast_nested(ssk);
+		tcp_sock_rate_check_app_limited(tcp_sk(ssk));
+		unlock_sock_fast(ssk, slow);
+	}
+}
+
 static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -2083,6 +2098,9 @@ static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 
+	/* is sending application-limited? */
+	mptcp_rate_check_app_limited(sk);
+
 	if ((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
 		ret = sk_stream_wait_connect(sk, &timeo);
 		if (ret)
-- 
2.53.0

