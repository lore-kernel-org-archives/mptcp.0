Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E213E27A900
	for <mptcp@lists.linux.dev>; Sat, 27 Sep 2025 12:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758976303; cv=none; b=kaIVUYawuaTNQMBIbsvP1w8It1NsZ+HZvbEuzhDp3xL/n9iTx0PVM2QkSIkRCNfSqgh88+Fh0U40tmsdT9FkormuE4KJ2pvtDK9hQ88YaE3GekXQq/Ld2OhXgvD2KtS3G/t2sIgq7wIEw+OZB18SpyBeZjKUkr0+W+nhsBHBycc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758976303; c=relaxed/simple;
	bh=Cq5wvVk0/9Ya5fhm3TV00/i0wjTJZX4g1uY68NMvft8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4VfIm1TSofjBZcR//BMFwm6G9IL5DrVqDlfnzoR1ua5iEHq6UHspm0GpoOzGyA73G9qkernVJ2ErFNw5aaSfyZNCazAtyPwIAt98z0vJH/Zi4TPmR/kDpR58K4eXjtA9LeDCFjmxmWM1uC0jFXChHl3BxtylFBIGULNngg2tbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=draM5z4J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="draM5z4J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E56C4CEE7;
	Sat, 27 Sep 2025 12:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758976302;
	bh=Cq5wvVk0/9Ya5fhm3TV00/i0wjTJZX4g1uY68NMvft8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=draM5z4JTXBmHupLq2aVP1jHOoc+I48VbzbPQVWxVLgek92taKQYFxlxoc31hKIGA
	 5CD4AL/5Y70XSIb48Oi5NoKXpdVm3LBkHU2ciWqqc67exPQkstB+uGzVKPIY9x2m50
	 /TQRzD3qc6i6vfKMTTw8ejpxEFDWpYVRLxPcgrXvgEQqS01bEShMxjFGG9OEKg7t9a
	 lEQubnBe4RwVRhCjgy+rdm4Vtqm5aufbCQeP28pxDmIkDN5GBVlCcYGi16AM9C1Es/
	 UVkXo20u3o1zEcmVE0wzDOgkAB7cvRv0jBbM8U28zGl2qIXNEQAwBxbPn/fQGG0JUL
	 YMfdkMtNJ72vA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v12 4/8] tcp: add recv_should_stop helper
Date: Sat, 27 Sep 2025 20:30:21 +0800
Message-ID: <9696fa685c7c2f6455eed9c62664e0affe3b3bfc.1758975929.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758975929.git.tanggeliang@kylinos.cn>
References: <cover.1758975929.git.tanggeliang@kylinos.cn>
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
index 402017e8367e..746ad7561eb6 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -294,6 +294,29 @@ struct tcp_splice_state {
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
index bfad7ccf6bad..39c86c338378 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -835,26 +835,14 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
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
@@ -866,10 +854,6 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
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
@@ -880,9 +864,7 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
 		release_sock(sk);
 		lock_sock(sk);
 
-		if (sk->sk_err || sk->sk_state == TCP_CLOSE ||
-		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-		    signal_pending(current))
+		if (tcp_recv_should_stop(sk, timeo))
 			break;
 	}
 
@@ -2719,42 +2701,11 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
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

