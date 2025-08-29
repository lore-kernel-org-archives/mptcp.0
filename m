Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207792E5B32
	for <mptcp@lists.linux.dev>; Fri, 29 Aug 2025 09:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756458630; cv=none; b=A7ZykQw0b17cH9/WAoH/VvCFX3ytYAAaIL+r0mJ5P7fHOEY2/1XhdPMfnGWp4wE++JNdy8n37U09bTpuA0Q7qk1JKPyR1VIsK9WLUniHU7CkOHs2zweI4bHhd3vaLnjr+SOZW4AgG0xwK4wn7jql0cFZ+anL3hWiZXrAwPYPWZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756458630; c=relaxed/simple;
	bh=e6Bk8QFYRCdVijtTBr4k/daDssVp4l93JRqIYBxqeFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=md5mOAUFTPcz7wi+G3HFy3O3hfHxkeTIyzdb+8ITSV5xAXFL5kebX9JIrQ5jAgWFeI73v1BWsmwGIEqYAq2pa/dWGW5Nw+itFgYIwgdIiLrCx2OsqNVsbJSb4dy9s5nCJfxQCjpEWG9o4/T8AtERBUsLc/RHG1kn52ZUvsic8cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aU4igFOZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aU4igFOZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A6BC4CEF4;
	Fri, 29 Aug 2025 09:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756458629;
	bh=e6Bk8QFYRCdVijtTBr4k/daDssVp4l93JRqIYBxqeFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aU4igFOZkiNSRbbe+pBhamxwEmiB3UozXKOtnoS4F3RtHx4Xmv+6Bp9Od1PitQXec
	 gF2xo2d4efyueWdaY2a/Ea+51+rL+9zHVuLHYJM/fuGMgsevYGwmkD2l8qhe5qnCFZ
	 zjsTDWqhlinVJu9yHmAZ9VteBkxGBwNSlSJ8PSOTvzsouJza1i1wam/6tpmyPwCBE/
	 nAe5Pq/CnqIQN79C2Er9PimfXzDW8joZqgepJp9C+GRTIop8Nc/J6+GpfOUo0chXLX
	 FGtVKF55BeML2KgNEGboBPlgm/jfprSD0hdhGu4D70aJzocXxqd5c1+FY3HthlwqS7
	 t7XLFVVYMtFAw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/2] Squash to "mptcp: implement .read_sock"
Date: Fri, 29 Aug 2025 17:10:06 +0800
Message-ID: <e14c5f597e17e6410c639811f44dbd7588667888.1756458375.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1756458375.git.tanggeliang@kylinos.cn>
References: <cover.1756458375.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add an offset parameter for mptcp_recv_skb and make it more like
tcp_recv_skb.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 33bf5bc26d36..701295f6ae1b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4019,11 +4019,23 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	return mask;
 }
 
-static struct sk_buff *mptcp_recv_skb(struct sock *sk)
+static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 {
+	struct sk_buff *skb;
+	u32 offset;
+
 	if (skb_queue_empty(&sk->sk_receive_queue))
 		__mptcp_move_skbs(sk);
-	return skb_peek(&sk->sk_receive_queue);
+
+	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
+		offset = MPTCP_SKB_CB(skb)->offset;
+		if (offset < skb->len) {
+			*off = offset;
+			return skb;
+		}
+		mptcp_eat_recv_skb(sk, skb);
+	}
+	return NULL;
 }
 
 /*
@@ -4037,11 +4049,11 @@ static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 	size_t len = sk->sk_rcvbuf;
 	struct sk_buff *skb;
 	int copied = 0;
+	u32 offset;
 
 	if (sk->sk_state == TCP_LISTEN)
 		return -ENOTCONN;
-	while ((skb = mptcp_recv_skb(sk)) != NULL) {
-		u32 offset = MPTCP_SKB_CB(skb)->offset;
+	while ((skb = mptcp_recv_skb(sk, &offset)) != NULL) {
 		u32 data_len = skb->len - offset;
 		u32 size = min_t(size_t, len - copied, data_len);
 		int count;
@@ -4072,7 +4084,7 @@ static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 	mptcp_rcv_space_adjust(msk, copied);
 
 	if (copied > 0) {
-		mptcp_recv_skb(sk);
+		mptcp_recv_skb(sk, &offset);
 		mptcp_cleanup_rbuf(msk, copied);
 	}
 
-- 
2.48.1

