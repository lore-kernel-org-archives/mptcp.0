Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB2922AE75
	for <mptcp@lists.linux.dev>; Thu, 10 Jul 2025 06:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752130138; cv=none; b=QWBOl0SG8kDhO8jM3l9vYvnCB/eyYCD4krRIq0jmRoqGzJ/U8PiVFxA4LZBXQYX1hNPEm8yRne+zeu2Ps0SzfpZ7KKo+cqjkROMT+8gA1MbpXczjhlrb171Oz9IQm0PzkIS8ddof1dmNnjgc/xgR7TIvir0fNl/s2ooihlCAvmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752130138; c=relaxed/simple;
	bh=S+ielgUajft+cdkil+tA/tzI0DA74QHmIdsGt6JjRHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFMfO6a57zLxvWdeCjhYLvCQbsyhf92gt163N7rT5AL++O0ffegqIXzD/20+g5FWxqGZ/dRLDxDtJ/RUPUXhIEXlmPJzftDtnZ1LwIRLDOdxsznMk/HwXbKExMeY2fmrstmx0sgVIXmpTzWo6STN5m21wFpYMhDrINBYoJX03MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXG0M7K0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXG0M7K0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C277C4CEF4;
	Thu, 10 Jul 2025 06:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752130137;
	bh=S+ielgUajft+cdkil+tA/tzI0DA74QHmIdsGt6JjRHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bXG0M7K0SUV6D49zNewh4Bp+jpJvokKAycs4mFZ5z95Yh/WMWsxetMoZpS7DNWk0v
	 L/8X12AWS9+4YJX1OZTjcPtfK7JZm5rjezo4HMhGwYQ9hXKnTzwGWXLOO77BICWetX
	 D1l6j2EFL9f2ZQNRi4C1EFlZEsXnH33oHLzXlamLntFYNps17kgrThfAImPUfA5i1c
	 +lC+/RyhOmIva9w/01Wsx7PRg7xaKcBpLof+vVf+QVP2S+0NaTAdD3y5tGle3XU8wY
	 1FaYPTWCE7mVNa69iudu09x+gIcjqQyyaA6yRuvbThJyGwo8nYMEowADfMkQGi7jLO
	 rbMz/G7Swa1sQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/2] Squash to "mptcp: add recv_should_stop helper"
Date: Thu, 10 Jul 2025 14:48:43 +0800
Message-ID: <9c91ae465bd8ffd1a7e30ee73c93866d874b22ba.1752129934.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1752129934.git.tanggeliang@kylinos.cn>
References: <cover.1752129934.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop "shutdown" parameter.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6b3be1d0668d..73359a61ec80 100644
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
 
@@ -2174,11 +2166,18 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			    signal_pending(current))
 				break;
 		} else {
-			copied = mptcp_recv_should_stop(sk, timeo, &shutdown);
-			if (copied < 0 || shutdown == 1)
+			copied = mptcp_recv_should_stop(sk, timeo);
+			if (copied == -ESHUTDOWN) {
+				copied = 0;
+				/* race breaker: the shutdown could be after the
+				 * previous receive queue check
+				 */
+				if (__mptcp_move_skbs(sk))
+					continue;
 				break;
-			if (shutdown == 0)
-				continue;
+			} else if (copied < 0) {
+				break;
+			}
 		}
 
 		pr_debug("block timeout %ld\n", timeo);
-- 
2.48.1

