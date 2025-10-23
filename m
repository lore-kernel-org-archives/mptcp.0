Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA97E1DF252
	for <mptcp@lists.linux.dev>; Thu, 23 Oct 2025 05:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761199028; cv=none; b=DpAvv+iGZ3E30ewAWcWmAn3j3MTuZWQzDAp/MH5HsW1Usj740MSTiNyHMCmiT62jPY3mKhYOlEKBn/0wzdGlwZRfeRcchzIQduZO1YGW8aDG11Uy14VL/zvzAKdk5o1sWMXE2lKsKnDYRbdxQU/+c0eAPdShKkjroZ0N8h4yd+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761199028; c=relaxed/simple;
	bh=jpOR2B16uY540hC0wfr4+rzKppa46MNcPqYrZFy2x9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgHbMil6w8ezKifniF+pva3p/e+3qX9Il3sCmJIy+usq9WNjsdiij5XoDPEs81GBLTBHdZHbol9CHNPCwweT/o0kCPkRc5XuMH450aDUhwN8r4ht/LWPjy2WoAPIEuqj/d8uh5o6S37JBpHVBGoc5iq9/pBkaqNxqrmmMomUQY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4mleXJV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4mleXJV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84DDC4CEFB;
	Thu, 23 Oct 2025 05:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761199028;
	bh=jpOR2B16uY540hC0wfr4+rzKppa46MNcPqYrZFy2x9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R4mleXJV112SHOU15RNbGyIIuhdfuhRb7+feJ69ERWDRkEBz8nNbBkT68YHROQCkA
	 G3ANU1VhR3DQXqoXzomvxw5q0TXun5aD/INVaaTaORO0gfB98FThASGtonrr/lXDIG
	 LMuey63MySeuJ7+Q/DAyOuTCnH4G8oHqtmiHU/9S1xxnzdSH/mMedUU3GCeWtlHc8c
	 pMLe432r2jn1dngzy+KiHzPEsWj5gD/9Y+8pD/qM44pciD4K0R80p12AKOQnlPXnkk
	 tUSiEqJ84ZTpZ4izLWP+fQZ+sHAXrQEe10eJislYZogPhOnSKEXqA+ZsHZfClYfVtg
	 Sq9em4dvxoB8Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 4/8] mptcp: use recv_should_stop helper
Date: Thu, 23 Oct 2025 13:56:47 +0800
Message-ID: <00529da4ea8b262f82505fc99d717145bc8c2aef.1761198660.git.geliang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1761198660.git.geliang@kernel.org>
References: <cover.1761198660.git.geliang@kernel.org>
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
index 3f29236ce5fc..1955717e7dfc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2306,36 +2306,11 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
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

