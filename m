Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793860702;
	b=J297RyyWHJFth3GPxVdF8R8F0lq8lm1NCkrVAAezZKr930gIGX+dJ3J6STH1hzYd+tJr
	 +NPwPZsQHxgy/OTSfPoqqza++YML54ak+C8DCD2/12TvaBjFE+WJfNt6LO3PkLtAWcMda
	 LnTJ2dh80g8fs8ECPABGYFL+bhVCi0kaf/J8B8di8eeGcYpFMiN7V6sdlJtc9Z2EKJx1o
	 poYkpIKCTBClFDUKJ+mULQzrMHelPk2FDjGPWcMHxsElRsfuc/qngi3XRRSXn3Jyo0pIA
	 HTzN/GpDEagOz//dGCRiA+PVkr/embsGkxMzogl7P2+rrTpNmlQAfGIwce6Yr/D9LaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793860702;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XgzNDp9TlZMmK+wBDH8jW/A4dbs2bnj8fP/nlOwZo4I=;
	b=sg6ds++4BXtCHlB/egS+N8Dx6ZCjKu7wq3DrpE7wLyW0phH02caF0qUjlcPlLKLyMprz
	 NuilVOycVBe5MNNt9w8RN7GyFtvOSrgKgESP+gqTNS/3J6g8b1Ywh8yXcgDdJujtWrkcj
	 c5xV4atOAkalIjKEhE2qV//ykWycO2rdJndySpAM0cSz6bktvb0rttlIQBp5dM5bjc3cG
	 iRow29hcv6Uprya/zkkpkm0ugfy4g6e3j4T9PkSIL0ntpYJxCOGHB7+XlvIxWW02Uep/Y
	 Gby6XElVnIEKcA4hKOqsfdWW/UELDcK4gucX6tbxr2T++5IOhFXKpaZZb66fO07rQDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TgEfWJnO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041E5606A31B
	for <mptcp@lists.linux.dev>; Thu,  5 Nov 2026 06:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TgEfWJnO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D355E1F00919;
	Thu,  5 Nov 2026 06:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793860701;
	bh=XgzNDp9TlZMmK+wBDH8jW/A4dbs2bnj8fP/nlOwZo4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TgEfWJnOaknrKl4ALvTTvvOSQQ5NZLRkx+6UFXuZZjRX5H2tWn1d2MH++ZlI6oovg
	 pfXUWoOO+9Ro/uca5L41EQdfUWlED7HwvGW9s/eIQe0kYCA+orUY4Nn8xoe9CTNReQ
	 /WIn1LZRUcFX6zBn6rrw7cTymUrmcTAC9+v1MP9JkaRxvcFrIwQhwC/k0Ty7ZioBsm
	 +2HB3CoGEmIv4YIgHNL1ePcr7pu6sqMfSpoeYFynSyuUoDMbIqwku90WYzsyiPAt1t
	 ZgefCADdFj/VcJ6MlmJvO5/un8EycWbSzFdCGsonWc7bVjhp34/vxensF+Ms8laZQ0
	 iG9Tutl08oLcA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 6/7] mptcp: track app-limited state in mptcp_sendmsg
Date: Thu,  5 Nov 2026 14:38:02 +0800
Message-ID: <1f1319763b4e12e1a3d89f6fe05d17591a86a3ef.1793860134.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793860134.git.tanggeliang@kylinos.cn>
References: <cover.1793860134.git.tanggeliang@kylinos.cn>
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
(write_seq != snd_nxt), pending dfrags (mptcp_send_head), or
pending retransmission (MPTCP_WORK_RTX or MPTCP_RETRANSMIT flags).
In these cases marking subflows app-limited would mislead congestion
controllers.

Invoke from mptcp_sendmsg_locked() after send-side setup so BBR and
similar controllers can ignore rate samples taken while the connection
is genuinely application-limited.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b9c7b0bb6f74..889f244d9da0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2038,6 +2038,30 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
 	}
 }
 
+static void mptcp_rate_check_app_limited(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+	unsigned long flags, cb_flags;
+
+	flags = READ_ONCE(msk->flags);
+	cb_flags = READ_ONCE(msk->cb_flags);
+
+	if (msk->write_seq != msk->snd_nxt || mptcp_send_head(sk) ||
+	    test_bit(MPTCP_WORK_RTX, &flags) ||
+	    test_bit(MPTCP_RETRANSMIT, &cb_flags))
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
@@ -2068,6 +2092,9 @@ static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 
+	/* is sending application-limited? */
+	mptcp_rate_check_app_limited(sk);
+
 	if ((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
 		ret = sk_stream_wait_connect(sk, &timeo);
 		if (ret)
-- 
2.55.0

