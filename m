Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B353016FB
	for <mptcp@lists.linux.dev>; Tue, 25 Aug 2026 07:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787644696; cv=none; b=LT+O5XcN57L7qeByy/tWrHSoKn0gQKfcdO9YZIgvgF09sUpN0iJ2Xdsa41Q3FWQFh+Jw7XXAJm1/WN2WPmgi+L3GVcxgC+dGIV2HElJFO5ezBD/9A0R8tFlLNBuo1VSnbh6cGdGstv1EkbwE47TEdu12CsTNvP9n1FqCMEArQSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787644696; c=relaxed/simple;
	bh=QShhJgnQ9xHLzhRxedSScJqbwH6gDcId/+b8YeX0TnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAE55zAMus2MM9gQzqjmvHM6w1Il7g/nIYXee6vCHuTalSEGYtXQ/fRGWXqDBcFqNma/lsjTLlZZSKAvUVLVtvIziDdyW5Q5ZEtYyhBi6tpJiMo4KI9mpRhip27wsDPgD67CnO5NEB0VYVJO4+20blwbjpTj/KYDsxVFaa7BVbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=audyk5N0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="audyk5N0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6356C1F000E9;
	Tue, 25 Aug 2026 07:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787644695;
	bh=CRtAv50dxBJ7qvvicm0u1BrJTPMsOcn8DIuLgXZC8ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=audyk5N0fxPEqEUIvRFp1jDAFGVm0QE/MXjha29+JEJKvFuayvtskZeptVHoWYqd+
	 Oemu3CHNbP8R/QemOPh/zZYrVNb9/JgHEVUcFURHHBFCTpXJBmOkuvuZE4tUDwzirp
	 iYaQjdEyGKNooYSa9gAexEC1JUcblnR8dbR4Ub+Iaq40h1e8dHpuZZpyDTwQ1Xqxvc
	 4UBSxGHu0QbtVgtWxl/odSREDPkiZW92Trl/uEpmNtoD728p1MwSC4UDXEZyjIP21T
	 +5lDo3IMC2CfjL9SZQy1wv7khcnqxdobl0EixUcC867MMnAD94bApUcfh10EXwyhA5
	 EMnHHK6BvjNAw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 7/8] mptcp: track app-limited state in mptcp_sendmsg
Date: Tue, 25 Aug 2026 15:57:35 +0800
Message-ID: <6d8c81563b2a1a862f91796d364ab2f4282fb0cf.1787644449.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787644449.git.tanggeliang@kylinos.cn>
References: <cover.1787644449.git.tanggeliang@kylinos.cn>
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
index 670c20876f26..f5cbb5a8a288 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -849,6 +849,7 @@ static inline int tcp_bound_to_half_wnd(struct tcp_sock *tp, int pktsize)
 
 /* tcp.c */
 void tcp_get_info(struct sock *, struct tcp_info *);
+void tcp_sock_rate_check_app_limited(struct tcp_sock *tp);
 void tcp_rate_check_app_limited(struct sock *sk);
 
 /* Read 'sendfile()'-style from a TCP socket */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 1452c40e22d4..f0f843fd1897 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1096,9 +1096,9 @@ int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
 }
 
 /* If a gap is detected between sends, mark the socket application-limited. */
-void tcp_rate_check_app_limited(struct sock *sk)
+void tcp_sock_rate_check_app_limited(struct tcp_sock *tp)
 {
-	struct tcp_sock *tp = tcp_sk(sk);
+	struct sock *sk = (struct sock *)tp;
 
 	if (/* We have less than one packet to send. */
 	    tp->write_seq - tp->snd_nxt < tp->mss_cache &&
@@ -1111,6 +1111,11 @@ void tcp_rate_check_app_limited(struct sock *sk)
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
index 623edce84b8b..8d72a62e0618 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2050,6 +2050,21 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
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
 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -2080,6 +2095,9 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 
+	/* is sending application-limited? */
+	mptcp_rate_check_app_limited(sk);
+
 	if ((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
 		ret = sk_stream_wait_connect(sk, &timeo);
 		if (ret)
-- 
2.53.0

