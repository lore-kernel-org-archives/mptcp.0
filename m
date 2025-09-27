Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71FC27A900
	for <mptcp@lists.linux.dev>; Sat, 27 Sep 2025 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758976304; cv=none; b=rYG+ayxM7Gscpz77Gfpz1q3AN1h3VkzJ2iZdNOND/uuBdW6ugalnxBwvrCUDN5e8NM7HOGehCREkUvFE45wmT80pZ5Qp6wc2ULnjzARr3BPpXnqbdFPnRnhx2ctoKz6/tXQU6FKoGOsESobGYE3SGv0/mARH7nNeXaOdWHxH2UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758976304; c=relaxed/simple;
	bh=Iki+1dnb+B/uAJcXECqXdbHo2g86Fup0XTV0nSZlnzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnkLdZ2YQF/eb+SPXHGhBP0lZVxcM6PuNfuuix9KpvvHxMiHONajgTSWOzslDFQBrwW6fHU4sZD/abws3hBijJ/bs48ZA9m/pb9f4ujJ4ReaMq86zzseIA+wBt6l0oXhQ+T5qWOeJDfC3KYqYWW768tdjsODRHQkKuESZ5PyGj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCuduuQ8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCuduuQ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728FBC4CEE7;
	Sat, 27 Sep 2025 12:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758976304;
	bh=Iki+1dnb+B/uAJcXECqXdbHo2g86Fup0XTV0nSZlnzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eCuduuQ8cngqf0DXG8ustO/4Re7P8eLUSXFRAeUyIFujXklMKb3RmgmvlgtyByTA+
	 ls4bE2eHIpdkmd+FwtEdxpuxOnt7HODC3D0fnefY78PC4ZM3P1JkMrOQUu7vH3YpWf
	 IS/m42qypRGQNhXFp8fi9f2K6Aemzs3RbrQJoQdtE6VMt48qKjiMTaY7cKv1ISxPgG
	 yahFYxz854d7fVdxGnS0CESOEBnRG60coMgC3Y7tFRcHH5bAtUsoYDFmCXZefmd7U4
	 VaZJyRjSX/gQO8Be29rlUmkk66owb+HDsGdX1Jfydm/3C5aTY5wNBFZMboyt3Ji/vb
	 e9SUQh+vnLIGA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 5/8] mptcp: use recv_should_stop helper
Date: Sat, 27 Sep 2025 20:30:22 +0800
Message-ID: <efac186fc8db802f134fcf86d93273039098aca9.1758975929.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758975929.git.tanggeliang@kylinos.cn>
References: <cover.1758975929.git.tanggeliang@kylinos.cn>
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
index dda16dbae9fd..5cbe652b6ea0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2206,36 +2206,11 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
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

