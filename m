Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCC328B7F0
	for <mptcp@lists.linux.dev>; Thu, 10 Jul 2025 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135398; cv=none; b=e3swKOhyLWlV70URfBREqAcKF9GaR++3ar0N9cY6HTGHtVCvoP10uAgy/mDzsUQCuZf5N2NJVq34ZmUK7jD+EG6KZzZr782Uo+cIqE4Obm6kqKYSskq9HaR/OqGU7NJ77YHp2QKb2Iat9h0omGza0/E5IEZ6g/+gHjGU7JcJnT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135398; c=relaxed/simple;
	bh=CGslljLzAvM/HLym40XR1WPdzZKX5/7eNIIC+UalimE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=braH2+JckkSOqD///Kp8W2VK/2FedEu/6fzqhlRy+12ay2n46XoF7N1fZGHTdBsKYt0BpNbdkBoyGcfHxwYItPmaTvdsqgubqoA7+6HQnsOiOrcOl9CVeGM92DisXM/U528fJCuyC2ovvwMXLtzJT1d0QHMf2RB6WQ6XDdPtErg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIuDK/CP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIuDK/CP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66D6C4CEE3;
	Thu, 10 Jul 2025 08:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752135396;
	bh=CGslljLzAvM/HLym40XR1WPdzZKX5/7eNIIC+UalimE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HIuDK/CPS9jaL0+p/3SUo+ziLb0uC6Mn/S5HnghrkCAv9vDV6nq2gxVqXi3WMrv9x
	 ynehIZ98uWjWtVHVkHoWUOgqHeevGNYqvKfxm7uokqsV/gy2WMJ/b3e3l/FXePOF1P
	 mjzklbOJhpQXZLV6aFCeBoYJOQHRr7px3+fGFE4W2ekpU6N+2tQsV+nJ/HTYYha78L
	 JB7fnrIPfE1n6vLJ5u+V4MraOkTL8ld9KKXAWt/V0QVMuVc6qpbiEYy6ZptK6SlHWm
	 JEZhGnm4Hp+ghKI/A1ADt8D2Rg2G/WgE8Wb+qafQyUBsvnWPfo65JxqU4L+YFfOVgW
	 sAdBKxk12pwMw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/2] Squash to "mptcp: add recv_should_stop helper"
Date: Thu, 10 Jul 2025 16:16:27 +0800
Message-ID: <8197ea3a696dd67809410ff1b12584db9b1e95b3.1752135065.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1752135065.git.tanggeliang@kylinos.cn>
References: <cover.1752135065.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop "shutdown" parameter of mptcp_recv_should_stop.
Use mptcp_recv_should_stop for "if (copied)" case too.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6b3be1d0668d..32ca63a0825a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2090,20 +2090,13 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
 	return 0;
 }
 
-static int mptcp_recv_should_stop(struct sock *sk, long timeo, int *shutdown)
+static int mptcp_recv_should_stop(struct sock *sk, long timeo)
 {
 	if (sk->sk_err)
 		return sock_error(sk);
 
-	if (sk->sk_shutdown & RCV_SHUTDOWN) {
-		*shutdown = 1;
-		/* race breaker: the shutdown could be after the
-		 * previous receive queue check
-		 */
-		if (__mptcp_move_skbs(sk))
-			*shutdown = 0;
-		return 0;
-	}
+	if (sk->sk_shutdown & RCV_SHUTDOWN)
+		return -ESHUTDOWN;
 
 	if (sk->sk_state == TCP_CLOSE)
 		return -ENOTCONN;
@@ -2123,7 +2116,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct scm_timestamping_internal tss;
 	int copied = 0, cmsg_flags = 0;
-	int shutdown = -1;
 	int target;
 	long timeo;
 
@@ -2166,19 +2158,22 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		if (copied >= target)
 			break;
 
-		if (copied) {
-			if (sk->sk_err ||
-			    sk->sk_state == TCP_CLOSE ||
-			    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-			    !timeo ||
-			    signal_pending(current))
+		err = mptcp_recv_should_stop(sk, timeo);
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

