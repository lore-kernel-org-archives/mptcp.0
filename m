Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C51136672
	for <mptcp@lists.linux.dev>; Sat, 22 Aug 2026 03:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787368785; cv=none; b=CBJgt10KsO9UGiUnZ1zgn6kMTi3Cyqf/V32P/UbhsHkUuN8mySgotj8WVEbv1qZ0ZjXkG2sofFlGueTd0f1CpuJ2gUCkKwznFw/hniz0PbqsDVbn9EegqVuTgcnFcUEjRZwWve/V/JJTZqs8YYJK18N5M1PtYq4YCpb57gTs91U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787368785; c=relaxed/simple;
	bh=IYDnaX3yQ/XgBN/Jd8aGv8YmkL+YKAKVXJwBf1FMmJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYNfxzBIQafzMOqL0sMqMU+g1YeBbYPaHNXm2wxJ4wuMN8oMRenFfKk3xtgvjxM7bXctgzexUELxLzJpjyU4yzgTHI3OahylqadMl26Bh6/TiHdLHvwrw5glRVSRnvgFtt810JZBzPVDGRb3KSORvS03fLb3JynmVxlqYJWx8Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFSHmSKi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFSHmSKi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0DC1F000E9;
	Sat, 22 Aug 2026 03:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787368784;
	bh=oAGejdGNswh8wAwlMbWKqH8qdmxCoeLn+ECjmLkG6S0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YFSHmSKiW6Qk26fI1xTqdYtihliqK8N4P9Mfn8ADjjOTfmkWfY2chCf08WMGyn6PD
	 AkJHCjbDY6AbI5Mld6IyEGWHBAcQK8Q8AHu1s9dI4OVK7sj3fmCDcTqX47UVmHrrD6
	 OQBmo38T6hKIHBNZm8UAqhwmccF+o8sWYOnItJ5I4AxHiaZD1ngiOnSy4q7Tkg42Ey
	 lCNV6Rpql9PDFf5r5Jw5qxi1YI9gQKGRfvFOGUUsatDGD83+RCdcMpMjud0nzO07tL
	 ESZh6mma8O0w+LpT/um/3+D2jHQ3j6kXFtdTI+yevG1Z19VHqtGGM6U+tlndN1zK5p
	 1K5LNjLGM95Aw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 6/7] mptcp: track app-limited state in mptcp_sendmsg
Date: Sat, 22 Aug 2026 11:19:06 +0800
Message-ID: <456a51551b99654bd84efa9565bdad7412a419cf.1787368526.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787368526.git.tanggeliang@kylinos.cn>
References: <cover.1787368526.git.tanggeliang@kylinos.cn>
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
index 2c5b889530b5..9d436816411b 100644
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
index 648eba89278f..735cd3984646 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2045,6 +2045,21 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
 	}
 }
 
+static void mptcp_sock_rate_check_app_limited(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow;
+
+		slow = lock_sock_fast(ssk);
+		tcp_sock_rate_check_app_limited(tcp_sk(ssk));
+		unlock_sock_fast(ssk, slow);
+	}
+}
+
 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -2075,6 +2090,9 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 
+	/* is sending application-limited? */
+	mptcp_sock_rate_check_app_limited(sk);
+
 	if ((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
 		ret = sk_stream_wait_connect(sk, &timeo);
 		if (ret)
-- 
2.53.0

