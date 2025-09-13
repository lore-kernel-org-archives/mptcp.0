Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE5811185
	for <mptcp@lists.linux.dev>; Sat, 13 Sep 2025 00:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757723951; cv=none; b=G40LTPf5Rhm7SQfbERgkrm15bPLz7aw+bGAio56CCCTTN8Pj1lqugtdGeJPlH2kJgWS/peUARnyKbBs7IxqPGlP0xBStakO11jFAm+6BRrKlox7q/FbueslLKjoAgnXJ+Z30xuE/xxkHx4oS8PKO7tf/SWne08xAU9IukshAV3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757723951; c=relaxed/simple;
	bh=ACUXJqNN368ju2r6WKKZ2m19M9rrmuVLa9x0FnrEQ9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWO2BnFFRFxKJxerwsS6xp86eA1slJpJhIJc1Opy1AH/jrL31A304QY1EgcTQ0RqXY1goY0sL4+sNh0ik9xExLcUGvpin3ppWzKC2itcIeHxgGpmmyu3AgbZ1rSm+dLgRqKGb7oA4eOGXE3QASDi74e2syU2ySW6q0H0I4N6blw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klXcqAKU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klXcqAKU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360A0C4CEF5;
	Sat, 13 Sep 2025 00:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757723951;
	bh=ACUXJqNN368ju2r6WKKZ2m19M9rrmuVLa9x0FnrEQ9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=klXcqAKUAIHdI607niwUgV5UFxi5nGxaIYHBMFzelUkVa88IKzGJzk6SyfLGYbmc/
	 Pj0ZNx65kTbXHzbEcXmk8YQEQZyeLSePYdXs1D5Mz+gPa9qfRyDZ9JF3K0jTBjBEEO
	 BGQsjN2HrTWlih1Ps8aS1kLfdUNr01Zru6VwMNhaX3YU/bHFiuS5/ZZXtiRH8i1xDj
	 JDmUgKitWA3+35bHbPa7hyzkSYj7IuyAc99uQ/1PTwsPcpbrPXrTakCoJGGOxwrpln
	 60ED6KIpmqvLjLKaJdb338IuDCGJfSZTXSa+DiXnT2Rp0gUZtL0zfaE7iiJBGL6aHz
	 UGCE7crM/+T8Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v11 4/8] tcp: add recv_should_stop helper
Date: Sat, 13 Sep 2025 08:37:23 +0800
Message-ID: <935226abaf68ae4e0e94e66bd1884575264ad9b0.1757723270.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1757723270.git.tanggeliang@kylinos.cn>
References: <cover.1757723270.git.tanggeliang@kylinos.cn>
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
 net/ipv4/tcp.c    | 73 +++++++----------------------------------------
 2 files changed, 34 insertions(+), 62 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index b071dad4c5e0..e4a8ab62ae77 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -280,6 +280,29 @@ struct tcp_splice_state {
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
index 03b75b3f676e..e772b4527ce0 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -812,7 +812,7 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
 	};
 	long timeo;
 	ssize_t spliced;
-	int ret;
+	int ret, err;
 
 	sock_rps_record_flow(sk);
 	/*
@@ -833,24 +833,10 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
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
@@ -862,10 +848,6 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
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
@@ -876,9 +858,7 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
 		release_sock(sk);
 		lock_sock(sk);
 
-		if (sk->sk_err || sk->sk_state == TCP_CLOSE ||
-		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-		    signal_pending(current))
+		if (tcp_recv_should_stop(sk, timeo))
 			break;
 	}
 
@@ -2715,42 +2695,11 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
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

