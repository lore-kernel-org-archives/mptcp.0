Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826677;
	b=MvNphWaWYBoz+wI7jmx0CXCWgkoQk86ivjQqoshpgxFAhGZPcS08svnCIUn66GPdyqcJ
	 M6RAkSE4HRX0oWofp9BwhBKsijAaiur20NpbX8TTSF8uu78B+FEiiPKl8kPupVT9m9E12
	 fyawhmEKLGuWDvtL9ndaYk6c9it5halnEuv5A1LidjfQANkzKZK8s10PlFLNsbRs6PU2t
	 B4Dm0I7URtwZHNZkQCaovj68IbOWxEu2+/D+b/yUl8QdS2EnJY1YJw1nW6yCFUAYYcChN
	 93hu4I/7kJUN8b3q9prtQ78QyrvRuh+luyoUR9IZMASF5UYXPU9QrxUa9KpJRBsLhiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826677;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rWv6AyzOluuhLm/HUVqEQM1zfALbdK/KFvw0zE34Wkg=;
	b=aqGEz+JeCWToxmSx1xk3W/95Xzd/ONfg/T3wwNh3BBa3HYnk2kYC+pn4QG8RFL0MkvMs
	 MOP+SHhPMgTg33mcvWRNMWY9XnmoSTTrss9XwiQISmTmtIYh250TTgcicM23RWk037bK+
	 sA6qBoPcgB/CgZy5Jf5HkPr74C74R5iQpocWrOoRdY2UyST3xKQsnJrBygrafu49rTvJk
	 rchhrlVv5dlz12I5LWOiTpviY5tLu4Yk7IZCsnnkzvngAIy2fpZ0+hZ5OKdL+xv5ovv5P
	 COQ2ctsO3yZlpfe79yNx97uvbPz3sciKiJ6qz97oRjGD+QOnaXL/vhHrzm/GAcjeGgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SZ5d3cnh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD76606A31C
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 10:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SZ5d3cnh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5111F000C6
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 10:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794826677;
	bh=rWv6AyzOluuhLm/HUVqEQM1zfALbdK/KFvw0zE34Wkg=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=SZ5d3cnhSBC72Sm13d2OaU+A61eqLUpWfQYGjv50oaVeRT9Nkqv97Vi3GUn1BDJ5S
	 YXKjZ/EUJ9k/YsT6ftVS6bKh1Stp/CVY/ZZD325JrkB3u/RVpm6Zzy9HpeE0pAYHgd
	 qy7R78LY+xH6349sO8lE3zCxyguxWw1LJVi1e7abuH/T5Bn8F2/Z0+qvthYI5O3/FK
	 rpSIB6s5KVNv/ewUjDJDy4fBt41yI7mPYbdcGxf5rKABUa0+kuihFyNmeB2+3Ly53L
	 f1bh30EmJyo0kW+1etoxDzRujR+tWweIvJSsjEy9IMm16f0QO0RxhwymxdlhgwGIwk
	 hRQMAmm57wLVA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v8 5/7] mptcp: track app-limited state in mptcp_sendmsg
Date: Mon, 16 Nov 2026 18:57:43 +0800
Message-ID: <f23d8a957314196249b5ca0e3b36be8bb0a755e2.1794826541.git.geliang@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794826541.git.geliang@kernel.org>
References: <cover.1794826541.git.geliang@kernel.org>
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
(write_seq != snd_nxt), pending dfrags (mptcp_send_head), or pending
retransmission (MPTCP_WORK_RTX or MPTCP_RETRANSMIT flags). In these
cases marking subflows app-limited would mislead congestion controllers.

Invoke from mptcp_sendmsg_locked() after send-side setup so BBR and
similar controllers can ignore rate samples taken while the connection
is genuinely application-limited. The per-subflow locking only occurs
when the MPTCP send queue is empty, which is the correct scenario to
mark the connection as application-limited.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 83abdf39c4e5..b9d080121f78 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2039,6 +2039,30 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
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
@@ -2069,6 +2093,9 @@ static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 
+	/* is sending application-limited? */
+	mptcp_rate_check_app_limited(sk);
+
 	if ((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
 		ret = sk_stream_wait_connect(sk, &timeo);
 		if (ret)
-- 
2.55.0

