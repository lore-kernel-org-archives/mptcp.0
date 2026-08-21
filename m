Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838A938E8BF
	for <mptcp@lists.linux.dev>; Fri, 21 Aug 2026 07:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787295919; cv=none; b=S7P8Pcr+BSCWxGpiV6H6m5bNAGTFHGOiUs2Z5vaN6/UijtlhTwO+Dp5VHy2QKWXZmFav33/BTXucpnAg0fpuCQWVlZscGUAv9fpKaVjZPO5f0PGQBo9bf2SsT7jRooEgJvXzamnzW2qwo7FfqkiU6t4VaPqoOqi8q/K2lu0Rr/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787295919; c=relaxed/simple;
	bh=c+Rw4XDZQ/FBX465zsj6u1QA6famqWLPLLB19vyZ0/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tuJboKVYVGb8D9tAPZfMDDWOECPgsvjc7SoXNllq7ot7e3K/1LEZe48kTB6rVZpKfomtAw4DlUr30Yspqa+ehtIRX3lCJen9uYGM5R1FHGdPT8/C+vzQEt08QoesE+B/gTqwN4JX/NDwvCdI+bc9A3Usmb1WB2v577PSh0noNeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+60IkAG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+60IkAG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2FC1F000E9;
	Fri, 21 Aug 2026 07:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787295918;
	bh=agEbS9MlZmqeWcKsdqgVYn8WeYk3OwGJDbKbLaPOTkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T+60IkAGbw8u1O646j3lOPQpsPqNlTgdyAyNV0dQHws0PD79vgE3K9qknwbNRvgYr
	 FpKo9RwkFEhBBu61cf6q1Nvz3S28zZQy36KO6BMRUu8e44OKvlczR+Hg4ftiysME8s
	 GTFtfp6Wfz3bAaPvoEkvGDwXwS+e4iY1Q1fENx/WuhEt2ZyTc6KgFfG/Hq8jx1jeG6
	 fYUrZP0tgdGOXeRztnfl6ULcc7jtfQ7u02/8VDXJl2piXL3NCCzJI/NcqV6oy4is2X
	 sadoUwRgNP08l3A1BBW+bw/bYnEKniMnJPJYPj9qWnuBnTaFUa11V81dY8TR37vyAo
	 HcbHg9Up1TnYg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 6/7] mptcp: track app-limited state in mptcp_sendmsg
Date: Fri, 21 Aug 2026 15:04:27 +0800
Message-ID: <feac38bc79e222aa983769a3004939ff1c589556.1787295147.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787295147.git.tanggeliang@kylinos.cn>
References: <cover.1787295147.git.tanggeliang@kylinos.cn>
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
index d38c5eec5471..a4ea1b522df9 100644
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

