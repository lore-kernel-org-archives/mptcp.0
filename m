Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EC43E5ED8
	for <mptcp@lists.linux.dev>; Tue, 31 Mar 2026 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774946429; cv=none; b=GohLJIVP7aGr6ZRUDvqGkaKFzw8IMTZULyyDZqYuMpabtSVdRjPeVScZlGWYgUM1rXCJw1PzBndZu5GLTXFkeweiS4oOdsUt1WeHn11OYDFW+49pbOFC8qegjGVVG+QfAZcdSmKCNs4qlQddh/z4mJm2nKpeMITKYLYzCbt5CYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774946429; c=relaxed/simple;
	bh=yH3eQ0OFkKEdpojeVp6orkFO9dDTX9u259AQVZtX940=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=obGQ2IMAGkGs1pvJU/JhuTHHhd7O/Q//zoy16KrXkyrgQvlv0xsw7WWG0eqGjNudyxelVp+2LL6ZMOucIr/9542h4xrKRDLt46UTZdZewfJgOyKi9rCQQND8VZn0A4C4Nyias4V8DfhIXmb+sYoJ4UvdjCpbemv9L0NLj9qHktw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tejmudJF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tejmudJF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19254C2BCB1;
	Tue, 31 Mar 2026 08:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774946429;
	bh=yH3eQ0OFkKEdpojeVp6orkFO9dDTX9u259AQVZtX940=;
	h=From:To:Cc:Subject:Date:From;
	b=tejmudJFkSU1seHa5+tvJB2z7Q8uTut+7z07MF6DwXPrwh5lgLsmthqq3QrN5OHL8
	 ZkhIzhE9NcSBOBPU1aT47cA4fRE8EqSjKeZ6LplPqn/ydXDxnkd89fE7VUuZhCxgHJ
	 s/CMGND3KfkypFY0HNxBxEgTqysIIgGL77tsApwChaiFgTKg+pPOYn1Hcm+MWlLYXY
	 52vf9Y7GJJ3RMDlAHbveWmOjHrZauS8vNKemsKcAGBlBTUPbxVWDplUINetXbBtfeV
	 acwJG6MQbmK2UGdZGirAIEVDixPzRt+rgn8fK0stdagt2ZWIfohYK7OE6fkuE196vb
	 u6hRPYPXNV1nA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>
Subject: [PATCH mptcp-next v3] tcp: add recv_should_stop helper
Date: Tue, 31 Mar 2026 16:40:22 +0800
Message-ID: <7d66c0d1f1384b142b064a760545ee6e2a8bcbde.1774946177.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
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
v3:
 - drop timeo parameter of tcp_recv_should_stop as Matt suggested.
 - drop patch 1 "mptcp: check desc->count in read_sock" in v2 as
   Matt suggested. I changed the state of it as "Rejected".

v2:
 - v1 changed the original behavior when replacing tcp_recv_should_stop.
   This version preserves the behavior unchanged.
 - add a cleanup patch for read_sock into this set.
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1773740635.git.tanggeliang@kylinos.cn/

v1:
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1765607485.git.tanggeliang@kylinos.cn/
---
 include/net/tcp.h    |  8 ++++++++
 net/ipv4/tcp.c       |  9 ++-------
 net/mptcp/protocol.c | 11 +++--------
 3 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 565943c34b7e..6156d1d068e1 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -3077,4 +3077,12 @@ enum skb_drop_reason tcp_inbound_hash(struct sock *sk,
 		const void *saddr, const void *daddr,
 		int family, int dif, int sdif);
 
+static inline int tcp_recv_should_stop(struct sock *sk)
+{
+	return sk->sk_err ||
+	       sk->sk_state == TCP_CLOSE ||
+	       (sk->sk_shutdown & RCV_SHUTDOWN) ||
+	       signal_pending(current);
+}
+
 #endif	/* _TCP_H */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 2a69441568b3..f2d2884652ea 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -888,9 +888,7 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
 		release_sock(sk);
 		lock_sock(sk);
 
-		if (sk->sk_err || sk->sk_state == TCP_CLOSE ||
-		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-		    signal_pending(current))
+		if (tcp_recv_should_stop(sk))
 			break;
 	}
 
@@ -2755,10 +2753,7 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 
 		if (copied) {
 			if (!timeo ||
-			    sk->sk_err ||
-			    sk->sk_state == TCP_CLOSE ||
-			    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-			    signal_pending(current))
+			    tcp_recv_should_stop(sk))
 				break;
 		} else {
 			if (sock_flag(sk, SOCK_DONE))
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 98a6caf9af97..2f0d7f9f7c3c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2322,11 +2322,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			break;
 
 		if (copied) {
-			if (sk->sk_err ||
-			    sk->sk_state == TCP_CLOSE ||
-			    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-			    !timeo ||
-			    signal_pending(current))
+			if (tcp_recv_should_stop(sk) ||
+			    !timeo)
 				break;
 		} else {
 			if (sk->sk_err) {
@@ -4511,9 +4508,7 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 		release_sock(sk);
 		lock_sock(sk);
 
-		if (sk->sk_err || sk->sk_state == TCP_CLOSE ||
-		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-		    signal_pending(current))
+		if (tcp_recv_should_stop(sk))
 			break;
 	}
 
-- 
2.51.0

