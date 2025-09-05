Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00E723BCE7
	for <mptcp@lists.linux.dev>; Fri,  5 Sep 2025 18:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757096356; cv=none; b=SK1w6Y2E4TlZuw8pCFAEBv8i+DQzeg4GQPD76R9xn4tT6gB+vHmoBK4uv5VwGvEDimfhCzNSPWROdMoDbmi7HaoRO01w/JKS4ch5FYKCKgPomQyz6x627hy+GGVQ3v0adk1+Nse7aBeiwYZMapmJSJ6dqqAr09HcXpEldjQqvzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757096356; c=relaxed/simple;
	bh=YXQ+CwIoJ9h5qstPz2KMyddL8vl2xQ2lQH4Wjo+XiZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RagMEwsNT8W/tPLg7BSYacyKV3Pu6lKn224dpBKqpnVYmSkIV/KEk+iFCv74vbKd4Soo6Yv8MCiKoYKgifnXHGMN591sRZgfDNC8YL6C+DXgB9+Hj87XPKureS60p1/Gtsx4UTtYwT1uFxLEl6OLmwH6VLmGQ22qqu73Mbsf1HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4vYuQev; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4vYuQev"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E44CC4CEF4;
	Fri,  5 Sep 2025 18:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757096356;
	bh=YXQ+CwIoJ9h5qstPz2KMyddL8vl2xQ2lQH4Wjo+XiZc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=t4vYuQevKZcrQgofY0cUihG22h8dItpgjLb5i4eLS2CuxpwY1qPmePs7hbiNnuAlG
	 0vG2hX7+uySkcRopKfUQQ5ZJwg7RpSXc8ujoWwVSJTuuUZMySVH50u2CHBWWgmrNQ1
	 K7YQxZmNhKEN2L/lZn9+sjUn6OprxRvaTXzZuSCg2RyZJgaSZoPKxOPHlJWGmwtMgA
	 m0LpmdnOJKQAqo6OeNsvjfwJBriZbe3wq9HO53sQhmPeYuqZrGyszhAwjNXVJi4WdF
	 KZ91fC06JegzimjNdk++CfUgIPqCm8e7oKDWrWZC0WbDu+t9ROBzAxfQUm4xGdHbuX
	 LTQhD15rpYiFw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Sep 2025 20:18:50 +0200
Subject: [PATCH mptcp-net v2 1/5] mptcp: propagate shutdown to subflows
 when possible
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-sft-mptcp-disc-err-v2-1-dfb3b6b4a877@kernel.org>
References: <20250905-sft-mptcp-disc-err-v2-0-dfb3b6b4a877@kernel.org>
In-Reply-To: <20250905-sft-mptcp-disc-err-v2-0-dfb3b6b4a877@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2364; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=YXQ+CwIoJ9h5qstPz2KMyddL8vl2xQ2lQH4Wjo+XiZc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ2a873cd71ylvs8KR9k5YrJm6MeG7nYzDJY1Y4005N7
 b23PPYd6ChlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZhIwgxGhm/Fdql3vJvPe879
 8FdRzu7U3C0TN57mvDIrK9FDSuGpZwgjw0bh0uKFf66tum54lOtaWKTLW4Ucs0nnmSYfN+bqzQ4
 +wwIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When the MPTCP DATA FIN have been ACKed, there is no more MPTCP related
metadata to exchange, and all subflows can be safely shutdown.

Before this patch, the subflows were actually terminated at 'close()'
time. That's certainly fine most of the time, but not when the userspace
'shutdown()' a connection, without close()ing it. When doing so, the
subflows were staying in LAST_ACK state on one side -- and consequently
in FIN_WAIT2 on the other side -- until the 'close()' of the MPTCP
socket.

Now, when the DATA FIN have been ACKed, all subflows are shutdown. A
consequence of this is that the TCP 'FIN' flag can be set earlier now,
but the end result is the same. This affects the packetdrill tests
looking at the end of the MPTCP connections, but for a good reason.

Fixes: 3721b9b64676 ("mptcp: Track received DATA_FIN sequence number and add related helpers")
Fixes: 16a9a9da1723 ("mptcp: Add helper to process acks of DATA_FIN")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1c26acf6c4145896ecbb5c7f7004121c66a20649..9feb9f437c2bdfff392249e7ad00edd09ba67ac3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -372,6 +372,20 @@ static void mptcp_close_wake_up(struct sock *sk)
 		sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
 }
 
+static void mptcp_shutdown_subflows(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow;
+
+		slow = lock_sock_fast(ssk);
+		tcp_shutdown(ssk, SEND_SHUTDOWN);
+		unlock_sock_fast(ssk, slow);
+	}
+}
+
 /* called under the msk socket lock */
 static bool mptcp_pending_data_fin_ack(struct sock *sk)
 {
@@ -396,6 +410,7 @@ static void mptcp_check_data_fin_ack(struct sock *sk)
 			break;
 		case TCP_CLOSING:
 		case TCP_LAST_ACK:
+			mptcp_shutdown_subflows(msk);
 			mptcp_set_state(sk, TCP_CLOSE);
 			break;
 		}
@@ -564,6 +579,7 @@ static bool mptcp_check_data_fin(struct sock *sk)
 			mptcp_set_state(sk, TCP_CLOSING);
 			break;
 		case TCP_FIN_WAIT2:
+			mptcp_shutdown_subflows(msk);
 			mptcp_set_state(sk, TCP_CLOSE);
 			break;
 		default:

-- 
2.51.0

