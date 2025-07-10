Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0592D5419
	for <mptcp@lists.linux.dev>; Thu, 10 Jul 2025 09:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752141135; cv=none; b=mKr0sQP5xbG38UywXDGwyZ9csCqdwzJN8euczJ+wgOaICkTJvMaK+LQfpLW2Hij13JIsxJ55bDAQh1gNqDBhKFh98XzKRnuVHuriVthCcLKGUTZ/+sHxvAxCbUFH91szuVmzdpeiTC73Gk7puzQXoTBaat1ItIx8fS3Ap7BoE9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752141135; c=relaxed/simple;
	bh=3ZlBrrizABMdX3hX5BaseCpXr3luWaS0GyULf9eidGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKHxqGnf6HfuEci9TSa2xZsUhIaMjpN/Xu7X2p2IgCenMK7k7CQy39tZpDQo/af9zQbGDbmfVBE6buYUoDrV8xWKC3DkUsqaaR5fUtAtXlqMQk06IFpTXd0zDy3IwlUDkqjBzvtb3ySiyEkM3MRzOcceeqgogyY31mtMN3ywANI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYiYQpLB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYiYQpLB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E52C4CEF6;
	Thu, 10 Jul 2025 09:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752141135;
	bh=3ZlBrrizABMdX3hX5BaseCpXr3luWaS0GyULf9eidGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JYiYQpLB++8m6E5L119FqxuPzbx9bPBHRUq2PsmwQv81apAxIPNFV3xt6rGZaRULW
	 4VEbrY6s9moMkAupepfkAjmMP6gahC28rOjD02cj5D+0t/ApfnC4TXZ7cr1H/iVZ33
	 Oqq6fq2Ea982a7kJ46+p2iR8d/MMoMAFWPOQtr0gU1gwPx5BXKMErOFdtgVKdNzaGP
	 wr7oWMGq86cyDQb/vdASQJ+fls3YQ7ExhGv+zL8xl2RgsU96rXbaymkadHCuZEKVh3
	 smOYOB3TUyLWDHST3LR1sKBfsUqoLxg8KaE8kUnhA5R3egZvDHkddK4c7ezh7C25KH
	 1+ABi4OImx11Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 2/2] Squash to "mptcp: implement .splice_read"
Date: Thu, 10 Jul 2025 17:52:06 +0800
Message-ID: <1fbba8a517aeb941fc9ffdc84469db65cca737c0.1752141057.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1752141057.git.tanggeliang@kylinos.cn>
References: <cover.1752141057.git.tanggeliang@kylinos.cn>
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
Rename to tcp_recv_should_stop.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index caeb48823058..bcae97b48b4b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4037,10 +4037,9 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
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
@@ -4063,11 +4062,17 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 				break;
 			if (sock_flag(sk, SOCK_DONE))
 				break;
-			ret = mptcp_recv_should_stop(sk, timeo, &shutdown);
-			if (ret < 0 || shutdown == 1)
+			err = tcp_recv_should_stop(sk, timeo);
+			if (err < 0) {
+				if (err == -ESHUTDOWN) {
+					if (__mptcp_move_skbs(sk))
+						continue;
+					break;
+				}
+				if (err != -ENETDOWN)
+					ret = err;
 				break;
-			if (shutdown == 0)
-				continue;
+			}
 			/* if __mptcp_splice_read() got nothing while we have
 			 * an skb in receive queue, we do not want to loop.
 			 * This might happen with URG data.
@@ -4087,9 +4092,7 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 		release_sock(sk);
 		lock_sock(sk);
 
-		if (sk->sk_err || sk->sk_state == TCP_CLOSE ||
-		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-		    signal_pending(current))
+		if (tcp_recv_should_stop(sk, timeo))
 			break;
 	}
 
-- 
2.48.1

