Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18883A3815
	for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789294515; cv=none; b=DgadRaIuJ/UmQ1T58x0gCuyOQMq3iJ6TDOVfqz2qFfDaa70eRuXI/F0Mo/KkLBKV2xVmGL/nQdvVAqV7HAbDJjmngb9fGBbVp59Mbtuv17vcS1OCcZDi0Ap9DSPphM38mCgaPGfYcG5GyhcSy3M99qOvFEIfSMDS3c4FL0RyJFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789294515; c=relaxed/simple;
	bh=2Pn5MzR3BgSJzo498vpaCSrowmL617tWaKGHE1wjacY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLL7UiypOGqHsm7oag8xdvd8bEFFHgJvm5MbSGNACaJPw5KSrkdTfFOZ0hKsPitmEDGPXaZd2xcx5WpEPuBg+pQLjUfGaf4edlDbihINymngR75qIRtqQ5hIpBUiC1DNIcuidubm6/MXtqt0JnpFbZIvU8+Tou5T87Vcrbk8GmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouWVQcPJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouWVQcPJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A64E1F000FF;
	Sun, 13 Sep 2026 10:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789294513;
	bh=wCyGUwuv7mB+3E3tApz1cajoAZyg715r4he6ihLz7ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ouWVQcPJ6CC/scNsaCQTkpcmSQulqIe8sYrAUM3MO0VPQqUrQ1ssnkaJ7mybS8fHD
	 Fg6Tr+T8L5Hr9lKSEJqtd7pXFcHWkgyrpQPaKZyYuzDGEM+2v+61+585tgYgTQHCVv
	 woRXllF2Cfq/MoITXn0MiKYX8D1pEFFRMibQ+mT30MIt6Fz9X6DJrcPFfQ1jDpBYtP
	 3sXBkGRDpN34PNJV85eRL/yHGnzExdnZg3WWIWdD1pojTAzc2NkMEetV+7rDOq2dbF
	 jfSya0yGDXxJAAYLsPF+9sBnF+BcCTS1MNCIh5skJnloLK8pJ22ZA0ToxXsvVhCzos
	 uItNuS/fcMEXA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 03/16] mptcp: track app-limited state in mptcp_sendmsg
Date: Sun, 13 Sep 2026 18:14:42 +0800
Message-ID: <4b585d4bedcd753fee14485a25772eeffb1a2b96.1789294365.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789294365.git.tanggeliang@kylinos.cn>
References: <cover.1789294365.git.tanggeliang@kylinos.cn>
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
index 5e5f5f9b89a3..14baee01c74b 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -851,6 +851,7 @@ static inline int tcp_bound_to_half_wnd(struct tcp_sock *tp, int pktsize)
 
 /* tcp.c */
 void tcp_get_info(struct sock *, struct tcp_info *);
+void tcp_sock_rate_check_app_limited(struct tcp_sock *tp);
 void tcp_rate_check_app_limited(struct sock *sk);
 
 /* Read 'sendfile()'-style from a TCP socket */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 1dd80a75f223..cd4347bfa029 100644
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
index 29e2cd2be815..1a19e494c609 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2030,6 +2030,21 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
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
@@ -2058,6 +2073,9 @@ static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 
+	/* is sending application-limited? */
+	mptcp_rate_check_app_limited(sk);
+
 	if ((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
 		ret = sk_stream_wait_connect(sk, &timeo);
 		if (ret)
-- 
2.53.0

