Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793588351;
	b=qVzk6VdnjRUpnwYmsaOie+BD99NHDfrHnngLI++cjdhdC5oY57OawvBQKVt+SATaTGzF
	 WJM9Fjc6t3U4na+npyYLyCnpqBWkPrp1f1c947yKj1sbqmVHphpo+ecOnSm6C1HVjFDhZ
	 Kayozzo3yBgZTEjsqr/42tIdnwvUZb4i0XWJuLpVARyHNPMVgnj6L7CGFbAsTInlqaucs
	 yrpdRei1T6/dvF8F3av1TcFhhVWEGty/fjaMZijD3b5TD3b58FwcZMgcHLO/UPE4NprbD
	 2LCC7svbrHv/2+OlPj4Vslgbtg9KwV1Ktyc34tCzxkCUXC+OGENVqKhtsisrz+p37/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793588351;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PNr91aVcCG8ECkTntB3/im7JjMBScbotU7eKr9YeC8I=;
	b=qWzzjVqRE4RvnYQgRI5qRZs29tjaQKwxR5HzhixQ+f7zbB1+Vgj+ffb0W5MblYNga5xe
	 7p7QwVkEbhDKki4ek088KPWJo8PhZEoLCEB/9pfZEYCYsZUJPla50MqSCUMGqvzLsMc15
	 Ysux+gcQ65SmD17/ESgsrQK1q0jX+fuYkp2Vo86jMw6lHZQRJ/55SNl4TLER9WFor7Uzq
	 PnHavwOFYC9MV+hwQIqqgLf8JDp7KmXr2uATXcXYjopmg4qMw5nvUT/hXXuDB0sBY+JAx
	 CsZL3q5ki+KI0lJsokerByrllZhNnny5uyF6QfnOxtlyFMQTshQ9sxrzbs8b5ZL4I3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OTI2Gx5w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0563A606A32E
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 02:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OTI2Gx5w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162661F0093A;
	Mon,  2 Nov 2026 02:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793588350;
	bh=PNr91aVcCG8ECkTntB3/im7JjMBScbotU7eKr9YeC8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OTI2Gx5wo4ZoQOws2Z0x3bHRyvVFrw+9vJuVL/W/hiIUMVL2S61iqyhoSiZSR5erf
	 pGnQCE8aHqkekTYzdG/4u+YTfnRMaHuV69UGbTFqJkCrS/ka1PuxCKBXFyJDlcQpQe
	 JUiubiQ9+lDfPungWFRcvzjDjw5hY2dxv5ar8h7piLBpE504CdoY7AOxveLbLIC9zW
	 OTEcFICrDbGhD0qpWAOkwaN4nkK+ObqJ3qMCk2ANps01uK2T2FkkwUX+PzgPCiFyQz
	 cQljph+JWrT/h7HEpdzvdU9neeUdAkEkyN5RoQvcLzVN104hzv5G7b0WsMip7yR0GB
	 1ulx41c2pKcyQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 4/5] mptcp: track app-limited state in mptcp_sendmsg
Date: Mon,  2 Nov 2026 10:58:57 +0800
Message-ID: <b3d85544ac84b3c83617f72a5cfc893bac2a6304.1793588257.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793588257.git.tanggeliang@kylinos.cn>
References: <cover.1793588257.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add mptcp_rate_check_app_limited() that walks every subflow and runs
tcp_rate_check_app_limited() under each subflow's socket lock. The
helper bails out early when MPTCP still has data to send: unsent data
(write_seq != snd_nxt), skbs on the send queue (mptcp_send_head), or
data awaiting retransmission (mptcp_rtx_head). In these cases marking
subflows app-limited would mislead congestion controllers.

Invoke from mptcp_sendmsg_locked() after send-side setup so BBR and
similar controllers can ignore rate samples taken while the connection
is genuinely application-limited.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7ccb1c7506a3..ab7de11a448c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2038,6 +2038,25 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
 	}
 }
 
+static void mptcp_rate_check_app_limited(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+
+	if (msk->write_seq != msk->snd_nxt ||
+	    mptcp_send_head(sk) || mptcp_rtx_head(sk))
+		return;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow;
+
+		slow = lock_sock_fast_nested(ssk);
+		tcp_rate_check_app_limited(ssk);
+		unlock_sock_fast(ssk, slow);
+	}
+}
+
 static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -2068,6 +2087,9 @@ static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 
+	/* is sending application-limited? */
+	mptcp_rate_check_app_limited(sk);
+
 	if ((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
 		ret = sk_stream_wait_connect(sk, &timeo);
 		if (ret)
-- 
2.55.0

