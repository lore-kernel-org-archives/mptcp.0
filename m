Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254150;
	b=dODjeazUD2+5XeVJS+euIupM51eS7vW1OCThKLJmPC63vJmbSSrJgQMxtWKeYw/xOLMs
	 yAbRPbM06B5zmb9/MulXFfJx4xJ21WQ4QETy+2FF3MwjYG6tZIEL3attI7R8ehieLR58M
	 criOXlAOAxX9Z0uMwYbL5TWQZIp20C3UQQ/dc26mOkK1h5bZxSXYA2ANhbvIpDhNdRtfw
	 7DjIoguWU7oEm5+i8k3igsbUYnBWfIFTg7l2+jVEc4vdUziyzVGPgFA8tPAvlcefF1N9M
	 9/W9pHM+lYePl2PjGiJVWzZy5HGtrttkJ+Bclb4OfPIWIVMVvdv4svHSSEaiwF0xbMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254150;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=2BPMEhKgZ3yHSrY6kt8NU0qc5xzjd/ULSg6WTSbivek=;
	b=B/zx3LMnpd/eYEzQXLDW4XF1BqtMcnStcV+gGebQkNVL8jJ9NI4mhFzzoBfCE1q8SQTc
	 rVjDD4iGk+P9aeTNX1tFch/DottQOuXWxqkh4Xd4ZzwI4Zi9bVGe+JALaGRq9FyIPbAmJ
	 JPNkAZAN5euY3IBBup2YYOT6+rcYQbzIxSUAkOW/OvR2Bt3edweXwplPMKcwHYcBMuvxA
	 HI9Ne6cNznEFZKIH1uO0EQWgqPO8buOzw9+ohfPgZYm3HENJketsQguvnza7K8eJpr2p+
	 Cb636gd2gltFS3ZFwXR/pNYL9fIxiSt5wVeinHP3v1YvlMslCLXM+U7yz0VcjRt1pPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=StWm1MwU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874BC606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=StWm1MwU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12B11F000C6;
	Sat, 21 Nov 2026 09:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254150;
	bh=2BPMEhKgZ3yHSrY6kt8NU0qc5xzjd/ULSg6WTSbivek=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=StWm1MwUxgF4P8lgHi2NVXkyt3hQfBpjaiEr1U93NuddNqW6v+NFBw0bWiYheQMHo
	 /q4qFhL/1Hv4iGiWOaW8mCV/U7t3ufWgqEOSpATtNXdiSbHNl6AQ0yPu5znV9XXO4n
	 YwGl9jf1RT4+GKqHSjLbBpLc/TSHkzyPsIimHNNSp63PQO9G8rQmnliiVuq6VJlBre
	 NzNtJq8JxhVxubshpR8PnfPG/xg4xs3MYroaGqSPvbVINJZvCQW4L+qUo+EIuBH+vE
	 O/pJofrLExn19HV1a4wFijqDhz1h0ChE3cyMsl+rsux5A2pRO7SdebCFN406hnPeW4
	 1fma8L8oDoHQg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:10 +0100
Subject: [PATCH mptcp-net v2 12/62] mptcp: keep an orphan while it can send
 its data
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261121-mptcp-cmason-fixes-v2-12-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3553; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=mxA7RXLnyGFxvO9Z1BIjBfGKjNv05o1qeL21uzhz2ho=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ0wN5f9/KmtfYV1Cf+sBH1nPr0afy4qkh6WVx/VLpt
 XeKXl7tKGVhEONikBVTZJFui8yf+byKt8TLzwJmDisTyBAGLk4BmEj0G4b/OZEXw6v3FGQy6bhs
 ErL49lLz7Jw0F12ngz6q8/6s2bhxFiPDp4yJ5vptRvUpZ97vby2vi/t1cIFQyqkr85x8Gj9OPer
 LAQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The close timeout of an orphaned MPTCP socket started at close(), and
its expiry reset the connection, while some data could still be waiting
for the peer to open its window: a peer reading slowly or pausing got a
reset 60 seconds after close(), and lost the end of the data, while TCP
delivers it.

This timeout is there for the DATA_FIN exchange, see commit d866ae9aaa43
("mptcp: add a new sysctl for make after break timeout"), and for an
orphan that can no longer send anything. So restart it when the DATA_FIN
is sent, and when it expires before, as long as a subflow can still send
the data, which is then pushed again: an established subflow, on which
the peer acked something recently, at least the window probes. Until
then, as for a TCP socket that is not orphaned, nothing limits how long
the peer can keep its window closed, while it acks the window probes.
The timeout still starts at close(): the subflows are not TCP orphans,
so its expiry is the only check that the orphan can still send.

This was reported on GitHub, with a reproducer: a server writes 2 MB,
then calls close(), while the client pauses before reading the rest.
After a pause of 90 seconds, the client got ECONNRESET, while TCP
delivered everything, as MPTCP now does. If the client vanishes instead,
the orphan is now reset as TCP does.

Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/647
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for issue #647 reported on GitHub
---
 net/mptcp/protocol.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d64e04245963..944c9d11d211 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2871,6 +2871,28 @@ static bool mptcp_close_tout_expired(const struct sock *sk)
 		  inet_csk(sk)->icsk_mtup.probe_timestamp + mptcp_close_timeout(sk));
 }
 
+/* Before its DATA_FIN, keep an orphan while a subflow can send its data */
+static bool mptcp_orphan_keep(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+
+	if (!sock_flag(sk, SOCK_DEAD) || msk->snd_nxt == msk->write_seq)
+		return false;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		/* a live peer acks at least the probes, every TCP_RTO_MAX */
+		if (__mptcp_subflow_active(subflow) &&
+		    tcp_jiffies32 - READ_ONCE(tcp_sk(ssk)->rcv_tstamp) <
+		    2 * TCP_RTO_MAX)
+			return true;
+	}
+
+	return false;
+}
+
 static void mptcp_check_fastclose(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
@@ -3208,6 +3230,11 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
 		__mptcp_close_subflow(sk);
 
+	if (mptcp_close_tout_expired(sk) && mptcp_orphan_keep(sk)) {
+		mptcp_start_tout_timer(sk);
+		__mptcp_push_pending(sk, 0);
+	}
+
 	if (mptcp_close_tout_expired(sk)) {
 		struct mptcp_subflow_context *subflow, *tmp;
 
@@ -3449,6 +3476,10 @@ static void mptcp_check_send_data_fin(struct sock *sk)
 
 	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
 
+	/* an orphan's close timeout is for the DATA_FIN exchange */
+	if (sock_flag(sk, SOCK_DEAD))
+		mptcp_start_tout_timer(sk);
+
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *tcp_sk = mptcp_subflow_tcp_sock(subflow);
 

-- 
2.55.0

