Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4B8228C9D
	for <mptcp@lists.linux.dev>; Sat, 13 Dec 2025 06:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765608000; cv=none; b=BSy1RfthM7DIONpk6lWv+WFF2bh0+bkv0ikuvsCUJvD2mfHtgFs1dIcS8jzcpPS+UYo/Zpt5URdlaVyVtwu6YpgGZ3jryD1Ke40G2ogn94nlhPR6DHll69Syaab8STY8HLUrkcr5zGTGQF7SewouzPz922lvXE5KtWzPbC7DGCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765608000; c=relaxed/simple;
	bh=CNQGwyZcMYb868VOo3LKjYGRiQrfNvLKvrUbT9olALI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C0ZorZIwBanoDK54Nrpq6psN8fkZM1nVj1UrVRb2sp+c8lmIsvfeUihV70wWSd1KVJRLGkyaOBsxoWzfagQHF8QqlDCbvpBTU8P8LhTDusHuj1AQD0kf+gej3hzBNRhJPHADCN3gPno+mtWy3QAz4nmF5bfs6G0owT4dU9Y2Dtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2UBf7zx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2UBf7zx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A91AC4CEF7;
	Sat, 13 Dec 2025 06:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765607999;
	bh=CNQGwyZcMYb868VOo3LKjYGRiQrfNvLKvrUbT9olALI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S2UBf7zxFOMNLKx26JKVQUYgj4JLEWgWqdcB//dfPoO112qvWrlh3jYP2YkV8bbrv
	 L/DvnY3VcWZlPD2zM13G0N7AWwV8vHf+LdLId0cJzeS4Re85abOJ4cvD/mFUyBJXj8
	 DiwzFJsDam7+0lXzc0crm+g/qiPB3TC3HytnvxcTW6jJbPcoWka1rvQliO0rx3qMT8
	 0vippMPEBQpNy8D7+k1SMagvgUsRgPyYbFZGahGl4k94kn2gjtE+Vq/CoOEZg76H+X
	 RFFhzqtbEpEXdttw+3+ujBRmljFLDZMUduq/td74cVRGg6QMZ05eW41e+2fppo9mSn
	 icd9+fW5Ah8+w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/3] mptcp: use recv_should_stop helper
Date: Sat, 13 Dec 2025 14:39:49 +0800
Message-ID: <017e298d8b4788e4ec78ce7901d64ff9c1d71ce0.1765607485.git.tanggeliang@kylinos.cn>
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

Use the newly added tcp_recv_should_stop() helper in mptcp_recvmsg() and
mptcp_splice_read() to check whether to stop receiving.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 52 ++++++++++----------------------------------
 1 file changed, 11 insertions(+), 41 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 334fdb10fdf3..dce7fcb05fc0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2315,11 +2315,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
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
@@ -2327,21 +2323,10 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 				break;
 			}
 
-			if (sk->sk_shutdown & RCV_SHUTDOWN)
-				break;
-
-			if (sk->sk_state == TCP_CLOSE) {
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
+				if (err != -ESHUTDOWN)
+					copied = err;
 				break;
 			}
 		}
@@ -4438,6 +4423,7 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 	ssize_t spliced = 0;
 	int ret = 0;
 	long timeo;
+	int err;
 
 	/*
 	 * We can't seek on a socket input
@@ -4457,24 +4443,14 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 		} else if (!ret) {
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
 			/* if __mptcp_splice_read() got nothing while we have
@@ -4486,10 +4462,6 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
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
@@ -4500,9 +4472,7 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 		release_sock(sk);
 		lock_sock(sk);
 
-		if (sk->sk_err || sk->sk_state == TCP_CLOSE ||
-		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-		    signal_pending(current))
+		if (tcp_recv_should_stop(sk, timeo))
 			break;
 	}
 
-- 
2.51.0

