Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5B928B7F0
	for <mptcp@lists.linux.dev>; Thu, 10 Jul 2025 08:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135400; cv=none; b=aTKtGBrV3O3Nl11BKX53i6Z5ii1/CQqNFQekdGvM2imM1O1b7Pxwu//x07Bbaegt3jraRHvIWaoYZqtYTy0UHpVg5DRvb84LN8sjr9B/QD8ssuCxok9ojzULUINlnBImIeJEyOcXKEMqde+qcyteQhlfwMv9HTX1DXX1hAxajog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135400; c=relaxed/simple;
	bh=Nd5i2w45LO3O1gx3KuoZUagFYX8gCZ9tKC17i7MpDeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFZzvbjrkt8TpnJGOa4MEeEpc32pbFlAwnYN11QTDfMxudsnN9VkFrKoDft48HNnK99Cp2ye7D5kN4AtmhGtMe14eYB5stYPMIHpVqrQo8a7DrxNh8QWav0988stSWzpc6jZ2HgdB1zHE4nDTAklFJrgbmdtF/Gr3wBE2WlGirY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwYmyu4x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwYmyu4x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31BDC4CEF4;
	Thu, 10 Jul 2025 08:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752135397;
	bh=Nd5i2w45LO3O1gx3KuoZUagFYX8gCZ9tKC17i7MpDeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GwYmyu4xtmGwtpp7HOodM1iXOFP4nv7WJqJrigne71p2jqhI1tL4L0N4j0k0VkTzb
	 7IKw1dlETcCpzNEhJTN6bFvKb+9Y2qzz5T90tU3p2u3nSgw0Ge0fKGB5czDYcQIGJd
	 X96dKiNUUxvtwcDgXVgm1qIWBOffUSWkR57ETwSpplQI5Z5xI97rDrmD3M4eC7bu1n
	 BmqSVYWAuMLVNJRH1h4DZYQgvrNikOFgpvjdJsF8wquyQb7mQdoo5U1SwJbJvf8mdm
	 Nq7evIyPDlZvQNJ1x58kjwj5QG/vmV+aN/f7p3uHfDSZIZV/YeMXFuCtdjkFaPjDZZ
	 JT6g/KR/EPzjg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/2] Squash to "mptcp: implement .splice_read"
Date: Thu, 10 Jul 2025 16:16:28 +0800
Message-ID: <9b738112df48766a6d9b454d89e9274dbf0bf1dd.1752135065.git.tanggeliang@kylinos.cn>
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

Update the parameter of mptcp_recv_should_stop.
Use mptcp_recv_should_stop at the end of the main loop too.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 32ca63a0825a..e8d26faaa51f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4056,10 +4056,9 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 		.flags = flags,
 	};
 	struct sock *sk = sock->sk;
-	int shutdown = -1;
 	ssize_t spliced;
+	int ret, err;
 	long timeo;
-	int ret;
 
 	/*
 	 * We can't seek on a socket input
@@ -4082,11 +4081,16 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 				break;
 			if (sock_flag(sk, SOCK_DONE))
 				break;
-			ret = mptcp_recv_should_stop(sk, timeo, &shutdown);
-			if (ret < 0 || shutdown == 1)
+			err = mptcp_recv_should_stop(sk, timeo);
+			if (err < 0) {
+				if (err == -ESHUTDOWN) {
+					if (__mptcp_move_skbs(sk))
+						continue;
+					break;
+				}
+				ret = err;
 				break;
-			if (shutdown == 0)
-				continue;
+			}
 			/* if __mptcp_splice_read() got nothing while we have
 			 * an skb in receive queue, we do not want to loop.
 			 * This might happen with URG data.
@@ -4106,9 +4110,7 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 		release_sock(sk);
 		lock_sock(sk);
 
-		if (sk->sk_err || sk->sk_state == TCP_CLOSE ||
-		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-		    signal_pending(current))
+		if (mptcp_recv_should_stop(sk, timeo))
 			break;
 	}
 
-- 
2.48.1

