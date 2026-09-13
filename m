Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA723CCFC3
	for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789294526; cv=none; b=eS25FbTwbvJWek+DqjorVv+/UrIlsrLFCD5aPqszWSYDb9WkiA5o6/bGSqyCy25nIZx11ScnWAo83o8+Ik6QhfOHE60WB7dBsbZyVeXfCjxjYgen9ZFdu7dDC6r2DAMp6npjGPRHQv+ZqFkqMKGn9N+PX8QkShKWK3fP7G7NVRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789294526; c=relaxed/simple;
	bh=sKHPyg7Dyb5XBXHV9dGnc3tWy0/8cddOICo+Obcc4ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWSbxwhUb1nbW0Jv2dT2KbsdCur9dkHVyzD86SkRaIFsYDe8mXHPclEADn9NNpWXQdo2fDKpB2pAmfhepq10f420rTnE8BFwN8lduVX4paNMb+Oxutz+qUOKyWBkYy0J7O5jwB4dqs733k8+m0wxYMCT0QaNySR4Alwz6Q1rnRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWrPdG2O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWrPdG2O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAED81F00899;
	Sun, 13 Sep 2026 10:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789294524;
	bh=h5OZpAKohlbk3worVQMNC6fVZBm3WDQiMVA4IsjTpYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MWrPdG2OZ4MPj//Qg0ctyqr4dmbDmPGfjWdJiq3I9pPdvX3W108xn5wxqEByFPgZj
	 GOFz9mPHXRWc0/7QrR01HIfa3Quo2fJNADVTTL05NoPrlCCTjHULkWonevXS/L0Q2f
	 l4qc9HU5NPeYurPEhNQiPyQ4L/lDmBgNJpUG0i91Q9K+LmWiJNhUuWw9N1y/if9rZU
	 mybCQ2yW/l6gfMV58/f33IzA2j6FAqKov8PwpmM32uwAfX6ebfSsNXcib2+A4w5WD8
	 niIyeo0GPDEWH5sUxrmagzxQeGZ/SxWf+yGt4NDul5I2OrfvFfieuXlp0ci+Trw8Lf
	 aJJ5CkIyNiqMg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 11/16] mptcp: add TCP_REPAIR sockopt support
Date: Sun, 13 Sep 2026 18:14:50 +0800
Message-ID: <15960ae7fff68167e041400db0480e55950ea1c1.1789294365.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789294365.git.tanggeliang@kylinos.cn>
References: <cover.1789294365.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add TCP_REPAIR socket option support for MPTCP, required for sockmap CRIU
checkpoint/restore. When TCP_REPAIR is set on the first subflow, skip the
normal connection handshake in mptcp_connect() and transition directly to
TCP_ESTABLISHED. On close, skip the shutdown sequence and jump to cleanup
when repair mode is active.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 10 ++++++++++
 net/mptcp/sockopt.c  |  4 +++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c5be29767cb1..07132976016e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3560,6 +3560,11 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		__mptcp_wr_shutdown(sk);
 	}
 
+	if (msk->first && tcp_sk(msk->first)->repair) {
+		mptcp_set_state(sk, TCP_CLOSE);
+		goto cleanup;
+	}
+
 	sk_stream_wait_close(sk, timeout);
 
 cleanup:
@@ -4281,6 +4286,11 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 
 	inet_assign_bit(DEFER_CONNECT, sk, inet_test_bit(DEFER_CONNECT, ssk));
 
+	if (unlikely(tcp_sk(ssk)->repair)) {
+		mptcp_set_state(sk, TCP_ESTABLISHED);
+		sk->sk_state_change(sk);
+	}
+
 out:
 	if (!msk->fastopening)
 		release_sock(ssk);
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 922f6ae5c80c..d2d1c9d1ed1d 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -671,12 +671,13 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		case TCP_FASTOPEN_CONNECT:
 		case TCP_FASTOPEN_KEY:
 		case TCP_FASTOPEN_NO_COOKIE:
+		case TCP_REPAIR:
 			return true;
 		}
 
 		/* TCP_MD5SIG, TCP_MD5SIG_EXT are not supported, MD5 is not compatible with MPTCP */
 
-		/* TCP_REPAIR, TCP_REPAIR_QUEUE, TCP_QUEUE_SEQ, TCP_REPAIR_OPTIONS,
+		/* TCP_REPAIR_QUEUE, TCP_QUEUE_SEQ, TCP_REPAIR_OPTIONS,
 		 * TCP_REPAIR_WINDOW are not supported, better avoid this mess
 		 */
 	}
@@ -918,6 +919,7 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	case TCP_CONGESTION:
 		return mptcp_setsockopt_sol_tcp_congestion(msk, optval, optlen);
 	case TCP_DEFER_ACCEPT:
+	case TCP_REPAIR:
 		/* See tcp.c: TCP_DEFER_ACCEPT does not fail */
 		mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname, optval, optlen);
 		return 0;
-- 
2.53.0

