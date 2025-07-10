Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55FF22AE75
	for <mptcp@lists.linux.dev>; Thu, 10 Jul 2025 06:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752130140; cv=none; b=WZty9jKXXkZQMFaLoUnaQVPB72mjtjiNdmj1759dtrQOgRopymAN1NVkWliyY6WSK7zsc+eZm0aput6kl+7IbLSz9nXMG/v6QZR6e9w6thO1hswC2N+PynPeQr3z4cqliBEdA7LLsbyvp/Fa6sAz9ou3NdVXt7sM0OdsDns16t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752130140; c=relaxed/simple;
	bh=1qrb70+GJC6gf3W0p1T+6TZ6P2x19pQiv8wBitTzHbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6yc5/z4BQm0s1tX2AEq6AOPoXlR5tFDUdyKkKzQDgwOo8rOeLqcaeB/Iuk5EV5cK+lqnqrdtE8ImyjXSKqvF+Q/KRzcudyKsyr2GZ/K1EsOZwBPfXYL5Wtom0HMVnfC4L4PtxtkofPjiRSwembDhSfNc/OwcCg3gQHoBMpRaBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFuQehZb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFuQehZb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9B8C4CEF4;
	Thu, 10 Jul 2025 06:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752130140;
	bh=1qrb70+GJC6gf3W0p1T+6TZ6P2x19pQiv8wBitTzHbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cFuQehZb4nzFGTqO+Qhq2adbZXIiUvt9b0w+uITuQdiVmfeXTPjxzpNhEIVQZNOdn
	 5EElePeNKeWE+XiHkgCXe7lfTT9Kss8QgASn1bwEDOOL+oGXvIeQxTDN0kos3Q4KGm
	 ECAwPUKgAGWqFTelV+DIUH9pjBTIgk/rusEdCXH2akiDziGNxuge0s/50ot4QxDxiK
	 5mVGWISJzLP7rg54dXsf5G0UGJh3OKHKyu3SBpbOLJzIiJX68msXM6QPm2PC4fcnJQ
	 XX7XtaI/DDZCujCL6I6H/3LN0dy6tZpfx5SXteFFDXhdmLPEWenBS/JHLj6GCi+LmN
	 SnCe6tSI3C7yg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/2] Squash to "mptcp: implement .splice_read"
Date: Thu, 10 Jul 2025 14:48:44 +0800
Message-ID: <2d096a91bd43f1b7325b5afdd2bde0018203b726.1752129934.git.tanggeliang@kylinos.cn>
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

Update the parameter of mptcp_recv_should_stop.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 73359a61ec80..a3eb39a45403 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4060,7 +4060,6 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 		.flags = flags,
 	};
 	struct sock *sk = sock->sk;
-	int shutdown = -1;
 	ssize_t spliced;
 	long timeo;
 	int ret;
@@ -4086,11 +4085,15 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 				break;
 			if (sock_flag(sk, SOCK_DONE))
 				break;
-			ret = mptcp_recv_should_stop(sk, timeo, &shutdown);
-			if (ret < 0 || shutdown == 1)
+			ret = mptcp_recv_should_stop(sk, timeo);
+			if (ret == -ESHUTDOWN) {
+				ret = 0;
+				if (__mptcp_move_skbs(sk))
+					continue;
 				break;
-			if (shutdown == 0)
-				continue;
+			} else if (ret < 0) {
+				break;
+			}
 			/* if __mptcp_splice_read() got nothing while we have
 			 * an skb in receive queue, we do not want to loop.
 			 * This might happen with URG data.
-- 
2.48.1

