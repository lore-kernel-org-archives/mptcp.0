Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638963A1E70
	for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740709; cv=none; b=HF8343Gs+d9bPwzfAfyebgMBo9YLV/ru9X8GdOXF+BaLEx4c6vwhiVUc0HxUhxkS5GwYlhaiKLvvucStmN88QiqXwk0IwiYZXifE7hSKRQN2IveRQS8UPT60GKKgRQ1h7qyFSSWR1QDL7vC4MiTjFcKvVxWg9V2j5Mcn6qCsRLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740709; c=relaxed/simple;
	bh=HJ5b3TSndkwwnnkR0RentRAdetUxBBRAdYQyiAtkqg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcv080yK2QYEGMOhm1bB0t7f2XswuEBpS188AOlimE2KeRfZNoJeCZ6dhMCK5mNNRYBuIUx59e5Ob7TNJAjHPFs1mQF1vHCatiLdFKtU1cgZdqK6SqZNpGgSd0huPbs1Qvb+fX7g0fwasf9RaSD/zVOsq161ZMlb3bctl1+n/ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAbqAiP9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAbqAiP9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C661C19425;
	Tue, 17 Mar 2026 09:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773740709;
	bh=HJ5b3TSndkwwnnkR0RentRAdetUxBBRAdYQyiAtkqg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IAbqAiP9V4rIVDMyB/gxGaeDGxsFnPeilSsi2zEq7EXjA52PUea8BqY0v2O7j6sBN
	 eO4gtnXTdHbgp218W9X2LzXzIcaJeHsJ5i7nHoJ+95qFP6Fp0kkPDUeZBO83iFr8av
	 nnU8kH8un0dfL/5bosYMuVdANE6Na+X42iMazF63sNEOe17cJKZfuioRZ5bHW2xWwb
	 +lplAYxDIcbvFrtGlIq7UChBM/uWHvkj2+YpxbEcE4fHcahheIs9OFBr4wQfwu93w7
	 1juA2fhEnoW2Y3BA1xWc4G+HIcwJKYFvt2SCtEghwQpfX/OB46tdhO7vrFFCvKPes/
	 VcxQl2pb31Ytg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>
Subject: [RESEND mptcp-next v2 2/2] tcp: add recv_should_stop helper
Date: Tue, 17 Mar 2026 17:44:55 +0800
Message-ID: <2c01b49782e2f648813389caa6138a1b1540f64b.1773740635.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773740635.git.tanggeliang@kylinos.cn>
References: <cover.1773740635.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Factor out a new helper tcp_recv_should_stop() from tcp_recvmsg_locked()
and tcp_splice_read() to check whether to stop receiving. And use this
helper in mptcp_recvmsg() and mptcp_splice_read() to reduce redundant code.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tcp.h    |  9 +++++++++
 net/ipv4/tcp.c       | 10 ++--------
 net/mptcp/protocol.c | 10 ++--------
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index f87bdacb5a69..229613b56f73 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -3069,4 +3069,13 @@ enum skb_drop_reason tcp_inbound_hash(struct sock *sk,
 		const void *saddr, const void *daddr,
 		int family, int dif, int sdif);
 
+static inline int tcp_recv_should_stop(struct sock *sk, long timeo)
+{
+	return sk->sk_err ||
+	       sk->sk_state == TCP_CLOSE ||
+	       (sk->sk_shutdown & RCV_SHUTDOWN) ||
+	       signal_pending(current) ||
+	       !timeo;
+}
+
 #endif	/* _TCP_H */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index dfd677c689ef..b0df7c4a0e20 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -895,9 +895,7 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
 		release_sock(sk);
 		lock_sock(sk);
 
-		if (sk->sk_err || sk->sk_state == TCP_CLOSE ||
-		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-		    signal_pending(current))
+		if (tcp_recv_should_stop(sk, timeo))
 			break;
 	}
 
@@ -2767,11 +2765,7 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 			break;
 
 		if (copied) {
-			if (!timeo ||
-			    sk->sk_err ||
-			    sk->sk_state == TCP_CLOSE ||
-			    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-			    signal_pending(current))
+			if (tcp_recv_should_stop(sk, timeo))
 				break;
 		} else {
 			if (sock_flag(sk, SOCK_DONE))
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index dc9fdd664871..b26b1098751a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2317,11 +2317,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			break;
 
 		if (copied) {
-			if (sk->sk_err ||
-			    sk->sk_state == TCP_CLOSE ||
-			    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-			    !timeo ||
-			    signal_pending(current))
+			if (tcp_recv_should_stop(sk, timeo))
 				break;
 		} else {
 			if (sk->sk_err) {
@@ -4508,9 +4504,7 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 		release_sock(sk);
 		lock_sock(sk);
 
-		if (sk->sk_err || sk->sk_state == TCP_CLOSE ||
-		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-		    signal_pending(current))
+		if (tcp_recv_should_stop(sk, timeo))
 			break;
 	}
 
-- 
2.53.0

