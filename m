Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3817E212F89
	for <mptcp@lists.linux.dev>; Tue,  2 Sep 2025 02:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756780519; cv=none; b=UL6V4tr3J16+OaTRbIo5BjLcm4KTIFD2GyBmyeWt0/0H7ynRpXLQAlbZCXel1RecyeXNEiB7fnRSc6Yy2x8GHPCGKZVhgsVmBQ+4ojaHFvmeX/avGi0KJaSzSlzchx8dCDa+MsuimwpnBvdm0u6KtAInSbuR+Md1dc5NCFI1fKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756780519; c=relaxed/simple;
	bh=x08RRAO39Hbjc9cKpNMVH9Tgg48yHR1VgULKidF1Wrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRRV/a5yAL7gxB5OZFwa3STUHfmS3mfEz/I2o3ts2tEAGbpTIr1JQ+Km1JGCPD3/ISaQMCHETX6BRJfcfSoTHfNdROvFCp0l8gAjRypuddFhldhwynYUUaQ0B77suBCKEpniICDgI7i7+Qsnu6hBYpePvD03cZORtMW4YQnqtgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i03eXJvV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i03eXJvV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259E8C4CEF1;
	Tue,  2 Sep 2025 02:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756780518;
	bh=x08RRAO39Hbjc9cKpNMVH9Tgg48yHR1VgULKidF1Wrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i03eXJvV/3lAjxvxwOSHgsrOTkwrzNnfheKjt9BCeoQTbwSSkjuXAA/zYLsRbV8Ro
	 4SMQyBpp6eMCDGNz1q6fgRodM5l/pUYSin3CwFar+hh1gn+SHPJ9Ar5H9UWuJrDqVB
	 +RKAw1mTpZWlY0bqRwWdH/MW6oyyNPflni7JQB/489JXLPfrWesbyUTPpK/zPK5lLB
	 QBjavgAbd8YE/Y8n/G5U0VOVmELpHhX3t9sYYFtGrdZzV8WXDwD8rFaXcOWChQG+qx
	 F3Slk0AkQst2nfFH2OVw7VoLzWK7iTeeUVTnXLKJAQh7SO11uQyHy4MJ8PGjI3+l6N
	 VcM8pKCFOJrcg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v10 5/9] tcp: add recv_should_stop helper
Date: Tue,  2 Sep 2025 10:34:56 +0800
Message-ID: <6dbd1609cfd20f98810f3793bdbb9dabe1c0ade8.1756780274.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1756780274.git.tanggeliang@kylinos.cn>
References: <cover.1756780274.git.tanggeliang@kylinos.cn>
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
 net/ipv4/tcp.c    | 75 ++++++++---------------------------------------
 2 files changed, 35 insertions(+), 63 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index d48555d5f792..530fa57ce508 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -270,6 +270,29 @@ struct tcp_splice_state {
 int tcp_splice_data_recv(read_descriptor_t *rd_desc, struct sk_buff *skb,
 			 unsigned int offset, size_t len);
 
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
 
 /* sysctl variables for tcp */
 extern int sysctl_tcp_max_orphans;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a1fc0a42d089..22619dab7a45 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -796,7 +796,7 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
 	};
 	long timeo;
 	ssize_t spliced;
-	int ret;
+	int ret, err;
 
 	sock_rps_record_flow(sk);
 	/*
@@ -817,24 +817,10 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
 		else if (!ret) {
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
+				if (err != -ESHUTDOWN && err != -ENETDOWN)
+					ret = err;
 				break;
 			}
 			/* if __tcp_splice_read() got nothing while we have
@@ -846,21 +832,15 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
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
 		spliced += ret;
 
-		if (!tss.len || !timeo)
+		if (!tss.len)
 			break;
 
-		if (sk->sk_err || sk->sk_state == TCP_CLOSE ||
-		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-		    signal_pending(current))
+		if (tcp_recv_should_stop(sk, timeo))
 			break;
 	}
 
@@ -2697,42 +2677,11 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
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
+			if (!copied && err != -ESHUTDOWN && err != -ENETDOWN)
+				copied = err;
+			break;
 		}
 
 		if (copied >= target) {
-- 
2.48.1

