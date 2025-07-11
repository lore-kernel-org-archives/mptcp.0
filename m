Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFAB5227
	for <mptcp@lists.linux.dev>; Fri, 11 Jul 2025 01:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752197776; cv=none; b=eV1oNrnJCtBAwuwULp7+M9KfirsDDz1vLubhJcPHTEdZfMKqsQRSWc4upSNdnmMwKKptuDk6vhcAjPpWx0BsLUelBZPmPQg1D8N0u1IjQqFLRZZ/2AQqasaIZTa48bw/sPf64AH19eGX/F5VfMRwsW5runbObNHdVVhZjj5HEQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752197776; c=relaxed/simple;
	bh=FE/6mo9xEEFRZzzT+vw1SlTsa7EVsrg8vdA2ZsotPEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R85mhTQ76/UeomBzmLLoXrJ67BefQQE3xjqgwyAsMeZqCJFrS1G1aSItZIMD+qNm5Swvo51ZoRp7kCChkRIFWA3dp7jxC7RD+7RLgKkjrvzKMAiKC5ubV/EMSDadMGN3OmbD/zUN1jx9quX5RIkpfUwuEmqoWk6YVF9cDHuAH3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DabClZOl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DabClZOl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC5BC4CEF4;
	Fri, 11 Jul 2025 01:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752197776;
	bh=FE/6mo9xEEFRZzzT+vw1SlTsa7EVsrg8vdA2ZsotPEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DabClZOlFbdACMkW5kEFu+NYbiyFCnarZX1Pbn3LeDDnWLD1HDRrDXiOnJO+JjE1i
	 VT5g/WFR77CebisQxgs0yLyHOuBqncS36dC2eF8ht2W/M002h0qzejoe98db8nqqFX
	 XYRoroJDmSDp0NF85Zo8TiqMbO3LYkmximZB7e3PClRXxHx4jS13MF9GVMn1upKZfL
	 0FzukmwLt5ifempQ3vtU78Gn5Eepc9YOw+tlv01yfH4zIOkbhyehVJ+ii2mAMmdy52
	 Ok3qzrhmRq9A67p135wkXy0UOdiVA8vccOF4wUj2I3+GmbSPInSY0JVWlFLGLE+d7t
	 ampdR/3oHgGeA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 1/2] Squash to "mptcp: add recv_should_stop helper"
Date: Fri, 11 Jul 2025 09:36:05 +0800
Message-ID: <782e65ce91f13786c11954cf5b69c481f193c44e.1752197546.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1752197546.git.tanggeliang@kylinos.cn>
References: <cover.1752197546.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

tcp: add recv_should_stop helper

Drop "shutdown" parameter of mptcp_recv_should_stop.
Use mptcp_recv_should_stop for "if (copied)" case too.
Rename this helper as tcp_recv_should_stop using for both TCP and MPTCP.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tcp.h    | 23 ++++++++++++++
 net/ipv4/tcp.c       | 73 +++++++-------------------------------------
 net/mptcp/protocol.c | 53 +++++++++-----------------------
 3 files changed, 48 insertions(+), 101 deletions(-)

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
index 75d4b4ddab8e..35aed2af1e34 100644
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
@@ -846,10 +832,6 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
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
@@ -860,9 +842,7 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
 		release_sock(sk);
 		lock_sock(sk);
 
-		if (sk->sk_err || sk->sk_state == TCP_CLOSE ||
-		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-		    signal_pending(current))
+		if (tcp_recv_should_stop(sk, timeo))
 			break;
 	}
 
@@ -2699,42 +2679,11 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
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
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6b3be1d0668d..5dc3716daab5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2090,40 +2090,12 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
 	return 0;
 }
 
-static int mptcp_recv_should_stop(struct sock *sk, long timeo, int *shutdown)
-{
-	if (sk->sk_err)
-		return sock_error(sk);
-
-	if (sk->sk_shutdown & RCV_SHUTDOWN) {
-		*shutdown = 1;
-		/* race breaker: the shutdown could be after the
-		 * previous receive queue check
-		 */
-		if (__mptcp_move_skbs(sk))
-			*shutdown = 0;
-		return 0;
-	}
-
-	if (sk->sk_state == TCP_CLOSE)
-		return -ENOTCONN;
-
-	if (!timeo)
-		return -EAGAIN;
-
-	if (signal_pending(current))
-		return sock_intr_errno(timeo);
-
-	return 0;
-}
-
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			 int flags, int *addr_len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct scm_timestamping_internal tss;
 	int copied = 0, cmsg_flags = 0;
-	int shutdown = -1;
 	int target;
 	long timeo;
 
@@ -2166,19 +2138,22 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		if (copied >= target)
 			break;
 
-		if (copied) {
-			if (sk->sk_err ||
-			    sk->sk_state == TCP_CLOSE ||
-			    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-			    !timeo ||
-			    signal_pending(current))
+		err = tcp_recv_should_stop(sk, timeo);
+		if (err < 0) {
+			if (copied)
 				break;
-		} else {
-			copied = mptcp_recv_should_stop(sk, timeo, &shutdown);
-			if (copied < 0 || shutdown == 1)
+
+			if (err == -ESHUTDOWN) {
+				/* race breaker: the shutdown could be after the
+				 * previous receive queue check
+				 */
+				if (__mptcp_move_skbs(sk))
+					continue;
 				break;
-			if (shutdown == 0)
-				continue;
+			}
+
+			copied = err;
+			break;
 		}
 
 		pr_debug("block timeout %ld\n", timeo);
-- 
2.48.1

