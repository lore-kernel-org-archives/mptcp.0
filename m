Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254153;
	b=SDt223aZiSj5TvUz9j6lefFjdXTrR/Xez7C8Ez3U8697fTX2hVvtKjmUHqW6F+6AK2F+
	 bZjVYsBWV1xg3XcafywtiidVFvIGPpxCJ/wTlSpTXHsBU+sBOdnX8CJX61R4swlDjamz2
	 ALABYVB9XPv70OnlUMrfbFZQvOhTqWZLXSD0jZO9Qk4SLMJnFSKi9OsQRW37DeT/voSd/
	 8EytEngTtLc542Dc9eiLqp6m7IihgZPg/h5mjF/Ulf1T5NGNZctBMLiuDWcm7YXw1IdR1
	 2wee/lqillIQDXNGkX0Wa6Fb0KptMW3Gmb5NnSQU61PtrkvJhufUslOHAi8Dd2MYNSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254153;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=hTltZsKX2+e0IUaapsSlYtetlx2KXbWXf1TiCgLo29A=;
	b=FmAedNmsN3EHBuA5b9PQb6vJJVYZYVx6E/gWobhqrTSs+6JeHsR74eMD7L/qPuuvoalE
	 bj0sYW1W+Keiyqxdd4b6x8TEvdIsTCRq4lq8w1xRQsHHh86hqOxiuFEyim7LmNCCyrbP1
	 VRKZFiU+EedTJvfykHpYFlap8T8rK8U63F+AYX5j+7aesyp86Q8zn8veuksit1Zcm9cE4
	 kizjT63dwWobVoI8F5V/+OyAUVx5XXKxfP6mljp83Ci3l9UPAlpZfaVTkUcbNK1pJOWRa
	 7GgWb0AztNr3T8W4soCsBK1AK1RcAzrENW+DDNjFH3BZhAfVllsj7isp2GRflEhd3XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fGENgk7t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315CF606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fGENgk7t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7BF1F000E6;
	Sat, 21 Nov 2026 09:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254152;
	bh=hTltZsKX2+e0IUaapsSlYtetlx2KXbWXf1TiCgLo29A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fGENgk7txBtY5P8/NJps/v7OtxU36DHBkzRbn1di8mddWCc94X+/O5givHpiDZYBa
	 0RRF6HATtB1196vxWWOr8g0z1uX2TWYf3+wGCc2Hdvesnnb5x8i/PE83lpa/2ge6zX
	 vqU9yyJvUrGDcOFU1T7aOM52ruxvbUGFBCsI6jHhrTPUiEcNUufMaIQfSaidTF6h8c
	 kNWNxu8EG3Odcg8x2VMo09U/YGLuCR2tG3ETBMajY9zQE0tf3ssCmAKqVbhxx9u9vy
	 51+gdGacpA9sVYypgzzXne1amfUn0Osw0UVrKWkrnEBDRY6oauz10adQ/pjkEocUk2
	 nTFUx4Ua+M1nA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:13 +0100
Subject: [PATCH mptcp-net v2 15/62] mptcp: return EOF after a DATA_FIN, as
 TCP does
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-15-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3751; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=OUhjCzgEfBwLroFI8sb8y0ubGvrKccVVHb0XMQQTs0U=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ04PNL/9/ZZ8WXGR09OtRZUbrUoX92ZzL2V61Jz2wD
 3weVbW3o5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCLHVBgZOqYs+zHpfOEmzXtB
 qRMu3lJlOdZ6c/420wx/jULR9lN7YxkZFux2PpHZvofze7Vrqcn7o/Xq7e/OL1/34OmECx7LFv5
 SZgUA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Once an MPTCP socket has received a DATA_FIN, recv() returns the
remaining data, then EOF. But if the connection was then reset, e.g. by
an MP_FASTCLOSE, recv() returned an error after the data, e.g. EPIPE,
instead of EOF as TCP does. A proxy resetting the other connection on
read errors then dropped the data it still had to forward.

As TCP does with a FIN, set SOCK_DONE when processing the DATA_FIN, and
check it before the socket error in recvmsg(). With an MP_FASTCLOSE, the
data still in the backlog is moved first, not to miss the DATA_FIN.
After a fallback, a DATA_FIN is also emulated after a reset: only set
SOCK_DONE after a FIN, not to hide a reset behind an EOF.

This was reported on GitHub, and is validated with new Packetdrill
tests: data and a DATA_FIN are received, then an MP_FASTCLOSE; and
after a fallback, data, a FIN and a reset. Without this patch, the
second read() returned EPIPE in both cases:

  receive_fastclose_after_data_fin.pkt:27: runtime error in read call: Expected result 0 but got -1 with errno 32 (Broken pipe)
  v1_connect_tcpfallback_fin_reset.pkt:19: runtime error in read call: Expected result 0 but got -1 with errno 32 (Broken pipe)

Note for the backports: the issue with an MP_FASTCLOSE comes from commit
69800e516e96 ("mptcp: propagate fastclose error"), in v6.1. Before that,
the modifications in mptcp_check_fastclose() and mptcp_disconnect() are
not needed.

Fixes: 15cc10453398 ("mptcp: deliver ssk errors to msk")
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/647
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for issue #647 reported on GitHub
---
 net/mptcp/protocol.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9e297fa08bfe..91639ae0c8a0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -714,6 +714,10 @@ static void mptcp_check_data_fin(struct sock *sk)
 		WRITE_ONCE(msk->rcv_data_fin, 0);
 
 		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
+		/* on fallback, also emulated after a reset: check for a FIN */
+		if (!__mptcp_check_fallback(msk) ||
+		    (msk->first && sock_flag(msk->first, SOCK_DONE)))
+			sock_set_flag(sk, SOCK_DONE);
 		smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
 
 		switch (sk->sk_state) {
@@ -972,6 +976,9 @@ static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
 	 * destroy the msk as needed.
 	 */
 	ssk_state = inet_sk_state_load(ssk);
+	/* a FIN received before still leads to EOF, as with TCP */
+	if (sock_flag(ssk, SOCK_DONE) && mptcp_pending_data_fin(sk, NULL))
+		sock_set_flag(sk, SOCK_DONE);
 	if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
 		mptcp_set_state(sk, ssk_state);
 	WRITE_ONCE(sk->sk_err, -err);
@@ -2494,6 +2501,9 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			    !timeo)
 				break;
 		} else {
+			if (sock_flag(sk, SOCK_DONE))
+				break;
+
 			copied = sock_error(sk);
 			if (copied)
 				break;
@@ -2938,6 +2948,11 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 	if (likely(!READ_ONCE(msk->rcv_fastclose)))
 		return;
 
+	/* a DATA_FIN received before still leads to EOF, as with TCP */
+	if (READ_ONCE(msk->rcv_data_fin))
+		mptcp_move_skbs(sk);
+	mptcp_check_data_fin(sk);
+
 	mptcp_token_destroy(msk);
 
 	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
@@ -3797,6 +3812,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	atomic64_set(&msk->rcv_wnd_sent, 0);
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
+	sock_reset_flag(sk, SOCK_DONE);
 	sk_error_report(sk);
 	return 0;
 }

-- 
2.55.0

