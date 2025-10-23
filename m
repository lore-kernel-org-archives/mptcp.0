Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F801DF252
	for <mptcp@lists.linux.dev>; Thu, 23 Oct 2025 05:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761199026; cv=none; b=rW7rjY/S3kbSfFNj8rnZzR0XVPZDMLaBDPkKBPftABcCtrUz7VMrAwG+usqF1ZDAycDX4k8IHykKL6Dc9iqtDZ6dlnTAZ+U3mbUMIXsdqMYpHUeInXGCJgj7bl7Lq+FMmVjTMBp0Fo9A7GF1beOlMbwZ6hodn3GHTX5W49fI3t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761199026; c=relaxed/simple;
	bh=Dh7AEh5ePrVz6T/Qe3BXGUCID93lwwa6+4yQ/bLsZTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERXH0sbphk3iBA+EQOEvZWXw0RB+gcHUbMgoLXCaDUkU8PbU3trQF3fg2LTRKPCsVZt/hgvz5hCiX32HiBtB0r/0770O2+5dNHet4T5eAIjjBjTW8UiCCHwkzcpigLujtw9TnF15fDand9r32KssbceyYbzG/4aKVClILbf9Nls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u41DnJmQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u41DnJmQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFBEC4CEFB;
	Thu, 23 Oct 2025 05:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761199026;
	bh=Dh7AEh5ePrVz6T/Qe3BXGUCID93lwwa6+4yQ/bLsZTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u41DnJmQe4EIEq/VKnVka4bq2VKTwr2Fessl1grk6yeTrdJ1bEsiO2zr775ZlcVjI
	 zXeb01w/Urw17Fz0iaAzqFhytSKu/GeXFGtBvtKSWGmBF/455B66m06SpqAdYemHt7
	 smxczjY0YwLY1pUxowunmNrq1Tx3k53EohEr3baJ6TF+SPE+qyudw9iRfp/jIm2ezO
	 cOMtP/6eRWpeYxNQRwDqH3jJDiBvSCns19A/kR/MOMIrkhRly8lvPM+TcnG94uNfEG
	 vG9vycHjtH4tZzUk1i3W1q78GPTCYtpZmBlXU/RqBstZ2/CfYbRCS3Niw3tAhLYuDk
	 QTiKP4BJJ/9VQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v13 3/8] tcp: add recv_should_stop helper
Date: Thu, 23 Oct 2025 13:56:46 +0800
Message-ID: <e4fbd8d1cdae3039d348539ef12466f1080cea2a.1761198660.git.geliang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1761198660.git.geliang@kernel.org>
References: <cover.1761198660.git.geliang@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Factor out a new helper tcp_recv_should_stop() from tcp_recvmsg_locked()
and tcp_splice_read() to check whether to stop receiving. It will be used
for MPTCP too.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tcp.h | 23 +++++++++++++++
 net/ipv4/tcp.c    | 73 ++++++++---------------------------------------
 2 files changed, 35 insertions(+), 61 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 190b3714e93b..4492397a5377 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2935,4 +2935,27 @@ enum skb_drop_reason tcp_inbound_hash(struct sock *sk,
 		const void *saddr, const void *daddr,
 		int family, int dif, int sdif);
 
+static inline int tcp_recv_should_stop(struct sock *sk, long timeo)
+{
+	if (sock_flag(sk, SOCK_DONE))
+		return -ENETDOWN;
+
+	if (sk->sk_err)
+		return sock_error(sk);
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
index adc9edd2e9bb..c5653daa2201 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -842,26 +842,14 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
 		if (ret < 0)
 			break;
 		else if (!ret) {
+			int err;
+
 			if (spliced)
 				break;
-			if (sock_flag(sk, SOCK_DONE))
-				break;
-			if (sk->sk_err) {
-				ret = sock_error(sk);
-				break;
-			}
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
@@ -873,10 +861,6 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
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
@@ -887,9 +871,7 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
 		release_sock(sk);
 		lock_sock(sk);
 
-		if (sk->sk_err || sk->sk_state == TCP_CLOSE ||
-		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-		    signal_pending(current))
+		if (tcp_recv_should_stop(sk, timeo))
 			break;
 	}
 
@@ -2730,42 +2712,11 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 		if (copied >= target && !READ_ONCE(sk->sk_backlog.tail))
 			break;
 
-		if (copied) {
-			if (!timeo ||
-			    sk->sk_err ||
-			    sk->sk_state == TCP_CLOSE ||
-			    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-			    signal_pending(current))
-				break;
-		} else {
-			if (sock_flag(sk, SOCK_DONE))
-				break;
-
-			if (sk->sk_err) {
-				copied = sock_error(sk);
-				break;
-			}
-
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
-				break;
-			}
+		err = tcp_recv_should_stop(sk, timeo);
+		if (err < 0) {
+			if (!copied && err != -ENETDOWN && err != -ESHUTDOWN)
+				copied = err;
+			break;
 		}
 
 		if (copied >= target) {
-- 
2.43.0

