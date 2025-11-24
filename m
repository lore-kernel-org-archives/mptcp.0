Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F2C2F531C
	for <mptcp@lists.linux.dev>; Mon, 24 Nov 2025 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975588; cv=none; b=klqqm+Ujlm+ik+3DHYemPG8P54QgudyTiP45wSQlzdAx/3I+70ZAUEm3kaT1B95VZebl4MePqlDQUBT2ONX5OQuPrXLs98ggWpIQlUw9SYcvxhFYAihawHYiHsanmaUayN2oDcmXtf54ruXMupBHaWmw3rpyhKaOFzn7isC2Xm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975588; c=relaxed/simple;
	bh=OAwG+bknZLpSx0zvEY65lzI2EEn0it9RHlF1E6xk4Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUcMkmMPlO7uSgDt05GpdjzGoalbgvf9fDJorV9mJo0swVcPSbI+NG1pE+wri51lJIfK/nSGQCAVH0uwYBjsyd2VAY4U8BApfUC4OGmPhJzalp71fDCV/seJCKnVi1zapcanGrwC8tkENgq0TWtZfls8bL5W4piLWLYuKkkVCJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJybegtK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJybegtK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4739FC116D0;
	Mon, 24 Nov 2025 09:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763975588;
	bh=OAwG+bknZLpSx0zvEY65lzI2EEn0it9RHlF1E6xk4Cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cJybegtKhDEY+HrdhOXUkF1Mp+fVTTHzHt+UBI4xDFzbH5WXvLf6Hly5W9oarY16O
	 2oNftxPcLsU667yeOIjX9HMecmkv2XOVPtVaAAl0yNW4u/kUbc165x79BAv+HWR9/5
	 I2sJFfL3gfe3lTh7fKw0tEDftQXx4H646EyFY4F3731SKYrI+h9Mc8XLzg0Q/riB3P
	 eDialF4ke7vYK9gJ44ct927dj3h/X88bY4ceYuaMwgNmUbpMz3sEmVZhIHWY/u7Uyh
	 GwLTnjXagqO1vMMJRCFipyjOzKsd4a2pnRUG1VoE6p1VDirUPjSl7R/xuSHWK/grCx
	 EIiFUsbvdaFNA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 4/8] mptcp: use recv_should_stop helper
Date: Mon, 24 Nov 2025 17:12:49 +0800
Message-ID: <e33a2eb7b3622d240774ab59061ae32dfd3e4dfa.1763974740.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1763974740.git.tanggeliang@kylinos.cn>
References: <cover.1763974740.git.tanggeliang@kylinos.cn>
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
 net/mptcp/protocol.c | 35 +++++------------------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 75f90f5fc2a3..9302b372910e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2296,36 +2296,11 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
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
-				break;
-			}
-
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
-				break;
-			}
+		err = tcp_recv_should_stop(sk, timeo);
+		if (err < 0) {
+			if (!copied && err != -ESHUTDOWN)
+				copied = err;
+			break;
 		}
 
 		pr_debug("block timeout %ld\n", timeo);
-- 
2.43.0

