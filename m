Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5FE1DF26B
	for <mptcp@lists.linux.dev>; Sun, 13 Jul 2025 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752399843; cv=none; b=cX9EkD6n9bpf3ueAz7hbdDELrhVzdl8rCUImV4FSZl4Jc2FZ+w2pQFuDVvvzxqIw97PpGNJoskfELS9DQqotmSlG7NNmVyrB9yyp7MQXVEcw1M7y+tL68KzlU0C7IUUD29IQ1y8TJFYUHxdhE/nQGFiL1S3x+b+Ro1s7PhbDIOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752399843; c=relaxed/simple;
	bh=MV/FWpIKlWa01YTg8uvSvZal+CVk2HZVBhQsRXm7luw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iopIUqBFrVJjVmrztlelOQl1712G7k/+uQQaW3kcujRRD1mXeb7kbGZQPNubqFtowyifpKHaGQ5ZANg8CHmDzoYzog2UvrSp8lZvEtLXrh+o/SjmEM1e2fGS6XEMTXQKHlJWTO1rR80edZokQ5ob0dLOl9DONUPff3nY+6RsuGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwtbCuRa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwtbCuRa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07B4C4CEF1;
	Sun, 13 Jul 2025 09:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752399843;
	bh=MV/FWpIKlWa01YTg8uvSvZal+CVk2HZVBhQsRXm7luw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TwtbCuRayaR+uvdso86im2925ULrYEzV1zYeTmmomXj8qXUthF34edwgkoFwPqz1n
	 QX43gSqt/BjY7qaIMwnUPyuHZ+A4kXjD3jWuarzt65NRmxe+Jp/nYaF5Z1ubbutZJN
	 0wNgo7pNPXeLRsz5vhhQXc9ciITvFUBZGA7l1F6VOxfO86rwA3IHkEG8vXkaA/k0Jh
	 RznMN7vmKfQMagLDWh/g0Xl186JorlZ5DvIZ5g0GeCeKmc887gSZzym+YMiL+oLuyx
	 Qzdrw+bNe//GHuuXhxIXCesGU++W0RprnoOopl4qyQBK0FQl05AuCxGKYibvj+TXL+
	 wLHLB57vGlOcQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 6/9] mptcp: use recv_should_stop helper
Date: Sun, 13 Jul 2025 17:43:46 +0800
Message-ID: <25d992117c64ee5be5fd5101b2faab74fafe60e4.1752399660.git.tanggeliang@kylinos.cn>
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

Use the newly added tcp_recv_should_stop() helper in mptcp_recvmsg() to
check whether to stop receiving.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 288f989ab078..f94fdf5b164f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2164,20 +2164,12 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		if (copied >= target)
 			break;
 
-		if (copied) {
-			if (sk->sk_err ||
-			    sk->sk_state == TCP_CLOSE ||
-			    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-			    !timeo ||
-			    signal_pending(current))
-				break;
-		} else {
-			if (sk->sk_err) {
-				copied = sock_error(sk);
+		err = tcp_recv_should_stop(sk, timeo);
+		if (err < 0) {
+			if (copied)
 				break;
-			}
 
-			if (sk->sk_shutdown & RCV_SHUTDOWN) {
+			if (err == -ESHUTDOWN) {
 				/* race breaker: the shutdown could be after the
 				 * previous receive queue check
 				 */
@@ -2186,20 +2178,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 				break;
 			}
 
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
-				break;
-			}
+			copied = err;
+			break;
 		}
 
 		pr_debug("block timeout %ld\n", timeo);
-- 
2.48.1

