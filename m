Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F65228C9D
	for <mptcp@lists.linux.dev>; Sat, 13 Dec 2025 06:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765607998; cv=none; b=KWDIKQxRuQzPkltUW63zTrZt3d3pgCkoNP5dqWNep0Ai6NZdH2fEZJEz0BvyXfDGuTK0T3EcnzNQoY+UNfaj98UxJYhK80wnOEFgO9vKLc8BWX3jtJuDRA9XE4MEqZJf5fMx7ohGBX1s89jreGkQPE+cyNINnqu/6tUqvMQVN0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765607998; c=relaxed/simple;
	bh=nzw4+5E+QO6hXCcbnRPjpLbcVxe1G6zWlRG3vS5J4qY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0gEYXXtc55rXPwQt7WbrVgDbQrX1oPC9MELxq0nJsPkevWTqy2ELM1OGmhoiZyfKzD1AitF/CafLJWisFEnc7wDyq5XXAwuxlImeHLrxqSFE6xbq78OyXLmGFPx/AuCg2Q4X2U+l0gmlQv9ZMVf/lkWewHZwGHRzGB47hmq+6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pse6l+aU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pse6l+aU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659FAC4CEF7;
	Sat, 13 Dec 2025 06:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765607997;
	bh=nzw4+5E+QO6hXCcbnRPjpLbcVxe1G6zWlRG3vS5J4qY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pse6l+aUxoatQDOr6Ew+CQkOSy2MtX2rMIbObue35aKJNWL3QcK3TrqSX4oB1eWS+
	 1TTaguxHOM6dYBjRBKX/WIUQ0C8LIPFbdtC63G+XG81h0d7OPphH0ec1+h/FgnENbh
	 3xFNQOyLucNNMVLBb3pHgW71L+QlRNpLcTvobofiymfJ2/3CF+0OoqwZdk7AffO3ye
	 NM3pGa3Uz3nc7EvjY0wc5Q7fSjLt/2OqwKZ07Tz2uPlU1Z29C5fLqe6Rc81qKeXSBj
	 8r0FV02Aoso21bPc9WKoYMS839QEADazG/GHy8+ppzrnNPv80wR40QP2dWhqGxc9Zv
	 P7WWNnaR6uS7A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>
Subject: [PATCH mptcp-next 1/3] tcp: add recv_should_stop helper
Date: Sat, 13 Dec 2025 14:39:48 +0800
Message-ID: <dcbbb08f6b4c15612584ad5b797188af8e988ee3.1765607485.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1765607485.git.tanggeliang@kylinos.cn>
References: <cover.1765607485.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Factor out a new helper tcp_recv_should_stop() from tcp_recvmsg_locked()
and tcp_splice_read() to check whether to stop receiving.

Use this new helper in tcp_bpf_recvmsg_parser() to check whether to stop
receiving.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tcp.h  | 23 ++++++++++++++++++
 net/ipv4/tcp.c     | 58 +++++++++-------------------------------------
 net/ipv4/tcp_bpf.c | 22 ++++--------------
 3 files changed, 39 insertions(+), 64 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index f5f6119f7716..e22f9fcb145d 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2953,4 +2953,27 @@ enum skb_drop_reason tcp_inbound_hash(struct sock *sk,
 		const void *saddr, const void *daddr,
 		int family, int dif, int sdif);
 
+static inline int tcp_recv_should_stop(struct sock *sk, long timeo)
+{
+	if (sock_flag(sk, SOCK_DONE))
+		return -ENETDOWN;
+
+	if (sk->sk_err)
+		return sk->sk_err;
+
+	if (sk->sk_shutdown & RCV_SHUTDOWN)
+		return -ESHUTDOWN;
+
+	if (sk->sk_state == TCP_CLOSE)
+		return -ENOTCONN;
+
+	if (!timeo)
+		return -EAGAIN;
+
+	if (signal_pending(current))
+		return sock_intr_errno(timeo);
+
+	return 0;
+}
+
 #endif	/* _TCP_H */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 40ad9656dc9e..f67d5cab5c15 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -815,6 +815,7 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
 	long timeo;
 	ssize_t spliced;
 	int ret;
+	int err;
 
 	sock_rps_record_flow(sk);
 	/*
@@ -835,24 +836,14 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
 		else if (!ret) {
 			if (spliced)
 				break;
-			if (sock_flag(sk, SOCK_DONE))
-				break;
 			if (sk->sk_err) {
 				ret = sock_error(sk);
 				break;
 			}
-			if (sk->sk_shutdown & RCV_SHUTDOWN)
-				break;
-			if (sk->sk_state == TCP_CLOSE) {
-				/*
-				 * This occurs when user tries to read
-				 * from never connected socket.
-				 */
-				ret = -ENOTCONN;
-				break;
-			}
-			if (!timeo) {
-				ret = -EAGAIN;
+			err = tcp_recv_should_stop(sk, timeo);
+			if (err < 0) {
+				if (err != -ENETDOWN && err != -ESHUTDOWN)
+					ret = err;
 				break;
 			}
 			/* if __tcp_splice_read() got nothing while we have
@@ -864,10 +855,6 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
 			ret = sk_wait_data(sk, &timeo, NULL);
 			if (ret < 0)
 				break;
-			if (signal_pending(current)) {
-				ret = sock_intr_errno(timeo);
-				break;
-			}
 			continue;
 		}
 		tss.len -= ret;
@@ -878,9 +865,7 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
 		release_sock(sk);
 		lock_sock(sk);
 
-		if (sk->sk_err || sk->sk_state == TCP_CLOSE ||
-		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-		    signal_pending(current))
+		if (tcp_recv_should_stop(sk, timeo))
 			break;
 	}
 
@@ -2724,39 +2709,18 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
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
-			if (sock_flag(sk, SOCK_DONE))
-				break;
-
 			if (sk->sk_err) {
 				copied = sock_error(sk);
 				break;
 			}
 
-			if (sk->sk_shutdown & RCV_SHUTDOWN)
-				break;
-
-			if (sk->sk_state == TCP_CLOSE) {
-				/* This occurs when user tries to read
-				 * from never connected socket.
-				 */
-				copied = -ENOTCONN;
-				break;
-			}
-
-			if (!timeo) {
-				copied = -EAGAIN;
-				break;
-			}
-
-			if (signal_pending(current)) {
-				copied = sock_intr_errno(timeo);
+			err = tcp_recv_should_stop(sk, timeo);
+			if (err < 0) {
+				if (err != -ENETDOWN && err != -ESHUTDOWN)
+					copied = err;
 				break;
 			}
 		}
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index a268e1595b22..314be75964fa 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -281,31 +281,19 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	if (!copied) {
 		long timeo;
 		int data;
-
-		if (sock_flag(sk, SOCK_DONE))
-			goto out;
+		int err;
 
 		if (sk->sk_err) {
 			copied = sock_error(sk);
 			goto out;
 		}
 
-		if (sk->sk_shutdown & RCV_SHUTDOWN)
-			goto out;
-
-		if (sk->sk_state == TCP_CLOSE) {
-			copied = -ENOTCONN;
-			goto out;
-		}
-
 		timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
-		if (!timeo) {
-			copied = -EAGAIN;
-			goto out;
-		}
 
-		if (signal_pending(current)) {
-			copied = sock_intr_errno(timeo);
+		err = tcp_recv_should_stop(sk, timeo);
+		if (err < 0) {
+			if (err != -ENETDOWN && err != -ESHUTDOWN)
+				copied = err;
 			goto out;
 		}
 
-- 
2.51.0

