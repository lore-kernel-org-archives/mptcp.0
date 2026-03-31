Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF7A3EC2C7
	for <mptcp@lists.linux.dev>; Tue, 31 Mar 2026 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774948135; cv=none; b=PRIPJVq6tWGYEYeLh3vM0Y2GozyPJUn4+f7fpAWe0tGGB3rORhv261MtTyRWyimwzpy+HNg/dQJ1MLSZC9krTqF5qnPKO1imQySyladnVXCRLvZgcozXdArsnUM7QKMkgbB6ixBmzfmOkgvlr462bibxCGA5BFJNi3nnQP1fJ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774948135; c=relaxed/simple;
	bh=L7z8mxjEKyyoD+jnBOupQf3hnK1tRzp/USnQWM7AlzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfzVeae7ctexC80V4jjkz7vmz4xPeRxoUk2qoxEvX/rU8lvxpVwH/ALifrdJ+qM3JYAQQUgM7N+CfUQUtyc2Yxoy6u8TJbbZjLI15sl4sYu/nmdrPxJrdsADOzJbLA/xbjGwELe77EuRiZ6eP5/wowyDh6p36nOrrPzQqDgNJZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tJTtf7aU; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tJTtf7aU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774948131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cA3snmR3/R3H1vjoGHVkWgrWXv+6oGnnRe0mqDjj9cw=;
	b=tJTtf7aU2ohEmgYGv1AOFadIw8Eney+yIy42XGpjXP3f5WvErEFMToo4MuLgEGCv6J/0KT
	baVaxH/ySslU+zXxHhrLF9ebgKXGaMjNzz1h7qMqBhhKOF7PAYei11sIphYjtAEwjTPvnG
	OP/8pFzhjw9nXjKgZax23ALD1S871D4=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/2] mptcp: preserve MSG_EOR semantics in sendmsg path
Date: Tue, 31 Mar 2026 17:08:09 +0800
Message-ID: <0bed96b3828c0a67950993fc0dd9233c17b94abd.1774947296.git.yangang@kylinos.cn>
In-Reply-To: <cover.1774947296.git.yangang@kylinos.cn>
References: <cover.1774947296.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

Extend MPTCP's sendmsg handling to recognize and honor the MSG_EOR flag,
which marks the end of a record for application-level message boundaries.

Data fragments tagged with MSG_EOR are explicitly marked in the
mptcp_data_frag structure and skb context to prevent unintended
coalescing with subsequent data chunks. This ensures the intent of
applications using MSG_EOR is preserved across MPTCP subflows,
maintaining consistent message segmentation behavior.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/protocol.c | 24 +++++++++++++++++++++---
 net/mptcp/protocol.h |  3 ++-
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 01690a84ea6d..dafa178f43c5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1032,7 +1032,8 @@ static bool mptcp_frag_can_collapse_to(const struct mptcp_sock *msk,
 				       const struct page_frag *pfrag,
 				       const struct mptcp_data_frag *df)
 {
-	return df && pfrag->page == df->page &&
+	return df && !df->eor &&
+		pfrag->page == df->page &&
 		pfrag->size - pfrag->offset > 0 &&
 		pfrag->offset == (df->offset + df->data_len) &&
 		df->data_seq + df->data_len == msk->write_seq;
@@ -1174,6 +1175,7 @@ mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag,
 	dfrag->offset = offset + sizeof(struct mptcp_data_frag);
 	dfrag->already_sent = 0;
 	dfrag->page = pfrag->page;
+	dfrag->eor = 0;
 
 	return dfrag;
 }
@@ -1435,6 +1437,13 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		mptcp_update_infinite_map(msk, ssk, mpext);
 	trace_mptcp_sendmsg_frag(mpext);
 	mptcp_subflow_ctx(ssk)->rel_write_seq += copy;
+
+	/* if this is the last chunk of a dfrag with MSG_EOR set,
+	 * mark the skb to prevent coalescing with subsequent data.
+	 */
+	if (dfrag->eor && info->sent + copy >= dfrag->data_len)
+		TCP_SKB_CB(skb)->eor = 1;
+
 	return copy;
 }
 
@@ -1895,7 +1904,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	long timeo;
 
 	/* silently ignore everything else */
-	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_FASTOPEN;
+	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
+			  MSG_FASTOPEN | MSG_EOR;
 
 	lock_sock(sk);
 
@@ -2002,8 +2012,16 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			goto do_error;
 	}
 
-	if (copied)
+	if (copied) {
+		/* mark the last dfrag with EOR if MSG_EOR was set */
+		if (msg->msg_flags & MSG_EOR) {
+			struct mptcp_data_frag *dfrag = mptcp_pending_tail(sk);
+
+			if (dfrag)
+				dfrag->eor = 1;
+		}
 		__mptcp_push_pending(sk, msg->msg_flags);
+	}
 
 out:
 	release_sock(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index afdead91a4d7..db96f2945cbd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -265,7 +265,8 @@ struct mptcp_data_frag {
 	u16 data_len;
 	u16 offset;
 	u8 overhead;
-	u8 __unused;
+	u8 eor:1,
+	   __unused:7;
 	u16 already_sent;
 	struct page *page;
 };
-- 
2.43.0

