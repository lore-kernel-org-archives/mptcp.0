Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA0F1DF26B
	for <mptcp@lists.linux.dev>; Sun, 13 Jul 2025 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752399842; cv=none; b=JsOM8/TbFiu2gNRpcR6/vFXwtkOJXmKiWpuCG4rU9NmsQ+9TyWlFTz3o2pwjNtN62FfkPNKULAUdTAgjcjjgn03AhQbFcqg609BGdMdVeE4VauPkLS1Ax4Vm8mzzKbIS5zXhw1cpocGP0ODZTHltoExjMFngwGj5evmYZTfmcDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752399842; c=relaxed/simple;
	bh=BVXVSmHggjfzmaDQJcG9Db2Qhxwzr0415CgH7PHw0QM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hljtFuWNE24KCOZVuWpVpbkcqi05/sPWMY2ZM356Qr23ZncEGLtcBt4W1sC2JzdM06fViutwRHp6HxIV503M2Ly0j7AnzXZmIY54w9pi9/4WXsXoGS56VXhHHZaFasrQzgJaxXi1YYeYebH33OfHLO1w6iPKMqoUQ2/Z64vQn20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeYsNOaK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeYsNOaK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC3BC4CEE3;
	Sun, 13 Jul 2025 09:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752399842;
	bh=BVXVSmHggjfzmaDQJcG9Db2Qhxwzr0415CgH7PHw0QM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FeYsNOaKLVkPJpbJbjYiWyUxbGqqrdvajrny4rl6f7JCgDQGFwHlnJiEzgGCw/HuN
	 PoXh/8HrILOoMdWvujizahrbq/nKb/xd6rfwuLqPmBzWqW5b5vhUx7ScwJlM7ivWVH
	 GTubw1pZIf5+SkJx58y+bLKDn6czLocgdU2P16wnQjEgsWaaqG77aBN8+yhQPCA4jN
	 hzJuWCwbcQ5rucICUJQNV5P30IZU/dxeO239YgAZcd3jxU5EhXVuNrxHHPUr74MOoz
	 Q0FwYBKJMMZ4llPziVPLx+aIdlbN7bgqFGn5ovlxoaQez8AF0eVxJOfQzqaMOCUYwA
	 hBlEhXqg9Wndw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v9 5/9] tcp: add recv_should_stop helper
Date: Sun, 13 Jul 2025 17:43:45 +0800
Message-ID: <ba27dd362819dc200f49d5b9bc1f2ffc8bc5903d.1752399660.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1752399660.git.tanggeliang@kylinos.cn>
References: <cover.1752399660.git.tanggeliang@kylinos.cn>
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
index 338b97a91278..bb1628c0b070 100644
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
index a9af4677051e..b0cb773ab4e7 100644
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

